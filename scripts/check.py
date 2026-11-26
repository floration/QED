"""CI check for a contribution PR.

Usage: python3 -I scripts/check.py [--stage=all|compile|verify] [--untrusted=DIR] [--files-from=NUL_SEPARATED_FILE | <changed files...>]
Writes check_result.json. Exit 1 on failure. Fails closed: anything not recognised is rejected.

A PR is classified ONLY by the files it changes (never by branch name):
  solution : adds solutions/<id>/<author>/{Solution.lean, meta.json[, README.md][, more .lean files, subfolders allowed]}
  partial  : adds/updates files under problems/<id>/partial/<author>/ (.md, .txt, .lean)
Anything else (statements, data, scripts, workflows, mixed PRs) is rejected here and needs a maintainer.

Stages (CI runs them in two separate jobs, see .github/workflows/verify.yml):
  compile : UNTRUSTED. Classifies the PR, applies the text filters, compiles
            <official statement> ++ <contribution> and exports the resulting module as text
            (qedbuild/QEDSol.ndjson, or qedbuild/partial-<n>.ndjson per partial-work .lean file) with the
            pinned exporter (scripts/qedexport). Only these text files leave the job.
  verify  : TRUSTED, on a fresh runner. Re-classifies the PR and hands each export to scripts/qed_trusted.py,
            which never loads anything from the untrusted job into Lean: it compiles the official statement
            itself, compares the export with the official declarations and checks it with an independent
            kernel (nanoda).
  all     : both, in one process (for local use).

Environment: PR_AUTHOR, BASE_REF; optional QED_WORKDIR (default .), QED_LEAN_TIMEOUT (s, default 2400),
QED_LEAN_PATH, QED_EXPORTER, QED_NANODA."""
import sys, os, re, json, subprocess, shutil, signal, unicodedata

ID = r'(?:QED-[ME]\d{3}|QED-Q\d|N-000)'
USER = r'[A-Za-z0-9](?:[A-Za-z0-9-]{0,38})'
LEANPATH = r'(?:[A-Za-z0-9][A-Za-z0-9_-]*/)*[A-Za-z0-9][A-Za-z0-9_.-]*\.lean'
SOL = re.compile(rf'solutions/({ID})/({USER})/(meta\.json|README\.md|{LEANPATH})')
PART = re.compile(rf'problems/({ID})/partial/({USER})/([A-Za-z0-9._-]+\.(?:md|txt|lean))')
MAX_PARTIAL_BYTES = 5_000_000
WORK = os.environ.get('QED_WORKDIR', '.')
BUILD = os.path.join(WORK, 'qedbuild')       # untrusted compile output (its *.ndjson are uploaded as an artifact)
TRUSTED = os.path.join(WORK, 'qedtrusted')   # verify-stage working dir
TRUSTED_CHECKER = 'scripts/qed_trusted.py'
EXPORTER = os.environ.get('QED_EXPORTER', 'scripts/qedexport/.lake/build/bin/qedexport')
NANODA = os.environ.get('QED_NANODA', 'nanoda_bin')
LEAN_TIMEOUT = int(os.environ.get('QED_LEAN_TIMEOUT', '2400'))

# Metaprogramming / escape hatches. The structural verifier does not rely on these filters for soundness,
# but they keep contributor code from running arbitrary code at compile time (defence in depth).
# Applied to the raw text, comments included.
META = [r'\baxiom\b', r'\bset_option\b', r'\bimplemented_by\b', r'\bextern\b', r'\bunsafe', r'#exit', r'#eval',
        r'#print', r'#guard', r'\brun_cmd\b', r'\brun_tac\b', r'\brun_elab\b', r'\brun_meta\b', r'\bby_elab\b',
        r'\belab\b', r'\belab_rules\b', r'\bmacro\b', r'\bmacro_rules\b', r'\bsyntax\b', r'\bdeclare_syntax_cat\b',
        r'\binitialize\b', r'\bbuiltin_\w+', r'\bIO\b', r'\bLean\s*\.', r'\b(?:open|export|namespace|section)\s+(?:[\w.]+\s+)*Lean\b', r'«', r'\bofReduceBool\b', r'\btrustCompiler\b',
        r'\b(?:command|term|tactic)_(?:elab|parser)\b', r'\bd?simproc\w*', r'\bNormNumExt\b', r'\bPositivityExt\b',
        r'\bMeta\b', r'\bElab\b', r'\bEnvironment\b', r'\bmodifyEnv\b', r'\baddDecl\w*', r'\bevalConst\w*',
        r'\b(?:Core|Meta|TermElab|CommandElab|Tactic)M\b']
