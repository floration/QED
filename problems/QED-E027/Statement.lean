import Mathlib
/-! QED-E027: Largest cap set in F_3^7
A cap set is a set of points in the 7-dimensional grid {0,1,2}^7 (arithmetic mod 3) containing no three points on a line. The biggest known one has 236 points, and it is known that 289 points is impossible. Find a bigger cap or prove a better upper bound.
Informal statement: Let $r_3(7)$ be the maximum size of $A\subseteq\mathbb F_3^7$ containing no three distinct points $x,y,z$ with $x+y+z=0$ (equivalently, no three collinear points). Known: $236\le r_3(7)\le 288$. Improve either bound; in particular, is there a cap of size $237$? Ultimately determine $r_3(7)$.
Formalization notes: IsCap A: no three pairwise distinct points of A sum to 0 in (ZMod 3)^7; this is the same as no three collinear points. Claim: a cap of size at least 237 exists, i.e. r_3(7) >= 237 (beating the record). ¬Claim means 236 is optimal, r_3(7)=236. This formalizes the lower-bound side only, not the upper bound.
-/
namespace OpenProblems.QEDE027
def IsCap (A : Finset (Fin 7 → ZMod 3)) : Prop :=
  ∀ x ∈ A, ∀ y ∈ A, ∀ z ∈ A, x ≠ y → y ≠ z → x ≠ z → x + y + z ≠ 0

def Claim : Prop :=
  ∃ A : Finset (Fin 7 → ZMod 3), IsCap A ∧ 237 ≤ A.card
end OpenProblems.QEDE027
