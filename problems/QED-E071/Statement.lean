import Mathlib
/-! QED-E071: Maximal eigenfunction growth beyond surfaces of revolution
On the round sphere, some eigenfunctions are as peaked as theory allows, because every geodesic leaving the pole comes back to it. Sogge and Zelditch proved that on any real-analytic surface, maximally peaked eigenfunctions force such a 'pole'. Is rotational symmetry also forced: must such a surface be a surface of revolution?
Informal statement: Let (M,g) be a compact connected boundaryless real-analytic Riemannian surface with
Δ_g e_j = −λ_j² e_j, ‖e_j‖_{L²} = 1. Say g has maximal eigenfunction growth if
limsup_j ‖e_j‖_{L^∞} / λ_j^{1/2} > 0 for some orthonormal eigenbasis. Decide whether every such (M,g)
carries a nontrivial isometric S¹-action, i.e. is a surface of revolution. (Necessary condition,
Sogge–Zelditch 2016: M has a pole.)
Formalization notes: Model. By Nash's analytic embedding theorem (Nash 1966), every compact
real-analytic Riemannian manifold has a real-analytic isometric embedding into some ℝ^N; conversely
a compact real-analytic embedded surface with the induced metric is a compact real-analytic Riemannian
surface. All notions involved (eigenbases, sup norms, isometric circle actions) are isometry
invariant, so we quantify over compact connected real-analytic embedded surfaces M ⊂ ℝ^N (N ≥ 3) with
the induced metric. `IsAnalyticSurface`: locally M = {F = 0} for a real-analytic submersion
F : ℝ^N → ℝ^{N−2} (no boundary; dimension 2 because N − 2 equations with surjective derivative; N ≥ 3
excludes degenerate cases such as N = 0, where a point would qualify). Riemannian measure: the
2-dimensional Hausdorff measure restricted to M (Mathlib's normalization differs from area by a
positive constant factor, which rescales L² norms and sup norms of normalized functions by a common
constant and does not affect eigenvalues, so the condition limsup > 0 is unchanged). Tangent plane:
`tangentConeAt ℝ M x`, which for an embedded C¹ submanifold is the tangent plane T_xM. Tangential
gradient: |∇_M f|²(x) = sup{(Df(x)v)² : v ∈ T_xM, |v| = 1}, and ⟨∇_M f, ∇_M g⟩ by polarization.
Eigenfunctions: smooth functions on M are exactly restrictions of smooth functions on ℝ^N (tubular
neighbourhood), and eigenfunctions are smooth (indeed analytic), so an eigenpair (λ, e) is an ambient
smooth e with ∫_M ⟨∇_M e, ∇_M φ⟩ = λ² ∫_M e φ for all ambient smooth φ (weak = strong for smooth e).
Real-valued bases suffice: for each eigenspace, sup over unit vectors of |u(x)| equals
(Σ_j |e_j(x)|²)^{1/2} for any (real or complex) orthonormal basis and is attained by a real vector.
Orthonormal eigenbasis: orthonormality in L²(M) and Parseval for all smooth φ (completeness). The
frequencies λ_j → ∞ along any enumeration, so limsup_j ‖e_j‖_∞/λ_j^{1/2} > 0 is "∃ c > 0 with
‖e_j‖_∞ ≥ c λ_j^{1/2} for infinitely many j" (`MaxGrowth`). Surface of revolution: a nontrivial
continuous action of S¹ = ℝ/ℤ (encoded as a 1-periodic ℝ-flow Φ on M) by isometries of the intrinsic
distance d_M (infimum of lengths, via `eVariationOn`, of paths in M); by Myers–Steenrod,
distance-preserving maps are smooth Riemannian isometries. A nontrivial continuous S¹ action has
finite kernel, so it induces an effective one. Connectedness is added (standard for this question).
Proving `Claim`: every such surface with maximal growth is a surface of revolution. Proving `¬Claim`:
a real-analytic surface with maximal growth but no isometric circle action (e.g. a non-rotational Zoll
surface with maximal growth).
-/
namespace OpenProblems.QEDE071
noncomputable section

open MeasureTheory Filter Topology

/-- Ambient Euclidean space `ℝ^N`. -/
abbrev E (N : ℕ) : Type := EuclideanSpace ℝ (Fin N)

/-- `M ⊂ ℝ^N` is a compact connected real-analytic embedded surface without boundary. -/
def IsAnalyticSurface (N : ℕ) (M : Set (E N)) : Prop :=
  IsCompact M ∧ IsConnected M ∧
    ∀ x ∈ M, ∃ U : Set (E N), IsOpen U ∧ x ∈ U ∧
      ∃ F : E N → EuclideanSpace ℝ (Fin (N - 2)),
        AnalyticOnNhd ℝ F U ∧ (∀ y ∈ U, Function.Surjective (fderiv ℝ F y)) ∧
          M ∩ U = {y : E N | y ∈ U ∧ F y = 0}

