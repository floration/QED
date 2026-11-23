# N-039 — Formalize 3D Kakeya

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** Turn the 2025 proof of the three-dimensional Kakeya conjecture into a compact computer-checked proof.

**Math:** Produce a Lean 4 formalization of the Wang–Zahl theorem ($\dim_H K=3$ for Kakeya $K\subset\mathbb{R}^3$) in under 50,000 lines beyond Mathlib.

Difficulty estimate: 2.9/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N039.Claim` or a proof of `¬ OpenProblems.N039.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-039/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-039` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-039/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-039/Statement.lean to your file
theorem solution : OpenProblems.N039.Claim := by   -- or ¬ OpenProblems.N039.Claim
  ...
```
3. Add `solutions/N-039/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-039/<user>/Solution.lean`.
