import Mathlib
open Filter Topology
/-! N-484: Largest prime factor of 2^n + n
Informal: Prove $P(2^n+n)/n\to\infty$. -/
namespace OpenProblems.N484
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Tendsto (fun n : ℕ => (P (2 ^ n + n) : ℝ) / n) atTop atTop
end OpenProblems.N484
