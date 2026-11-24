import Mathlib
/-! N-278. Cycles of the map (as observed numerically): (13, 16); (30, 66); (36, 76).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N278
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (2*n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {13, 16, 30, 36, 66, 76}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N278
