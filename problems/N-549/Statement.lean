import Mathlib
/-! N-549. Cycles of `q ↦ P(7q+4)` on primes (as observed numerically): (3, 5, 13, 19, 137, 107, 251, 587, 457, 3203, 23, 11). -/
namespace OpenProblems.N549
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P (7 * q + 4)
def cycleSet : Finset ℕ := {3, 5, 11, 13, 19, 23, 107, 137, 251, 457, 587, 3203}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.N549
