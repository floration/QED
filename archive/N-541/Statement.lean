import Mathlib
/-! N-541. Cycles of `q ↦ P(4q+1)` on primes (as observed numerically): (5, 7, 29, 13, 53, 71, 19, 11). -/
namespace OpenProblems.N541
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P (4 * q + 1)
def cycleSet : Finset ℕ := {5, 7, 11, 13, 19, 29, 53, 71}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.N541
