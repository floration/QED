import Mathlib
/-! QED-E152: Does the classical Hénon map have a periodic sink?
The Hénon map H(x,y) = (1 − 1.4x² + y, 0.3x) is the textbook example of a 'strange attractor': on a computer screen its orbits trace out a fractal set. No one has proved that what we see is not just a stable periodic orbit with a very long period. Decide whether H has an attracting periodic orbit.
Informal statement: Let $H(x,y)=(1-\tfrac{7}{5}x^2+y,\ \tfrac{3}{10}x)$ on $\mathbb{R}^2$. Decide whether there exist $n\ge1$ and $p\in\mathbb{R}^2$ with $H^n(p)=p$ such that both eigenvalues of $DH^n(p)$ have modulus $<1$.
Formalization notes:
* H is defined exactly (7/5 = 1.4, 3/10 = 0.3). Its Jacobian at (x, y) is `J (x, y) = !![-(14/5) x, 1; 3/10, 0]`.
  By the chain rule DHⁿ(p) = J(H^{n−1} p) ⋯ J(H p) J(p); `jac n p` is this product, defined recursively
  (jac 0 p = 1, jac (k+1) p = J(H^[k] p) * jac k p), so no fderiv API is needed.
* The eigenvalues of a real 2×2 matrix M are the complex roots of z² − tr(M) z + det(M); trace and determinant are
  written out from the entries. "Both eigenvalues have modulus < 1" is stated as: every complex root z of this
  polynomial has ‖z‖ < 1.
* `Claim`: there exist n ≥ 1 and p with Hⁿ(p) = p whose eigenvalues of DHⁿ(p) lie in the open unit disk, i.e. H has
  an attracting periodic orbit (a sink). Decision problem: proving `Claim` = exhibit a sink (e.g. certified
  computation); ¬Claim = H has no periodic sink.
-/
namespace OpenProblems.QEDE152
noncomputable section

/-- The classical Hénon map. -/
def H (p : ℝ × ℝ) : ℝ × ℝ := (1 - 7 / 5 * p.1 ^ 2 + p.2, 3 / 10 * p.1)

/-- Jacobian matrix of H at p. -/
def J (p : ℝ × ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![-(14 / 5) * p.1, 1; 3 / 10, 0]

/-- Jacobian matrix of H^[n] at p, by the chain rule. -/
def jac : ℕ → ℝ × ℝ → Matrix (Fin 2) (Fin 2) ℝ
  | 0, _ => 1
  | k + 1, p => J (H^[k] p) * jac k p

def Claim : Prop :=
  ∃ n : ℕ, 1 ≤ n ∧ ∃ p : ℝ × ℝ, H^[n] p = p ∧
    ∀ z : ℂ, z ^ 2 - (((jac n p) 0 0 + (jac n p) 1 1 : ℝ) : ℂ) * z
        + (((jac n p) 0 0 * (jac n p) 1 1 - (jac n p) 0 1 * (jac n p) 1 0 : ℝ) : ℂ) = 0 → ‖z‖ < 1

end
end OpenProblems.QEDE152
