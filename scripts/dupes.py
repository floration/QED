"""Near-duplicate detection across live (main, extended, tests) and archived problems.
TF-IDF cosine similarity over title + plain + math (word unigrams and bigrams, LaTeX stripped).
Usage: python3 scripts/dupes.py [--threshold 0.25] [--fail 0.5]   (calibrated on the Nov 2026 corpus: known overlaps score 0.26-0.31)
Prints the most similar pairs. Exits 1 if two LIVE problems are at or above --fail similarity, unless the
pair is listed in data/dupes_allowlist.json as ["QED-Mxxx", "QED-Exxx"] (a reviewed, intentional overlap)."""
import json, math, re, sys, os
from collections import Counter

args = sys.argv[1:]
def opt(name, default):
    return float(args[args.index(name) + 1]) if name in args else default
TH, FAIL = opt('--threshold', 0.25), opt('--fail', 0.5)

STOP = set('a an the of in on and or to for is are be by with as that this it its at from into if then than any every each all '
           'some no not there their which what when where whether prove disprove show find determine known open problem conjecture '
           'let we one two can does do such least most equal'.split())

def words(t):
    t = re.sub(r'\$[^$]*\$', lambda m: ' ' + re.sub(r'[\\{}^_]', ' ', m.group(0)) + ' ', t or '')
    w = [x for x in re.findall(r'[a-zA-Z][a-zA-Z0-9]+', t.lower()) if x not in STOP and len(x) > 2]
    return w + [a + '_' + b for a, b in zip(w, w[1:])]

docs = []
for path, live in (('data/main.json', True), ('data/extended.json', True), ('data/qtests.json', True), ('data/archive.json', False)):
    if os.path.exists(path):
        for p in json.load(open(path)):
            docs.append((p['id'], live, p.get('title', ''), Counter(words(' '.join([p.get('title', '')] * 3 + [p.get('plain', ''), p.get('math', '')])))))

df = Counter(t for _, _, _, c in docs for t in c)
N = len(docs)
vecs = []
for pid, live, title, c in docs:
    v = {t: (1 + math.log(n)) * math.log(N / df[t]) for t, n in c.items()}
    norm = math.sqrt(sum(x * x for x in v.values())) or 1
    vecs.append({t: x / norm for t, x in v.items()})

allow = set()
if os.path.exists('data/dupes_allowlist.json'):
    allow = {frozenset(p) for p in json.load(open('data/dupes_allowlist.json'))}

pairs = []
for i in range(N):
    for j in range(i + 1, N):
        if not (docs[i][1] or docs[j][1]): continue   # skip archive-vs-archive
        a, b = vecs[i], vecs[j]
        if len(a) > len(b): a, b = b, a
        s = sum(x * b.get(t, 0) for t, x in a.items())
        if s >= TH: pairs.append((s, i, j))
pairs.sort(reverse=True)
bad = 0
for s, i, j in pairs[:60]:
    (p, lp, tp, _), (q, lq, tq, _) = docs[i], docs[j]
    both = lp and lq; flag = both and s >= FAIL and frozenset((p, q)) not in allow
    bad += flag
    print(f'{s:.2f} {"FAIL " if flag else ""}{p}{"" if lp else " (archived)"} "{tp[:50]}"  <->  {q}{"" if lq else " (archived)"} "{tq[:50]}"')
print(f'{len(pairs)} pair(s) at or above {TH}; {bad} live pair(s) at or above {FAIL} not in the allowlist')
sys.exit(1 if bad else 0)
