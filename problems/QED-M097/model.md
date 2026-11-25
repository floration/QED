# QED-M097 — Mass-critical scattering on flat cones

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade A · QED Extension · PDE

**Plain words:** Dodson proved that the defocusing cubic Schrodinger equation in the plane scatters for every finite-mass initial state. Prove the same on every flat cone, a plane with a single conical singularity of total angle alpha. For alpha = 2pi/k it follows from Dodson by symmetry, and radial data are also easy. Every other angle, such as the surface of a cube corner (alpha = 3pi/2) or alpha > 2pi, is open.

**Math:** For $\alpha>0$ let $\mathcal C_\alpha=(0,\infty)\times(\mathbb R/\alpha\mathbb Z)$ with metric $dr^2+r^2d\theta^2$ and $\Delta$ the Friedrichs extension of the Laplacian on $C_c^\infty(\mathcal C_\alpha)$. Prove that for every $\alpha>0$ and every $u_0\in L^2(\mathcal C_\alpha)$ the solution of $iu_t+\Delta u=|u|^2u$, $u(0)=u_0$, is global with $\|u\|_{L^4_{t,x}(\mathbb R\times\mathcal C_\alpha)}<\infty$, hence scatters in $L^2$. (Known: $\alpha=2\pi/k$, since $\mathcal C_{2\pi/k}=\mathbb R^2/\mathbb Z_k$ and Dodson applies to $\mathbb Z_k$-invariant data. Radial data for any $\alpha$, since the radial equation coincides with the 2D one.)

**Credit:** B. Dodson, global well-posedness and scattering for the defocusing L^2-critical NLS in d=2 (Duke Math. J. 2016)

**QED results so far (reviewer-derived; check before relying on them):** Both trivial cases check out. For alpha=2pi/k, C_alpha=R^2/Z_k: the Friedrichs modes e^{ikmθ} with Bessel order k|m| match the Z_k-invariant plane functions, and Dodson applies for any mass, with mass scaled by k. For radial data the m=0 mode on the cone is the 2D radial Laplacian. The sign convention iu_t+Δu=+|u|^2u is defocusing.

**References:**
- https://arxiv.org/abs/1702.05813
- https://arxiv.org/pdf/1105.5410
- https://arxiv.org/pdf/2504.06045
- https://arxiv.org/pdf/0707.3188
- https://ar5iv.arxiv.org/html/1909.03572
- https://arxiv.org/abs/1702.05813
- https://arxiv.org/abs/2504.06045
- https://arxiv.org/abs/1909.03572
- https://arxiv.org/pdf/1105.5410
- https://arxiv.org/pdf/2610.29265

Difficulty estimate: 3.8/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM097.Claim` or a proof of `¬ OpenProblems.QEDM097.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M097/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: it needs the Friedrichs extension, Stone's theorem / the Schrodinger group on L^2 of the cone, mild L^2 solutions of NLS, and space-time Lebesgue norms.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M097` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M097/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M097/Statement.lean to your file
theorem solution : OpenProblems.QEDM097.Claim := by   -- or ¬ OpenProblems.QEDM097.Claim
  ...
```
3. Add `solutions/QED-M097/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M097/<user>/Solution.lean`.
