import Mathlib
/-! QED-E143: Does a projective plane of order 12 exist?
A finite projective plane of order n has n^2+n+1 points and the same number of lines. Every line has n+1 points, and any two points lie on exactly one common line. Planes exist whenever n is a prime power, they are impossible for n = 6 and n = 10, and no plane is known for any other n. The smallest unsettled order is 12.
Informal statement: Decide whether there exists a finite incidence structure with $157$ points and $157$ lines in which every line contains exactly $13$ points, every point lies on exactly $13$ lines, and any two distinct points lie on exactly one common line. Equivalently: is there a $157\times157$ $0/1$ matrix $A$ with $AA^{\mathsf T}=12I+J$, or equivalently are there $11$ mutually orthogonal Latin squares of order $12$?
Formalization notes:
* Points are Fin 157; lines are 13-element subsets of the points, collected in a Finset B (so lines are distinct as
  point sets, as in a projective plane). `Claim`: |B| = 157, every line has 13 points, and any two distinct points
  lie on exactly one line of B.
* This is exactly a projective plane of order 12: a 2-(157,13,1) design. Counting gives each point on
  156/12 = 13 lines and |B| = 157·156/(13·12) = 157 (so the |B| condition is redundant but stated for fidelity), and
  two distinct lines meet in exactly one point (Fisher/symmetric-design argument); non-degeneracy is automatic.
  Conversely a projective plane of order 12 gives such B.
* Decision problem: proving `Claim` = constructing a projective plane of order 12; ¬Claim = none exists.
-/
namespace OpenProblems.QEDE143

def Claim : Prop :=
  ∃ B : Finset (Finset (Fin 157)), B.card = 157 ∧ (∀ b ∈ B, b.card = 13) ∧
    ∀ x y : Fin 157, x ≠ y → ∃! b : Finset (Fin 157), b ∈ B ∧ x ∈ b ∧ y ∈ b

end OpenProblems.QEDE143
