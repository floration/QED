import Mathlib
/-! QED-E147: How many faces can a convex space-filler have?
A convex polyhedron is a space-filler if congruent copies of it fill all of 3-space with no gaps or overlaps. In the plane a convex tile has at most 6 sides, but in space the record is 38 faces (Engel, 1981). Is there any finite upper bound at all on the number of faces of a convex space-filler?
Informal statement: Call a convex polytope $P\subset\mathbb{R}^3$ with nonempty interior a monohedral prototile if there are isometries $g_1,g_2,\dots$ of $\mathbb{R}^3$ with $\bigcup_i g_iP=\mathbb{R}^3$ and $\operatorname{int}(g_iP)\cap\operatorname{int}(g_jP)=\emptyset$ for $i\neq j$ (the tiling need not be face-to-face, isohedral or periodic). Decide whether there is $N<\infty$ such that every monohedral prototile in $\mathbb{R}^3$ has at most $N$ facets.
Formalization notes:
* E = `EuclideanSpace ℝ (Fin 3)` (Euclidean metric). A convex polytope is the convex hull of
  a finite point set `S`; we require nonempty interior (3-dimensional).
* Tiling: a sequence `g : ℕ → E ≃ᵢ E` of isometries (orientation-reversing ones allowed, the
  standard meaning of "congruent copies") whose images cover E and have pairwise disjoint
  interiors. Indexing by ℕ loses nothing: tiles with disjoint nonempty interiors are at most
  countably many, and finitely many compact tiles cannot cover E.
* Facets: F is a facet of P if F = {x ∈ P | ⟪a,x⟫ = sup_P ⟪a,·⟫} for some a ≠ 0 (an exposed
  face; P is compact and nonempty so the sSup is a genuine maximum) and the affine span of F
  has dimension 2. For a 3-polytope these are exactly its 2-dimensional faces.
* To avoid the junk value of cardinalities of possibly infinite sets, "P has at most N facets"
  is stated as: every finite family of distinct facets has at most N members.
* `Claim` = there is a uniform bound N. `¬Claim` = convex space-fillers with arbitrarily
  many facets exist.
-/
namespace OpenProblems.QEDE147
noncomputable section
open scoped InnerProductSpace RealInnerProductSpace

abbrev E := EuclideanSpace ℝ (Fin 3)

/-- `P` tiles space by congruent copies. -/
def Tiles (P : Set E) : Prop :=
  ∃ g : ℕ → (E ≃ᵢ E),
    (⋃ i : ℕ, (g i) '' P) = Set.univ ∧
    ∀ i j : ℕ, i ≠ j → Disjoint (interior ((g i) '' P)) (interior ((g j) '' P))

/-- `F` is a facet (2-dimensional exposed face) of `P`. -/
def IsFacet (P F : Set E) : Prop :=
  (∃ a : E, a ≠ 0 ∧
    F = {x : E | x ∈ P ∧ ⟪a, x⟫_ℝ = sSup ((fun y : E => ⟪a, y⟫_ℝ) '' P)}) ∧
  Module.finrank ℝ (affineSpan ℝ F).direction = 2

def Claim : Prop :=
  ∃ N : ℕ, ∀ S : Finset E,
    (interior (convexHull ℝ (S : Set E))).Nonempty →
    Tiles (convexHull ℝ (S : Set E)) →
    ∀ 𝓕 : Finset (Set E), (∀ F ∈ 𝓕, IsFacet (convexHull ℝ (S : Set E)) F) → 𝓕.card ≤ N

end
end OpenProblems.QEDE147
