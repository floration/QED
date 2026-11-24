import Mathlib
open Filter Topology
/-! N-601: Seven-free primes have a bounded gap
Informal: Prove $\liminf(q_{n+1}-q_n)<\infty$ where $q_n$ enumerates the 7-free primes. -/
namespace OpenProblems.N601
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  ∃ C : ℕ, Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ ∃ q : ℕ, q.Prime ∧ SevenFree q ∧ p < q ∧ q ≤ p + C}
end OpenProblems.N601
