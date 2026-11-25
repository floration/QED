import Mathlib
/-! QED-E012: Prime Markov triples
Markov triples are positive integer solutions of x² + y² + z² = 3xyz. Are there infinitely many
in which all three numbers are prime?

Informal statement: Decide whether infinitely many solutions (x,y,z) ∈ ℤ_{>0}³ of
x² + y² + z² = 3xyz have x, y, z all prime.

Formalization notes: Triples are ordered triples of naturals (primes are automatically positive;
ordered vs unordered does not affect infinitude since each unordered triple has ≤ 6 orderings).
Examples: (2,5,29), (5,29,433). Claim = "infinitely many"; ¬Claim = "finitely many".
-/
namespace OpenProblems.QEDE012

/-- The set of Markov triples with all entries prime. -/
def primeMarkovTriples : Set (ℕ × ℕ × ℕ) :=
  {t | t.1.Prime ∧ t.2.1.Prime ∧ t.2.2.Prime ∧
    t.1 ^ 2 + t.2.1 ^ 2 + t.2.2 ^ 2 = 3 * t.1 * t.2.1 * t.2.2}

/-- There are infinitely many Markov triples consisting of three primes. -/
def Claim : Prop := primeMarkovTriples.Infinite

end OpenProblems.QEDE012
