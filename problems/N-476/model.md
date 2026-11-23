# N-476 — Five squares of seven-free primes

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** Show every large number of the right residue is a sum of five squares of primes without the digit 7.

**Math:** Prove every sufficiently large $n\equiv5\pmod{24}$ is $p_1^2+\dots+p_5^2$ with all $p_i$ prime and free of the decimal digit 7.

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N476.Claim` or a proof of `¬ OpenProblems.N476.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-476/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-476` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-476/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-476/Statement.lean to your file
theorem solution : OpenProblems.N476.Claim := by   -- or ¬ OpenProblems.N476.Claim
  ...
```
3. Add `solutions/N-476/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-476/<user>/Solution.lean`.
