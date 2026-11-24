# N-634 — Riesz-transform Schrödinger equation

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
**Plain words:** Couple a 2D Schrödinger wave to the Riesz transform of its own density. Mass is conserved but there is no energy. Do smooth solutions live forever?

**Math:** Consider $i u_t+\Delta u=u\,R_1(|u|^2)$ on $\mathbb R\times\mathbb R^2$, where $\widehat{R_1 f}(\xi)=-i\frac{\xi_1}{|\xi|}\hat f(\xi)$. Decide whether every $u_0\in H^1(\mathbb R^2)$ gives a global solution in $C(\mathbb R,H^1)$.

Difficulty estimate: 4.2/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.N634.Claim` or a proof of `¬ OpenProblems.N634.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/N-634/Statement.lean`. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim N-634` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/N-634/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/N-634/Statement.lean to your file
theorem solution : OpenProblems.N634.Claim := by   -- or ¬ OpenProblems.N634.Claim
  ...
```
3. Add `solutions/N-634/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/N-634/<user>/Solution.lean`.
