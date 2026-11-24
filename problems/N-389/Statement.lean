import Mathlib
open Filter Topology
/-! N-389: Carmichael numbers with prime digit sum
Informal: Prove infinitely many Carmichael numbers $n$ with $s_{10}(n)$ prime. -/
namespace OpenProblems.N389
/-- Carmichael number (Korselt-free definition) -/
def Carmichael (n : ℕ) : Prop := 1 < n ∧ ¬ n.Prime ∧ ∀ a : ℕ, Nat.Coprime a n → a ^ (n - 1) ≡ 1 [MOD n]
/-- digit sum in base `b` -/
def ds (b n : ℕ) : ℕ := (Nat.digits b n).sum
def Claim : Prop :=
  Set.Infinite {n : ℕ | Carmichael n ∧ (ds 10 n).Prime}
end OpenProblems.N389
