"""CI check for a contribution PR. Usage: python3 scripts/check.py <changed files...>
Writes check_result.json. Exit 1 on failure. Fails closed: anything not recognised is rejected.

A PR is classified ONLY by the files it changes (never by branch name):
  solution : adds solutions/<id>/<author>/{Solution.lean, meta.json[, README.md][, more .lean files, subfolders allowed]}
  partial  : adds/updates files under problems/<id>/partial/<author>/ (.md, .txt, .lean)
Anything else (statements, data, scripts, workflows, mixed PRs) is rejected here and needs a maintainer."""
import sys, os, re, json, subprocess

ID = r'(?:QED-[ME]\d{3}|QED-Q\d|N-000)'
USER = r'[A-Za-z0-9](?:[A-Za-z0-9-]{0,38})'
LEANPATH = r'(?:[A-Za-z0-9][A-Za-z0-9_-]*/)*[A-Za-z0-9][A-Za-z0-9_.-]*\.lean'
SOL = re.compile(rf'solutions/({ID})/({USER})/(meta\.json|README\.md|{LEANPATH})')
PART = re.compile(rf'problems/({ID})/partial/({USER})/([A-Za-z0-9._-]+\.(?:md|txt|lean))')
ALLOWED_AXIOMS = {'propext', 'Classical.choice', 'Quot.sound'}
MAX_PARTIAL_BYTES = 5_000_000

files = [f for f in sys.argv[1:] if f.strip()]
author = os.environ.get('PR_AUTHOR', '')

def done(res, code):
    json.dump(res, open('check_result.json', 'w')); print(('OK ' if code == 0 else 'FAIL: ') + json.dumps(res)); sys.exit(code)
def fail(msg): done({'ok': False, 'error': msg}, 1)
BASE = os.environ.get('BASE_REF', '')
def base_file(path):
    """Read a file as it is on the base branch, so a PR can never change the statement it is checked against."""
    if BASE:
        r = subprocess.run(['git', 'show', f'origin/{BASE}:{path}'], capture_output=True, text=True)
        return r.stdout if r.returncode == 0 else None
    return open(path).read() if os.path.exists(path) else None
def lean(path):
    r = subprocess.run(['lake', 'env', 'lean', path], capture_output=True, text=True, timeout=3600)
    return r.returncode, r.stdout + r.stderr
def has_error(out):
    return re.search(r'(^|\n)[^\n]*:\d+:\d+: error', out) is not None or 'error:' in out

if not files: fail('PR changes no files')
for f in files:
    if not os.path.isfile(f): fail(f'{f} is deleted or not a regular file; deletions and renames need a maintainer')
if not author: fail('PR author unknown')

sol = [SOL.fullmatch(f) for f in files]
part = [PART.fullmatch(f) for f in files]

# ---------- partial work ----------
if all(part):
    ids = {m.group(1) for m in part}; users = {m.group(2) for m in part}
    if len(ids) != 1 or len(users) != 1: fail('A partial-work PR must touch exactly one problems/<id>/partial/<username>/ folder')
    pid, user = ids.pop(), users.pop()
    if user.lower() != author.lower(): fail(f'Folder name {user} must match PR author {author}')
    for f in files:
        if os.path.getsize(f) > MAX_PARTIAL_BYTES: fail(f'{f} is larger than {MAX_PARTIAL_BYTES} bytes')
    leans = [f for f in files if f.endswith('.lean')]
    stmt_txt = base_file(f'problems/{pid}/Statement.lean')
    if stmt_txt is None: fail(f'Unknown problem {pid}')
    for f in leans:
        body = open(f).read()
        for bad in [r'\baxiom\b', r'\bset_option\b', r'\bimplemented_by\b', r'\bextern\b', r'\bunsafe\b', r'#exit', r'#eval',
                    r'\brun_cmd\b', r'\brun_tac\b', r'\brun_elab\b', r'\belab\b', r'\bmacro\b', r'\bsyntax\b', r'\binitialize\b', r'\bIO\b']:
            if re.search(bad, re.sub(r'(?m)^import .*$', '', body)): fail(f'Forbidden token in {f}: {bad}')
        # Partial Lean may use `sorry`, but must compile against the official statement.
        open('Check.lean', 'w').write(stmt_txt + '\n' + re.sub(r'(?m)^import .*$', '', body) + '\n')
        code, out = lean('Check.lean')
        if code != 0 or has_error(out): fail(f'Lean error in {f}:\n' + out[-3000:])
    done({'ok': True, 'kind': 'partial', 'id': pid, 'user': user, 'files': files}, 0)

