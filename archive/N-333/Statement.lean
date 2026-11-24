import Mathlib
/-! N-333. Cycles of the map (as observed numerically): (6); (8); (9, 15, 23, 29, 61, 69, 95, 117, 31, 43, 49, 25); (19, 27, 33); (37, 51, 71, 145).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N333
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+2) + 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {6, 8, 9, 15, 19, 23, 25, 27, 29, 31, 33, 37, 43, 49, 51, 61, 69, 71, 95, 117, 145}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N333
