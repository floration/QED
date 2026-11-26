"""Self-test for the solution verifier (scripts/check.py, scripts/qed_trusted.py, scripts/qedexport).

Run by .github/workflows/verifier-selftest.yml, in two jobs that mirror verify.yml:

    python3 -I tests/verifier/selftest.py compile OUT   # untrusted stage: compile + export every case
    python3 -I tests/verifier/selftest.py verify  IN    # trusted stage, fresh runner: verify, print table

Only the text exports (*.ndjson) and small JSON results cross from the compile job to the verify job.

Each case is a folder tests/verifier/cases/<name>/ with case.json:
    {"id": "QED-Q1", "expect": "pass"|"fail", "raw": "pass"|"reject"|"fail" (optional),
     "partial": true (optional: files go to problems/<id>/partial/<user>/ instead of solutions/<id>/<user>/),
     "statement": "Statement.lean" (optional: a FAKE statement for an id that does not exist),
     "timeout": seconds (optional: QED_LEAN_TIMEOUT for this case),
     "expect_msg"/"raw_msg": regex the failure output must match (optional), "note": "..."}
plus the submission files.

Two modes per case:
  pipeline : the real thing: `check.py --stage=compile` here, `check.py --stage=verify` in the other job.
  raw      : (only if "raw" is given) compiled and exported WITHOUT check.py's text filters, then checked by
             scripts/qed_trusted.py directly, to test the trusted checker on its own.
             "reject" = must compile and then be rejected by the trusted checker; "fail" = rejected anywhere.
Every merged solution in solutions/<id>/<user>/ also goes through the pipeline and must pass.
Cases run in parallel (SELFTEST_JOBS, default 3), each in its own work directory and contribution folder.
Exit status of `verify` is 1 if any expectation is violated."""
import sys, os, re, json, shutil, subprocess, time, signal, threading
from concurrent.futures import ThreadPoolExecutor

ROOT = os.getcwd()
CASES = os.path.join(ROOT, 'tests', 'verifier', 'cases')
EXCLUDE = {'case.json', 'Statement.lean'}
JOBS = int(os.environ.get('SELFTEST_JOBS', '3'))
LOCK = threading.Lock()


def log(msg):
    with LOCK: print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def sh(args, env=None, timeout=None, stdout=None):
    """Run in its own process group; on timeout kill the group and keep the partial output."""
    timeout = timeout or int(os.environ.get('SELFTEST_TIMEOUT', '5400'))
    t = time.time()
    p = subprocess.Popen(args, stdout=stdout or subprocess.PIPE, stderr=subprocess.PIPE if stdout else subprocess.STDOUT,
                         text=True, env=env, cwd=ROOT, start_new_session=True)
    try:
        out, err = p.communicate(timeout=timeout)
        return p.returncode, (out or '') + (err or ''), time.time() - t
    except subprocess.TimeoutExpired:
        os.killpg(p.pid, signal.SIGKILL)
        out, err = p.communicate()
        return 124, (out or '') + (err or '') + f'\n[selftest] TIMEOUT after {timeout} s', time.time() - t


def lean_path():
    lp = os.environ.get('QED_LEAN_PATH')
    if not lp:
        code, out, _ = sh(['lake', 'env', 'printenv', 'LEAN_PATH'], timeout=600)
        if code != 0: sys.exit('could not get LEAN_PATH: ' + out)
        lp = os.environ['QED_LEAN_PATH'] = out.strip()
    return lp


def load_cases():
    cases = []
    for i, name in enumerate(sorted(os.listdir(CASES))):
        d = os.path.join(CASES, name)
        c = json.load(open(os.path.join(d, 'case.json')))
        files = sorted(os.path.relpath(os.path.join(dp, f), d) for dp, _, fs in os.walk(d) for f in fs
                       if os.path.relpath(os.path.join(dp, f), d) not in EXCLUDE)
        cases.append(dict(c, name=name, dir=d, files=files, user=f'selftest-{i:02d}', live=False))
    for pid in sorted(os.listdir(os.path.join(ROOT, 'solutions'))):
        for user in sorted(os.listdir(os.path.join(ROOT, 'solutions', pid))):
            d = os.path.join(ROOT, 'solutions', pid, user)
            if user.startswith('selftest-') or not os.path.isfile(os.path.join(d, 'Solution.lean')): continue
            files = sorted(os.path.relpath(os.path.join(dp, f), d) for dp, _, fs in os.walk(d) for f in fs)
            cases.append(dict(id=pid, expect='pass', note='merged solution on this branch', name=f'live-{pid}-{user}',
                              dir=d, files=files, user=user, live=True))
    return cases


def install_statements(cases):
    for c in cases:
        if not c.get('statement'): continue
        dst = os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')
        src = os.path.join(c['dir'], c['statement'])
        if os.path.exists(dst) and open(dst).read() != open(src).read():
            sys.exit(f"{c['name']}: refusing to overwrite the real statement {dst}")
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copyfile(src, dst)


