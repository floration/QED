import Mathlib
/-! QED-E040: Densest packing of regular heptagons
Copies of a regular heptagon (any rotations and positions allowed) are placed in the plane without overlapping. The best known arrangement uses rows of heptagons pointing alternately up and down and covers about 89.27% of the plane. Prove no arrangement does better.
Informal statement: Let $\delta(P_7)$ be the maximal packing density of congruent copies of the regular heptagon $P_7$ in $\mathbb R^2$ (isometries allowed). Prove $\delta(P_7)=\frac{2}{97}\left(-111+492\cos\frac{\pi}{7}-356\cos^2\frac{\pi}{7}\right)\approx 0.892691$, the density of the best double-lattice packing.
Formalization notes:
* Space: `EuclideanSpace ℝ (Fin 2)` with its `volume` (Lebesgue measure; the Euclidean metric
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
* The regular heptagon: convex hull of the 7 points (cos 2πk/7, sin 2πk/7). Density is invariant
  under similarities, so the circumradius 1 is no loss.
* The double-lattice packing attaining the constant is known (Kuperberg–Kuperberg construction),
  so δ(P₇) ≥ value; the open content is the upper bound. Proving `Claim` = δ(P₇) equals the
  stated closed form (in particular optimality of the double-lattice packing). Proving `¬Claim` =
  δ(P₇) ≠ that value (by the known construction, a strictly denser packing exists).
-/
namespace OpenProblems.QEDE040
noncomputable section
open scoped ENNReal

/-- Ambient Euclidean space. -/
abbrev E : Type := EuclideanSpace ℝ (Fin 2)

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

/-- The regular heptagon with circumradius 1 centred at the origin. -/
def heptagon : Set E :=
  convexHull ℝ (Set.range fun k : Fin 7 =>
    (!₂[Real.cos (2 * Real.pi * (k : ℝ) / 7), Real.sin (2 * Real.pi * (k : ℝ) / 7)] : E))

/-- The conjectured optimal density `(2/97)(−111 + 492 cos(π/7) − 356 cos²(π/7)) ≈ 0.892691`. -/
def heptagonValue : ℝ :=
  2 / 97 * (-111 + 492 * Real.cos (Real.pi / 7) - 356 * Real.cos (Real.pi / 7) ^ 2)

def Claim : Prop := packingDensity heptagon = ENNReal.ofReal heptagonValue

end
end OpenProblems.QEDE040
