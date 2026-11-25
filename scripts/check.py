"""CI check for a contribution PR.

Usage: python3 -I scripts/check.py [--stage=all|compile|verify] [--olean=PATH] [--files-from=NUL_SEPARATED_FILE | <changed files...>]
Writes check_result.json. Exit 1 on failure. Fails closed: anything not recognised is rejected.

A PR is classified ONLY by the files it changes (never by branch name):
  solution : adds solutions/<id>/<author>/{Solution.lean, meta.json[, README.md][, more .lean files, subfolders allowed]}
  partial  : adds/updates files under problems/<id>/partial/<author>/ (.md, .txt, .lean)
Anything else (statements, data, scripts, workflows, mixed PRs) is rejected here and needs a maintainer.

Stages (CI runs them in two separate jobs, see .github/workflows/verify.yml):
  compile : UNTRUSTED. Classifies the PR, applies the text filters, and compiles
            <official statement> ++ <contribution> into qedbuild/QEDSol.olean (or checks partial work).
  verify  : TRUSTED, on a fresh runner that never elaborates contributor Lean. Re-classifies the PR,
            compiles the official statement alone into QEDStmt.olean, and runs scripts/qed_verify.lean,
            which loads QEDSol.olean as data, replays every new declaration through the kernel, and checks
            the root-level constant `solution` has type exactly `Claim` / `¬ Claim` with standard axioms only.
  all     : both, in one process (for local use)."""
import sys, os, re, json, subprocess, shutil, secrets, unicodedata

ID = r'(?:QED-[ME]\d{3}|QED-Q\d|N-000)'
USER = r'[A-Za-z0-9](?:[A-Za-z0-9-]{0,38})'
LEANPATH = r'(?:[A-Za-z0-9][A-Za-z0-9_-]*/)*[A-Za-z0-9][A-Za-z0-9_.-]*\.lean'
SOL = re.compile(rf'solutions/({ID})/({USER})/(meta\.json|README\.md|{LEANPATH})')
PART = re.compile(rf'problems/({ID})/partial/({USER})/([A-Za-z0-9._-]+\.(?:md|txt|lean))')
MAX_PARTIAL_BYTES = 5_000_000
BUILD = 'qedbuild'          # untrusted compile output (uploaded as an artifact by the compile job)
TRUSTED = 'qedtrusted'      # verify-stage working dir
VERIFIER = 'scripts/qed_verify.lean'

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
    json.dump(res, open('check_result.json', 'w')); print(('OK ' if code == 0 else 'FAIL: ') + json.dumps(res)); sys.exit(code)
def fail(msg): done({'ok': False, 'error': msg}, 1)

# ---------- arguments ----------
stage, olean_in, files = 'all', None, []
for a in sys.argv[1:]:
    if a.startswith('--stage='): stage = a.split('=', 1)[1]
    elif a.startswith('--olean='): olean_in = a.split('=', 1)[1]
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

_LP = None
def lean_path():
    global _LP
    if _LP is None:
        try: r = subprocess.run(['lake', 'env', 'printenv', 'LEAN_PATH'], capture_output=True, text=True, timeout=600)
        except (OSError, subprocess.TimeoutExpired) as e: fail(f'could not run lake: {e}')
        if r.returncode != 0: fail('could not determine LEAN_PATH:\n' + r.stderr[-2000:])
        _LP = r.stdout.strip()
    return _LP
def lean(args, extra_path=None, timeout=3600):
    env = dict(os.environ, LEAN_PATH=(os.path.abspath(extra_path) + os.pathsep if extra_path else '') + lean_path())
    try: r = subprocess.run(['lean'] + args, capture_output=True, text=True, timeout=timeout, env=env)
    except subprocess.TimeoutExpired: fail(f'Lean timed out after {timeout} s')
    except OSError as e: fail(f'could not run lean: {e}')
    return r.returncode, r.stdout + r.stderr
def has_error(out):
    return re.search(r'(^|\n)[^\n]*:\d+:\d+: error', out) is not None or 'error:' in out
def compile_module(dirname, modname, text):
    os.makedirs(dirname, exist_ok=True)
    src = os.path.join(dirname, modname + '.lean')
    open(src, 'w').write(text)
    return lean([f'--root={dirname}', src, '-o', os.path.join(dirname, modname + '.olean')])

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
    leans = [f for f in files if f.endswith('.lean')]
    for f in leans:
        body = re.sub(r'(?m)^import .*$', '', open(f).read())
        scan(f, body, META)
    if stage == 'verify':   # partial work has no proof obligation; it was compiled in the compile stage
        done({'ok': True, 'kind': 'partial', 'id': pid, 'user': user, 'files': files}, 0)
    for f in leans:
        # Partial Lean may use `sorry`, but must compile against the official statement.
        body = re.sub(r'(?m)^import .*$', '', open(f).read())
        shutil.rmtree(BUILD, ignore_errors=True)
        code, out = compile_module(BUILD, 'QEDPartial', stmt_txt + '\n' + body + '\n')
        if code != 0 or has_error(out): fail(f'Lean error in {f}:\n' + out[-3000:])
    done({'ok': True, 'kind': 'partial', 'id': pid, 'user': user, 'files': files}, 0)

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
    if stage == 'compile': done(dict(result, stage='compiled; not yet verified'), 0)
    olean_in = f'{BUILD}/QEDSol.olean'

# TRUSTED step (in CI: a separate job on a fresh runner that never elaborates contributor Lean).
if not olean_in or not os.path.isfile(olean_in) or os.path.islink(olean_in): fail('No compiled solution (.olean) to verify')
shutil.rmtree(TRUSTED, ignore_errors=True); os.makedirs(TRUSTED)
code, out = compile_module(TRUSTED, 'QEDStmt', stmt + '\n')
if code != 0 or has_error(out): fail('Official statement does not compile:\n' + out[-3000:])
shutil.copyfile(olean_in, f'{TRUSTED}/QEDSol.olean')
verifier = base_file(VERIFIER)
if verifier is None: fail(f'{VERIFIER} missing on the base branch')
open(f'{TRUSTED}/qed_verify.lean', 'w').write(verifier)
nonce = secrets.token_hex(16)
code, out = lean(['--run', f'{TRUSTED}/qed_verify.lean', nonce, 'QEDStmt', 'QEDSol', claim, meta['kind']], extra_path=TRUSTED)
m = re.search(rf'(?m)^QED-VERIFY {nonce} OK ?(.*)$', out)
if code != 0 or not m: fail('Verification failed:\n' + out[-3000:])
axioms = sorted(a.strip() for a in m.group(1).split(',') if a.strip())
done(dict(result, axioms=axioms), 0)
