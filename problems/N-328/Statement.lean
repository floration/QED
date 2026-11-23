import Mathlib
/-! N-328. Cycles of the map (as observed numerically): (16, 19, 26).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N328
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- sum of the distinct prime factors -/
def sopf (n : ℕ) : ℕ := n.primeFactors.sum id
def f (n : ℕ) : ℕ := P n + sopf (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {16, 19, 26}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N328
