import Mathlib
/-! QED-E005: Drum tones of superellipses
Informal statement: for $p\in[2,\infty)$ let $D_p=\{|x|^p+|y|^p\le r_p^p\}$ with $|D_p|=1$ and $\lambda_1(p)$ the
first Dirichlet eigenvalue of $-\Delta$ on $D_p$. Prove that $\lambda_1$ is strictly increasing on $[2,\infty)$, with
$\lambda_1(2)=\pi j_{0,1}^2$ and $\lambda_1(p)\uparrow 2\pi^2$ as $p\to\infty$.
Formalization notes:
* No Dirichlet Laplacian in Mathlib, so λ₁ of an open set U ⊆ ℝ² is the Rayleigh–Ritz infimum
  `inf ∫|∇φ|² / ∫φ²` over nonzero C¹ functions with compact support inside U. For bounded (Lipschitz) U
  this equals the first Dirichlet eigenvalue (C¹_c is dense in H¹₀). The set is nonempty and bounded below
  by 0, so `sInf` is not a junk value; φ ≠ 0 continuous makes the denominator positive.
* |∇φ(x)| is the operator norm of `fderiv ℝ φ x` on `EuclideanSpace ℝ (Fin 2)` (= Euclidean gradient norm);
  integrals use Lebesgue measure `volume`.
* Area normalisation via scaling: λ₁(tU) = λ₁(U)/t² and |tU| = t²|U|, so λ₁(D_p) = λ₁(U_p)·|U_p| where U_p
  is the open unit superellipse |x|^p+|y|^p<1 (bounded, finite area; `.toReal` is safe).
* Claim: strict monotonicity on [2,∞) and the limit 2π² (area-1 square). The classical value
  λ₁(2)=π j₀,₁² (disk) is omitted: Bessel zeros are not in Mathlib, and it is a known fact, not the problem.
-/

namespace OpenProblems.QEDE005
noncomputable section

open MeasureTheory

/-- The open unit superellipse `|x|^p + |y|^p < 1`. -/
def U (p : ℝ) : Set (EuclideanSpace ℝ (Fin 2)) :=
  {x | |x 0| ^ p + |x 1| ^ p < 1}

/-- Rayleigh–Ritz first Dirichlet eigenvalue of an open set `Ω ⊆ ℝ²`. -/
def lambda1 (Ω : Set (EuclideanSpace ℝ (Fin 2))) : ℝ :=
  sInf {r : ℝ | ∃ φ : EuclideanSpace ℝ (Fin 2) → ℝ,
    ContDiff ℝ 1 φ ∧ HasCompactSupport φ ∧ tsupport φ ⊆ Ω ∧ φ ≠ 0 ∧
    r = (∫ x, ‖fderiv ℝ φ x‖ ^ 2) / (∫ x, φ x ^ 2)}

/-- First Dirichlet eigenvalue of the area-one superellipse with exponent `p`. -/
def LamP (p : ℝ) : ℝ := lambda1 (U p) * (volume (U p)).toReal

def Claim : Prop :=
  StrictMonoOn LamP (Set.Ici 2) ∧
    Filter.Tendsto LamP Filter.atTop (nhds (2 * Real.pi ^ 2))

end
end OpenProblems.QEDE005
