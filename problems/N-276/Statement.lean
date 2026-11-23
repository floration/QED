import Mathlib
/-! N-276. Cycles of the map (as observed numerically): (4, 6, 9, 7, 8); (17, 19, 23, 25); (167, 173, 201).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N276
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+1) - 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {4, 6, 7, 8, 9, 17, 19, 23, 25, 167, 173, 201}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N276
