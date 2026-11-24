import Mathlib
open Filter Topology
/-! N-404: Joint digit sums of primes
Informal: Prove infinitely many primes $p$ have $s_2(p)$ and $s_{10}(p)$ both prime. -/
namespace OpenProblems.N404
/-- digit sum in base `b` -/
def ds (b n : ℕ) : ℕ := (Nat.digits b n).sum
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ (ds 2 p).Prime ∧ (ds 10 p).Prime}
end OpenProblems.N404
