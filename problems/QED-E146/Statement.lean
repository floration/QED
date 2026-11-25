import Mathlib
/-! QED-E146: Eight points with integer distances in general position
Can you place eight points in the plane so that every pair is an integer distance apart, no three points lie on a line, and no four lie on a circle? Seven such points were found by computer in 2008. Nobody has found eight or shown that eight is impossible.
Informal statement: Decide whether there exist pairwise distinct $p_1,\dots,p_8\in\mathbb{R}^2$ such that $|p_i-p_j|\in\mathbb{Z}$ for all $i,j$, no three of the $p_i$ are collinear, and no four of the $p_i$ are concyclic.
Formalization notes:
* The plane is `EuclideanSpace ℝ (Fin 2)` with its Euclidean `dist`.
* Integer distances: for all i, j there is an integer m with `dist (p i) (p j) = m`.
* No three collinear: for every 3-element index set s, the image point set is not `Collinear ℝ`.
* No four concyclic: for every 4-element index set s, the image is not
  `EuclideanGeometry.Cospherical` (some center and radius with all points at that distance).
  In the plane, cospherical = concyclic (Mathlib's `Concyclic` adds coplanarity, automatic in
  dimension 2), so we use `Cospherical` directly. Radius 0 is impossible for distinct points.
* `Function.Injective p` gives pairwise distinct points (also implied by the collinearity condition).
* Claim = such 8 points exist; ¬Claim = they do not.
-/
namespace OpenProblems.QEDE146
noncomputable section

def Claim : Prop :=
  ∃ p : Fin 8 → EuclideanSpace ℝ (Fin 2), Function.Injective p ∧
    (∀ i j : Fin 8, ∃ m : ℤ, dist (p i) (p j) = (m : ℝ)) ∧
    (∀ s : Finset (Fin 8), s.card = 3 → ¬ Collinear ℝ (p '' (s : Set (Fin 8)))) ∧
    (∀ s : Finset (Fin 8), s.card = 4 →
      ¬ EuclideanGeometry.Cospherical (p '' (s : Set (Fin 8))))

end
end OpenProblems.QEDE146
