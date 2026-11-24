import Mathlib
open Filter Topology
/-! N-193: Seven-free almost-Sophie-Germain
Informal: Prove infinitely many 7-free primes $p$ have $\Omega(2p+1)\le3$. -/
namespace OpenProblems.N193
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
/-- number of prime factors with multiplicity -/
def Ω (n : ℕ) : ℕ := n.primeFactorsList.length
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ Ω (2 * p + 1) ≤ 3}
end OpenProblems.N193
