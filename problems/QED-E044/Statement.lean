import Mathlib
/-! QED-E044: A macroscopic upper bound for tetrahedron packing
Regular tetrahedra cannot fill space, and the best packings found fill about 85.6% of it. Yet the best proved limit only says a packing fills at most 1 − 0.00000000000000000000000026 of space. Prove a macroscopic upper bound, for instance that no packing of congruent regular tetrahedra fills more than 99% of space.
Informal statement: Let $\delta_T$ be the maximal packing density of congruent copies of the
regular tetrahedron in $\mathbb R^3$ (rotations allowed). Known:
$4000/4671\approx0.856347\le\delta_T\le 1-2.6\times10^{-25}$ (Gravel–Elser–Kallus). Formal
target: the macroscopic upper bound $\delta_T\le 0.99$.
Formalization notes:
* Space: `EuclideanSpace ℝ (Fin 3)` with its `volume` (Lebesgue measure; the Euclidean metric
  matters because congruent copies are images under isometries `E ≃ᵢ E` of this metric — these
  are exactly the maps x ↦ Ax + b with A orthogonal, so rotations and reflections are allowed).
* Packing: a sequence `g : ℕ → E ≃ᵢ E` with the copies `g i '' K` having pairwise disjoint
  interiors (boundaries may touch). Indexing by ℕ loses nothing: a packing of copies of a convex
  body is countable, and finite packings have density 0. Repeated copies are impossible since
  `interior K ≠ ∅`.
* Density: upper density = limsup over R → ∞ of vol(⋃ copies ∩ B(0,R)) / vol(B(0,R)), computed
  in `ℝ≥0∞` (no junk values: numerator ≤ denominator < ∞, denominator > 0 for R > 0). The
  maximal packing density δ(K) is the supremum over all packings. This is the standard
  definition (Rogers; Fejes Tóth); taking limsup instead of lim, or balls about the origin
  instead of arbitrary centres, does not change the supremum over packings.
* The regular tetrahedron: convex hull of (1,1,1), (1,−1,−1), (−1,1,−1), (−1,−1,1) (edge 2√2;
  density is similarity-invariant). It is mirror-symmetric, so allowing reflections among the
  isometries is the same as allowing only rotations.
* Choice of target: the problem explicitly asks for a *macroscopic* gap, and "strictly improve
  1 − 2.6·10⁻²⁵" by an arbitrarily small amount would not be the intended question; we use the
  problem's own illustrative threshold 0.99 (c = 10⁻²). This is a strict improvement over the
  best known upper bound by 24 orders of magnitude in the gap. Proving `Claim` = δ_T ≤ 0.99.
  Proving `¬Claim` = some tetrahedron packing has upper density > 0.99.
-/
namespace OpenProblems.QEDE044
noncomputable section
open scoped ENNReal

/-- Ambient Euclidean space. -/
abbrev E : Type := EuclideanSpace ℝ (Fin 3)

/-- A packing of congruent copies of `K`: a sequence of isometries of `E` (rotations,
reflections, translations) whose images of `K` have pairwise disjoint interiors. -/
def IsPacking (K : Set E) (g : ℕ → (E ≃ᵢ E)) : Prop :=
  ∀ i j : ℕ, i ≠ j → Disjoint (interior (g i '' K)) (interior (g j '' K))

/-- Fraction of the ball of radius `R` about the origin covered by the packing. -/
def coveredFraction (K : Set E) (g : ℕ → (E ≃ᵢ E)) (R : ℝ) : ℝ≥0∞ :=
  MeasureTheory.volume ((⋃ i : ℕ, g i '' K) ∩ Metric.ball (0 : E) R) /
    MeasureTheory.volume (Metric.ball (0 : E) R)

/-- Upper density of a packing: `limsup_{R → ∞}` of the covered fraction. -/
def upperDensity (K : Set E) (g : ℕ → (E ≃ᵢ E)) : ℝ≥0∞ :=
  Filter.limsup (fun R : ℝ => coveredFraction K g R) Filter.atTop

/-- Maximal packing density of congruent copies of `K`. -/
def packingDensity (K : Set E) : ℝ≥0∞ :=
  ⨆ (g : ℕ → (E ≃ᵢ E)) (_ : IsPacking K g), upperDensity K g

/-- A regular tetrahedron centred at the origin. -/
def tetrahedron : Set E :=
  convexHull ℝ {(!₂[(1 : ℝ), 1, 1] : E), (!₂[(1 : ℝ), -1, -1] : E),
    (!₂[(-1 : ℝ), 1, -1] : E), (!₂[(-1 : ℝ), -1, 1] : E)}

def Claim : Prop := packingDensity tetrahedron ≤ ENNReal.ofReal (99 / 100)

end
end OpenProblems.QEDE044
