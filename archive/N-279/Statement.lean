import Mathlib
open Filter Topology
/-! N-279: Last digits of consecutive largest factors
Informal: Prove $\#\{n\le x: P(n)\equiv a,\ P(n+1)\equiv b\ (10)\}\sim\frac{x}{16}$ for all $a,b\in\{1,3,7,9\}$. -/
namespace OpenProblems.N279
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- `#{n ≤ x : S n}` -/
noncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}
def Claim : Prop :=
  ∀ a ∈ ({1, 3, 7, 9} : Finset ℕ), ∀ b ∈ ({1, 3, 7, 9} : Finset ℕ), Tendsto (fun x : ℕ => (count (fun n => P n % 10 = a ∧ P (n + 1) % 10 = b) x : ℝ) / x) atTop (𝓝 (1 / 16))
end OpenProblems.N279
