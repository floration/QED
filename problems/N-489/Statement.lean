import Mathlib
/-! N-489. Cycles of the map (as observed numerically): (10, 18, 24); (14); (33); (42, 52, 68); (67, 87, 129, 187); (97, 107, 219); (3307, 4137, 6405).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N489
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- least prime factor (`Nat.minFac`, so `p 1 = 1`) -/
def p (n : ℕ) : ℕ := n.minFac
def f (n : ℕ) : ℕ := P n + P (n+1) + p (n+2)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {10, 14, 18, 24, 33, 42, 52, 67, 68, 87, 97, 107, 129, 187, 219, 3307, 4137, 6405}
def Claim : Prop := ∀ n : ℕ, 2 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N489
