import Mathlib
open Filter Topology
/-! N-463: Seven-free primes in Piatetski-Shapiro sequences
Informal: Prove infinitely many primes $\lfloor n^{1.1}\rfloor$ free of the decimal digit 7. -/
namespace OpenProblems.N463
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ n : ℕ, p = ⌊(n : ℝ) ^ (1.1 : ℝ)⌋₊}
end OpenProblems.N463
