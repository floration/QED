import Mathlib
open Filter Topology
/-! N-208: Seven-free primes in short intervals
Informal: Prove $[x,x+x^{0.6}]$ contains a prime with no digit 7 for all large $x$. -/
namespace OpenProblems.N208
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∃ x₀ : ℝ, ∀ x : ℝ, x₀ ≤ x → ∃ p : ℕ, p.Prime ∧ SevenFree p ∧ x ≤ p ∧ (p : ℝ) ≤ x + x ^ (0.6 : ℝ)
end OpenProblems.N208
