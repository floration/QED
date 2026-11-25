import Mathlib
/-! QED-E073: Spikes at the primes
Put a potential spike of fixed height λ ≠ 0 at every prime on the half-line lattice. Inside the free
band (−2, 2), is the spectrum pure point (as for a random sparse set of the same density), or is there
a singular continuous component?
Informal statement: Let (Hu)(n) = u(n+1) + u(n−1) + λ 1_ℙ(n) u(n) on ℓ²(ℕ) with Dirichlet condition
u(0) = 0, λ ≠ 0. Determine the spectral type of H on (−2, 2). In particular: is the spectral measure
restricted to (−2, 2) pure point, or does it have a singular continuous part?
Formalization notes: `Claim` is the sharpest yes/no form: for every λ ≠ 0, the spectral measure of H
restricted to (−2, 2) is pure point. H is a bounded Jacobi operator (a_n = 1, b_n = λ 1_ℙ(n)), δ₁ is
cyclic, and its spectral measure μ is the unique probability measure making the generalized
eigenfunctions P_n orthonormal (P₀ = 0, P₁ = 1, P_{n+1}(x) = (x − λ 1_ℙ(n)) P_n(x) − P_{n−1}(x)).
Pure point on (−2, 2) means μ((−2,2) \ C) = 0 for some countable set C. Absolutely continuous
spectrum is already excluded (Remling 2011, since 1_ℙ is not eventually periodic), so `¬ Claim`
means: for some λ ≠ 0 there is singular continuous spectrum in (−2, 2). Eigenfunction decay rates
are not part of `Claim`. The literature numerics (de Oliveira–Pellegrino 2001) suggest delocalized
states near E = 0, i.e. that `¬ Claim` may hold.
-/
namespace OpenProblems.QEDE073

open MeasureTheory

/-- The potential `λ · 1_ℙ(n)`. -/
noncomputable def V (lam : ℝ) (n : ℕ) : ℝ := Set.indicator {p : ℕ | Nat.Prime p} (fun _ => lam) n

/-- Generalized eigenfunctions of `H` (Dirichlet at 0). -/
noncomputable def P (lam : ℝ) : ℕ → ℝ → ℝ
  | 0, _ => 0
  | 1, _ => 1
  | (n + 2), x => (x - V lam (n + 1)) * P lam (n + 1) x - P lam n x

/-- `μ` is the spectral measure of `H` at `δ₁`. -/
def IsSpectralMeasure (lam : ℝ) (μ : Measure ℝ) : Prop :=
  IsProbabilityMeasure μ ∧
    ∀ m n : ℕ, 1 ≤ m → 1 ≤ n →
      Integrable (fun x => P lam m x * P lam n x) μ ∧
        (∫ x, P lam m x * P lam n x ∂μ) = if m = n then (1 : ℝ) else 0

def Claim : Prop :=
  ∀ lam : ℝ, lam ≠ 0 → ∀ μ : Measure ℝ, IsSpectralMeasure lam μ →
    ∃ C : Set ℝ, C.Countable ∧ μ (Set.Ioo (-2 : ℝ) 2 \ C) = 0

end OpenProblems.QEDE073