SOLUTION_ONLY = [r'\bsorry\b', r'\bsorryAx\b', r'\badmit\b', r'\bnative_decide\b', r'\bopaque\b',
                 r'\bdef Claim\b', r'\bnamespace OpenProblems\b']

def done(res, code):
    os.makedirs(WORK, exist_ok=True)
    json.dump(res, open(os.path.join(WORK, 'check_result.json'), 'w')); print(('OK ' if code == 0 else 'FAIL: ') + json.dumps(res)); sys.exit(code)
def fail(msg): done({'ok': False, 'error': msg}, 1)

# ---------- arguments ----------
stage, untrusted, files = 'all', None, []
for a in sys.argv[1:]:
    if a.startswith('--stage='): stage = a.split('=', 1)[1]
    elif a.startswith('--untrusted='): untrusted = a.split('=', 1)[1]
    elif a.startswith('--files-from='): files += [f for f in open(a.split('=', 1)[1], 'rb').read().decode('utf-8', 'strict').split('\0') if f]
    else: files.append(a)
if stage not in ('all', 'compile', 'verify'): fail(f'unknown stage {stage}')
files = [f for f in files if f.strip()]
author = os.environ.get('PR_AUTHOR', '')
BASE = os.environ.get('BASE_REF', '')

def base_file(path):
    """Read a file as it is on the base branch, so a PR can never change the statement it is checked against."""
    if BASE:
        r = subprocess.run(['git', 'show', f'origin/{BASE}:{path}'], capture_output=True, text=True)
        return r.stdout if r.returncode == 0 else None
    return open(path).read() if os.path.exists(path) else None

def run(args, timeout=LEAN_TIMEOUT, env=None, stdout=None):
    """Run a command in its own process group with a hard wall-clock limit; on timeout kill the group and fail."""
    p = subprocess.Popen(args, stdout=stdout if stdout is not None else subprocess.PIPE,
                         stderr=subprocess.PIPE if stdout is not None else subprocess.STDOUT,
                         text=True, env=env, start_new_session=True)
    try:
        out, err = p.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        os.killpg(p.pid, signal.SIGKILL); p.communicate()
        fail(f'{os.path.basename(args[0])} timed out after {timeout} s (wall-clock limit); the contribution is too slow to check')
    except OSError as e:
        fail(f'could not run {args[0]}: {e}')
    return p.returncode, (out or '') + (err or '')

_LP = os.environ.get('QED_LEAN_PATH')
def lean_path():
    global _LP
    if _LP is None:
        code, out = run(['lake', 'env', 'printenv', 'LEAN_PATH'], timeout=600)
        if code != 0: fail('could not determine LEAN_PATH:\n' + out[-2000:])
        _LP = out.strip()
    return _LP
def lean_env(extra):
    return dict(os.environ, LEAN_PATH=os.path.abspath(extra) + os.pathsep + lean_path())
def has_error(out):
    return re.search(r'(^|\n)[^\n]*:\d+:\d+: error', out) is not None or 'error:' in out
def compile_module(dirname, modname, text):
    os.makedirs(dirname, exist_ok=True)
    src = os.path.join(dirname, modname + '.lean')
    open(src, 'w').write(text)
    return run(['lean', f'--root={dirname}', src, '-o', os.path.join(dirname, modname + '.olean')], env=lean_env(dirname))
def export_module(dirname, modname, out_path):
    """UNTRUSTED: export the compiled module (and its dependencies) as NDJSON text."""
    with open(out_path, 'w') as f:
        code, err = run([EXPORTER, 'module', modname], env=lean_env(dirname), stdout=f)
    if code != 0: fail('export of the compiled contribution failed:\n' + err[-2000:])
