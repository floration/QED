import Mathlib
/-! N-275. Cycles of the map (as observed numerically): (14); (77, 103, 123).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N275
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+1) + P (n+2)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {14, 77, 103, 123}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N275
