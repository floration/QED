# QED-M011 — Maximal eigenfunction growth beyond surfaces of revolution

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Curated · Analysis

**Plain words:** On the round sphere, some eigenfunctions are as peaked as theory allows, because every geodesic leaving the pole comes back to it. Sogge and Zelditch proved that on any real-analytic surface, maximally peaked eigenfunctions force such a 'pole'. Is rotational symmetry also forced: must such a surface be a surface of revolution?

**Math:** Let $(M,g)$ be a compact boundaryless real-analytic Riemannian surface with $\Delta_g e_j=-\lambda_j^2e_j$, $\|e_j\|_{L^2}=1$. Say $g$ has maximal eigenfunction growth if $\limsup_j \|e_j\|_{L^\infty}/\lambda_j^{1/2}>0$ for some orthonormal eigenbasis. Decide whether every such $(M,g)$ admits a nontrivial isometric $S^1$-action, i.e. is a surface of revolution. (Necessary condition, Sogge-Zelditch 2016: $M$ has a pole $p$, meaning all geodesics from $p$ return smoothly closed at a common time $2T_p$.)

**Credit:** C. D. Sogge and S. Zelditch, 'Focal points and sup-norms of eigenfunctions' (arXiv:1311.3999) and its two-dimensional addendum (arXiv:1409.2063, Rev. Mat. Iberoam. 2016).

**References:**
- https://arxiv.org/abs/1311.3999
- https://arxiv.org/abs/1409.2063

Difficulty estimate: 4.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM011.Claim` or a proof of `¬ OpenProblems.QEDM011.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M011/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution. What is missing: Not formalized: needs real-analytic Riemannian surfaces, the Laplace-Beltrami spectral theory, and isometric circle actions.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M011` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M011/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M011/Statement.lean to your file
theorem solution : OpenProblems.QEDM011.Claim := by   -- or ¬ OpenProblems.QEDM011.Claim
  ...
```
3. Add `solutions/QED-M011/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M011/<user>/Solution.lean`.
