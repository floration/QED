import Mathlib
/-! N-312. Cycles of the map (as observed numerically): (6); (8, 13, 15); (10, 18).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N312
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+3)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {6, 8, 10, 13, 15, 18}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N312
