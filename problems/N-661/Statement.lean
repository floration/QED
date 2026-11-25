import Mathlib
/-! N-661: Hearing tetrahedra
Triangles are determined up to congruence by their Dirichlet spectrum (Durso 1988; Grieser–Maronna 2013).
The question is whether the same holds for tetrahedra in ℝ³: if two nondegenerate tetrahedra have the
same Dirichlet Laplacian eigenvalues counted with multiplicity, must they be congruent?
Informal statement: Let T₁, T₂ ⊂ ℝ³ be nondegenerate tetrahedra whose Dirichlet Laplacian eigenvalues,
counted with multiplicity, coincide. Prove that T₁ and T₂ are congruent.
Formalization notes: A tetrahedron is the convex hull of four affinely independent points of
`EuclideanSpace ℝ (Fin 3)`. The Dirichlet eigenvalues of the open set U = interior T are encoded by the
Courant–Fischer min-max characterization: λ_k(U) is the infimum, over k-tuples of linearly independent
smooth compactly supported functions with support in U, of the maximum of the Rayleigh quotient
∫|∇u|² / ∫u² over nonzero u in their span. Since C_c^∞(U) is dense in H¹₀(U), this equals the k-th
Dirichlet eigenvalue (with multiplicity) of the Friedrichs Dirichlet Laplacian. Hence "same spectrum
with multiplicity" is "λ_k equal for all k ≥ 1". `‖fderiv ℝ u x‖` is the operator norm of the
derivative, which equals the Euclidean length of the gradient. Congruence = some isometry of ℝ³
(reflections allowed) maps T₁ onto T₂. Proving `Claim` proves spectral rigidity for tetrahedra;
proving `¬ Claim` means exhibiting two noncongruent isospectral tetrahedra.
-/
namespace OpenProblems.N661

open MeasureTheory

/-- Euclidean 3-space. -/
abbrev E3 : Type := EuclideanSpace ℝ (Fin 3)

/-- The closed tetrahedron spanned by four points. -/
def tetra (v : Fin 4 → E3) : Set E3 := convexHull ℝ (Set.range v)

/-- Test functions on `U`: smooth, compactly supported, with support inside `U`. -/
def IsTestFn (U : Set E3) (u : E3 → ℝ) : Prop :=
  (∀ k : ℕ, ContDiff ℝ k u) ∧ HasCompactSupport u ∧ tsupport u ⊆ U

/-- Dirichlet energy `∫ |∇u|²`. -/
noncomputable def energy (u : E3 → ℝ) : ℝ := ∫ x, ‖fderiv ℝ u x‖ ^ 2

/-- `∫ u²`. -/
noncomputable def massSq (u : E3 → ℝ) : ℝ := ∫ x, (u x) ^ 2

/-- Rayleigh quotient. -/
noncomputable def rayleigh (u : E3 → ℝ) : ℝ := energy u / massSq u

/-- Maximum of the Rayleigh quotient over nonzero elements of the span of `φ`. -/
noncomputable def maxRayleigh {k : ℕ} (φ : Fin k → E3 → ℝ) : ℝ :=
  sSup {r : ℝ | ∃ c : Fin k → ℝ, c ≠ 0 ∧ r = rayleigh (∑ i, c i • φ i)}

/-- The `k`-th Dirichlet eigenvalue (k ≥ 1, counted with multiplicity) of the open set `U`,
via Courant–Fischer min-max over test functions. -/
noncomputable def dirichletEigenvalue (U : Set E3) (k : ℕ) : ℝ :=
  sInf {r : ℝ | ∃ φ : Fin k → E3 → ℝ, (∀ i, IsTestFn U (φ i)) ∧ LinearIndependent ℝ φ ∧
    r = maxRayleigh φ}

def Claim : Prop :=
  ∀ v w : Fin 4 → E3, AffineIndependent ℝ v → AffineIndependent ℝ w →
    (∀ k : ℕ, 1 ≤ k →
      dirichletEigenvalue (interior (tetra v)) k = dirichletEigenvalue (interior (tetra w)) k) →
    ∃ e : E3 ≃ᵢ E3, e '' tetra v = tetra w

end OpenProblems.N661
