import Mathlib
/-! N-630: Charge on a Fermat conductor
Put a unit of electric charge on the perfectly conducting solid x⁴ + y⁴ + z⁴ ≤ 1. The claim is that
the surface charge density is smallest exactly at the six flat points (±1,0,0), (0,±1,0), (0,0,±1)
and largest exactly at the eight diagonal points 3^{-1/4}(±1,±1,±1).
Informal statement: Let K = {x⁴+y⁴+z⁴ ≤ 1} ⊂ ℝ³ and let μ = ρ dσ be its Newtonian (capacitary)
equilibrium measure, σ surface measure on ∂K (ρ is real-analytic and positive since ∂K is analytic).
Prove that min_{∂K} ρ is attained exactly at (±1,0,0),(0,±1,0),(0,0,±1) and max_{∂K} ρ exactly at
3^{-1/4}(±1,±1,±1).
Formalization notes: ℝ³ is `EuclideanSpace ℝ (Fin 3)` (Euclidean distance), coordinates via
`EuclideanSpace.proj`. The boundary ∂K is written explicitly as S = {x⁴+y⁴+z⁴ = 1}. Surface measure
is the 2-dimensional Hausdorff measure restricted to S; Mathlib's `hausdorffMeasure 2` is not
normalized to area, but it differs from surface area by a constant factor, which only rescales ρ and
does not affect where ρ is extremal. The equilibrium density is characterized as a continuous ρ with
total charge ∫_S ρ dσ = 1 whose single-layer potential ∫_S ρ(y)/|x−y| dσ(y) is constant on K. This
density exists (classical potential theory, ∂K analytic) and is unique on S (a zero-charge single
layer with constant potential on K has zero energy, hence vanishes), so quantifying over all such ρ
is faithful. The flat points are the points of S with two zero coordinates; the diagonal points are
the points of S with |x| = |y| = |z|. Proving `Claim` proves the conjecture; proving `¬ Claim` means
showing the density's minimum or maximum set is something else.
-/
namespace OpenProblems.N630

open MeasureTheory

/-- Euclidean 3-space. -/
abbrev E3 : Type := EuclideanSpace ℝ (Fin 3)

/-- The `i`-th coordinate. -/
noncomputable def coord (i : Fin 3) (x : E3) : ℝ := (EuclideanSpace.proj i : E3 →L[ℝ] ℝ) x

/-- `x⁴ + y⁴ + z⁴`. -/
noncomputable def quartic (x : E3) : ℝ := coord 0 x ^ 4 + coord 1 x ^ 4 + coord 2 x ^ 4

/-- The Fermat superball. -/
def K : Set E3 := {x | quartic x ≤ 1}

/-- Its boundary surface. -/
def S : Set E3 := {x | quartic x = 1}

/-- The six flat points. -/
def flatPts : Set E3 :=
  {y | y ∈ S ∧ ((coord 0 y = 0 ∧ coord 1 y = 0) ∨ (coord 0 y = 0 ∧ coord 2 y = 0) ∨
    (coord 1 y = 0 ∧ coord 2 y = 0))}

/-- The eight diagonal points `3^{-1/4}(±1,±1,±1)`. -/
def diagPts : Set E3 :=
  {y | y ∈ S ∧ |coord 0 y| = |coord 1 y| ∧ |coord 1 y| = |coord 2 y|}

/-- Surface measure on `S` (unnormalized 2-dimensional Hausdorff measure). -/
noncomputable def surf : Measure E3 := (Measure.hausdorffMeasure (2 : ℝ)).restrict S

/-- `ρ` is the (continuous) Newtonian equilibrium charge density of `K` w.r.t. `surf`. -/
def IsEquilibriumDensity (ρ : E3 → ℝ) : Prop :=
  Continuous ρ ∧ (∫ y, ρ y ∂surf) = 1 ∧
    ∃ c : ℝ, ∀ x ∈ K, (∫ y, ρ y / ‖x - y‖ ∂surf) = c

def Claim : Prop :=
  ∀ ρ : E3 → ℝ, IsEquilibriumDensity ρ →
    (∀ p ∈ flatPts, ∀ y ∈ S, ρ p ≤ ρ y ∧ (ρ y ≤ ρ p → y ∈ flatPts)) ∧
    (∀ p ∈ diagPts, ∀ y ∈ S, ρ y ≤ ρ p ∧ (ρ p ≤ ρ y → y ∈ diagPts))

end OpenProblems.N630
