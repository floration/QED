import Mathlib
/-! N-332. Cycles of the map (as observed numerically): (16, 22, 28, 36, 58, 66, 86).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N332
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- least prime factor (`Nat.minFac`, so `p 1 = 1`) -/
def p (n : ℕ) : ℕ := n.minFac
def f (n : ℕ) : ℕ := p n + p (n+1) + P (n+2)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {16, 22, 28, 36, 58, 66, 86}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N332
