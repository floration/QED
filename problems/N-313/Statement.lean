import Mathlib
/-! N-313. Cycles of the map (as observed numerically): (8, 11, 9); (10, 15).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N313
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P (n-1) + P (n+1) + 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {8, 9, 10, 11, 15}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N313
