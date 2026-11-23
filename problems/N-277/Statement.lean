import Mathlib
/-! N-277. Cycles of the map (as observed numerically): (3, 5, 8).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N277
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := (3 * P n + 1) / 2
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {3, 5, 8}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N277
