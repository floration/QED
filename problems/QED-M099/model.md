# QED-M099 — Ising spin at a cube corner

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · Probability

**Plain words:** Glue three quarter-planes of the square grid into the surface of an infinite cube corner (a flat cone of angle 3π/2) and run the critical Ising model. Prove that the spin at the corner decorrelates with the exponent 7/24 predicted by conformal field theory.

**Math:** Let $\Gamma$ be the union of the three quadrant lattices $\mathbb Z_{\ge0}^2$ on the faces of $\partial\mathbb R_{\ge0}^3$, glued along the coordinate axes, with apex $o$ (degree 3; every other vertex has degree 4). Let $\langle\cdot\rangle$ be the infinite-volume limit of the nearest-neighbour Ising model at $\beta_c=\tfrac12\log(1+\sqrt2)$ with free boundary conditions on $\Gamma\cap\{\|x\|_\infty\le n\}$. Prove $\langle\sigma_o\sigma_x\rangle\asymp|x|^{-7/24}$ as $|x|\to\infty$.

**Credit:** Chelkak, Hongler, Izyurov, Conformal invariance of spin correlations in the planar Ising model, Ann. Math. 2015 (arXiv:1202.2838)

**QED results so far (reviewer-derived; check before relying on them):** The CFT step is correct. With w=z^{4/3}, the apex spin has dimension (2pi/alpha)(1/8)=1/6, and 1/6+1/8=7/24. For alpha=2pi the formula gives back 1/4. The lattice description is right: the apex has degree 3 and axis vertices have degree 4. The beta_c value is right. The free-boundary infinite-volume limit exists by GKS monotonicity. The apex defect is irrelevant (energy dimension >0), so 7/24 should be universal.

**References:**
- https://arxiv.org/pdf/2103.10263
- https://arxiv.org/abs/2104.12858
- https://arxiv.org/abs/cond-mat/0306396
- https://ar5iv.arxiv.org/html/1712.04192
- https://arxiv.org/pdf/1712.04192
- https://arxiv.org/abs/2104.12858
- https://arxiv.org/abs/cond-mat/0306396
- https://arxiv.org/abs/2006.14559

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM099.Claim` or a proof of `¬ OpenProblems.QEDM099.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M099/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M099` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M099/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M099/Statement.lean to your file
theorem solution : OpenProblems.QEDM099.Claim := by   -- or ¬ OpenProblems.QEDM099.Claim
  ...
```
3. Add `solutions/QED-M099/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M099/<user>/Solution.lean`.
