import Mathlib
open Filter Topology
/-! N-477: Large prime factors of 2^n + 3^n
Informal: Prove $P(2^n+3^n)/n^2\to\infty$. -/
namespace OpenProblems.N477
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Tendsto (fun n : ℕ => (P (2 ^ n + 3 ^ n) : ℝ) / (n : ℝ) ^ 2) atTop atTop
end OpenProblems.N477
