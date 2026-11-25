import Mathlib
/-! QED-M057: A strongly aperiodic monotile in four dimensions
Find a single shape in four-dimensional space, homeomorphic to a closed 4-ball, whose congruent
copies (rotations and reflections allowed) tile R^4, but such that no tiling by it is invariant
under any nonzero translation. Aperiodic monotiles are known in the plane (the hat/spectre) and
have been claimed in dimension 3 (Chair44, 2026).
Informal statement: Find a compact set T ⊂ R^4 homeomorphic to a closed 4-ball such that
(i) R^4 admits a tiling by isometric copies of T (reflections allowed; copies cover R^4 with
pairwise disjoint interiors), and (ii) no such tiling is invariant under any nonzero translation.
Formalization notes: R^4 is modelled as `Fin 4 → ℝ` (product topology = Euclidean topology).
Isometries of R^4 are written explicitly as rigid motions x ↦ A x + b with Aᵀ A = 1 (so
reflections are allowed). The closed unit ball is {x | Σ x_i^2 <= 1}. A tiling by T is a set 𝒯
of subsets of R^4, each the image of T under a rigid motion, whose union is all of R^4 and whose
distinct members have disjoint interiors. A tiling is translation-invariant if some nonzero v
satisfies P ∈ 𝒯 ↔ P + v ∈ 𝒯 for every P. Proving Claim means exhibiting such a T together with
a proof that it tiles and that every tiling by it is non-periodic; proving ¬Claim means showing
that every topological-ball tile of R^4 that tiles admits some tiling with a nonzero translational
symmetry (i.e. no strongly aperiodic topological-ball monotile exists in R^4).
-/
namespace OpenProblems.QEDM057

/-- Four-dimensional real space as a function type. -/
abbrev R4 : Type := Fin 4 → ℝ

/-- The closed Euclidean unit ball in R^4. -/
def closedUnitBall : Set R4 := {x | (∑ i : Fin 4, x i ^ 2) ≤ 1}

/-- A rigid motion (isometry) of R^4: x ↦ A x + b with A orthogonal (reflections allowed). -/
structure RigidMotion where
  A : Matrix (Fin 4) (Fin 4) ℝ
  b : R4
  orth : Matrix.transpose A * A = 1

/-- Apply a rigid motion to a point. -/
def RigidMotion.apply (g : RigidMotion) (x : R4) : R4 := Matrix.mulVec g.A x + g.b

/-- `𝒯` is a tiling of R^4 by congruent copies of `T`. -/
def IsTilingBy (T : Set R4) (𝒯 : Set (Set R4)) : Prop :=
  (∀ P ∈ 𝒯, ∃ g : RigidMotion, P = g.apply '' T) ∧
  (⋃₀ 𝒯 = Set.univ) ∧
  (∀ P ∈ 𝒯, ∀ Q ∈ 𝒯, P ≠ Q → Disjoint (interior P) (interior Q))

/-- A tiling is invariant under some nonzero translation. -/
def IsTranslationInvariant (𝒯 : Set (Set R4)) : Prop :=
  ∃ v : R4, v ≠ 0 ∧ ∀ P : Set R4, P ∈ 𝒯 ↔ (fun x : R4 => x + v) '' P ∈ 𝒯

def Claim : Prop :=
  ∃ T : Set R4, IsCompact T ∧ Nonempty (↥T ≃ₜ ↥closedUnitBall) ∧
    (∃ 𝒯 : Set (Set R4), IsTilingBy T 𝒯) ∧
    ∀ 𝒯 : Set (Set R4), IsTilingBy T 𝒯 → ¬ IsTranslationInvariant 𝒯

end OpenProblems.QEDM057
