import Mathlib
/-! N-334. Cycles of the map (as observed numerically): (4); (7, 9, 13, 17, 35, 43, 47, 53, 63, 19, 25); (23, 27, 31, 41, 83, 99, 111, 149, 299, 65, 79, 81, 85, 45, 51, 69, 93, 49); (223, 227, 455, 469).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N334
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + P (n+2) - 1
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {4, 7, 9, 13, 17, 19, 23, 25, 27, 31, 35, 41, 43, 45, 47, 49, 51, 53, 63, 65, 69, 79, 81, 83, 85, 93, 99, 111, 149, 223, 227, 299, 455, 469}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N334
