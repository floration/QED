import Mathlib
open Filter Topology
/-! N-283: Prime plus two seven-free squares
Informal: Prove every sufficiently large $n$ is $p+a^2+b^2$ with $p$ prime and $a,b$ free of the decimal digit 7. -/
namespace OpenProblems.N283
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∃ N₀ : ℕ, ∀ n ≥ N₀, ∃ p a b : ℕ, p.Prime ∧ SevenFree a ∧ SevenFree b ∧ n = p + a ^ 2 + b ^ 2
end OpenProblems.N283
