import Mathlib
/-! N-633: Ergodicity of the regular tetrahedron billiard
A billiard ball bounces inside a regular tetrahedron (dihedral angle arccos(1/3), an irrational multiple
of π). Is the billiard flow ergodic, so that almost every trajectory equidistributes in position and
direction?
Informal statement: Let Δ ⊂ ℝ³ be a regular tetrahedron and φ_t the billiard flow on T¹Δ, with specular
reflection at faces and orbits hitting edges or vertices discarded (a null set). Prove or disprove
that φ_t is ergodic with respect to Liouville measure. (Claim: ergodic.)
Formalization notes: Δ = {x : ∀ i, −⟪v_i, x⟫ ≤ 1} with vertices v_i = (1,1,1), (1,−1,−1), (−1,1,−1),
(−1,−1,1); face i (opposite v_i) has outward normal −v_i, |v_i|² = 3. The flow is built from the
collision map: `hitTime` = first time the ray x + tv reaches a face it moves towards, `hitFace` such a
face (an arbitrary choice on ties, i.e. edge/vertex hits — a null set), `reflect` the specular
reflection, `collTime z k` the k-th collision time, and `flow t z` free motion after the last
collision before t (junk value z if collision times accumulate before t; this is a null set).
Instead of the unit sphere bundle we use all nonzero velocities with Lebesgue measure on
int Δ × (ℝ³∖0): speed is conserved and the flow at speed r is the unit-speed flow reparametrized,
so ergodicity on T¹Δ is equivalent to: every measurable a.e.-invariant set is a.e. radial in the
velocity, i.e. a.e. equal to {(x,v) : |v|² ∈ R} for some R ⊆ ℝ. Invariance is a.e. and for t ≥ 0,
so junk on null sets does not matter.
Proving `Claim` = ergodicity. Proving `¬Claim` = an invariant set of positive, non-full measure on
the unit-speed shell.
-/
namespace OpenProblems.N633

open Classical

/-- ℝ³ with coordinates. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Dot product. -/
def dot (a b : R3) : ℝ := ∑ i : Fin 3, a i * b i

/-- Vertices of the regular tetrahedron. -/
def vert : Fin 4 → R3 := ![![1, 1, 1], ![1, -1, -1], ![-1, 1, -1], ![-1, -1, 1]]

/-- Interior of the tetrahedron. -/
def InTet (x : R3) : Prop := ∀ i : Fin 4, -dot (vert i) x < 1

/-- Rate of approach to face `i` (outward normal `-vert i`). -/
def rate (i : Fin 4) (v : R3) : ℝ := -dot (vert i) v

/-- Gap to face `i` measured along its normal. -/
def gap (i : Fin 4) (x : R3) : ℝ := 1 + dot (vert i) x

/-- Time until the next collision. -/
noncomputable def hitTime (z : R3 × R3) : ℝ :=
  sInf {t : ℝ | ∃ i : Fin 4, 0 < rate i z.2 ∧ t = gap i z.1 / rate i z.2}

/-- A face hit at the next collision. -/
noncomputable def hitFace (z : R3 × R3) : Fin 4 :=
  if h : ∃ i : Fin 4, 0 < rate i z.2 ∧ gap i z.1 / rate i z.2 = hitTime z then Classical.choose h
  else 0

/-- Specular reflection in face `i`. -/
noncomputable def reflect (i : Fin 4) (v : R3) : R3 := v + (2 * rate i v / 3) • vert i

/-- Collision map: move to the next face and reflect. -/
noncomputable def collide (z : R3 × R3) : R3 × R3 :=
  (z.1 + hitTime z • z.2, reflect (hitFace z) z.2)

/-- Time of the k-th collision. -/
noncomputable def collTime (z : R3 × R3) : ℕ → ℝ
  | 0 => 0
  | k + 1 => collTime z k + hitTime (collide^[k] z)

/-- The billiard flow (for `t ≥ 0`). -/
noncomputable def flow (t : ℝ) (z : R3 × R3) : R3 × R3 :=
  if h : ∃ k : ℕ, t < collTime z (k + 1) then
    ((collide^[Nat.find h] z).1 + (t - collTime z (Nat.find h)) • (collide^[Nat.find h] z).2,
      (collide^[Nat.find h] z).2)
  else z

/-- Phase space: interior positions, nonzero velocities. -/
def Phase : Set (R3 × R3) := {z | InTet z.1 ∧ z.2 ≠ 0}

def Claim : Prop :=
  ∀ A : Set (R3 × R3), MeasurableSet A → A ⊆ Phase →
    (∀ t : ℝ, 0 ≤ t →
      MeasureTheory.volume ((flow t ⁻¹' A ∩ Phase) \ A) = 0 ∧
      MeasureTheory.volume (A \ flow t ⁻¹' A) = 0) →
    ∃ Rset : Set ℝ, A =ᵐ[MeasureTheory.volume] {z : R3 × R3 | z ∈ Phase ∧ dot z.2 z.2 ∈ Rset}

end OpenProblems.N633
