import Mathlib
/-! N-128. Cycles of the map (as observed numerically): (6, 9, 12).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N128
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- decimal digit sum -/
def s10 (n : ℕ) : ℕ := (Nat.digits 10 n).sum
def f (n : ℕ) : ℕ := P n + s10 n
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {6, 9, 12}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N128
