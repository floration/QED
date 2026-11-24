import Mathlib
open Filter Topology
/-! N-498: Consecutive largest factors both 3 mod 4
Informal: Prove $\#\{n\le x:P(n)\equiv P(n+1)\equiv3\ (4)\}\sim x/4$. -/
namespace OpenProblems.N498
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- `#{n ≤ x : S n}` -/
noncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}
def Claim : Prop :=
  Tendsto (fun x : ℕ => (count (fun n => P n % 4 = 3 ∧ P (n + 1) % 4 = 3) x : ℝ) / x) atTop (𝓝 (1 / 4))
end OpenProblems.N498
