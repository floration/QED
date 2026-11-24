import Mathlib
open Filter Topology
/-! N-608: Irrational orbit sum
Informal: Prove $\sum_{k\ge0}1/Q^k(2)$ converges and is irrational. -/
namespace OpenProblems.N608
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
def Claim : Prop :=
  Summable (fun k : ℕ => (1 : ℝ) / ((fun n => P (n ^ 2 + 1))^[k] 2 : ℝ)) ∧ Irrational (∑' k : ℕ, (1 : ℝ) / ((fun n => P (n ^ 2 + 1))^[k] 2 : ℝ))
end OpenProblems.N608
