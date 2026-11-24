import Mathlib
/-! N-559. Cycles of `q ↦ P(3q+4)` on primes (as observed numerically): (11, 37, 23, 73, 223, 673, 17). -/
namespace OpenProblems.N559
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def g (q : ℕ) : ℕ := P (3 * q + 4)
def cycleSet : Finset ℕ := {11, 17, 23, 37, 73, 223, 673}
def Claim : Prop := ∀ q : ℕ, q.Prime → ∃ k : ℕ, g^[k] q ∈ cycleSet
end OpenProblems.N559
