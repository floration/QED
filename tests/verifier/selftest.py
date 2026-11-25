"""Self-test for the solution verifier (scripts/check.py + scripts/qed_verify.lean).

Run by .github/workflows/verifier-selftest.yml, in two jobs that mirror verify.yml:

    python3 -I tests/verifier/selftest.py compile OUT     # untrusted stage: compile every case
    python3 -I tests/verifier/selftest.py verify  IN      # trusted stage, fresh runner: verify, print table

Each case is a folder tests/verifier/cases/<name>/ with case.json:
    {"id": "QED-Q1", "expect": "pass"|"fail", "raw": "pass"|"reject"|"fail" (optional),
     "statement": "Statement.lean" (optional: a FAKE problem statement for an id that does not exist), "note": "..."}
plus the submission files (Solution.lean, meta.json, extra .lean files, subfolders allowed).

Two modes per case:
  pipeline : the real thing. The files are put in solutions/<id>/qedselftest/ and run through
             `check.py --stage=compile` here and `check.py --stage=verify` in the other job, exactly like CI.
             `expect` must hold.
  raw      : (only if "raw" is given) the contribution is compiled WITHOUT check.py's text filters, then
             scripts/qed_verify.lean is run on the result directly. This tests the structural verifier on its
             own, for attacks the text filter would already stop. "reject" = it must compile and then be
             rejected by the verifier; "fail" = rejected at either step; "pass" = must be accepted.
Every merged solution in solutions/<id>/<user>/ is also run through the pipeline and must pass.
Exit status of `verify` is 1 if any expectation is violated."""
import sys, os, re, json, shutil, subprocess, secrets, time, signal

ROOT = os.getcwd()
CASES = os.path.join(ROOT, 'tests', 'verifier', 'cases')
USER = 'qedselftest'
EXCLUDE = {'case.json', 'Statement.lean'}


def sh(args, env=None, timeout=None):
    """Run a command in its own process group; on timeout kill the whole group and keep the partial output."""
    timeout = timeout or int(os.environ.get('SELFTEST_TIMEOUT', '900'))
    t = time.time()
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, env=env, cwd=ROOT,
                         start_new_session=True)
    try:
        out, _ = p.communicate(timeout=timeout)
        return p.returncode, out, time.time() - t
    except subprocess.TimeoutExpired:
        os.killpg(p.pid, signal.SIGKILL)
        out, _ = p.communicate()
        return 124, (out or '') + f'\n[selftest] TIMEOUT after {timeout} s', time.time() - t


_LP = None
def lean_path():
    global _LP
    if _LP is None:
        code, out, _ = sh(['lake', 'env', 'printenv', 'LEAN_PATH'])
        if code != 0: sys.exit('could not get LEAN_PATH: ' + out)
        _LP = out.strip()
    return _LP


def load_cases():
    cases = []
    for name in sorted(os.listdir(CASES)):
        d = os.path.join(CASES, name)
        c = json.load(open(os.path.join(d, 'case.json')))
        files = []
        for dp, _, fs in os.walk(d):
            for f in fs:
                rel = os.path.relpath(os.path.join(dp, f), d)
                if rel not in EXCLUDE: files.append(rel)
        cases.append(dict(c, name=name, dir=d, files=sorted(files), user=USER, live=False))
    for pid in sorted(os.listdir(os.path.join(ROOT, 'solutions'))):
        for user in sorted(os.listdir(os.path.join(ROOT, 'solutions', pid))):
            d = os.path.join(ROOT, 'solutions', pid, user)
            if not os.path.isfile(os.path.join(d, 'Solution.lean')): continue
            files = sorted(os.path.relpath(os.path.join(dp, f), d) for dp, _, fs in os.walk(d) for f in fs)
            cases.append(dict(id=pid, expect='pass', note='merged solution on this branch', name=f'live-{pid}-{user}',
                              dir=d, files=files, user=user, live=True))
    return cases


def install(c):
    """Put the case's files where check.py expects them; return the repo-relative paths ("changed files")."""
    if c.get('statement'):
        dst = os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')
        src = os.path.join(c['dir'], c['statement'])
        if os.path.exists(dst) and open(dst).read() != open(src).read():
            sys.exit(f"{c['name']}: refusing to overwrite the real statement {dst}")
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copyfile(src, dst)
    if c['live']:
        return [f"solutions/{c['id']}/{c['user']}/{f}" for f in c['files']]
    d = os.path.join(ROOT, 'solutions', c['id'], USER)
    shutil.rmtree(d, ignore_errors=True)
    out = []
    for f in c['files']:
        os.makedirs(os.path.dirname(os.path.join(d, f)), exist_ok=True)
        shutil.copyfile(os.path.join(c['dir'], f), os.path.join(d, f))
        out.append(f"solutions/{c['id']}/{USER}/{f}")
    return out


