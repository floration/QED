import Mathlib
/-! N-490. Cycles of the map (as observed numerically): (6, 8, 21, 12); (9, 10, 28, 66, 16); (50, 108, 76).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N490
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P (2*n+3) + P n
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {6, 8, 9, 10, 12, 16, 21, 28, 50, 66, 76, 108}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N490
