import Mathlib
/-! N-471. Cycles of the map (as observed numerically): (46, 162, 490, 1478, 1626, 312, 950, 2870, 150); (80, 246, 780, 2354, 1116, 228, 156).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N471
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P (3*n+1) + P n
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {46, 80, 150, 156, 162, 228, 246, 312, 490, 780, 950, 1116, 1478, 1626, 2354, 2870}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N471