def install(c):
    """Put the case's files where check.py expects them; return the repo-relative paths ("changed files")."""
    if c['live']:
        return [f"solutions/{c['id']}/{c['user']}/{f}" for f in c['files']]
    base = f"problems/{c['id']}/partial/{c['user']}" if c.get('partial') else f"solutions/{c['id']}/{c['user']}"
    d = os.path.join(ROOT, base)
    shutil.rmtree(d, ignore_errors=True)
    for f in c['files']:
        os.makedirs(os.path.dirname(os.path.join(d, f)), exist_ok=True)
        shutil.copyfile(os.path.join(c['dir'], f), os.path.join(d, f))
    g = c.get('generate')
    if g:   # e.g. a huge solution that would bloat the repository: prepend generated lines to Solution.lean
        sp = os.path.join(d, 'Solution.lean')
        body = open(sp).read()
        open(sp, 'w').write(''.join(g['line'] + '\n' for _ in range(int(g['count']))) + body)
    return [f'{base}/{f}' for f in c['files']]


def env_for(c, work):
    env = dict(os.environ, PR_AUTHOR=c['user'], QED_WORKDIR=work, QED_LEAN_PATH=lean_path(), QED_NANODA_THREADS='2')
    env.pop('BASE_REF', None)   # statements, checker and exporter come from this checkout (the branch under test)
    if c.get('timeout'): env['QED_LEAN_TIMEOUT'] = str(c['timeout'])
    return env


def summary(out):
    m = re.search(r'(?m)^(OK|FAIL: )(.*)$', out)
    if not m: return out.strip().splitlines()[-1][:400] if out.strip() else ''
    try:
        j = json.loads(m.group(2))
        return 'OK' if m.group(1) == 'OK' else (j.get('error', '') or '')
    except Exception:
        return m.group(0)[:400]


def strip_imports(t): return re.sub(r'(?m)^import .*$', '', t)


