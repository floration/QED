# QED-E129 — The centred maximal function diminishes variation

You are an AI model helping someone attack this open problem. Read all of this before working.

## The problem
Extended set · Grade A · QED Curated · Analysis

**Plain words:** Replace a function on the real line by its centred maximal average: at each point take the largest average of |f| over intervals centred there. The total variation of the new function should be no larger than that of f. This is known for the uncentred maximal function and, for the centred one, for indicator functions and special step functions; for general f the best proven bound allows growth by a factor 240,004.

**Math:** For locally integrable $f:\mathbb{R}\to\mathbb{R}$ let $Mf(x)=\sup_{r>0}\frac{1}{2r}\int_{x-r}^{x+r}|f(y)|\,dy$. Prove or disprove: for every $f$ of bounded variation, $\operatorname{Var}(Mf)\le\operatorname{Var}(f)$, where $\operatorname{Var}(f)$ is the essential variation (variation of the best normalized representative) and $\operatorname{Var}(Mf)$ is the pointwise variation of the everywhere-defined function $Mf$. Discrete companion (also open; a separate statement, not part of the main claim): for finitely supported $f:\mathbb{Z}\to\mathbb{R}$ with $Mf(n)=\sup_{r\in\mathbb{N}_0}\frac{1}{2r+1}\sum_{|k|\le r}|f(n+k)|$, prove $\sum_{n}|Mf(n+1)-Mf(n)|\le\sum_n|f(n+1)-f(n)|$. The constant 1 cannot be improved.

**Credit:** Question raised in the regularity-of-maximal-functions literature (Aldaz-Perez Lazaro; Kurka 2015; Carneiro survey 2019); not a named conjecture.

**Rests on recent unrefereed work. Check these premises first:**
- Continuous/discrete equivalence is proved in 2407.06734 only for the step-function class; state both versions explicitly rather than claiming equivalence in general
- Var(f) must be the essential (normalized) variation in the continuous version

**References:**
- https://arxiv.org/abs/2610.18544
- https://arxiv.org/abs/2107.12404
- https://arxiv.org/abs/1210.0496
- https://arxiv.org/abs/2407.06734
- https://arxiv.org/abs/1512.04112
- https://arxiv.org/abs/1703.00362

Difficulty estimate: 3.5/10 (calibrated: Collatz ≈ 5.5, twin primes ≈ 5.0). It is believed open; do not assume a quick answer exists, and say so plainly if you cannot make progress. Never present a heuristic, numerical evidence, or a partial result as a solution.

## What counts as an answer
Either a proof of `OpenProblems.QEDE129.Claim` or a proof of `¬ OpenProblems.QEDE129.Claim` (a disproof), in Lean 4 + Mathlib, using the exact statement in `problems/QED-E129/Statement.lean`. Read its "Formalization notes" first. If that file still says `def Claim : Prop := sorry`, the problem must first be formalized (see CONTRIBUTING.md); a faithful formalization is itself a welcome contribution.

If you think the Lean statement does not match the informal problem (it is trivially true or false, or it says something else), report that in an issue instead of exploiting it: such solutions are not credited.

## How to submit
0. First time? Solve a test problem (QED-Q1, the 2-line one, at minimum) and submit it, to confirm your Lean setup and the submission pipeline work before spending effort here. Skip this step if this IS a test problem.
1. Claim it (optional but encouraged): open an issue titled `Claim QED-E129` at https://github.com/floration/qed/issues/new?template=claim.yml. Comment on it at least once a week or the claim lapses.
2. Add `solutions/QED-E129/<github-username>/Solution.lean`:
```lean
import Mathlib
-- do NOT redefine Claim: CI prepends problems/QED-E129/Statement.lean to your file
theorem solution : OpenProblems.QEDE129.Claim := by   -- or ¬ OpenProblems.QEDE129.Claim
  ...
```
   Large proofs may add more `.lean` files (subfolders allowed) next to Solution.lean; CI concatenates them in path order before Solution.lean. Don't import them.
3. Add `solutions/QED-E129/<github-username>/meta.json`: `{"model": "<AI model used, or none>", "kind": "proof" | "disproof"}`. Optionally a `README.md` explaining the idea.
4. Open a pull request. CI checks: it compiles, no `sorry`/`admit`/new `axiom`/`set_option` tricks, and `#print axioms solution` shows only `propext`, `Classical.choice`, `Quot.sound`.

## Scoring
Size = number of non-blank, non-comment lines of `Solution.lean` excluding `import` lines (helper lemmas count). First verified solution is credited permanently; any later, strictly smaller verified solution becomes the "smallest solution".

## Rules for you, the model
- Do not modify `Statement.lean` in a solution PR.
- Be honest about uncertainty; if a step is unproven, leave it out rather than sneak in `sorry`.
- Test locally: `lake exe cache get && lake env lean solutions/QED-E129/<user>/Solution.lean`.
