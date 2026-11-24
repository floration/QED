import Mathlib
open Filter Topology
/-! N-318: Sums of a square and a seven-free prime
Informal: Prove the set of $n$ not of the form $m^2+p$ with $p$ prime and $7\notin p$ has density zero. -/
namespace OpenProblems.N318
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
/-- `#{n ≤ x : S n}` -/
noncomputable def count (S : ℕ → Prop) (x : ℕ) : ℕ := Nat.card {n : ℕ // n ≤ x ∧ S n}
def Claim : Prop :=
  Tendsto (fun x : ℕ => (count (fun n => ¬ ∃ m p : ℕ, p.Prime ∧ SevenFree p ∧ n = m ^ 2 + p) x : ℝ) / x) atTop (𝓝 0)
end OpenProblems.N318
