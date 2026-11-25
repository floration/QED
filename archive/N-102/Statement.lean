import Mathlib
open Filter Topology
/-! N-102: Emirps, almost
Informal: Prove $\#\{p\le x: \Omega(\operatorname{rev}(p))\le3\}\to\infty$. -/
namespace OpenProblems.N102
/-- decimal digit reversal -/
def rev (n : ℕ) : ℕ := Nat.ofDigits 10 (Nat.digits 10 n).reverse
/-- number of prime factors with multiplicity -/
def Ω (n : ℕ) : ℕ := n.primeFactorsList.length
def Claim : Prop :=
  Set.Infinite {p : ℕ | p.Prime ∧ Ω (rev p) ≤ 3}
end OpenProblems.N102