# ---------- full solution ----------
if not all(sol):
    fail('Not an automatic contribution. Solution PRs may only add files in solutions/<id>/<username>/ (Solution.lean, meta.json, README.md, extra .lean files); '
         'partial-work PRs may only touch problems/<id>/partial/<username>/. Anything else needs a maintainer.')
dirs = {(m.group(1), m.group(2)) for m in sol}
if len(dirs) != 1: fail('One solution per PR')
pid, user = dirs.pop()
if user.lower() != author.lower(): fail(f'Folder name {user} must match PR author {author}')
d = f'solutions/{pid}/{user}'
if not os.path.exists(f'{d}/Solution.lean') or not os.path.exists(f'{d}/meta.json'): fail('Need Solution.lean and meta.json')
src = open(f'{d}/Solution.lean').read()
# Extra .lean files (helpers) are concatenated in sorted path order before Solution.lean.
extras = sorted(f for f in files if f.endswith('.lean') and f != f'{d}/Solution.lean')
srcs = [(f, open(f).read()) for f in extras] + [(f'{d}/Solution.lean', src)]
try: meta = json.load(open(f'{d}/meta.json'))
except Exception as e: fail(f'meta.json is not valid JSON: {e}')
if meta.get('kind') not in ('proof', 'disproof') or not isinstance(meta.get('model'), str) or not meta['model'].strip():
    fail('meta.json needs "model" (string) and "kind": proof|disproof')
stmt = base_file(f'problems/{pid}/Statement.lean')
if stmt is None: fail(f'Unknown problem {pid}')
if re.search(r'def Claim : Prop := sorry', stmt): fail(f'{pid} is not formalized yet; formalize Statement.lean first')
body = '\n'.join(f'-- file: {f}\n' + re.sub(r'(?m)^import .*$', '', t) for f, t in srcs)
for bad in [r'\bsorry\b', r'\badmit\b', r'\baxiom\b', r'\bset_option\b', r'\bimplemented_by\b', r'\bextern\b', r'\bunsafe\b',
            r'\bdef Claim\b', r'\bnamespace OpenProblems\b', r'\bnative_decide\b', r'#exit', r'\bopaque\b', r'#eval', r'\brun_cmd\b',
            r'\brun_tac\b', r'\brun_elab\b', r'\belab\b', r'\bmacro\b', r'\bsyntax\b', r'\binitialize\b', r'\bIO\b', r'#print',
            r'\bofReduceBool\b', r'\bLean\.trustCompiler\b']:
    if re.search(bad, body): fail(f'Forbidden token: {bad}')
ns = pid.replace('-', '')
target = f'OpenProblems.{ns}.Claim' if meta['kind'] == 'proof' else f'¬ OpenProblems.{ns}.Claim'
MARK = '<<<QED-AXIOMS>>>'
open('Check.lean', 'w').write(stmt + '\n' + body + f'\nexample : {target} := solution\n#eval IO.println "{MARK}"\n#print axioms solution\n')
code, out = lean('Check.lean')
if code != 0 or has_error(out): fail('Lean error:\n' + out[-3000:])
# Fail closed: the axiom report must be present and parseable; otherwise reject.
tail = out.split(MARK, 1)[1] if MARK in out else ''
if not tail: fail('Could not find the axiom report; rejecting')
if re.search(r"'solution' does not depend on any axioms", tail):
    axioms = set()
else:
    ax = re.search(r"'solution' depends on axioms: \[(.*?)\]", tail, re.S)
    if not ax: fail('Could not parse the axiom report; rejecting:\n' + tail[-1000:])
    axioms = {a.strip() for a in ax.group(1).split(',') if a.strip()}
if axioms - ALLOWED_AXIOMS: fail('Uses non-standard axioms: ' + ', '.join(sorted(axioms - ALLOWED_AXIOMS)))
lines = [l for _, t in srcs for l in re.sub(r'/-.*?-/', '', t, flags=re.S).splitlines()
         if l.strip() and not l.strip().startswith('--') and not l.startswith('import ')]
done({'ok': True, 'kind': 'solution', 'id': pid, 'user': user, 'model': meta['model'], 'proof_kind': meta['kind'],
      'size': len(lines), 'files': [f for f, _ in srcs], 'axioms': sorted(axioms)}, 0)