def raw_source(c):
    stmt = open(os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')).read()
    if c.get('partial'):
        srcs = [f for f in c['files'] if f.endswith('.lean')]
    else:
        srcs = sorted(f for f in c['files'] if f.endswith('.lean') and f != 'Solution.lean') + ['Solution.lean']
    return stmt + '\n' + '\n'.join(strip_imports(open(os.path.join(c['dir'], f)).read()) for f in srcs) + '\n'


def lenv(extra):
    return dict(os.environ, LEAN_PATH=os.path.abspath(extra) + os.pathsep + lean_path())


def exporter(): return os.environ.get('QED_EXPORTER', os.path.join(ROOT, 'scripts/qedexport/.lake/build/bin/qedexport'))


# ---------------------------------------------------------------- compile (untrusted)

def compile_case(c, out, tmp):
    files = install(c)
    res = {}
    work = os.path.join(tmp, c['name'], 'pipe')
    code, o, dt = sh([sys.executable, '-I', 'scripts/check.py', '--stage=compile'] + files, env=env_for(c, work))
    res['pipeline'] = {'code': code, 'msg': summary(o), 'secs': round(dt), 'files': files, 'log': o[-6000:]}
    dst = os.path.join(out, c['name'], 'pipeline', 'qedbuild')
    os.makedirs(dst, exist_ok=True)
    if code == 0:
        for f in os.listdir(os.path.join(work, 'qedbuild')):
            if f.endswith('.ndjson'): shutil.copyfile(os.path.join(work, 'qedbuild', f), os.path.join(dst, f))
    if c.get('raw'):
        rd = os.path.join(tmp, c['name'], 'raw'); od = os.path.join(out, c['name'], 'raw')
        os.makedirs(rd, exist_ok=True); os.makedirs(od, exist_ok=True)
        open(os.path.join(rd, 'QEDSol.lean'), 'w').write(raw_source(c))
        code, o, dt = sh(['lean', f'--root={rd}', os.path.join(rd, 'QEDSol.lean'), '-o', os.path.join(rd, 'QEDSol.olean')],
                         env=lenv(rd), timeout=c.get('timeout') or 2400)
        err = code != 0 or re.search(r':\d+:\d+: error', o) is not None
        if not err:
            with open(os.path.join(od, 'QEDSol.ndjson'), 'w') as f:
                code2, o2, _ = sh([exporter(), 'module', 'QEDSol'], env=lenv(rd), stdout=f)
            if code2 != 0: err, o = True, 'export failed: ' + o2
        first_err = next((l for l in o.splitlines() if 'error' in l), (o.strip().splitlines() or [''])[0])
        res['raw'] = {'code': 1 if err else 0, 'msg': first_err[:400] if err else 'compiled and exported',
                      'secs': round(dt), 'log': o[-6000:]}
    json.dump(res, open(os.path.join(out, c['name'], 'compile.json'), 'w'), indent=1)
    log(f"{c['name']}: pipeline={res['pipeline']['code']} ({res['pipeline']['secs']} s) {res['pipeline']['msg'][:150]}"
        + (f" | raw={res['raw']['code']} {res['raw']['msg'][:150]}" if 'raw' in res else ''))


def do_compile(out):
    os.makedirs(out, exist_ok=True)
    tmp = os.path.join(os.environ.get('RUNNER_TEMP', '/tmp'), 'selftest-work')
    cases = load_cases(); install_statements(cases); lean_path()
    with ThreadPoolExecutor(JOBS) as ex:
        for f in [ex.submit(compile_case, c, out, tmp) for c in cases]: f.result()


# ---------------------------------------------------------------- verify (trusted)

def outcome_ok(expect, actual):
    if expect == 'pass': return actual == 'PASS'
    if expect == 'reject': return actual == 'FAIL(verify)'
    if expect == 'fail': return actual.startswith('FAIL')
    return False


def verify_case(c, inp, tmp):
    rows = []
    files = install(c)
    comp = json.load(open(os.path.join(inp, c['name'], 'compile.json')))
    p = comp['pipeline']
    if p['code'] != 0:
        actual, msg, text = 'FAIL(compile)', p['msg'], p['log']
    else:
        work = os.path.join(tmp, c['name'], 'pipe')
        t = time.time()
        code, o, dt = sh([sys.executable, '-I', 'scripts/check.py', '--stage=verify',
                          f"--untrusted={os.path.join(inp, c['name'], 'pipeline')}"] + files, env=env_for(c, work))
        actual, msg, text = ('PASS' if code == 0 else 'FAIL(verify)'), summary(o), o
        if code == 0:
            try:
                j = json.load(open(os.path.join(work, 'check_result.json')))
                msg = f"axioms: {', '.join(j.get('axioms', [])) or 'none'}; {j.get('checked_decls', '?')} decls checked by nanoda, {j.get('new_decls', '?')} new"
            except Exception: pass
        msg += f' [{round(dt)} s]'
    good = outcome_ok(c['expect'], actual) and (actual == 'PASS' or not c.get('expect_msg') or re.search(c['expect_msg'], text) is not None)
    rows.append((c['name'], 'pipeline', c['expect'], actual, good, msg, text))
    if c.get('raw'):
        r = comp['raw']
        if r['code'] != 0:
            actual, msg, text = 'FAIL(compile)', r['msg'], r['log']
        else:
            wd = os.path.join(tmp, c['name'], 'raw')
            os.makedirs(wd, exist_ok=True)
            kind = 'partial' if c.get('partial') else json.load(open(os.path.join(c['dir'], 'meta.json')))['kind']
            claim = f"OpenProblems.{c['id'].replace('-', '')}.Claim"
            resf = os.path.join(wd, 'result.json')
            code, o, dt = sh([sys.executable, '-I', 'scripts/qed_trusted.py', f"--export={os.path.join(inp, c['name'], 'raw', 'QEDSol.ndjson')}",
                              f"--statement={os.path.join(ROOT, 'problems', c['id'], 'Statement.lean')}", f'--claim={claim}', f'--kind={kind}',
                              f'--workdir={wd}/work', f'--result={resf}', f'--lean-path={lean_path()}', f'--exporter={exporter()}',
                              f"--nanoda={os.environ.get('QED_NANODA', 'nanoda_bin')}"], env=dict(os.environ, QED_NANODA_THREADS='2'))
            try: j = json.load(open(resf))
            except Exception: j = {'ok': False, 'error': 'no result: ' + o[-500:]}
            actual = 'PASS' if code == 0 and j.get('ok') else 'FAIL(verify)'
            msg, text = ((f"axioms: {', '.join(j.get('axioms', [])) or 'none'}" if j.get('ok') else str(j.get('error'))) + f' [{round(dt)} s]'), str(j) + o
        good = outcome_ok(c['raw'], actual) and (actual == 'PASS' or not c.get('raw_msg') or re.search(c['raw_msg'], text) is not None)
        rows.append((c['name'], 'raw', c['raw'], actual, good, msg, text))
    for n, mode, e, a, g, m, _ in rows:
        log(f"{n} {mode}: {a} (expected {e}){'' if g else ' <-- UNEXPECTED'} {m[:200]}")
    return rows


def do_verify(inp):
    tmp = os.path.join(os.environ.get('RUNNER_TEMP', '/tmp'), 'selftest-work')
    cases = load_cases(); install_statements(cases); lean_path()
    with ThreadPoolExecutor(JOBS) as ex:
        rows = [r for f in [ex.submit(verify_case, c, inp, tmp) for c in cases] for r in f.result()]
    bad = [r for r in rows if not r[4]]
    for n, mode, e, a, g, m, text in bad:
        print(f"::group::{n} {mode} (expected {e}, got {a})\n{text[-6000:]}\n::endgroup::")
    w = max(len(r[0]) for r in rows)
    lines = [f"{'case':<{w}}  {'mode':<8}  {'expected':<8}  {'actual':<14}  ok   detail", '-' * (w + 60)]
    for n, mode, e, a, g, m, _ in rows:
        lines.append(f"{n:<{w}}  {mode:<8}  {e:<8}  {a:<14}  {'yes' if g else 'NO '}  {m.replace(chr(10), ' ')[:170]}")
    lines.append(f"\n{len(rows) - len(bad)}/{len(rows)} expectations hold")
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
