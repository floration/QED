import Mathlib
/-! N-385: Cross-polytopes in 4D
Every smooth convex body in ℝ⁴ should have the eight vertices of some regular cross-polytope lying on
its boundary.
Informal statement: Prove that for every smooth convex body K ⊂ ℝ⁴ there is a regular cross-polytope
(a similar copy of conv{±e₁,…,±e₄}) all of whose 8 vertices lie on ∂K.
Formalization notes: ℝ⁴ is `Fin 4 → ℝ`; only its topology is used for compactness, convexity,
interior and frontier (the same as the Euclidean topology), and Euclidean geometry enters via the
explicit dot product `dot`. A smooth convex body is a compact convex set with nonempty interior that
has a global C^∞ defining function g (K = {g ≤ 0}, dg ≠ 0 on {g = 0}); this is equivalent to ∂K being
a C^∞ hypersurface. A regular cross-polytope (any similar copy, reflections allowed) is given by a
center c and four mutually orthogonal vectors u₁,…,u₄ of common length r > 0; its vertices are c ± uᵢ.
Proving `Claim` settles the case d = 4; proving `¬ Claim` means exhibiting a smooth convex body in ℝ⁴
with no inscribed regular cross-polytope.
-/
namespace OpenProblems.N385

/-- ℝ⁴ as functions `Fin 4 → ℝ`. -/
abbrev R4 : Type := Fin 4 → ℝ

/-- Euclidean dot product. -/
def dot (u v : R4) : ℝ := ∑ k : Fin 4, u k * v k

/-- Compact convex body with nonempty interior and C^∞ boundary (via a defining function). -/
def IsSmoothConvexBody (K : Set R4) : Prop :=
  IsCompact K ∧ Convex ℝ K ∧ (interior K).Nonempty ∧
    ∃ g : R4 → ℝ, (∀ n : ℕ, ContDiff ℝ n g) ∧ K = {x | g x ≤ 0} ∧
      ∀ x : R4, g x = 0 → fderiv ℝ g x ≠ 0

def Claim : Prop :=
  ∀ K : Set R4, IsSmoothConvexBody K →
    ∃ (c : R4) (u : Fin 4 → R4) (r : ℝ), 0 < r ∧
      (∀ i : Fin 4, dot (u i) (u i) = r ^ 2) ∧
      (∀ i j : Fin 4, i ≠ j → dot (u i) (u j) = 0) ∧
      ∀ i : Fin 4, c + u i ∈ frontier K ∧ c - u i ∈ frontier K

end OpenProblems.N385
