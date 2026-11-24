import Mathlib
open Filter Topology
/-! N-436: Seven-free Gaussian primes
Informal: Prove infinitely many primes $a^2+b^2$ with $a,b$ positive integers free of the decimal digit 7. -/
namespace OpenProblems.N436
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ ∃ a b : ℕ, 0 < a ∧ 0 < b ∧ SevenFree a ∧ SevenFree b ∧ p = a ^ 2 + b ^ 2}
end OpenProblems.N436
