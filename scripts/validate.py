"""Validate the problem dataset and repo layout. Exit 1 on any error. Usage: python3 scripts/validate.py"""
import json, os, re, sys

errs = []
def err(m): errs.append(m)

FMT = {'main': r'QED-M\d{3}', 'extended': r'QED-E\d{3}', 'test': r'QED-Q\d'}
GRADES = {'main': {'A', 'B'}, 'extended': {'A', 'B', 'B-', 'C'}, 'test': {'Q'}}  # main is capped at ~100, so strong problems can live in extended
PROV = {None, 'Original', 'Extension', 'Curated'}
FORMAL = {'formalized', 'not_formalized'}
REQ = {'id': str, 'set': str, 'title': str, 'area': str, 'grade': str, 'plain': str, 'math': str, 'formal_status': str}
OPT = {'difficulty': (int, float), 'provenance': (str, type(None)), 'credit': (str, type(None)), 'results': (str, type(None)),
       'premise_risks': list, 'refs': list, 'novelty': (int, float, type(None)), 'importance': (int, float, type(None)),
       'value': (int, float, type(None)), 'lean': (str, type(None)), 'lean_gap': (str, type(None)), 'review_note': (str, type(None)),
       'est_lines': (int, type(None))}
SORRY = 'def Claim : Prop := sorry'

def load(p):
    try: return json.load(open(p))
    except Exception as e: err(f'{p}: cannot parse JSON ({e})'); return []

live = []
for path, st in (('data/main.json', 'main'), ('data/extended.json', 'extended'), ('data/qtests.json', 'test')):
    D = load(path)
    if not isinstance(D, list): err(f'{path}: must be a list'); continue
    for i, p in enumerate(D):
        where = f'{path}[{i}]'
        if not isinstance(p, dict): err(f'{where}: not an object'); continue
        pid = p.get('id', '?'); where = f'{path} {pid}'
        for k, t in REQ.items():
            if not isinstance(p.get(k), t) or (t is str and not p[k].strip()): err(f'{where}: field {k} missing or not a non-empty {t.__name__}')
        for k, t in OPT.items():
            if k in p and not isinstance(p[k], t): err(f'{where}: field {k} has wrong type')
        if p.get('set') != st: err(f'{where}: set should be {st!r}')
        if not re.fullmatch(FMT[st], str(pid)): err(f'{where}: id does not match {FMT[st]}')
        if p.get('grade') not in GRADES[st]: err(f'{where}: grade {p.get("grade")!r} not allowed in {st}')
        if p.get('provenance') not in PROV: err(f'{where}: provenance {p.get("provenance")!r} not allowed')
        if p.get('formal_status') not in FORMAL: err(f'{where}: formal_status {p.get("formal_status")!r} not allowed')
        d = p.get('difficulty')
        if isinstance(d, (int, float)) and not 0 <= d <= 10: err(f'{where}: difficulty out of range 0-10')
        live.append(p)

ids = [p.get('id') for p in live]
for x in {i for i in ids if ids.count(i) > 1}: err(f'duplicate id {x}')
titles = [p.get('title', '').strip().lower() for p in live]
for t in {t for t in titles if t and titles.count(t) > 1}: err(f'duplicate title {t!r}')

arc = load('data/archive.json')
arc_ids = {a.get('id') for a in arc if isinstance(a, dict)}
for x in arc_ids & set(ids): err(f'{x} is both live and archived')
for a in arc:
    if isinstance(a, dict) and not (isinstance(a.get('reason'), str) and a['reason'].strip()): err(f'archive {a.get("id")}: missing reason')

for p in live:
    pid = p.get('id'); d = f'problems/{pid}'
    for f in ('problem.json', 'model.md', 'Statement.lean'):
        if not os.path.isfile(f'{d}/{f}'): err(f'{d}/{f} missing')
    sp = f'{d}/Statement.lean'
    if not os.path.isfile(sp): continue
    s = open(sp).read(); ns = pid.replace('-', '')
    if not re.search(rf'(?m)^namespace OpenProblems\.{ns}\s*$', s): err(f'{sp}: namespace OpenProblems.{ns} missing')
    if not re.search(rf'(?m)^end OpenProblems\.{ns}\s*$', s): err(f'{sp}: end OpenProblems.{ns} missing')
    if not re.search(r'(?m)^\s*(noncomputable\s+)?def Claim\s*:\s*Prop\s*:=', s): err(f'{sp}: no `def Claim : Prop :=`')
    stub = SORRY in s
    if p.get('formal_status') == 'formalized' and stub: err(f'{pid}: marked formalized but Statement.lean is a sorry stub')
    if p.get('formal_status') == 'not_formalized' and not stub: err(f'{pid}: marked not_formalized but Statement.lean has a statement')
    body = re.sub(r'/-.*?-/', '', s, flags=re.S); body = re.sub(r'--.*', '', body)
    if not stub:
        for bad in (r'\bsorry\b', r'\badmit\b', r'^\s*axiom\b', r'\bset_option\b', r'^\s*opaque\b'):
            if re.search(bad, body, re.M): err(f'{sp}: forbidden {bad} in a formalized statement')
    if p.get('lean') and p['lean'].rstrip() != s.rstrip(): err(f'{pid}: data `lean` field differs from {sp} (run scripts/gen_main.py --statements)')

pub = load('data/problems.json')
pub_ids = {q.get('id') for q in pub if isinstance(q, dict)}
for x in set(ids) - pub_ids: err(f'{x} missing from data/problems.json (run scripts/gen_main.py)')

known = set(ids) | {'N-000'}
for pid in sorted(os.listdir('problems')):
    if pid not in known: err(f'problems/{pid}: folder has no entry in main/extended/qtests')
    pd = f'problems/{pid}/partial'
    if os.path.isdir(pd):
        for u in os.listdir(pd):
            if not re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9-]{0,38}', u) or not os.path.isdir(f'{pd}/{u}'): err(f'{pd}/{u}: not a username folder')
if os.path.isdir('solutions'):
    for pid in os.listdir('solutions'):
        if pid not in known and pid not in arc_ids: err(f'solutions/{pid}: unknown problem id')

if errs:
    print(f'{len(errs)} validation error(s):'); [print(' -', e) for e in errs]; sys.exit(1)
print(f'OK: {len(live)} live problems ({sum(p["set"]=="main" for p in live)} main, {sum(p["set"]=="extended" for p in live)} extended, '
      f'{sum(p["set"]=="test" for p in live)} tests), {len(arc_ids)} archived')
