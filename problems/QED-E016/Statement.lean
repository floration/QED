import Mathlib
/-! QED-E016: Shifted Fujita equation
In the plane, every positive solution of u_t = Delta u + u^2 blows up (u^2 is exactly Fujita-critical in dimension 2). Does this survive when u^2 is replaced by the product of the values of u one unit to the left and one unit to the right?
Informal statement: Let $e=(1,0)$. Prove or disprove: for every $0\le u_0\in C_c(\mathbb R^2)$ with $u_0\not\equiv0$, the solution of $u_t=\Delta u+u(x-e,t)\,u(x+e,t)$ on $\mathbb R^2$ blows up in finite time.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E016`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE016
def Claim : Prop := sorry
end OpenProblems.QEDE016
