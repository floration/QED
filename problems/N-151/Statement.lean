import Mathlib
/-! N-151: Geodesic squares on convex surfaces
On a smooth convex surface with positive curvature, measure distance by the length of the
shortest path on the surface. Does every smooth simple closed curve on the surface contain four
points, in cyclic order, forming an intrinsic "square": four equal positive sides and two equal
diagonals? This is the Toeplitz square peg problem moved to intrinsic geometry.
Informal statement: Let S = ∂K for a convex body K ⊂ R^3 with smooth boundary and positive
Gaussian curvature, and let d be the intrinsic distance on S. Prove that every smooth simple
closed curve γ ⊂ S contains four distinct points p1, p2, p3, p4, in this cyclic order along γ,
with d(p1,p2) = d(p2,p3) = d(p3,p4) = d(p4,p1) > 0 and d(p1,p3) = d(p2,p4).
Formalization notes: Space is `EuclideanSpace ℝ (Fin 3)` (needed so that curve length uses the
Euclidean metric). The surface is S = {g = 0} for a C^∞ function g with K = {g <= 0} compact,
convex, with nonempty interior, ∇g ≠ 0 on S, and the Hessian of g positive definite on each
tangent plane ker dg(x), x ∈ S. With outward normal ∇g/|∇g| this says exactly that the second
fundamental form is positive definite, i.e. Gaussian curvature > 0; every smooth convex body
with positive curvature admits such a defining function. The intrinsic distance is the infimum,
in ℝ≥0∞, of the lengths (`eVariationOn` over [0,1]) of continuous paths in ℝ^3 with values in S
on [0,1] joining the points. A smooth simple closed curve is a C^∞ map γ : ℝ → ℝ^3 of period 1,
injective on [0,1), with nonvanishing derivative, lying in S. Cyclic order is encoded by
parameters t1 < t2 < t3 < t4 < t1 + 1 (so the four points are distinct). Proving Claim proves the
statement for all such surfaces and curves; ¬Claim requires a specific surface and curve with no
intrinsic inscribed square.
-/
namespace OpenProblems.N151

/-- Euclidean 3-space. -/
abbrev E3 : Type := EuclideanSpace ℝ (Fin 3)

/-- `S` is the boundary of a convex body with C^∞ boundary and positive Gaussian curvature,
given by a smooth defining function `g` (S = {g = 0}, body = {g <= 0}). -/
def IsSmoothPosCurvedConvexSurface (S : Set E3) : Prop :=
  ∃ g : E3 → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g ∧
    S = {x | g x = 0} ∧
    IsCompact {x | g x ≤ 0} ∧ Convex ℝ {x | g x ≤ 0} ∧ (interior {x | g x ≤ 0}).Nonempty ∧
    (∀ x ∈ S, fderiv ℝ g x ≠ 0) ∧
    (∀ x ∈ S, ∀ v : E3, v ≠ 0 → fderiv ℝ g x v = 0 → 0 < fderiv ℝ (fderiv ℝ g) x v v)

/-- `γ` parametrizes a smooth simple closed curve lying in `S` (period 1). -/
def IsSmoothSimpleClosedCurveOn (S : Set E3) (γ : ℝ → E3) : Prop :=
  ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) γ ∧ (∀ t : ℝ, γ (t + 1) = γ t) ∧
    Set.InjOn γ (Set.Ico (0 : ℝ) 1) ∧ (∀ t : ℝ, deriv γ t ≠ 0) ∧ (∀ t : ℝ, γ t ∈ S)

/-- Intrinsic (path-length) distance on `S`, valued in ℝ≥0∞. -/
noncomputable def intrinsicDist (S : Set E3) (p q : E3) : ENNReal :=
  ⨅ (c : ℝ → E3) (_ : Continuous c) (_ : ∀ t ∈ Set.Icc (0 : ℝ) 1, c t ∈ S)
    (_ : c 0 = p) (_ : c 1 = q), eVariationOn c (Set.Icc (0 : ℝ) 1)

def Claim : Prop :=
  ∀ S : Set E3, IsSmoothPosCurvedConvexSurface S →
    ∀ γ : ℝ → E3, IsSmoothSimpleClosedCurveOn S γ →
      ∃ t₁ t₂ t₃ t₄ : ℝ, t₁ < t₂ ∧ t₂ < t₃ ∧ t₃ < t₄ ∧ t₄ < t₁ + 1 ∧
        0 < intrinsicDist S (γ t₁) (γ t₂) ∧
        intrinsicDist S (γ t₁) (γ t₂) = intrinsicDist S (γ t₂) (γ t₃) ∧
        intrinsicDist S (γ t₂) (γ t₃) = intrinsicDist S (γ t₃) (γ t₄) ∧
        intrinsicDist S (γ t₃) (γ t₄) = intrinsicDist S (γ t₄) (γ t₁) ∧
        intrinsicDist S (γ t₁) (γ t₃) = intrinsicDist S (γ t₂) (γ t₄)

end OpenProblems.N151
