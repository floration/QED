import Mathlib
/-! N-315. Cycles of the map (as observed numerically): (8); (20, 21, 39, 57, 105, 165, 259, 77, 101, 219, 99, 115, 63); (33); (177, 325, 283, 371, 455, 487, 709, 857, 1727).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N315
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+1) + P (n+2) - 2
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {8, 20, 21, 33, 39, 57, 63, 77, 99, 101, 105, 115, 165, 177, 219, 259, 283, 325, 371, 455, 487, 709, 857, 1727}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N315
