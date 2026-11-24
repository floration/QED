# N-513 — Sofa beyond Gerver in 3 dimensions of turning

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** A 2D hallway that turns 90° twice in a row (an S-bend): find the best sofa.

**Math:** Determine the optimal sofa for the width-1 corridor with two consecutive right turns in opposite directions, separated by length $L$, for every $L>0$.

Difficulty estimate: 4.4/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N513.Claim` or a proof of `¬ OpenProblems.N513.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-513/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-513` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-513/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-513/Statement.lean to your file
theorem solution : OpenProblems.N513.Claim := by   -- or ¬ OpenProblems.N513.Claim
  ...
```
3. Add `solutions/N-513/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-513/<user>/Solution.lean`.
