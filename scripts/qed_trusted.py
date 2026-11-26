"""Trusted verification of an exported contribution. Runs in the TRUSTED verify job only (see check.py).

    python3 -I scripts/qed_trusted.py --export=FILE --statement=FILE --claim=OpenProblems.X.Claim
        --kind=proof|disproof|partial --workdir=DIR --result=FILE

Nothing produced by the untrusted job is loaded by Lean here. The only input from it is FILE, an NDJSON
export (lean4export format 3.1) that it claims describes the contribution. This script:

1. parses that file strictly (memory-safe Python; unknown keys, duplicate keys, out-of-order or dangling ids,
   bad literals are all rejected) and re-serializes exactly what it parsed into checked.ndjson;
2. compiles the official statement itself and exports, with the pinned exporter, the official version of the
   statement's declarations and of every constant the file mentions that exists in the official environment
   (Mathlib, core) -- these Lean inputs are all trusted;
3. compares them by structural hash: each such constant must be identical to the official one; the
   statement's declarations must all be present; NEW declarations may not be axioms, opaque/partial/unsafe
   constants or quotient declarations, and may not shadow a statement declaration from another namespace;
   for a proof/disproof, `solution` must be a new root-level theorem/definition without universe parameters
   whose type is exactly `Claim` / `Not Claim`;
4. runs nanoda (an independent Rust kernel, pinned) on checked.ndjson, permitting only the axioms
   propext, Classical.choice and Quot.sound.

Result: JSON {"ok": bool, "error"?: str, "axioms"?: [...], "new": n, "decls": n} in --result.
Every external command has a wall-clock limit; nanoda also has an address-space limit."""
import sys, os, json, hashlib, subprocess, signal, time, resource, re

STD_AXIOMS = {'propext', 'Classical.choice', 'Quot.sound'}
MAX_EXPORT_BYTES = int(os.environ.get('QED_MAX_EXPORT_BYTES', str(3 * 1024 ** 3)))


class Reject(Exception):
    pass


def run(args, timeout, env=None, stdout=None, limit_as=None):
    """Run a command in its own process group with a hard wall-clock limit (kills the whole group)."""
    def pre():
        if limit_as: resource.setrlimit(resource.RLIMIT_AS, (limit_as, limit_as))
    out_f = stdout if stdout is not None else subprocess.PIPE
    p = subprocess.Popen(args, stdout=out_f, stderr=subprocess.PIPE if stdout is not None else subprocess.STDOUT,
                         text=True, env=env, start_new_session=True, preexec_fn=pre)
    try:
        out, err = p.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        os.killpg(p.pid, signal.SIGKILL)
        p.communicate()
        raise Reject(f'{os.path.basename(args[0])} timed out after {timeout} s')
    return p.returncode, (out or '') + (err or '')


# ---------------------------------------------------------------- strict NDJSON parsing + hashing

def H(*parts):
    h = hashlib.blake2b(digest_size=16)
    for p in parts:
        if isinstance(p, bytes): b = p
        elif isinstance(p, bool): b = b'T' if p else b'F'
        elif isinstance(p, int): b = b'i' + str(p).encode()
        elif isinstance(p, str): b = b's' + p.encode('utf-8', 'surrogatepass')
        elif isinstance(p, (list, tuple)): b = H(*p)
        else: raise TypeError(type(p))
        h.update(len(b).to_bytes(8, 'little')); h.update(b)
    return h.digest()


def no_dupes(pairs):
    d = {}
    for k, v in pairs:
        if k in d: raise Reject(f'duplicate JSON key {k!r}')
        d[k] = v
    return d


def keys(o, required, optional=()):
    ks = set(o)
    if not set(required) <= ks or not ks <= set(required) | set(optional):
        raise Reject(f'unexpected record shape {sorted(ks)}')


def is_nat(x): return isinstance(x, int) and not isinstance(x, bool) and x >= 0
def is_bool(x): return isinstance(x, bool)
def is_str(x): return isinstance(x, str)


BINDERS = {'default', 'implicit', 'strictImplicit', 'instImplicit'}


