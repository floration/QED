import Mathlib
open Filter Topology
/-! N-441: Four-term square-sum chains in primes
Informal: Prove infinitely many 4-tuples of primes $p_1,p_2,p_3,p_4$ with $p_i+p_{i+1}$ a square for $i=1,2,3$. -/
namespace OpenProblems.N441

def Claim : Prop :=
  Set.Infinite {v : Fin 4 → ℕ | (∀ i, (v i).Prime) ∧ ∀ i : Fin 3, IsSquare (v i.castSucc + v i.succ)}
end OpenProblems.N441