def check_env(c):
    env = dict(os.environ, PR_AUTHOR=c['user'])
    env.pop('BASE_REF', None)   # read statements/verifier from this checkout (the branch under test)
    return env


def last_line(out):
    m = re.search(r'(?m)^(OK|FAIL: )(.*)$', out)
    if not m: return out.strip().splitlines()[-1][:300] if out.strip() else ''
    try:
        j = json.loads(m.group(2))
        return 'OK' if m.group(1) == 'OK' else (j.get('error', '') or '')
    except Exception:
        return m.group(0)[:300]


def strip_imports(t): return re.sub(r'(?m)^import .*$', '', t)


def raw_source(c):
    stmt = open(os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')).read()
    srcs = sorted(f for f in c['files'] if f.endswith('.lean') and f != 'Solution.lean') + ['Solution.lean']
    return stmt + '\n' + '\n'.join(strip_imports(open(os.path.join(c['dir'], f)).read()) for f in srcs) + '\n'


def lean(args, extra):
    env = dict(os.environ, LEAN_PATH=os.pathsep.join([os.path.abspath(p) for p in extra] + [lean_path()]))
    return sh(['lean'] + args, env=env)


def do_compile(out):
    os.makedirs(out, exist_ok=True)
    for c in load_cases():
        files = install(c)
        res = {}
        code, o, dt = sh([sys.executable, '-I', 'scripts/check.py', '--stage=compile'] + files, env=check_env(c))
        res['pipeline'] = {'code': code, 'msg': last_line(o), 'secs': round(dt), 'files': files, 'log': o[-4000:]}
        dst = os.path.join(out, c['name'], 'pipeline')
        os.makedirs(dst, exist_ok=True)
        if code == 0 and os.path.isfile('qedbuild/QEDSol.olean'):
            os.makedirs(os.path.join(dst, 'qedbuild'), exist_ok=True)
            shutil.copyfile('qedbuild/QEDSol.olean', os.path.join(dst, 'qedbuild', 'QEDSol.olean'))
        if c.get('raw'):
            rd = os.path.join(out, c['name'], 'raw')
            os.makedirs(rd, exist_ok=True)
            open(os.path.join(rd, 'QEDSol.lean'), 'w').write(raw_source(c))
            code, o, dt = lean([f'--root={rd}', os.path.join(rd, 'QEDSol.lean'), '-o', os.path.join(rd, 'QEDSol.olean')], [])
            err = code != 0 or re.search(r':\d+:\d+: error', o) is not None
            res['raw'] = {'code': 1 if err else 0, 'msg': (o.strip().splitlines() or [''])[0][:300] if err else 'compiled',
                          'secs': round(dt), 'log': o[-4000:]}
            if err and os.path.exists(os.path.join(rd, 'QEDSol.olean')): os.remove(os.path.join(rd, 'QEDSol.olean'))
        json.dump(res, open(os.path.join(out, c['name'], 'compile.json'), 'w'), indent=1)
        for mode in ('pipeline', 'raw'):
            if mode in res and res[mode]['code'] != 0:
                print(f"::group::{c['name']} {mode} compile log\n{res[mode]['log']}\n::endgroup::")
        print(f"[{time.strftime('%H:%M:%S')}] {c['name']}: pipeline={res['pipeline']['code']} {res['pipeline']['msg'][:150]}"
              + (f" | raw={res['raw']['code']} {res['raw']['msg'][:150]}" if 'raw' in res else ''), flush=True)


def outcome(stage_code_pairs):
    for stage, code in stage_code_pairs:
        if code != 0: return f'FAIL({stage})'
    return 'PASS'


def ok_for(expect, actual):
    if expect == 'pass': return actual == 'PASS'
    if expect == 'reject': return actual == 'FAIL(verify)'
    if expect == 'fail': return actual.startswith('FAIL')
    return False


def do_verify(inp):
    rows, bad = [], 0
    stmt_dirs = {}
    for c in load_cases():
        files = install(c)
        comp = json.load(open(os.path.join(inp, c['name'], 'compile.json')))
        # --- pipeline: trusted stage through check.py, like verify.yml ---
        p = comp['pipeline']
        if p['code'] != 0:
            actual, msg, log = 'FAIL(compile)', p['msg'], p['log']
        else:
            olean = os.path.join(inp, c['name'], 'pipeline', 'qedbuild', 'QEDSol.olean')
            code, o, dt = sh([sys.executable, '-I', 'scripts/check.py', '--stage=verify', f'--olean={olean}'] + files, env=check_env(c))
            actual, msg, log = ('PASS' if code == 0 else 'FAIL(verify)'), last_line(o), o
            if code == 0:
                try: msg = 'axioms: ' + ', '.join(json.load(open('check_result.json')).get('axioms', [])) or 'axioms: none'
                except Exception: pass
        good = ok_for(c['expect'], actual)
        bad += not good
        rows.append((c['name'], 'pipeline', c['expect'], actual, good, msg))
        print(f"[{time.strftime('%H:%M:%S')}] {c['name']} pipeline: {actual} (expected {c['expect']}) {msg[:200]}", flush=True)
        if not good: print(f"::group::{c['name']} pipeline log\n{p['log']}\n{log}\n::endgroup::")
        # --- raw: structural verifier alone on an unfiltered compile ---
        if c.get('raw'):
            r = comp['raw']
            if r['code'] != 0:
                actual, msg, log = 'FAIL(compile)', r['msg'], r['log']
            else:
                if c['id'] not in stmt_dirs:
                    sd = os.path.join('qedselftest-stmt', c['id'])
                    os.makedirs(sd, exist_ok=True)
                    open(os.path.join(sd, 'QEDStmt.lean'), 'w').write(open(os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')).read())
                    code, o, _ = lean([f'--root={sd}', os.path.join(sd, 'QEDStmt.lean'), '-o', os.path.join(sd, 'QEDStmt.olean')], [])
                    if code != 0: sys.exit(f"statement {c['id']} does not compile:\n{o}")
                    stmt_dirs[c['id']] = sd
                kind = json.load(open(os.path.join(c['dir'], 'meta.json')))['kind']
                nonce = secrets.token_hex(16)
                claim = f"OpenProblems.{c['id'].replace('-', '')}.Claim"
                rd = os.path.join(inp, c['name'], 'raw')
                code, o, _ = lean(['--run', 'scripts/qed_verify.lean', nonce, 'QEDStmt', 'QEDSol', claim, kind], [stmt_dirs[c['id']], rd])
                print(''.join(l + '\n' for l in o.splitlines() if l.startswith('[qed_verify') or 'TIMEOUT' in l), end='', flush=True)
                okline = re.search(rf'(?m)^QED-VERIFY {nonce} OK', o) is not None
                actual = 'PASS' if code == 0 and okline else 'FAIL(verify)'
                m = re.search(rf'(?m)^QED-VERIFY {nonce} (.*)$', o)
                msg, log = (m.group(1) if m else (o.strip().splitlines() or [''])[-1])[:300], o
            good = ok_for(c['raw'], actual)
            bad += not good
            rows.append((c['name'], 'raw', c['raw'], actual, good, msg))
            print(f"[{time.strftime('%H:%M:%S')}] {c['name']} raw: {actual} (expected {c['raw']}) {msg[:200]}", flush=True)
            if not good: print(f"::group::{c['name']} raw log\n{r['log']}\n{log}\n::endgroup::")
    w = max(len(r[0]) for r in rows)
    lines = [f"{'case':<{w}}  {'mode':<8}  {'expected':<8}  {'actual':<14}  ok   detail", '-' * (w + 60)]
    for n, mode, e, a, g, msg in rows:
        lines.append(f"{n:<{w}}  {mode:<8}  {e:<8}  {a:<14}  {'yes' if g else 'NO '}  {msg.replace(chr(10), ' ')[:160]}")
    lines.append(f"\n{len(rows) - bad}/{len(rows)} expectations hold")
    table = '\n'.join(lines)
    print(table)
    if os.environ.get('GITHUB_STEP_SUMMARY'):
        with open(os.environ['GITHUB_STEP_SUMMARY'], 'a') as f:
            f.write('### Verifier self-test\n```\n' + table + '\n```\n')
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    if len(sys.argv) != 3 or sys.argv[1] not in ('compile', 'verify'):
        sys.exit(__doc__)
    (do_compile if sys.argv[1] == 'compile' else do_verify)(sys.argv[2])
