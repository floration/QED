import Mathlib
open Filter Topology
/-! N-405: Squares of seven-free primes
Informal: Prove infinitely many primes $p$ with neither $p$ nor $p^2$ containing the decimal digit 7. -/
namespace OpenProblems.N405
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ SevenFree (p ^ 2)}
end OpenProblems.N405
