import Mathlib
/-! QED-M080: Largest prime factor of Markov numbers
Markov numbers are the numbers appearing in positive integer solutions of x² + y² + z² = 3xyz.
Show that the largest prime factor of a Markov number tends to infinity; equivalently, for any
finite set of primes only finitely many Markov numbers are built from those primes alone.
Informal statement: Let 𝓜 = {m ≥ 1 : ∃ x, y ∈ ℤ_{>0}, x² + y² + m² = 3xym} and P(m) the largest
prime factor of m (P(1) = 1). Prove that P(m) → ∞ as m → ∞ in 𝓜; equivalently, for every
finite set S of primes, only finitely many m ∈ 𝓜 are S-units.
Formalization notes: The Claim is the S-unit form: for every finite set S ⊆ ℕ, the set of
Markov numbers all of whose prime divisors lie in S is finite. (Non-primes in S are harmless.)
This is equivalent to P(m) → ∞ along 𝓜. Everything is in ℕ with no subtraction. Proving
`Claim` = the conjecture; `¬Claim` = a finite set of primes supporting infinitely many Markov
numbers.
-/
namespace OpenProblems.QEDM080

/-- `m` is a Markov number. -/
def IsMarkov (m : ℕ) : Prop :=
  1 ≤ m ∧ ∃ x y : ℕ, 0 < x ∧ 0 < y ∧ x ^ 2 + y ^ 2 + m ^ 2 = 3 * x * y * m

def Claim : Prop :=
  ∀ S : Finset ℕ,
    Set.Finite {m : ℕ | IsMarkov m ∧ ∀ p : ℕ, p.Prime → p ∣ m → p ∈ S}

end OpenProblems.QEDM080
