import Mathlib
/-! N-639: KdV with a cosine coefficient
Put a cos x in front of the cubic term of modified KdV on the circle. Energy survives but the L² norm no longer does. Can solutions blow up?
Informal statement: Consider $u_t+u_{xxx}+(\cos(x)\,u^3)_x=0$ on $\mathbb T=\mathbb R/2\pi\mathbb Z$, which conserves $\int u$ and $\int(\tfrac12u_x^2-\tfrac14\cos(x)u^4)$ but not $\int u^2$. Decide whether every $u_0\in C^\infty(\mathbb T)$ yields a global smooth solution.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N639
def Claim : Prop := sorry
end OpenProblems.N639
