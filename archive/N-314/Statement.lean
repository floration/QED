import Mathlib
/-! N-314. Cycles of the map (as observed numerically): (6, 11, 15, 8); (9); (19, 25); (61, 93, 79, 85).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N314
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+1) + 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {6, 8, 9, 11, 15, 19, 25, 61, 79, 85, 93}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N314