def trusted_check(export_path, stmt_text, claim, kind, tag):
    """TRUSTED: scripts/qed_trusted.py (from the base branch) checks one export."""
    if not os.path.isfile(export_path) or os.path.islink(export_path): fail('No exported contribution to verify')
    wd = os.path.join(TRUSTED, tag); shutil.rmtree(wd, ignore_errors=True); os.makedirs(wd)
    open(os.path.join(wd, 'statement.lean'), 'w').write(stmt_text)
    checker = base_file(TRUSTED_CHECKER)
    if checker is None: fail(f'{TRUSTED_CHECKER} missing on the base branch')
    cpath = os.path.join(TRUSTED, 'qed_trusted.py'); open(cpath, 'w').write(checker)
    res_path = os.path.join(wd, 'result.json')
    run([sys.executable, '-I', cpath, f'--export={export_path}', f'--statement={wd}/statement.lean', f'--claim={claim}',
         f'--kind={kind}', f'--workdir={wd}/work', f'--result={res_path}', f'--lean-path={lean_path()}',
         f'--exporter={os.path.abspath(EXPORTER)}', f'--nanoda={NANODA}'], timeout=2 * LEAN_TIMEOUT + 600)
    try: res = json.load(open(res_path))
    except Exception: fail('trusted checker produced no result')
    if not res.get('ok'): fail('Verification failed: ' + str(res.get('error')))
    return res

def bad_chars(text):
    """Invisible / bidi / control characters have no place in a proof and only serve to mislead reviewers."""
    for ch in text:
        if ch in '\n\t': continue
        if unicodedata.category(ch) in ('Cc', 'Cf', 'Co', 'Cn', 'Zl', 'Zp'): return f'U+{ord(ch):04X}'
    return None
def scan(path, body, patterns):
    c = bad_chars(body)
    if c: fail(f'Disallowed character {c} in {path}')
    for bad in patterns:
        if re.search(bad, body): fail(f'Forbidden token in {path}: {bad}')

# ---------- classification (both stages; cheap and deterministic) ----------
if not files: fail('PR changes no files')
root = os.path.realpath('.')
for f in files:
    if os.path.islink(f) or not os.path.isfile(f): fail(f'{f} is deleted, a symlink or not a regular file; that needs a maintainer')
    p = f
    while True:
        p = os.path.dirname(p)
        if not p: break
        if os.path.islink(p): fail(f'{f} is under a symlinked directory')
    if not os.path.realpath(f).startswith(root + os.sep): fail(f'{f} resolves outside the repository')
if not author: fail('PR author unknown')

sol = [SOL.fullmatch(f) for f in files]
part = [PART.fullmatch(f) for f in files]

# ---------- partial work ----------
if all(part):
    ids = {m.group(1) for m in part}; users = {m.group(2) for m in part}
    if len(ids) != 1 or len(users) != 1: fail('A partial-work PR must touch exactly one problems/<id>/partial/<username>/ folder')
    pid, user = ids.pop(), users.pop()
    if user != author: fail(f'Folder name {user} must be exactly the PR author {author} (same letter case)')
    for f in files:
        if os.path.getsize(f) > MAX_PARTIAL_BYTES: fail(f'{f} is larger than {MAX_PARTIAL_BYTES} bytes')
    stmt_txt = base_file(f'problems/{pid}/Statement.lean')
    if stmt_txt is None: fail(f'Unknown problem {pid}')
    leans = sorted(f for f in files if f.endswith('.lean'))
    for f in leans:
        body = re.sub(r'(?m)^import .*$', '', open(f).read())
        scan(f, body, META + SOLUTION_ONLY)
    ns = pid.replace('-', '')
    res = {'ok': True, 'kind': 'partial', 'id': pid, 'user': user, 'files': files}
    if stage in ('all', 'compile'):
        # UNTRUSTED: each .lean file must compile against the official statement (no sorry, no axioms).
        shutil.rmtree(BUILD, ignore_errors=True)
        for i, f in enumerate(leans):
            body = re.sub(r'(?m)^import .*$', '', open(f).read())
            dn = os.path.join(BUILD, f'p{i}')
            code, out = compile_module(dn, 'QEDPartial', stmt_txt + '\n' + body + '\n')
            if code != 0 or has_error(out): fail(f'Lean error in {f}:\n' + out[-3000:])
            export_module(dn, 'QEDPartial', os.path.join(BUILD, f'partial-{i}.ndjson'))
        if stage == 'compile': done(dict(res, stage='compiled; not yet verified'), 0)
        untrusted = WORK
    axioms, checked, new = set(), 0, 0
    for i, f in enumerate(leans):
        r = trusted_check(os.path.join(untrusted or '', 'qedbuild', f'partial-{i}.ndjson'), stmt_txt,
                          f'OpenProblems.{ns}.Claim', 'partial', f'partial-{i}')
        axioms |= set(r.get('axioms', [])); checked += r.get('decls', 0); new += r.get('new', 0)
    done(dict(res, axioms=sorted(axioms), checked_decls=checked, new_decls=new), 0)

