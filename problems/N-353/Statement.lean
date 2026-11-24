import Mathlib
open Filter Topology
/-! N-353: Doubly smooth neighbours
Informal: Prove infinitely many primes $p$ with $P(p-1),P(p+1)\le p^{0.1}$. -/
namespace OpenProblems.N353
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ (P (p - 1) : ℝ) ≤ (p : ℝ) ^ (0.1 : ℝ) ∧ (P (p + 1) : ℝ) ≤ (p : ℝ) ^ (0.1 : ℝ)}
end OpenProblems.N353
