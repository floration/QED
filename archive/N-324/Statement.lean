import Mathlib
/-! N-324. Cycles of the map (as observed numerically): (5, 8); (10, 18, 24); (14); (21); (31, 33); (82, 126, 139, 146).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N324
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- sum of the distinct prime factors -/
def sopf (n : ℕ) : ℕ := n.primeFactors.sum id
def f (n : ℕ) : ℕ := sopf n + P (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {5, 8, 10, 14, 18, 21, 24, 31, 33, 82, 126, 139, 146}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N324
