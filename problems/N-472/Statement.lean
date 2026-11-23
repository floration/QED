import Mathlib
/-! N-472. Cycles of the map (as observed numerically): (5); (8, 10, 14, 18, 36, 44, 48, 54, 64, 20, 26); (24, 28, 32, 42, 84, 100, 112, 150, 300, 66, 80, 82, 86, 46, 52, 70, 94, 50); (224, 228, 456, 470).
`Claim` says every orbit from the stated starting range eventually lands in one of these cycles. -/
namespace OpenProblems.N472
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def f (n : ℕ) : ℕ := P (n-1) + P (n+1)
/-- union of all the listed cycles -/
def cycleSet : Finset ℕ := {5, 8, 10, 14, 18, 20, 24, 26, 28, 32, 36, 42, 44, 46, 48, 50, 52, 54, 64, 66, 70, 80, 82, 84, 86, 94, 100, 112, 150, 224, 228, 300, 456, 470}
def Claim : Prop := ∀ n : ℕ, 3 ≤ n → ∃ k : ℕ, f^[k] n ∈ cycleSet
end OpenProblems.N472
