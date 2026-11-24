import Mathlib
open Filter Topology
/-! N-280: Primes with equal binary and ternary digit sums
Informal: Prove infinitely many primes $p$ with $s_2(p)=s_3(p)$. -/
namespace OpenProblems.N280
/-- digit sum in base `b` -/
def ds (b n : ℕ) : ℕ := (Nat.digits b n).sum
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ ds 2 p = ds 3 p}
end OpenProblems.N280
