import Mathlib
open Filter Topology
/-! N-435: Long progressions of seven-free primes
Informal: Prove for every $k$ there are $k$-term arithmetic progressions consisting of primes with no decimal digit 7. -/
namespace OpenProblems.N435
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∀ k : ℕ, ∃ a d : ℕ, 0 < d ∧ ∀ i < k, (a + i * d).Prime ∧ SevenFree (a + i * d)
end OpenProblems.N435
