import Mathlib
open Filter Topology
/-! N-352: Primes x² + y³ with prime inputs
Informal: Prove infinitely many primes of the form $p^2+q^3$ with $p,q$ prime. -/
namespace OpenProblems.N352

def Claim : Prop :=
  Set.Infinite {r : ℕ | r.Prime ∧ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ r = p ^ 2 + q ^ 3}
end OpenProblems.N352
