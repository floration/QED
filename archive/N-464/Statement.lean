import Mathlib
open Filter Topology
/-! N-464: Quasi-independence of square-plus-one steps
Informal: Prove $\#\{n\le x: P(n^2+1)<P((n+1)^2+1)\}\sim x/2$. -/
namespace OpenProblems.N464
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- `#{n ≤ x : S n}` -/
noncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}
def Claim : Prop :=
  Tendsto (fun x : ℕ => (count (fun n => P (n ^ 2 + 1) < P ((n + 1) ^ 2 + 1)) x : ℝ) / x) atTop (𝓝 (1 / 2))
end OpenProblems.N464
