# N-478 — Infinite monochromatic square-sum paths

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** Colour the positive integers red and blue. Show there is always an infinite increasing sequence of one colour in which every two consecutive terms sum to a perfect square.

**Math:** Prove every 2-colouring of $\mathbb{N}$ admits $a_1<a_2<\cdots$ of one colour with $a_i+a_{i+1}$ a perfect square for all $i$.

Difficulty estimate: 2.8/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N478.Claim` or a proof of `¬ OpenProblems.N478.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-478/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-478` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-478/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-478/Statement.lean to your file
theorem solution : OpenProblems.N478.Claim := by   -- or ¬ OpenProblems.N478.Claim
  ...
```
3. Add `solutions/N-478/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-478/<user>/Solution.lean`.
