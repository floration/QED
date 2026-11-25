import Mathlib
/-! QED-M086: A Jörgens theorem for the Hessian permanent
Jörgens proved that a convex entire solution of det D^2 u = 1 in the plane is a quadratic
polynomial. Replace the determinant by the permanent u_xx u_yy + u_xy^2 and ask whether entire
solutions on the elliptic branch are still quadratic.
Informal statement: Let u ∈ C^4(R^2) satisfy u_xx u_yy + u_xy^2 = 1, u_xx > 0 and 2 u_xy^2 < 1
on R^2. Prove or disprove that u is a quadratic polynomial.
Formalization notes: u : ℝ × ℝ → ℝ with `ContDiff ℝ 4 u`. Second partials are values of the
second Fréchet derivative: u_xx = D^2u(p)(e1,e1), u_xy = D^2u(p)(e1,e2), u_yy = D^2u(p)(e2,e2)
with e1 = (1,0), e2 = (0,1). The conditions u_xx > 0 and 2u_xy^2 < 1 are exactly ellipticity of
the linearized operator; they imply convexity. "Quadratic polynomial" means
u(x,y) = a x^2 + b xy + c y^2 + d x + e y + f for real constants (any degree <= 2 polynomial).
Quadratic solutions exist (e.g. (x^2+y^2)/2), so the hypothesis is not vacuous. Proving Claim
is the Jörgens-type rigidity theorem; proving ¬Claim exhibits a non-quadratic entire elliptic
solution.
-/
namespace OpenProblems.QEDM086

/-- Second Fréchet derivative of `u` at `p` applied to `(v, w)`. -/
noncomputable def secondPartial (u : ℝ × ℝ → ℝ) (p : ℝ × ℝ) (v w : ℝ × ℝ) : ℝ :=
  fderiv ℝ (fderiv ℝ u) p v w

/-- Unit vector in the x direction. -/
def ex : ℝ × ℝ := (1, 0)

/-- Unit vector in the y direction. -/
def ey : ℝ × ℝ := (0, 1)

def Claim : Prop :=
  ∀ u : ℝ × ℝ → ℝ, ContDiff ℝ 4 u →
    (∀ p : ℝ × ℝ,
      secondPartial u p ex ex * secondPartial u p ey ey + secondPartial u p ex ey ^ 2 = 1 ∧
      0 < secondPartial u p ex ex ∧
      2 * secondPartial u p ex ey ^ 2 < 1) →
    ∃ a b c d e f : ℝ, ∀ x y : ℝ,
      u (x, y) = a * x ^ 2 + b * x * y + c * y ^ 2 + d * x + e * y + f

end OpenProblems.QEDM086
