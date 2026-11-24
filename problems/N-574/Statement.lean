import Mathlib
open Filter Topology
/-! N-574: An irrational sum over largest factors
Informal: Prove $\sum_{n\ge2}\frac{1}{n\,P(n)}$ is irrational. -/
namespace OpenProblems.N574
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Irrational (∑' n : ℕ, if 2 ≤ n then (1 : ℝ) / ((n : ℝ) * P n) else 0)
end OpenProblems.N574
