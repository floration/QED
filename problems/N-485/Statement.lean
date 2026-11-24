import Mathlib
open Filter Topology
/-! N-485: Largest prime factor of n^n + 1
Informal: Prove $P(n^n+1)/n\to\infty$. -/
namespace OpenProblems.N485
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Tendsto (fun n : ℕ => (P (n ^ n + 1) : ℝ) / n) atTop atTop
end OpenProblems.N485
