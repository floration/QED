import Mathlib
open Filter Topology
/-! N-175: Emirp sieve
Informal: Prove infinitely many primes $p$ have $\operatorname{rev}(p)$ with all prime factors $>p^{0.1}$. -/
namespace OpenProblems.N175
/-- decimal digit reversal -/
def rev (n : ℕ) : ℕ := Nat.ofDigits 10 (Nat.digits 10 n).reverse
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ ∀ q ∈ (rev p).primeFactors, (p : ℝ) ^ (0.1 : ℝ) < q}
end OpenProblems.N175
