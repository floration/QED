import Mathlib
open Filter Topology
/-! N-530: Three of four
Informal: Prove there are infinitely many $n$ such that at least three of $n,n+2,2n+1,2n+3$ are prime. -/
namespace OpenProblems.N530

def Claim : Prop :=
  Set.Infinite {n : ℕ | 3 ≤ ([n, n + 2, 2 * n + 1, 2 * n + 3].filter Nat.Prime).length}
end OpenProblems.N530