# ---------- full solution ----------
if not all(sol):
    fail('Not an automatic contribution. Solution PRs may only add files in solutions/<id>/<username>/ (Solution.lean, meta.json, README.md, extra .lean files); '
         'partial-work PRs may only touch problems/<id>/partial/<username>/. Anything else needs a maintainer.')
dirs = {(m.group(1), m.group(2)) for m in sol}
if len(dirs) != 1: fail('One solution per PR')
pid, user = dirs.pop()
if user != author: fail(f'Folder name {user} must be exactly the PR author {author} (same letter case)')
d = f'solutions/{pid}/{user}'
if f'{d}/Solution.lean' not in files or f'{d}/meta.json' not in files: fail('Need Solution.lean and meta.json')
src = open(f'{d}/Solution.lean').read()
# Extra .lean files (helpers) are concatenated in sorted path order before Solution.lean.
extras = sorted(f for f in files if f.endswith('.lean') and f != f'{d}/Solution.lean')
srcs = [(f, open(f).read()) for f in extras] + [(f'{d}/Solution.lean', src)]
try: meta = json.load(open(f'{d}/meta.json'))
except Exception as e: fail(f'meta.json is not valid JSON: {e}')
if not isinstance(meta, dict) or meta.get('kind') not in ('proof', 'disproof') or not isinstance(meta.get('model'), str) or not meta['model'].strip():
    fail('meta.json needs "model" (string) and "kind": proof|disproof')
stmt = base_file(f'problems/{pid}/Statement.lean')
if stmt is None: fail(f'Unknown problem {pid}')
if re.search(r'def Claim : Prop := sorry', stmt): fail(f'{pid} is not formalized yet; formalize Statement.lean first')
for f, t in srcs: scan(f, re.sub(r'(?m)^import .*$', '', t), META + SOLUTION_ONLY)
body = '\n'.join(f'-- file: {f}\n' + re.sub(r'(?m)^import .*$', '', t) for f, t in srcs)
ns = pid.replace('-', '')
claim = f'OpenProblems.{ns}.Claim'
lines = [l for _, t in srcs for l in re.sub(r'/-.*?-/', '', t, flags=re.S).splitlines()
         if l.strip() and not l.strip().startswith('--') and not l.startswith('import ')]
result = {'ok': True, 'kind': 'solution', 'id': pid, 'user': user, 'model': meta['model'], 'proof_kind': meta['kind'],
          'size': len(lines), 'files': [f for f, _ in srcs]}

if stage in ('all', 'compile'):
    # UNTRUSTED step: elaborates contributor code. Nothing after this in the same job is trusted.
    shutil.rmtree(BUILD, ignore_errors=True)
    code, out = compile_module(BUILD, 'QEDSol', stmt + '\n' + body + '\n')
    if code != 0 or has_error(out): fail('Lean error:\n' + out[-3000:])
    if not os.path.isfile(f'{BUILD}/QEDSol.olean'): fail('Lean produced no .olean')
    export_module(BUILD, 'QEDSol', f'{BUILD}/QEDSol.ndjson')
    if stage == 'compile': done(dict(result, stage='compiled; not yet verified'), 0)
    untrusted = WORK

# TRUSTED step (in CI: a separate job on a fresh runner; only the text export crosses over).
res = trusted_check(os.path.join(untrusted or '', 'qedbuild', 'QEDSol.ndjson'), stmt, claim, meta['kind'], 'solution')
done(dict(result, axioms=res.get('axioms', []), checked_decls=res.get('decls'), new_decls=res.get('new')), 0)
