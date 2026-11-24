import Mathlib
open Filter Topology
/-! N-026: Seven-free Egyptian fractions
Informal: Prove every $q\in\mathbb{Q}\cap(0,1)$ is $\sum_{d\in D}1/d$ for a finite set $D$ of distinct integers with no decimal digit 7. -/
namespace OpenProblems.N026
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∀ q : ℚ, 0 < q → q < 1 → ∃ D : Finset ℕ, (∀ d ∈ D, 0 < d ∧ SevenFree d) ∧ ∑ d ∈ D, (1 : ℚ) / d = q
end OpenProblems.N026
