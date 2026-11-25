import Mathlib
open Filter Topology
/-! N-282: Smooth p²+1
Informal: Prove infinitely many primes $p$ with $P(p^2+1)<p^{1/2}$. -/
namespace OpenProblems.N282
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ (P (p ^ 2 + 1) : ℝ) < (p : ℝ) ^ (1 / 2 : ℝ)}
end OpenProblems.N282
