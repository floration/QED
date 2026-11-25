import Mathlib
open Filter Topology
/-! N-141: Two of four
Informal: Prove infinitely many primes $p$ have at least one of $p+2,\,2p+1,\,2p+3$ prime. -/
namespace OpenProblems.N141

def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ ((p + 2).Prime ∨ (2 * p + 1).Prime ∨ (2 * p + 3).Prime)}
end OpenProblems.N141
