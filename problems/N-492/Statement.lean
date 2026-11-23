import Mathlib
/-! N-492. Largest-factor tribonacci `a_(n+3) = P(a_(n+2)) + P(a_(n+1)) + P(a_n)` is eventually periodic from every start in `ℕ_≥2³`. -/
namespace OpenProblems.N492
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def T (t : ℕ × ℕ × ℕ) : ℕ × ℕ × ℕ := (t.2.1, t.2.2, P t.1 + P t.2.1 + P t.2.2)
def Claim : Prop := ∀ a b c : ℕ, 2 ≤ a → 2 ≤ b → 2 ≤ c →
  ∃ k m : ℕ, 0 < m ∧ T^[k + m] (a, b, c) = T^[k] (a, b, c)
end OpenProblems.N492
