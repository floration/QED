import Mathlib
open Filter Topology
/-! N-241: Seven-free Beatty primes
Informal: Prove infinitely many primes $p=\lfloor n\sqrt2\rfloor$ with no decimal digit 7. -/
namespace OpenProblems.N241
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ n : ℕ, p = ⌊(n : ℝ) * Real.sqrt 2⌋₊}
end OpenProblems.N241
