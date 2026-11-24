import Mathlib
open Filter Topology
/-! N-123: Three large consecutive factors
Informal: Prove infinitely many $n$ with $\min\{P(n),P(n+1),P(n+2)\}>n^{0.9}$. -/
namespace OpenProblems.N123
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Set.Infinite {n : ℕ | (n : ℝ) ^ (0.9 : ℝ) < P n ∧ (n : ℝ) ^ (0.9 : ℝ) < P (n + 1) ∧ (n : ℝ) ^ (0.9 : ℝ) < P (n + 2)}
end OpenProblems.N123
