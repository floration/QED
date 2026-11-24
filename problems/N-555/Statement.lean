import Mathlib
open Filter Topology
/-! N-555: Square-sum chains in primes
Informal: Prove for every $k$ there are primes $p_1,\dots,p_k$ with $p_i+p_{i+1}$ a perfect square for all $i<k$. -/
namespace OpenProblems.N555

def Claim : Prop :=
  ∀ k : ℕ, ∃ l : List ℕ, l.length = k ∧ l.Nodup ∧ (∀ p ∈ l, p.Prime) ∧ l.Chain' (fun a b => IsSquare (a + b))
end OpenProblems.N555