class Export:
    def __init__(self, path):
        self.names = [('',)]          # id -> components tuple; id 0 = anonymous
        self.name_h = [H('anon')]
        self.lvl_h = [H('zero')]      # id 0 = Level.zero
        self.expr_h = []
        self.decls = {}               # name string -> dict(kind, hash, info...)
        self.order = []
        self.lines = []               # re-serialized records, exactly as parsed
        self.meta = None
        self.parse(path)

    # ids must be dense and in order; references must be to earlier ids
    def nm(self, i):
        if not is_nat(i) or i >= len(self.names): raise Reject(f'dangling name id {i!r}')
        return i
    def lv(self, i):
        if not is_nat(i) or i >= len(self.lvl_h): raise Reject(f'dangling level id {i!r}')
        return self.lvl_h[i]
    def ex(self, i):
        if not is_nat(i) or i >= len(self.expr_h): raise Reject(f'dangling expr id {i!r}')
        return self.expr_h[i]
    def name_str(self, i):
        return '.'.join(str(c) for c in self.names[self.nm(i)][1:]) if i else '[anonymous]'
    def nlist(self, xs):
        if not isinstance(xs, list): raise Reject('expected a list of names')
        return [self.nm(x) for x in xs]

    def parse(self, path):
        if os.path.getsize(path) > MAX_EXPORT_BYTES: raise Reject('export file too large')
        with open(path, 'rb') as f:
            for ln, raw in enumerate(f, 1):
                try: o = json.loads(raw.decode('utf-8', 'strict'), object_pairs_hook=no_dupes)
                except Reject: raise
                except Exception as e: raise Reject(f'line {ln}: not valid JSON ({e})')
                if not isinstance(o, dict): raise Reject(f'line {ln}: not an object')
                try: self.record(o)
                except Reject as e: raise Reject(f'line {ln}: {e}')
                self.lines.append(json.dumps(o, ensure_ascii=False, separators=(',', ':')))
        if self.meta is None: raise Reject('no metadata record')

    def record(self, o):
        if 'meta' in o:
            keys(o, ['meta'])
            if self.meta is not None or self.lines: raise Reject('metadata must come first, once')
            m = o['meta']
            if not isinstance(m, dict): raise Reject('bad meta')
            v = (m.get('format') or {}).get('version') if isinstance(m.get('format'), dict) else None
            if not is_str(v) or not re.fullmatch(r'3\.1\.\d+', v): raise Reject(f'unsupported export format {v!r}')
            self.meta = m
            return
        if self.meta is None: raise Reject('metadata must come first')
        if 'in' in o:
            i = o['in']
            if i != len(self.names): raise Reject('name ids out of order')
            if 'str' in o:
                keys(o, ['in', 'str']); s = o['str']; keys(s, ['pre', 'str'])
                if not is_str(s['str']): raise Reject('bad name string')
                p = self.nm(s['pre']); comp = s['str']
                self.name_h.append(H('nstr', self.name_h[p], comp))
            elif 'num' in o:
                keys(o, ['in', 'num']); s = o['num']; keys(s, ['pre', 'i'])
                if not is_nat(s['i']): raise Reject('bad name number')
                p = self.nm(s['pre']); comp = s['i']
                self.name_h.append(H('nnum', self.name_h[p], comp))
            else: raise Reject('bad name record')
            self.names.append(self.names[p] + (comp,))
            return
        if 'il' in o:
            i = o['il']
            if i != len(self.lvl_h): raise Reject('level ids out of order')
            if 'succ' in o: keys(o, ['il', 'succ']); h = H('succ', self.lv(o['succ']))
            elif 'max' in o or 'imax' in o:
                t = 'max' if 'max' in o else 'imax'; keys(o, ['il', t]); a = o[t]
                if not (isinstance(a, list) and len(a) == 2): raise Reject('bad level')
                h = H(t, self.lv(a[0]), self.lv(a[1]))
            elif 'param' in o: keys(o, ['il', 'param']); h = H('param', self.name_h[self.nm(o['param'])])
            else: raise Reject('bad level record')
            self.lvl_h.append(h)
            return
        if 'ie' in o:
            i = o['ie']
            if i != len(self.expr_h): raise Reject('expr ids out of order')
            self.expr_h.append(self.expr(o))
            return
        if len(o) != 1: raise Reject('bad declaration record')
        (tag, d), = o.items()
        if not isinstance(d, dict): raise Reject('bad declaration record')
        if tag == 'inductive':
            keys(d, ['types', 'ctors', 'recs'])
            if not all(isinstance(d[k], list) for k in d): raise Reject('bad inductive')
            for t in d['types']: self.decl('inductive', t)
            for c in d['ctors']: self.decl('ctor', c)
            for r in d['recs']: self.decl('rec', r)
        elif tag in ('axiom', 'def', 'opaque', 'thm', 'quot'):
            self.decl(tag, d)
        else: raise Reject(f'unknown record {tag!r}')

    def expr(self, o):
        ks = set(o) - {'ie'}
        if len(ks) != 1: raise Reject('bad expr record')
        t = ks.pop(); v = o[t]
        if t == 'bvar':
            if not is_nat(v): raise Reject('bad bvar')
            return H('bvar', v)
        if t == 'sort': return H('sort', self.lv(v))
        if t == 'natVal':
            if not (is_str(v) and re.fullmatch(r'0|[1-9][0-9]*', v)): raise Reject('bad nat literal')
            return H('nat', v)
        if t == 'strVal':
            if not is_str(v): raise Reject('bad string literal')
            return H('strlit', v)
        if not isinstance(v, dict): raise Reject('bad expr')
        if t == 'const':
            keys(v, ['name', 'us'])
            if not isinstance(v['us'], list): raise Reject('bad const')
            return H('const', self.name_h[self.nm(v['name'])], [self.lv(u) for u in v['us']])
        if t == 'app': keys(v, ['fn', 'arg']); return H('app', self.ex(v['fn']), self.ex(v['arg']))
        if t in ('lam', 'forallE'):
            keys(v, ['name', 'type', 'body', 'binderInfo'])
            if v['binderInfo'] not in BINDERS: raise Reject('bad binder info')
            self.nm(v['name'])
            # Binder names and binder info are not part of the hash: lean4export shares expressions up to
            # `Expr.eqv`, which ignores them, and the kernel ignores them too.
            return H(t, self.ex(v['type']), self.ex(v['body']))
        if t == 'letE':
            keys(v, ['name', 'type', 'value', 'body', 'nondep'])
            if not is_bool(v['nondep']): raise Reject('bad let')
            self.nm(v['name'])
            return H('let', self.ex(v['type']), self.ex(v['value']), self.ex(v['body']))
        if t == 'proj':
            keys(v, ['typeName', 'idx', 'struct'])
            if not is_nat(v['idx']): raise Reject('bad proj')
            return H('proj', self.name_h[self.nm(v['typeName'])], v['idx'], self.ex(v['struct']))
        if t == 'mdata':
            keys(v, ['expr', 'data'])
            return H('mdata', self.ex(v['expr']), json.dumps(v['data'], sort_keys=True))
        raise Reject(f'unknown expr kind {t!r}')

    def decl(self, kind, d):
        if not isinstance(d, dict): raise Reject('bad declaration')
        common = ['name', 'levelParams', 'type']
        spec = {
            'axiom': (common + ['isUnsafe'], []),
            'def': (common + ['value', 'hints', 'safety', 'all'], []),
            'opaque': (common + ['value', 'isUnsafe', 'all'], []),
            'thm': (common + ['value', 'all'], []),
            'quot': (common + ['kind'], []),
            'inductive': (common + ['numParams', 'numIndices', 'all', 'ctors', 'numNested', 'isRec', 'isUnsafe', 'isReflexive'], []),
            'ctor': (common + ['induct', 'cidx', 'numParams', 'numFields', 'isUnsafe'], []),
            'rec': (common + ['all', 'numParams', 'numIndices', 'numMotives', 'numMinors', 'rules', 'k', 'isUnsafe'], []),
        }[kind]
        keys(d, *spec)
        parts = [kind, self.name_h[self.nm(d['name'])], [self.name_h[x] for x in self.nlist(d['levelParams'])], self.ex(d['type'])]
        unsafe = False; info = {}
        fields = {'_kind': H(kind), 'name': parts[1], 'levelParams': H(parts[2]), 'type': parts[3]}
        for k in sorted(d):
            if k in ('name', 'levelParams', 'type'): continue
            v = d[k]
            fields[k] = len(parts)   # index of this field's first part; turned into a hash below
            if k == 'value': parts += [k, self.ex(v)]
            elif k in ('all', 'ctors'): parts += [k, [self.name_h[x] for x in self.nlist(v)]]
            elif k in ('induct',): parts += [k, self.name_h[self.nm(v)]]
            elif k in ('isUnsafe', 'isRec', 'isReflexive', 'k'):
                if not is_bool(v): raise Reject(f'bad {k}')
                parts += [k, v]
                if k == 'isUnsafe' and v: unsafe = True
            elif k in ('numParams', 'numIndices', 'numNested', 'cidx', 'numFields', 'numMotives', 'numMinors'):
                if not is_nat(v): raise Reject(f'bad {k}')
                parts += [k, v]
            elif k == 'hints':
                if v in ('opaque', 'abbrev'): parts += [k, v]
                elif isinstance(v, dict) and set(v) == {'regular'} and is_nat(v['regular']): parts += [k, 'regular', v['regular']]
                else: raise Reject('bad hints')
            elif k == 'safety':
                if v not in ('safe', 'unsafe', 'partial'): raise Reject('bad safety')
                parts += [k, v]; info['safety'] = v
                if v == 'unsafe': unsafe = True
            elif k == 'kind':
                if v not in ('type', 'ctor', 'lift', 'ind'): raise Reject('bad quot kind')
                parts += [k, v]
            elif k == 'rules':
                if not isinstance(v, list): raise Reject('bad rules')
                rs = []
                for r in v:
                    if not isinstance(r, dict): raise Reject('bad rule')
                    keys(r, ['ctor', 'nfields', 'rhs'])
                    if not is_nat(r['nfields']): raise Reject('bad rule')
                    rs.append([self.name_h[self.nm(r['ctor'])], r['nfields'], self.ex(r['rhs'])])
                parts += [k, rs]
        starts = sorted((i, k) for k, i in fields.items() if isinstance(i, int))
        for j, (i, k) in enumerate(starts):
            end = starts[j + 1][0] if j + 1 < len(starts) else len(parts)
            fields[k] = H(*parts[i:end])
        name = self.names[d['name']][1:]      # key: exact name components
        if name in self.decls: raise Reject(f"declaration {self.name_str(d['name'])} appears twice")
        self.decls[name] = dict(kind=kind, hash=H(*parts), unsafe=unsafe, fields=fields, safety=info.get('safety'),
                                nlp=len(d['levelParams']), type=self.ex(d['type']))
        self.order.append(name)


