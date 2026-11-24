import Mathlib
open Filter Topology
/-! N-450: Missing digits in two bases
Informal: Prove infinitely many primes whose base-10 expansion avoids the digit 9 and whose base-11 expansion avoids the digit 10. -/
namespace OpenProblems.N450

def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ 9 ∉ Nat.digits 10 p ∧ 10 ∉ Nat.digits 11 p}
end OpenProblems.N450
