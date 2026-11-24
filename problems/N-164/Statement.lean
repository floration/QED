import Mathlib
open Filter Topology
/-! N-164: Big factors of p² + p + 1
Informal: Prove $P(p^2+p+1)>p^{1.5}$ for infinitely many primes $p$. -/
namespace OpenProblems.N164
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ (p : ℝ) ^ (1.5 : ℝ) < P (p ^ 2 + p + 1)}
end OpenProblems.N164
