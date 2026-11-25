"""Generate problems/<id>/{problem.json,model.md,Statement.lean} and data/problems.json from
data/main.json (QED-Mxxx, the main set) and data/extended.json (QED-Exxx, the extended set).
Usage: python3 scripts/gen_main.py [--statements]
  --statements  also (re)write Statement.lean from the `lean` field of each entry.
Without it, an existing Statement.lean is never overwritten."""
import json,sys,os
REPO=os.environ.get('REPO','floration/qed')
D=json.load(open('data/main.json'))+json.load(open('data/extended.json'))+json.load(open('data/qtests.json'))
WRITE_LEAN='--statements' in sys.argv
PUB=('id','set','title','area','difficulty','grade','provenance','credit','results','premise_risks','plain','math',
     'novelty','importance','value','formal_status','lean_gap','review_note','est_lines','refs')
out=[]
for m in D:
    pid=m['id']; ns=pid.replace('-',''); d=f'problems/{pid}'; os.makedirs(d,exist_ok=True)
    p={k:m.get(k) for k in PUB if m.get(k) not in (None,[],'')}
    json.dump(p,open(f'{d}/problem.json','w'),ensure_ascii=False,indent=1); out.append(p)
    sp=f'{d}/Statement.lean'
    if m.get('lean'):
        if WRITE_LEAN or not os.path.exists(sp): open(sp,'w').write(m['lean'].rstrip()+'\n')
    elif WRITE_LEAN or not os.path.exists(sp) or f'namespace OpenProblems.{ns}' not in open(sp).read():
        open(sp,'w').write(f"""import Mathlib
/-! {pid}: {m['title']}
{m['plain']}
Informal statement: {m['math']}
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-{pid}`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.{ns}
def Claim : Prop := sorry
end OpenProblems.{ns}
""")
    extra=''
    if m.get('review_note'): extra+=f"\n**Reviewer note:** {m['review_note']}\n"
    if m.get('credit'): extra+=f"\n**Credit:** {m['credit']}\n"
    if m.get('results'): extra+=f"\n**QED results so far (reviewer-derived; check before relying on them):** {m['results']}\n"
    if m.get('premise_risks'): extra+='\n**Rests on recent unrefereed work. Check these premises first:**\n'+''.join(f'- {r}\n' for r in m['premise_risks'])
    if m.get('refs'): extra+='\n**References:**\n'+''.join(f'- {r}\n' for r in m['refs'][:12])
    formal=("If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); "
            "a faithful formalization is itself a welcome contribution."+(f" What is missing: {m['lean_gap']}" if m.get('lean_gap') else ''))
    open(f'{d}/model.md','w').write(f"""# {pid} — {m['title']}

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
{ {'main':'Main set','extended':'Extended set','test':'Submission test'}[m['set']] }{' · Grade '+m['grade'] if m['set']!='test' else ''}{' · QED '+m['provenance'] if m.get('provenance') else ''} · {m.get('area','')}

**Plain words:** {m['plain']}

**Math:** {m['math']}
{extra}
Difficulty estimate: {m.get('difficulty')}/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.{ns}.Claim` or a proof of `¬ OpenProblems.{ns}.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/{pid}/Statement.lean`. Read its "Formalization notes" first. {formal}

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim {pid}` at https://github.com/{REPO}/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/{pid}/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/{pid}/Statement.lean to your file
theorem solution : OpenProblems.{ns}.Claim := by   -- or ¬ OpenProblems.{ns}.Claim
  ...
```
3. Add `solutions/{pid}/<github-username>/meta.json`: `{{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/{pid}/<user>/Solution.lean`.
""")
if os.path.exists('problems/N-000/problem.json'): out.insert(0,json.load(open('problems/N-000/problem.json')))
json.dump(out,open('data/problems.json','w'),ensure_ascii=False)
print(len(out),'problems')
