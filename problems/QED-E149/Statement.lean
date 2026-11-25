import Mathlib
/-! QED-E149: Every centrally symmetric 5-polytope has at least 243 faces
A polytope is centrally symmetric if it looks the same after reflection through its centre, like a cube or an octahedron. The 5-dimensional cube has 3^5 = 243 non-empty faces (counting the polytope itself), and so does the 5-dimensional cross-polytope. It is conjectured that no centrally symmetric 5-polytope has fewer. This is proved in dimensions up to 4 and open in dimension 5.
Informal statement: Let $P\subset\mathbb R^5$ be a full-dimensional convex polytope with $P=-P$. Prove that $P$ has at least $3^5=243$ non-empty faces, where the faces are the sets $\{x\in P:\langle a,x\rangle=\max_{y\in P}\langle a,y\rangle\}$, $a\in\mathbb R^5$ ($a=0$ gives $P$ itself).
Formalization notes:
* ℝ⁵ is Fin 5 → ℝ (product topology = Euclidean) with the standard dot product `dot a x = ∑ a i * x i`.
  A polytope is P = convexHull of a finite set V; full-dimensional: interior P nonempty; centrally symmetric:
  x ∈ P → −x ∈ P (equivalently P = −P).
* `IsFace P F`: F = {x ∈ P | ∀ y ∈ P, dot a y ≤ dot a x} for some a (the maximizers of a linear functional; a = 0
  gives P). These are exactly the nonempty faces of P (P is compact and nonempty, so each such set is nonempty;
  the empty face is not counted).
* "At least 243 faces" is stated as an injection Fin 243 → faces, avoiding `ncard` junk values (faces of a polytope
  are finitely many, but the injection form needs no finiteness argument).
* Proving `Claim` = the 3^d conjecture in dimension 5; ¬Claim = a centrally symmetric 5-polytope with < 243
  nonempty faces.
-/
namespace OpenProblems.QEDE149
noncomputable section

def dot (a x : Fin 5 → ℝ) : ℝ := ∑ i : Fin 5, a i * x i

/-- F is a nonempty face of P: the set of maximizers in P of some linear functional. -/
def IsFace (P F : Set (Fin 5 → ℝ)) : Prop :=
  ∃ a : Fin 5 → ℝ, F = {x : Fin 5 → ℝ | x ∈ P ∧ ∀ y ∈ P, dot a y ≤ dot a x}

def Claim : Prop :=
  ∀ V : Finset (Fin 5 → ℝ),
    (interior (convexHull ℝ (V : Set (Fin 5 → ℝ)))).Nonempty →
    (∀ x ∈ convexHull ℝ (V : Set (Fin 5 → ℝ)), -x ∈ convexHull ℝ (V : Set (Fin 5 → ℝ))) →
    ∃ F : Fin 243 → Set (Fin 5 → ℝ), Function.Injective F ∧
      ∀ i : Fin 243, IsFace (convexHull ℝ (V : Set (Fin 5 → ℝ))) (F i)

end
end OpenProblems.QEDE149
