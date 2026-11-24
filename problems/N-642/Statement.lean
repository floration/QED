import Mathlib
/-! N-642: Permanent–Ampère equation
Monge–Ampère sets the Hessian determinant to 1, and Jörgens showed its entire convex solutions are quadratics. Swap the determinant for the permanent.
Informal statement: Let $u\in C^4(\mathbb R^2)$ satisfy $u_{xx}u_{yy}+u_{xy}^2=1$, $u_{xx}>0$, $2u_{xy}^2<1$ everywhere (ellipticity). Prove or disprove that $u$ is a quadratic polynomial.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N642
def Claim : Prop := sorry
end OpenProblems.N642
