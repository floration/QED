import Mathlib
/-! N-560. Cycles of `q ↦ P(5q+4)` on primes (as observed numerically): (11, 59, 23, 17, 89, 449, 173, 79, 19). -/
namespace OpenProblems.N560
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P (5 * q + 4)
def cycleSet : Finset ℕ := {11, 17, 19, 23, 59, 79, 89, 173, 449}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.N560
