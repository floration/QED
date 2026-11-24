import Mathlib
/-! N-501. The map `n ↦ n/2` (n even), `n ↦ P(5n+1)` (n odd). `Claim`: every orbit from `n ≥ 1` is eventually periodic. -/
namespace OpenProblems.N501
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := if Even n then n / 2 else P (5 * n + 1)
def Claim : Prop := ∀ n : ℕ, 1 ≤ n → ∃ k m : ℕ, 0 < m ∧ f^[k + m] n = f^[k] n
end OpenProblems.N501
