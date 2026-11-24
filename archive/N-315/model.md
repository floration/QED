# N-315 — Triple factor map minus two

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** Map n to P(n) + P(n+1) + P(n+2) − 2. Tested starts reach the fixed points 8 or 33, a 13-step loop through 20, or a 9-step loop through 177. Prove nothing else happens.

**Math:** For $f(n)=P(n)+P(n+1)+P(n+2)-2$, prove every orbit reaches $\{8\}$, $\{33\}$, the 13-cycle through $20$, or the 9-cycle through $177$.

Difficulty estimate: 5.3/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N315.Claim` or a proof of `¬ OpenProblems.N315.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-315/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-315` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-315/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-315/Statement.lean to your file
theorem solution : OpenProblems.N315.Claim := by   -- or ¬ OpenProblems.N315.Claim
  ...
```
3. Add `solutions/N-315/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-315/<user>/Solution.lean`.
