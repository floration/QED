import Mathlib
/-! N-658: Jacobi matrix of primes
Build the infinite tridiagonal (Jacobi) matrix with zero diagonal and the primes 2, 3, 5, 7, … on the
off-diagonals. Is its spectrum purely absolutely continuous and equal to the whole real line?
Informal statement: Let J be the self-adjoint Jacobi operator on ℓ²(ℕ) given by
(Ju)_n = p_{n−1}u_{n−1} + p_n u_{n+1} (with p₀u₀ := 0), where p_n is the n-th prime. It is
self-adjoint by Carleman's criterion since ∑ 1/p_n = ∞. Decide whether σ(J) = σ_ac(J) = ℝ with no
singular part.
Formalization notes: p_n = `Nat.nth Nat.Prime (n − 1)` for n ≥ 1 (so p₁ = 2). Unbounded operators are
avoided: the spectral measure μ of J at δ₁ is the probability measure on ℝ for which the generalized
eigenfunctions P_n (P₀ = 0, P₁ = 1, P_{n+1}(x) = (x P_n(x) − p_{n−1} P_{n−1}(x)) / p_n) are
orthonormal in L²(μ). By Carleman the moment problem is determinate, so μ is unique (it exists by
Favard), and δ₁ is cyclic, so the spectral type of J is that of μ. "σ(J) = σ_ac(J) = ℝ with no
singular part" is: μ ≪ Lebesgue and μ gives positive mass to every nonempty open interval (so
supp μ = σ(J) = ℝ). Proving `Claim` answers yes; proving `¬ Claim` shows a singular part exists or a
gap in the spectrum.
-/
namespace OpenProblems.N658

open MeasureTheory

/-- `p n` = the `n`-th prime for `n ≥ 1` (`p 1 = 2`); `p 0` is a junk value, always multiplied by 0. -/
noncomputable def p (n : ℕ) : ℝ := (Nat.nth Nat.Prime (n - 1) : ℝ)

/-- Generalized eigenfunctions of `J`. -/
noncomputable def P : ℕ → ℝ → ℝ
  | 0, _ => 0
  | 1, _ => 1
  | (n + 2), x => (x * P (n + 1) x - p n * P n x) / p (n + 1)

/-- `μ` is the spectral measure of `J` at `δ₁`. -/
def IsSpectralMeasure (μ : Measure ℝ) : Prop :=
  IsProbabilityMeasure μ ∧
    ∀ m n : ℕ, 1 ≤ m → 1 ≤ n →
      Integrable (fun x => P m x * P n x) μ ∧
        (∫ x, P m x * P n x ∂μ) = if m = n then (1 : ℝ) else 0

def Claim : Prop :=
  ∀ μ : Measure ℝ, IsSpectralMeasure μ →
    Measure.AbsolutelyContinuous μ volume ∧
      ∀ a b : ℝ, a < b → 0 < μ (Set.Ioo a b)

end OpenProblems.N658