/-- Riemannian area measure of `M` (up to a constant factor): `𝓗²` restricted to `M`. -/
def area (N : ℕ) (M : Set (E N)) : Measure (E N) :=
  (Measure.hausdorffMeasure (2 : ℝ)).restrict M

/-- `|∇_M f|²(x)`: the squared norm of the tangential gradient. -/
def gradSq (N : ℕ) (M : Set (E N)) (f : E N → ℝ) (x : E N) : ℝ :=
  sSup ((fun v : E N => (fderiv ℝ f x v) ^ 2) '' {v : E N | v ∈ tangentConeAt ℝ M x ∧ ‖v‖ = 1})

/-- `⟨∇_M f, ∇_M g⟩(x)` by polarization. -/
def gradDot (N : ℕ) (M : Set (E N)) (f g : E N → ℝ) (x : E N) : ℝ :=
  (gradSq N M (f + g) x - gradSq N M (f - g) x) / 4

/-- Smooth functions on `ℝ^N` (their restrictions are exactly the smooth functions on `M`). -/
def IsSmooth (N : ℕ) (f : E N → ℝ) : Prop := ∀ k : ℕ, ContDiff ℝ k f

/-- `Δ_M e = −lam² e`, weakly against all smooth test functions. -/
def IsEigen (N : ℕ) (M : Set (E N)) (lam : ℝ) (e : E N → ℝ) : Prop :=
  IsSmooth N e ∧ ∀ φ : E N → ℝ, IsSmooth N φ →
    ∫ x, gradDot N M e φ x ∂(area N M) = lam ^ 2 * ∫ x, e x * φ x ∂(area N M)

/-- An orthonormal eigenbasis `(e_j)` of `L²(M)` with frequencies `lam_j ≥ 0`. -/
def IsEigenbasis (N : ℕ) (M : Set (E N)) (lam : ℕ → ℝ) (e : ℕ → E N → ℝ) : Prop :=
  (∀ j : ℕ, 0 ≤ lam j ∧ IsEigen N M (lam j) (e j)) ∧
    (∀ i j : ℕ, ∫ x, e i x * e j x ∂(area N M) = if i = j then (1 : ℝ) else 0) ∧
    ∀ φ : E N → ℝ, IsSmooth N φ →
      HasSum (fun j : ℕ => (∫ x, e j x * φ x ∂(area N M)) ^ 2) (∫ x, φ x ^ 2 ∂(area N M))

/-- Sup norm on `M`. -/
def supNorm (N : ℕ) (M : Set (E N)) (f : E N → ℝ) : ℝ := sSup ((fun x : E N => |f x|) '' M)

/-- Maximal eigenfunction growth: `limsup_j ‖e_j‖_∞ / lam_j^{1/2} > 0` for some eigenbasis. -/
def MaxGrowth (N : ℕ) (M : Set (E N)) : Prop :=
  ∃ (lam : ℕ → ℝ) (e : ℕ → E N → ℝ), IsEigenbasis N M lam e ∧
    ∃ c : ℝ, 0 < c ∧ ∀ J : ℕ, ∃ j : ℕ, J ≤ j ∧ c * Real.sqrt (lam j) ≤ supNorm N M (e j)

/-- Intrinsic (path-length) distance on `M`. -/
def dist_M (N : ℕ) (M : Set (E N)) (x y : E N) : ENNReal :=
  ⨅ (γ : ℝ → E N) (_ : ContinuousOn γ (Set.Icc (0 : ℝ) 1) ∧ γ 0 = x ∧ γ 1 = y ∧
      ∀ t ∈ Set.Icc (0 : ℝ) 1, γ t ∈ M),
    eVariationOn γ (Set.Icc (0 : ℝ) 1)

/-- `M` carries a nontrivial continuous isometric action of the circle `ℝ/ℤ`. -/
def HasCircleAction (N : ℕ) (M : Set (E N)) : Prop :=
  ∃ Φ : ℝ → E N → E N,
    (∀ t : ℝ, ∀ x ∈ M, Φ t x ∈ M) ∧
    (∀ x ∈ M, Φ 0 x = x) ∧
    (∀ s t : ℝ, ∀ x ∈ M, Φ (s + t) x = Φ s (Φ t x)) ∧
    (∀ t : ℝ, ∀ x ∈ M, Φ (t + 1) x = Φ t x) ∧
    ContinuousOn (fun q : ℝ × E N => Φ q.1 q.2) (Set.univ ×ˢ M) ∧
    (∀ t : ℝ, ∀ x ∈ M, ∀ y ∈ M, dist_M N M (Φ t x) (Φ t y) = dist_M N M x y) ∧
    ∃ t : ℝ, ∃ x ∈ M, Φ t x ≠ x

/-- Every compact real-analytic surface with maximal eigenfunction growth is a surface of
revolution. -/
def Claim : Prop :=
  ∀ N : ℕ, 3 ≤ N → ∀ M : Set (E N), IsAnalyticSurface N M → MaxGrowth N M → HasCircleAction N M

end
end OpenProblems.QEDE071
