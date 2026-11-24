import Mathlib
open Filter Topology
/-! N-341: Prime Markov triples
Informal: Decide whether infinitely many solutions of $x^2+y^2+z^2=3xyz$ have $x,y,z$ all prime. -/
namespace OpenProblems.N341

def Claim : Prop :=
  Set.Infinite {t : ℕ × ℕ × ℕ | t.1.Prime ∧ t.2.1.Prime ∧ t.2.2.Prime ∧ t.1 ^ 2 + t.2.1 ^ 2 + t.2.2 ^ 2 = 3 * t.1 * t.2.1 * t.2.2}
end OpenProblems.N341
