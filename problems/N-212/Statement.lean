import Mathlib
open Filter Topology
/-! N-212: Largest factor of consecutive-prime products
Informal: Prove $P(p_np_{n+1}+1)>p_{n+1}^{1.5}$ for infinitely many $n$. -/
namespace OpenProblems.N212
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- `p k` is the k-th prime, `p 1 = 2` -/
noncomputable def pr (k : ℕ) : ℕ := Nat.nth Nat.Prime (k - 1)
def Claim : Prop :=
  Set.Infinite {n : ℕ | 1 ≤ n ∧ (pr (n + 1) : ℝ) ^ (1.5 : ℝ) < P (pr n * pr (n + 1) + 1)}
end OpenProblems.N212
