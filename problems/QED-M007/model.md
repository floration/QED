# QED-M007 — Charge on a Fermat conductor

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · Analysis

**Plain words:** Put a unit of electric charge on a perfectly conducting solid x^4+y^4+z^4 <= 1. Show that the surface charge is thinnest exactly at the six flat points (+-1,0,0),... and thickest exactly at the eight points in the diagonal directions.

**Math:** Let $K=\{x^4+y^4+z^4\le1\}\subset\mathbb R^3$ and let $\mu=\rho\,d\sigma$ be its Newtonian (capacitary) equilibrium measure, $\sigma$ surface measure on $\partial K$ ($\rho$ is real-analytic and positive since $\partial K$ is analytic). Prove that $\min_{\partial K}\rho$ is attained exactly at $(\pm1,0,0),(0,\pm1,0),(0,0,\pm1)$ and $\max_{\partial K}\rho$ exactly at $3^{-1/4}(\pm1,\pm1,\pm1)$.

**References:**
- https://arxiv.org/pdf/1911.03602
- https://arxiv.org/pdf/1509.09252

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM007.Claim` or a proof of `¬ OpenProblems.QEDM007.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M007/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M007` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M007/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M007/Statement.lean to your file
theorem solution : OpenProblems.QEDM007.Claim := by   -- or ¬ OpenProblems.QEDM007.Claim
  ...
```
3. Add `solutions/QED-M007/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M007/<user>/Solution.lean`.
