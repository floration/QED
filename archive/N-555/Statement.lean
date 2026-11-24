import Mathlib
open Filter Topology
/-! N-555: Square-sum chains in primes
Informal: Prove for every $k$ there are primes $p_1,\dots,p_k$ with $p_i+p_{i+1}$ a perfect square for all $i<k$. -/
namespace OpenProblems.N555

def Claim : Prop :=
  ∀ k : ℕ, ∃ l : List ℕ, l.length = k ∧ l.Nodup ∧ (∀ p ∈ l, p.Prime) ∧ ∀ i : ℕ, ∀ h : i + 1 < l.length, IsSquare (l[i] + l[i + 1])
end OpenProblems.N555
