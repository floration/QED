"""Generate problems/N-xxx/{problem.json,model.md,Statement.lean} and data/problems.json from D2.json.
Usage: python3 scripts/gen.py path/to/D2.json   (re-running never overwrites a Statement.lean that has been formalized)"""
import json,sys,os
D=json.load(open(sys.argv[1])); REPO=os.environ.get('REPO','floration/qed')
out=[]
for r in D:
    pid,title,rating,area,W,M=r[:6]; adv=r[7]
    d=f'problems/{pid}'; os.makedirs(d,exist_ok=True)
    p=dict(id=pid,title=title,area=area,difficulty=(adv[0] if adv else rating),plain=W,math=M)
    json.dump(p,open(f'{d}/problem.json','w'),ensure_ascii=False,indent=1); out.append(p)
    ns=pid.replace('-','')
    sp=f'{d}/Statement.lean'
    if not os.path.exists(sp):
        open(sp,'w').write(f"""import Mathlib
/-! {pid}: {title}
{W}
Informal statement: {M}
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.{ns}
def Claim : Prop := sorry
end OpenProblems.{ns}
""")
    open(f'{d}/model.md','w').write(f"""# {pid} — {title}

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** {W}

**Math:** {M}

Difficulty estimate: {p['difficulty']}/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.{ns}.Claim` or a proof of `¬ OpenProblems.{ns}.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/{pid}/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
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
