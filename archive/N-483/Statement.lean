import Mathlib
/-! N-483. Cycles of the map (as observed numerically): (93, 109, 229, 481, 315); (1231, 2473, 6183).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N483
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := 2 * P n + P (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {93, 109, 229, 315, 481, 1231, 2473, 6183}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N483
