import Mathlib
open Filter Topology
/-! N-412: Seven-free Carmichael quotients
Informal: Prove infinitely many Carmichael numbers $n$ such that $n-1$ has no decimal digit 7. -/
namespace OpenProblems.N412
/-- Carmichael number (Korselt-free definition) -/
def Carmichael (n : ℕ) : Prop := 1 < n ∧ ¬ n.Prime ∧ ∀ a : ℕ, Nat.Coprime a n → a ^ (n - 1) ≡ 1 [MOD n]
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {n : ℕ | Carmichael n ∧ SevenFree (n - 1)}
end OpenProblems.N412
