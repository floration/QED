import Mathlib
open Filter Topology
/-! N-433: Seven-free values of n²+1
Informal: Prove infinitely many $n$ with $n^2+1=q_1q_2$, $q_i$ primes free of the digit 7. -/
namespace OpenProblems.N433
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {n : ℕ | ∃ q₁ q₂ : ℕ, q₁.Prime ∧ q₂.Prime ∧ SevenFree q₁ ∧ SevenFree q₂ ∧ n ^ 2 + 1 = q₁ * q₂}
end OpenProblems.N433
