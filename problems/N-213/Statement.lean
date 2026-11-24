import Mathlib
open Filter Topology
/-! N-213: Smooth shifted primes in two bases
Informal: Prove infinitely many 7-free primes $p$ with $P(p-1)\le p^{0.3}$. -/
namespace OpenProblems.N213
/-- largest prime factor; `P 0 = 0`, `P 1 = 1` -/
def P (n : ℕ) : ℕ := if n ≤ 1 then n else n.primeFactors.sup id
/-- no decimal digit 7 -/
def SevenFree (n : ℕ) : Prop := 7 ∉ Nat.digits 10 n
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ SevenFree p ∧ (P (p - 1) : ℝ) ≤ (p : ℝ) ^ (0.3 : ℝ)}
end OpenProblems.N213
