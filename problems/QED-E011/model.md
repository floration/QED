# QED-E011 — Rupert superballs

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade C · Geometry

**Plain words:** A cube can pass through a hole drilled in a copy of itself; a round ball cannot. Show that every superball between them, |x|^p+|y|^p+|z|^p ≤ 1 with p > 2, can.

**Math:** Let $B_p=\{x\in\mathbb R^3:|x_1|^p+|x_2|^p+|x_3|^p\le1\}$ and $q=p/(p-1)$. Prove that for every $p\in(2,\infty)$ there are orthogonal projections $\pi_1,\pi_2$ of $\mathbb R^3$ onto planes and a rigid motion $\rho$ with $\rho(\pi_1(B_p))\subset\operatorname{int}\pi_2(B_p)$. By central symmetry this is equivalent to: there are orthonormal pairs $(a_1,a_2),(b_1,b_2)$ in $\mathbb R^3$ with $\|\cos t\,b_1+\sin t\,b_2\|_q>\|\cos t\,a_1+\sin t\,a_2\|_q$ for all $t$.

**Reviewer note:** N

**References:**
- https://arxiv.org/abs/2508.18475
- https://arxiv.org/abs/2210.00601
- https://mathworld.wolfram.com/RupertsProperty.html

Difficulty estimate: 3.0/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE011.Claim` or a proof of `¬ OpenProblems.QEDE011.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E011/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E011` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E011/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E011/Statement.lean to your file
theorem solution : OpenProblems.QEDE011.Claim := by   -- or ¬ OpenProblems.QEDE011.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E011/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E011/<user>/Solution.lean`.
