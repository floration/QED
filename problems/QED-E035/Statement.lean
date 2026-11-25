import Mathlib
/-! QED-E035: Pin down the Schur–Siegel–Smyth trace constant
Take algebraic integers all of whose conjugates are positive real numbers, and look at the average of their conjugates (trace divided by degree). Apart from finitely many exceptions this average cannot be small, and the threshold where infinitely many examples start is a constant lambda. For decades people believed lambda = 2; Smith disproved this, and now lambda is known only to lie between 1.80220 and 1.8216. Narrow this window.
Informal statement: Let $\lambda_{\mathrm{SSS}}$ be the smallest limit point of $\{\operatorname{tr}(\alpha)/\deg(\alpha)\}$ over totally positive algebraic integers $\alpha$ (equivalently $\liminf\operatorname{tr}(\alpha)/\deg(\alpha)$ as $\deg\alpha\to\infty$). Known: $1.80220\le\lambda_{\mathrm{SSS}}\le 1.8216$. Improve either bound (ultimately, determine $\lambda_{\mathrm{SSS}}$).
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E035`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE035
def Claim : Prop := sorry
end OpenProblems.QEDE035
