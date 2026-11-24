import Mathlib
open Filter Topology
/-! N-066: Seven-free three primes
Informal: Prove every sufficiently large odd $N$ is $p_1+p_2+p_3$ with each $p_i$ prime and free of the decimal digit 7. -/
namespace OpenProblems.N066
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∃ N₀ : ℕ, ∀ N ≥ N₀, Odd N → ∃ p₁ p₂ p₃ : ℕ, p₁.Prime ∧ p₂.Prime ∧ p₃.Prime ∧ SevenFree p₁ ∧ SevenFree p₂ ∧ SevenFree p₃ ∧ p₁ + p₂ + p₃ = N
end OpenProblems.N066
