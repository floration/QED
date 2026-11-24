import Mathlib
/-! N-634: Riesz-transform Schrödinger equation
Couple a 2D Schrödinger wave to the Riesz transform of its own density. Mass is conserved but there is no energy. Do smooth solutions live forever?
Informal statement: Consider $i u_t+\Delta u=u\,R_1(|u|^2)$ on $\mathbb R\times\mathbb R^2$, where $\widehat{R_1 f}(\xi)=-i\frac{\xi_1}{|\xi|}\hat f(\xi)$. Decide whether every $u_0\in H^1(\mathbb R^2)$ gives a global solution in $C(\mathbb R,H^1)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N634
def Claim : Prop := sorry
end OpenProblems.N634
