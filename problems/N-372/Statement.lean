import Mathlib
open Filter Topology
/-! N-372: Divisor-balanced primes
Informal: Prove infinitely many primes $p$ with $d(p-1)=d(p+1)$. -/
namespace OpenProblems.N372

def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ (p - 1).divisors.card = (p + 1).divisors.card}
end OpenProblems.N372
