import Mathlib
/-! N-627: Rupert superballs
The cube can pass through a hole drilled in a copy of itself; the round ball cannot. Show every superball between them, |x|^p+|y|^p+|z|^p ≤ 1 with p > 2, can.
Informal statement: Let $B_p=\{|x|^p+|y|^p+|z|^p\le1\}$. Prove that for every $p\in(2,\infty)$ there are orthogonal projections $\pi_1,\pi_2$ onto planes and a rigid motion $\rho$ of the plane with $\rho(\pi_1(B_p))\subset\operatorname{int}\pi_2(B_p)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N627
def Claim : Prop := sorry
end OpenProblems.N627
