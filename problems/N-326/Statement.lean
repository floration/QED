import Mathlib
/-! N-326. Cycles of the map (as observed numerically): (5, 7, 10, 16, 19, 22, 34, 24, 8).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N326
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := if Even n then P n + P (n+1) else P n + P (n-1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {5, 7, 8, 10, 16, 19, 22, 24, 34}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N326
