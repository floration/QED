import Mathlib
open Filter Topology
/-! N-284: Linnik–Gallagher with seven-free primes
Informal: Prove there is $K$ such that every sufficiently large even $n$ is $p+2^{a_1}+\dots+2^{a_k}$ with $k\le K$ and $p$ a 7-free prime. -/
namespace OpenProblems.N284
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∃ K N₀ : ℕ, ∀ n ≥ N₀, Even n → ∃ p : ℕ, ∃ l : List ℕ, p.Prime ∧ SevenFree p ∧ l.length ≤ K ∧ n = p + (l.map (2 ^ ·)).sum
end OpenProblems.N284
