import Mathlib
/-! N-542. Cycles of `q ↦ P(2q+3)` on primes (as observed numerically): (3); (5, 13, 29, 61); (43, 89, 181, 73, 149). -/
namespace OpenProblems.N542
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P (2 * q + 3)
def cycleSet : Finset ℕ := {3, 5, 13, 29, 43, 61, 73, 89, 149, 181}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.N542
