import Mathlib
/-! QED-E132: Optimal sphere packing in dimension 5, 6 or 7
In dimensions 5, 6 and 7 the densest known ball packings come from the lattices D5, E6 and E7, which are known to be the best lattice packings. Prove that at least one of them is optimal among all packings.
Informal statement: Let $\Delta_n$ be the supremum of upper densities of packings of congruent balls in
$\mathbb{R}^n$. Prove that at least one of $\Delta_5=\pi^2/(15\sqrt2)$ (density of $D_5$),
$\Delta_6=\pi^3/(48\sqrt3)$ (density of $E_6$), $\Delta_7=\pi^3/105$ (density of $E_7$) holds.
Formalization notes:
* Same packing-density definition as the board's convex-body packing problems (QED-E040),
  parametrised by the dimension: space `E n = EuclideanSpace ℝ (Fin n)` with `volume`; a packing
  of congruent copies of `K` is a sequence `g : ℕ → E n ≃ᵢ E n` of isometries with pairwise
  disjoint interiors `interior (g i '' K)`; upper density = `limsup_{R→∞}` of
  `vol(⋃ copies ∩ B(0,R)) / vol(B(0,R))` in `ℝ≥0∞`; `packingDensity n K` = supremum over packings.
  Indexing by ℕ loses nothing (packings of a body with nonempty interior are countable; finite
  packings have density 0), and limsup about the origin gives the standard supremum (Rogers).
* Balls: `K = closedBall 0 1` (density is scale invariant). Isometric images of a ball are balls
  of radius 1, and interiors are open balls, so a packing is exactly a set of unit balls with
  centres at mutual distance ≥ 2. `Δ n := packingDensity n (closedBall 0 1)`.
* Constants: centre density of D₅, E₆, E₇ times the unit-ball volume gives
  `π²/(15√2) ≈ 0.4653`, `π³/(48√3) ≈ 0.3729`, `π³/105 ≈ 0.2953`. The lattice packings give
  `Δ n ≥` these values, so each equality is equivalent to optimality of the lattice packing among
  all packings.
* `Claim` = the disjunction (at least one of the three dimensions is solved by its lattice).
  `¬Claim` = in each of dimensions 5, 6, 7 some packing has upper density strictly exceeding the
  lattice value.
-/
namespace OpenProblems.QEDE132
noncomputable section
open scoped ENNReal

/-- Ambient Euclidean space of dimension `n`. -/
abbrev E (n : ℕ) : Type := EuclideanSpace ℝ (Fin n)

/-- A packing of congruent copies of `K`: a sequence of isometries of `E n` whose images of `K`
have pairwise disjoint interiors. -/
def IsPacking {n : ℕ} (K : Set (E n)) (g : ℕ → (E n ≃ᵢ E n)) : Prop :=
  ∀ i j : ℕ, i ≠ j → Disjoint (interior (g i '' K)) (interior (g j '' K))

/-- Fraction of the ball of radius `R` about the origin covered by the packing. -/
def coveredFraction {n : ℕ} (K : Set (E n)) (g : ℕ → (E n ≃ᵢ E n)) (R : ℝ) : ℝ≥0∞ :=
  MeasureTheory.volume ((⋃ i : ℕ, g i '' K) ∩ Metric.ball (0 : E n) R) /
    MeasureTheory.volume (Metric.ball (0 : E n) R)

/-- Upper density of a packing: `limsup_{R → ∞}` of the covered fraction. -/
def upperDensity {n : ℕ} (K : Set (E n)) (g : ℕ → (E n ≃ᵢ E n)) : ℝ≥0∞ :=
  Filter.limsup (fun R : ℝ => coveredFraction K g R) Filter.atTop

/-- Maximal packing density of congruent copies of `K` in `E n`. -/
def packingDensity (n : ℕ) (K : Set (E n)) : ℝ≥0∞ :=
  ⨆ (g : ℕ → (E n ≃ᵢ E n)) (_ : IsPacking K g), upperDensity K g

/-- The sphere-packing constant `Δ_n`. -/
def spherePackingDensity (n : ℕ) : ℝ≥0∞ :=
  packingDensity n (Metric.closedBall (0 : E n) 1)

/-- At least one of the lattices D₅, E₆, E₇ is an optimal sphere packing. -/
def Claim : Prop :=
  spherePackingDensity 5 = ENNReal.ofReal (Real.pi ^ 2 / (15 * Real.sqrt 2)) ∨
  spherePackingDensity 6 = ENNReal.ofReal (Real.pi ^ 3 / (48 * Real.sqrt 3)) ∨
  spherePackingDensity 7 = ENNReal.ofReal (Real.pi ^ 3 / 105)

end
end OpenProblems.QEDE132
