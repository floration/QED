# QED-M012 — Non-arithmetic tones of the cube

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Analysis

**Plain words:** Many vibration frequencies of a cube's surface come from flat tori and are rational multiples of pi squared. Prove that at least one frequency is not of this form.

**Math:** Let $S$ be the boundary of the unit cube $[0,1]^3$ with its intrinsic flat metric (8 cone points of angle $3\pi/2$), and let $\Delta$ be the Friedrichs extension of the Laplacian on $S$. Prove that some eigenvalue of $\Delta$ is not in $\pi^2\mathbb{Q}$.

**References:**
- https://arxiv.org/abs/1809.09909
- https://www.numdam.org/item/CRMATH_2002__335_12_1047_0

Difficulty estimate: 5.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM012.Claim` or a proof of `¬ OpenProblems.QEDM012.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M012/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M012` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M012/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M012/Statement.lean to your file
theorem solution : OpenProblems.QEDM012.Claim := by   -- or ¬ OpenProblems.QEDM012.Claim
  ...
```
3. Add `solutions/QED-M012/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M012/<user>/Solution.lean`.
