import Mathlib
open Filter Topology
/-! N-379: Palindromic Carmichael numbers
Informal: Prove there are infinitely many Carmichael numbers that are decimal palindromes. -/
namespace OpenProblems.N379
/-- Carmichael number (Korselt-free definition) -/
def Carmichael (n : ℕ) : Prop := 1 < n ∧ ¬ n.Prime ∧ ∀ a : ℕ, Nat.Coprime a n → a ^ (n - 1) ≡ 1 [MOD n]
def Claim : Prop :=
  Set.Infinite {n : ℕ | Carmichael n ∧ (Nat.digits 10 n).reverse = Nat.digits 10 n}
end OpenProblems.N379
