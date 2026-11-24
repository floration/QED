import Mathlib
open Filter Topology
/-! N-453: Largest factor of shifted primes mod 4
Informal: Prove $\#\{p\le x: P(p-1)\equiv1\ (4)\}\sim\tfrac12\pi(x)$. -/
namespace OpenProblems.N453
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- `#{n ≤ x : S n}` -/
noncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}
def Claim : Prop :=
  Tendsto (fun x : ℕ => (count (fun p => p.Prime ∧ P (p - 1) % 4 = 1) x : ℝ) / (count Nat.Prime x)) atTop (𝓝 (1 / 2))
end OpenProblems.N453
