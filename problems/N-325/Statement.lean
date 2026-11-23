import Mathlib
/-! N-325. Cycles of the map (as observed numerically): (23, 29, 39).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N325
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P n + 2 * P (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {23, 29, 39}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → n ≠ 8 → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N325
