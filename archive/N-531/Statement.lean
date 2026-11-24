import Mathlib
open Filter Topology
/-! N-531: Seven-free Carmichael numbers
Informal: Prove there are infinitely many Carmichael numbers with no digit 7 in base 10. -/
namespace OpenProblems.N531
/-- Carmichael number (Korselt-free definition) -/
def Carmichael (n : ℕ) : Prop := 1 < n ∧ ¬ n.Prime ∧ ∀ a : ℕ, Nat.Coprime a n → a ^ (n - 1) ≡ 1 [MOD n]
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {n : ℕ | Carmichael n ∧ SevenFree n}
end OpenProblems.N531
