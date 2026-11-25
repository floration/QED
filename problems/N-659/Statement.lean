import Mathlib
/-! N-659: Fibonacci-modulated growing Jacobi matrix
Take the Jacobi matrix with zero diagonal and off-diagonal weights √n, and double the weight at every
position where the Fibonacci word has a 1. Determine the spectral type; the main question is whether
there is any absolutely continuous spectrum.
Informal statement: Let f = f₁f₂f₃⋯ = 0100101001001⋯ be the Fibonacci word, the fixed point of
0 ↦ 01, 1 ↦ 0. Let J be the Jacobi operator on ℓ²(ℕ) with (Ju)_n = a_{n−1}u_{n−1} + a_n u_{n+1},
a_n = √n (1 + f_n), a₀u₀ := 0. J is self-adjoint (Carleman). Determine the spectral type of J; in
particular, is σ_ac(J) ≠ ∅?
Formalization notes: `Claim` is the headline yes/no question σ_ac(J) ≠ ∅. Unbounded operators are
avoided via the standard correspondence: the spectral measure μ of J at δ₁ is the probability
measure on ℝ for which the generalized eigenfunctions P_n (P₀ = 0, P₁ = 1,
P_{n+1}(x) = (x P_n(x) − a_{n−1} P_{n−1}(x)) / a_n) are orthonormal in L²(μ). Since ∑ 1/a_n = ∞,
the moment problem is determinate, so μ is unique (it exists by Favard), and δ₁ is cyclic, so the
spectral type of J is that of μ. σ_ac(J) ≠ ∅ iff μ has a nonzero absolutely continuous part, i.e.
μ is not mutually singular with Lebesgue measure. The Fibonacci word is given by the standard
formula f_n = 2 + ⌊nφ⌋ − ⌊(n+1)φ⌋ (n ≥ 1), φ the golden ratio. Proving `Claim` shows σ_ac ≠ ∅;
proving `¬ Claim` shows the spectrum is purely singular. The finer questions (σ_ac = ℝ? pure point
or singular continuous on intervals?) are not part of `Claim`.
-/
namespace OpenProblems.N659

open MeasureTheory

/-- The golden ratio. -/
noncomputable def phi : ℝ := (1 + Real.sqrt 5) / 2

/-- The `n`-th letter (n ≥ 1) of the Fibonacci word `0100101001001…`. -/
noncomputable def fibWord (n : ℕ) : ℤ := 2 + ⌊(n : ℝ) * phi⌋ - ⌊((n : ℝ) + 1) * phi⌋

/-- Off-diagonal weights `a_n = √n (1 + f_n)`. -/
noncomputable def a (n : ℕ) : ℝ := Real.sqrt (n : ℝ) * (1 + (fibWord n : ℝ))

/-- Generalized eigenfunctions: `P 0 = 0`, `P 1 = 1`, and the three-term recurrence. -/
noncomputable def P : ℕ → ℝ → ℝ
  | 0, _ => 0
  | 1, _ => 1
  | (n + 2), x => (x * P (n + 1) x - a n * P n x) / a (n + 1)

/-- `μ` is the spectral measure of `J` at `δ₁` (orthogonality measure of the `P n`, n ≥ 1). -/
def IsSpectralMeasure (μ : Measure ℝ) : Prop :=
  IsProbabilityMeasure μ ∧
    ∀ m n : ℕ, 1 ≤ m → 1 ≤ n →
      Integrable (fun x => P m x * P n x) μ ∧
        (∫ x, P m x * P n x ∂μ) = if m = n then (1 : ℝ) else 0

def Claim : Prop :=
  ∀ μ : Measure ℝ, IsSpectralMeasure μ → ¬ Measure.MutuallySingular μ volume

end OpenProblems.N659
