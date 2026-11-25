# QED-M086 — A Jörgens theorem for the Hessian permanent

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Main set · Grade B · QED Original · PDE · formerly N-642

**Plain words:** Jörgens proved that a convex function on the whole plane whose Hessian determinant is 1 must be a quadratic polynomial. Replace the determinant by the permanent, u_xx·u_yy + u_xy², and ask whether the same rigidity holds for solutions on the elliptic branch.

**Math:** Let $u\in C^4(\mathbb R^2)$ satisfy $u_{xx}u_{yy}+u_{xy}^2=1$, $u_{xx}>0$ and $2u_{xy}^2<1$ on $\mathbb R^2$ (these are exactly the conditions for the linearized operator $u_{yy}\partial_{xx}+2u_{xy}\partial_{xy}+u_{xx}\partial_{yy}$ to be elliptic; they force $u$ convex with $0<\det D^2u=1-2u_{xy}^2\le1$). Prove or disprove that $u$ is a quadratic polynomial.

**References:**
- https://arxiv.org/pdf/2407.11903
- https://arxiv.org/pdf/2603.10797
- https://www.numdam.org/item/ASNSP_2003_5_2_1_181_0/

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDM086.Claim` or a proof of `¬ OpenProblems.QEDM086.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-M086/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
1. Claim it (optional but encouraged): open an issue titled `Claim QED-M086` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-M086/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-M086/Statement.lean to your file
theorem solution : OpenProblems.QEDM086.Claim := by   -- or ¬ OpenProblems.QEDM086.Claim
  ...
```
3. Add `solutions/QED-M086/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-M086/<user>/Solution.lean`.
