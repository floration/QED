import Mathlib
open Filter Topology
/-! N-603: Partition numbers contain a 7
Informal: Prove there is $N$ such that the decimal expansion of $p(n)$ contains the digit 7 for all $n\ge N$. -/
namespace OpenProblems.N603

def Claim : Prop :=
  ∃ N : ℕ, ∀ n ≥ N, 7 ∈ Nat.digits 10 (Fintype.card (Nat.Partition n))
end OpenProblems.N603
