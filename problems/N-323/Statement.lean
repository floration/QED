import Mathlib
/-! N-323. Cycles of the map (as observed numerically): (10, 18, 24); (17, 22, 36, 42, 55, 25, 20); (30, 41, 53, 58, 90); (33); (107, 112, 122).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N323
/-- sum of the distinct prime factors -/
def sopf (n : ℕ) : ℕ := n.primeFactors.sum id
def f (n : ℕ) : ℕ := sopf n + sopf (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {10, 17, 18, 20, 22, 24, 25, 30, 33, 36, 41, 42, 53, 55, 58, 90, 107, 112, 122}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N323
