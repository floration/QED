import Mathlib
/-! QED-E221: Hyperbolic square peg for all Jordan curves
Every closed curve without self-crossings in the hyperbolic plane should pass through the four corners of some regular hyperbolic quadrilateral (four equal sides, four equal angles). Smooth curves are known; the question is all continuous ones.
Informal statement: Let $\gamma\subset\mathbb H^2$ be a Jordan curve and $d$ the hyperbolic metric. Prove there are four distinct points $p_1,p_2,p_3,p_4\in\gamma$ with $d(p_1,p_2)=d(p_2,p_3)=d(p_3,p_4)=d(p_4,p_1)$ and $d(p_1,p_3)=d(p_2,p_4)$ (so they are the vertices of a regular geodesic quadrilateral). First targets: rectifiable curves, or the analogue of Stromquist's locally monotone class.
Formalization notes:
* Model of ℍ²: the upper half-plane `{z : ℂ | 0 < z.im}` with the standard hyperbolic distance
  `d(z,w) = 2 arsinh(|z − w| / (2 √(Im z · Im w)))` (curvature −1). This is defined by hand (`hdist`) rather than
  through Mathlib's `UpperHalfPlane` metric instance, to avoid any dependence on how that instance's topology is
  set up. All models of ℍ² are isometric, so the choice is immaterial.
* Jordan curve: `γ : ℝ → ℂ` continuous, 1-periodic, with values in the upper half-plane, injective on `[0,1)`.
  Its image is exactly a Jordan curve in ℍ² (the hyperbolic and Euclidean topologies on the open half-plane agree,
  so continuity w.r.t. the ambient topology of ℂ is the right notion), and every Jordan curve arises this way.
* Inscribed regular quadrilateral: four pairwise distinct points of `range γ` with the four "side" distances equal
  and the two "diagonal" distances equal. In ℍ², given distinct p₁, p₃, the points equidistant from both lie on the
  perpendicular bisector, at most two at a given distance (one on each side of the geodesic p₁p₃); so distinctness
  forces p₂, p₄ to be mirror images across p₁p₃, and the equal diagonals then give a regular geodesic quadrilateral
  (equal sides, equal angles). Distinctness rules out the degenerate "square of side 0". No cyclic order along γ
  is required (matching the informal statement).
* `Claim` = every Jordan curve in ℍ² inscribes a regular quadrilateral; `¬Claim` = an explicit Jordan curve in ℍ²
  without one. The partial targets (rectifiable / locally monotone curves) are not encoded.
-/
namespace OpenProblems.QEDE221
noncomputable section

/-- The upper half-plane model of the hyperbolic plane, as a subset of `ℂ`. -/
def H2 : Set ℂ := {z : ℂ | 0 < z.im}

/-- Hyperbolic distance in the upper half-plane model. -/
def hdist (z w : ℂ) : ℝ :=
  2 * Real.arsinh (‖z - w‖ / (2 * Real.sqrt (z.im * w.im)))

/-- `γ` is a 1-periodic parametrization of a Jordan curve lying in the hyperbolic plane. -/
def IsJordanCurve (γ : ℝ → ℂ) : Prop :=
  Continuous γ ∧ (∀ t : ℝ, γ (t + 1) = γ t) ∧ (∀ t : ℝ, γ t ∈ H2) ∧
    Set.InjOn γ (Set.Ico (0 : ℝ) 1)

/-- The curve passes through the four vertices of a regular hyperbolic quadrilateral. -/
def InscribesRegularQuad (γ : ℝ → ℂ) : Prop :=
  ∃ p₁ p₂ p₃ p₄ : ℂ,
    p₁ ∈ Set.range γ ∧ p₂ ∈ Set.range γ ∧ p₃ ∈ Set.range γ ∧ p₄ ∈ Set.range γ ∧
    p₁ ≠ p₂ ∧ p₁ ≠ p₃ ∧ p₁ ≠ p₄ ∧ p₂ ≠ p₃ ∧ p₂ ≠ p₄ ∧ p₃ ≠ p₄ ∧
    hdist p₁ p₂ = hdist p₂ p₃ ∧ hdist p₂ p₃ = hdist p₃ p₄ ∧ hdist p₃ p₄ = hdist p₄ p₁ ∧
    hdist p₁ p₃ = hdist p₂ p₄

/-- Every Jordan curve in the hyperbolic plane inscribes a regular quadrilateral. -/
def Claim : Prop :=
  ∀ γ : ℝ → ℂ, IsJordanCurve γ → InscribesRegularQuad γ

end
end OpenProblems.QEDE221
