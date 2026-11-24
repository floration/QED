import Mathlib
open Filter Topology
/-! N-407: Prime-indexed seven-free primes
Informal: Prove infinitely many primes $p_q$ with $q$ prime and $p_q$ free of the decimal digit 7. -/
namespace OpenProblems.N407
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
/-- `p k` is the k-th prime, `p 1 = 2` -/
noncomputable def pr (k : ℕ) : ℕ := Nat.nth Nat.Prime (k - 1)
def Claim : Prop :=
  Set.Infinite {q : ℕ | q.Prime ∧ SevenFree (pr q)}
end OpenProblems.N407
