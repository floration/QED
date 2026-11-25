# QED-M140 — Least volume of a Kakeya set for discs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Geometry

**Plain words:** A set in space contains a flat unit disc in every orientation. How small can its volume be? Such sets cannot have zero volume, unlike sets containing a needle in every direction.

**Math:** For a unit vector ν let D_ν = {x ∈ ℝ³ : x·ν = 0, |x| ≤ 1}, and c_* = inf{|E| : E ⊂ ℝ³ compact, ∀ν ∃x_ν, x_ν + D_ν ⊂ E} (c_* > 0 by Marstrand/Falconer). Decide whether c_* < (4/3)π, i.e. whether some compact set containing a translate of every D_ν has smaller volume than the unit ball. (Determining c_* exactly and whether the infimum is attained are further questions.)

**Credit:** QED original (archived Nov 2026, restored after re-review).

**References:**
- https://www.cambridge.org/core/journals/mathematical-proceedings-of-the-cambridge-philosophical-society/article/abs/some-remarks-on-the-kakeya-problem/F994CB74D52930B6A0209D8F52B66627
- https://arxiv.org/abs/2610.33734
- https://en.wikipedia.org/wiki/Kakeya_set

Difficulty estimate: 4.1/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM140.Claim` or a proof of `¬ OpenProblems.QEDM140.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M140/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M140` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M140/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M140/Statement.lean to your file
theorem solution : OpenProblems.QEDM140.Claim := by   -- or ¬ OpenProblems.QEDM140.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-M140/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M140/<user>/Solution.lean`.
