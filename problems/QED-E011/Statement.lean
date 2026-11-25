import Mathlib
/-! QED-E011: Rupert superballs
Informal statement: Let B_p = {x ∈ ℝ³ : |x₁|^p + |x₂|^p + |x₃|^p ≤ 1}. For every p ∈ (2, ∞) there
are orthogonal projections π₁, π₂ of ℝ³ onto planes and a rigid motion ρ of the plane with
ρ(π₁(B_p)) ⊂ int π₂(B_p), i.e. B_p has Rupert's property.
Formalization notes: equivalently (moving the body instead of the plane) there are rigid motions
ρ₁, ρ₂ of ℝ³ such that the shadow of ρ₁(B_p) on the xy-plane lies in the interior of the shadow
of ρ₂(B_p). The shadow is the coordinate map x ↦ (x₀, x₁) ∈ ℝ × ℝ; only the topology of the
target (product topology = Euclidean topology) is used, via `interior`. Rigid motions are
`IsometryEquiv`s of `EuclideanSpace ℝ (Fin 3)` (affine by Mazur–Ulam); allowing reflections is
harmless since B_p is invariant under coordinate reflections. The dual-norm reformulation of the
board text is not used. p = 2 (the ball) fails, so the claim is not vacuous.
-/
namespace OpenProblems.QEDE011
noncomputable section

abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- The superball `|x₁|^p + |x₂|^p + |x₃|^p ≤ 1`. -/
def superball (p : ℝ) : Set E3 := {x | ∑ i : Fin 3, |x i| ^ p ≤ 1}

/-- Orthogonal projection to the `xy`-plane. -/
def shadow (x : E3) : ℝ × ℝ := (x 0, x 1)

/-- Rupert's property: one copy can pass through a straight hole in another copy. -/
def IsRupert (K : Set E3) : Prop :=
  ∃ ρ₁ ρ₂ : E3 ≃ᵢ E3, shadow '' (ρ₁ '' K) ⊆ interior (shadow '' (ρ₂ '' K))

def Claim : Prop := ∀ p : ℝ, 2 < p → IsRupert (superball p)

end
end OpenProblems.QEDE011
