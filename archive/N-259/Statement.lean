import Mathlib
open Filter Topology
/-! N-259: Seven-free primes with prime digit sum
Informal: Prove infinitely many primes $p$ free of the decimal digit 7 with $s_{10}(p)$ prime. -/
namespace OpenProblems.N259
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
/-- digit sum in base `b` -/
def ds (b n : ℕ) : ℕ := (Nat.digits b n).sum
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ (ds 10 p).Prime}
end OpenProblems.N259
