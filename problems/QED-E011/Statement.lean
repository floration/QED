import Mathlib
/-! QED-E011: Rupert superballs
A cube can pass through a hole drilled in a copy of itself; a round ball cannot. Show that every superball between them, |x|^p+|y|^p+|z|^p ≤ 1 with p > 2, can.
Informal statement: Let $B_p=\{x\in\mathbb R^3:|x_1|^p+|x_2|^p+|x_3|^p\le1\}$ and $q=p/(p-1)$. Prove that for every $p\in(2,\infty)$ there are orthogonal projections $\pi_1,\pi_2$ of $\mathbb R^3$ onto planes and a rigid motion $\rho$ with $\rho(\pi_1(B_p))\subset\operatorname{int}\pi_2(B_p)$. By central symmetry this is equivalent to: there are orthonormal pairs $(a_1,a_2),(b_1,b_2)$ in $\mathbb R^3$ with $\|\cos t\,b_1+\sin t\,b_2\|_q>\|\cos t\,a_1+\sin t\,a_2\|_q$ for all $t$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E011`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE011
def Claim : Prop := sorry
end OpenProblems.QEDE011
