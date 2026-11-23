import Mathlib
/-! N-274. Cycles of the map (as observed numerically): (5, 9); (37, 73, 145, 57).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N274
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := 2 * P n - 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {5, 9, 37, 57, 73, 145}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N274