def name_json(comps): return json.dumps(list(comps), ensure_ascii=False)
def show(comps): return '.'.join(str(c) for c in comps)


def const_hash(name):
    """Hash of `Expr.const name []` as computed by Export.expr."""
    h = H('anon')
    for c in name.split('.'):
        h = H('nstr', h, c)
    return H('const', h, [])


# ---------------------------------------------------------------- main check

def verify(a):
    work = a['workdir']; os.makedirs(work, exist_ok=True)
    lean_env = dict(os.environ, LEAN_PATH=os.path.abspath(work) + os.pathsep + a['lean_path'])
    t_lean = int(os.environ.get('QED_LEAN_TIMEOUT', '1800'))
    t_nanoda = int(os.environ.get('QED_NANODA_TIMEOUT', '1800'))

    u = Export(a['export'])
    with open(os.path.join(work, 'checked.ndjson'), 'w') as f:
        for l in u.lines: f.write(l + '\n')
    names_file = os.path.join(work, 'names.jsonl')
    with open(names_file, 'w') as f:
        for n in u.order: f.write(name_json(n) + '\n')

    # Official side: compile the official statement here and export it with the trusted exporter.
    src = os.path.join(work, 'QEDStmt.lean')
    with open(src, 'w') as f: f.write(open(a['statement']).read())
    code, out = run(['lean', f'--root={work}', src, '-o', os.path.join(work, 'QEDStmt.olean')], t_lean, env=lean_env)
    if code != 0: raise Reject('official statement does not compile:\n' + out[-2000:])
    stmt_names = os.path.join(work, 'stmt.jsonl'); off_path = os.path.join(work, 'official.ndjson')
    with open(off_path, 'w') as f:
        code, err = run([a['exporter'], 'official', 'QEDStmt', names_file, stmt_names], t_lean, env=lean_env, stdout=f)
    if code != 0: raise Reject('official export failed:\n' + err[-2000:])
    o = Export(off_path)
    stmt = [tuple(json.loads(l)) for l in open(stmt_names) if l.strip()]

    # Compare.
    for n in stmt:
        if n not in u.decls: raise Reject(f'statement declaration {show(n)} is missing from the contribution')
    new = []
    for n in u.order:
        d = u.decls[n]
        if n in o.decls:
            if d['hash'] != o.decls[n]['hash']:
                fu, fo = d['fields'], o.decls[n]['fields']
                diff = sorted(k for k in set(fu) | set(fo) if fu.get(k) != fo.get(k))
                raise Reject(f"{show(n)} ({d['kind']}) differs from the official declaration in: {', '.join(diff)}")
            if d['unsafe'] or d['safety'] == 'partial': raise Reject(f'depends on unsafe/partial declaration {show(n)}')
            continue
        new.append(n)
        if d['kind'] == 'axiom': raise Reject(f'declares a new axiom {show(n)}')
        if d['kind'] == 'quot': raise Reject(f'declares quotient primitive {show(n)}')
        if d['unsafe']: raise Reject(f'declares unsafe constant {show(n)}')
        if d['safety'] == 'partial': raise Reject(f'declares partial definition {show(n)}')
        if d['kind'] == 'opaque': raise Reject(f'declares opaque constant {show(n)} (opaque and partial definitions are not allowed)')
        for sc in stmt:
            if len(n) > len(sc) and n[-len(sc):] == sc:
                raise Reject(f'{show(n)} shadows the official statement declaration {show(sc)}')
    axioms = sorted(show(n) for n in u.order if u.decls[n]['kind'] == 'axiom')
    bad = [x for x in axioms if x not in STD_AXIOMS]
    if bad: raise Reject('uses non-standard axioms: ' + ', '.join(bad))
    if a['kind'] in ('proof', 'disproof'):
        s = u.decls.get(('solution',))
        if s is None or ('solution',) not in new:
            raise Reject('no root-level `solution` declaration (it must not be inside a namespace)')
        if s['kind'] not in ('thm', 'def') or s['safety'] not in (None, 'safe'):
            raise Reject('`solution` must be a theorem or a definition')
        claim = const_hash(a['claim'])
        target = claim if a['kind'] == 'proof' else H('app', const_hash('Not'), claim)
        if s['nlp'] != 0 or s['type'] != target:
            raise Reject(f"`solution` must have type exactly {'' if a['kind'] == 'proof' else '¬ '}{a['claim']}")

    # Independent kernel.
    cfg = os.path.join(work, 'nanoda.json')
    json.dump({'export_file_path': os.path.abspath(os.path.join(work, 'checked.ndjson')),
               'permitted_axioms': sorted(STD_AXIOMS), 'unpermitted_axiom_hard_error': True,
               'nat_extension': True, 'string_extension': True,
               'num_threads': int(os.environ.get('QED_NANODA_THREADS', '2')),
               'stack_size_bytes': 512 * 1024 * 1024, 'print_success_message': True, 'print_axioms': False}, open(cfg, 'w'))
    code, out = run([a['nanoda'], cfg], t_nanoda, limit_as=int(os.environ.get('QED_NANODA_MEM', str(12 * 1024 ** 3))))
    if code != 0 or 'with no errors' not in out:
        raise Reject('independent kernel (nanoda) rejected the export:\n' + out[-2000:])
    return {'ok': True, 'axioms': axioms, 'new': len(new), 'decls': len(u.order)}


def main():
    a = {}
    for x in sys.argv[1:]:
        k, _, v = x.partition('=')
        a[k.lstrip('-').replace('-', '_')] = v
    need = ['export', 'statement', 'claim', 'kind', 'workdir', 'result', 'lean_path', 'exporter', 'nanoda']
    miss = [k for k in need if k not in a]
    if miss: sys.exit(f'missing arguments {miss}')
    try:
        if a['kind'] not in ('proof', 'disproof', 'partial'): raise Reject(f"unknown kind {a['kind']}")
        res = verify(a)
    except Reject as e:
        res = {'ok': False, 'error': str(e)}
    except Exception as e:   # fail closed on anything unexpected
        res = {'ok': False, 'error': f'verifier error: {type(e).__name__}: {e}'}
    json.dump(res, open(a['result'], 'w'))
    sys.exit(0 if res['ok'] else 1)


if __name__ == '__main__':
    main()
