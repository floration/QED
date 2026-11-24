import Mathlib
/-! N-635: Shifted Fujita equation
In the plane, every positive solution of u_t = Δu + u² blows up. Does this survive when the square is replaced by the product of values one unit to the left and right?
Informal statement: Let $e=(1,0)$. Prove or disprove: every solution of $u_t=\Delta u+u(x-e,t)\,u(x+e,t)$ on $\mathbb R^2$ with $0\le u_0\in C_c(\mathbb R^2)$, $u_0\not\equiv0$, blows up in finite time.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N635
def Claim : Prop := sorry
end OpenProblems.N635
