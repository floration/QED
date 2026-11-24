import Mathlib
open Filter Topology
/-! N-351: Primes a² + b⁴ with prime inputs
Informal: Prove infinitely many primes of the form $p^2+q^4$ with $p,q$ prime. -/
namespace OpenProblems.N351

def Claim : Prop :=
  Set.Infinite {r : ℕ | r.Prime ∧ ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ r = p ^ 2 + q ^ 4}
end OpenProblems.N351
