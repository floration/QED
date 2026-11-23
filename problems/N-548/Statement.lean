import Mathlib
/-! N-548. For all integers `a ≥ 2`, `b ≥ 1`, every orbit of `q ↦ P(aq+b)` on primes is eventually periodic. -/
namespace OpenProblems.N548
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop := ∀ a b : ℕ, 2 ≤ a → 1 ≤ b → ∀ q : ℕ, q.Prime →
  ∃ k m : ℕ, 0 < m ∧ (fun x => P (a * x + b))^[k + m] q = (fun x => P (a * x + b))^[k] q
end OpenProblems.N548
