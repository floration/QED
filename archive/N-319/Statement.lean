import Mathlib
open Filter Topology
/-! N-319: Seven-free factorial-like products
Informal: Prove $7\in n!+1$ (decimal) for all sufficiently large $n$. -/
namespace OpenProblems.N319

def Claim : Prop :=
  ∃ N : ℕ, ∀ n ≥ N, 7 ∈ Nat.digits 10 (n.factorial + 1)
end OpenProblems.N319
