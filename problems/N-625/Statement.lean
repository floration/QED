import Mathlib
/-! N-625: Outer billiards around analytic tables with flat points
Outer billiards around a smooth convex table with positive curvature has only bounded orbits
(Moser–Douady), while polygons, semicircles and C^1-generic tables can have escaping orbits.
Question: if the table is strictly convex with real-analytic boundary but the curvature
vanishes at some point (e.g. the superellipse x^4 + y^4 ≤ 1), is every orbit bounded?
Informal statement: Let K ⊂ ℝ² be a strictly convex body whose boundary is a real-analytic
closed curve with curvature vanishing at at least one point. For p ∉ K let T(p) = 2q − p,
where q ∈ ∂K is the tangency point of the tangent line from p that has K on its left.
Is every T-orbit bounded, for every such K? (First test case: x^4 + y^4 ≤ 1.)
Formalization notes:
* Points are `ℝ × ℝ`; `cross u v = u.1 v.2 − u.2 v.1`. "y is (weakly) on the left of the
  directed line p → q" is `0 ≤ cross (q - p) (y - p)`.
* `AnalyticFlatTable K`: K compact, strictly convex, with nonempty interior, and its frontier
  is the image of a 1-periodic, real-analytic (`AnalyticAt` at every t), regular
  (`deriv γ t ≠ 0`) curve, injective on [0,1), with `cross γ'(t) γ''(t) = 0` for some t
  (zero curvature there). Analyticity forces finitely many flat points.
* `IsOuterBilliardOrbit K p`: p 0 ∉ K and for each n there is q ∈ K such that all of K lies
  weakly left of the line p n → q, and p (n+1) = 2q − p n. For strictly convex K and p ∉ K,
  such q exists and is unique (the line through p and q meets K only at q), so this is exactly
  the T-orbit; the orbit then stays outside K automatically.
* Proving `Claim`: every orbit of every such table is bounded. Proving `¬Claim`: exhibit one
  such table and one unbounded orbit. The "characterize" follow-up is not formalized.
-/
namespace OpenProblems.N625

/-- The planar cross product (signed area form). -/
def cross (u v : ℝ × ℝ) : ℝ := u.1 * v.2 - u.2 * v.1

/-- A strictly convex body with real-analytic regular boundary having a point of zero
curvature. -/
structure AnalyticFlatTable (K : Set (ℝ × ℝ)) : Prop where
  compact : IsCompact K
  strictConvex : StrictConvex ℝ K
  interior_nonempty : (interior K).Nonempty
  boundary : ∃ γ : ℝ → ℝ × ℝ,
    (∀ t : ℝ, AnalyticAt ℝ γ t) ∧
    Function.Periodic γ 1 ∧
    Set.InjOn γ (Set.Ico (0 : ℝ) 1) ∧
    Set.range γ = frontier K ∧
    (∀ t : ℝ, deriv γ t ≠ 0) ∧
    ∃ t : ℝ, cross (deriv γ t) (deriv (deriv γ) t) = 0

/-- `p` is an orbit of the outer billiard map around `K` (tangency point with `K` on the left). -/
def IsOuterBilliardOrbit (K : Set (ℝ × ℝ)) (p : ℕ → ℝ × ℝ) : Prop :=
  p 0 ∉ K ∧
    ∀ n : ℕ, ∃ q : ℝ × ℝ, q ∈ K ∧
      (∀ y : ℝ × ℝ, y ∈ K → 0 ≤ cross (q - p n) (y - p n)) ∧
      p (n + 1) = (2 : ℝ) • q - p n

def Claim : Prop :=
  ∀ K : Set (ℝ × ℝ), AnalyticFlatTable K →
    ∀ p : ℕ → ℝ × ℝ, IsOuterBilliardOrbit K p → Bornology.IsBounded (Set.range p)

end OpenProblems.N625
