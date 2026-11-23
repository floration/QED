import Mathlib
/-! N-322. Cycles of the map (as observed numerically): (5, 7, 9); (22, 34).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N322
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- least prime factor (`Nat.minFac`, so `p 1 = 1`) -/
def p (n : ℕ) : ℕ := n.minFac
def f (n : ℕ) : ℕ := P n + p (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {5, 7, 9, 22, 34}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N322
