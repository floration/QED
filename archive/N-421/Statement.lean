import Mathlib
open Filter Topology
/-! N-421: Prime cubes with one shift
Informal: Prove infinitely many prime solutions $(x,y,z,w)$ of $x^3+y^3=z^3+w^3+1$. -/
namespace OpenProblems.N421

def Claim : Prop :=
  Set.Infinite {v : ℕ × ℕ × ℕ × ℕ | v.1.Prime ∧ v.2.1.Prime ∧ v.2.2.1.Prime ∧ v.2.2.2.Prime ∧ v.1 ^ 3 + v.2.1 ^ 3 = v.2.2.1 ^ 3 + v.2.2.2 ^ 3 + 1}
end OpenProblems.N421
