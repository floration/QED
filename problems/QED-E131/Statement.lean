import Mathlib
/-! QED-E131: Optimal sphere packing in dimension 4
What is the densest way to pack equal balls in 4-dimensional space? The D4 lattice packing (density π²/16) is believed optimal and has been known to be the best lattice packing since 1873, but denser non-lattice packings have never been ruled out. Prove that no packing beats π²/16.
Informal statement: Let $\Delta_4$ be the supremum, over all packings of congruent open balls in $\mathbb{R}^4$, of the upper density $\limsup_{R\to\infty}\mathrm{vol}(\bigcup B\cap B(0,R))/\mathrm{vol}(B(0,R))$. Prove $\Delta_4=\pi^2/16$, the density of the $D_4$ lattice packing.
Formalization notes:
* Space: `EuclideanSpace ℝ (Fin 4)` with its `volume` (Lebesgue measure) and Euclidean metric,
  as in QED-E040 (heptagon packing), whose density definitions are reused here.
* Packing: a set `S` of centres with pairwise distances ≥ 2; the packing is the union of the
  open unit balls `ball x 1`, x ∈ S, which are pairwise disjoint exactly when distinct centres are
  at distance ≥ 2. Density is invariant under scaling, so radius 1 is no loss. `S` may be finite
  (density 0) or infinite (it is automatically countable).
* Density: upper density = limsup over R → ∞ of vol(⋃ balls ∩ B(0,R)) / vol(B(0,R)) in `ℝ≥0∞`
  (no junk values: numerator ≤ denominator < ∞, denominator > 0 for R > 0). Δ₄ = supremum over
  packings. The informal source used cubes [-R,R]⁴ instead of balls B(0,R); the supremum over
  packings is the same for either exhaustion (standard; cf. Rogers, Conway–Sloane), and balls are
  used for consistency with QED-E040. Open vs closed balls does not change volumes.
* The D₄ packing (centres the vectors of √2·D₄, minimal distance 2) has density π²/16, so
  Δ₄ ≥ π²/16 is known; the open content is Δ₄ ≤ π²/16. Proving `Claim` = Δ₄ = π²/16 (D₄ is an
  optimal packing). Proving `¬Claim` = Δ₄ ≠ π²/16, i.e. some packing has upper density > π²/16.
-/
namespace OpenProblems.QEDE131
noncomputable section
open scoped ENNReal

/-- Ambient Euclidean space `ℝ⁴`. -/
abbrev E : Type := EuclideanSpace ℝ (Fin 4)

/-- A packing of unit balls: centres pairwise at distance at least 2. -/
def IsPacking (S : Set E) : Prop :=
  ∀ x ∈ S, ∀ y ∈ S, x ≠ y → (2 : ℝ) ≤ dist x y

/-- Fraction of the ball of radius `R` about the origin covered by the open unit balls centred
at the points of `S`. -/
def coveredFraction (S : Set E) (R : ℝ) : ℝ≥0∞ :=
  MeasureTheory.volume ((⋃ x ∈ S, Metric.ball x 1) ∩ Metric.ball (0 : E) R) /
    MeasureTheory.volume (Metric.ball (0 : E) R)

/-- Upper density of a packing: `limsup_{R → ∞}` of the covered fraction. -/
def upperDensity (S : Set E) : ℝ≥0∞ :=
  Filter.limsup (fun R : ℝ => coveredFraction S R) Filter.atTop

/-- The sphere packing density `Δ₄` of `ℝ⁴`. -/
def packingDensity : ℝ≥0∞ :=
  ⨆ (S : Set E) (_ : IsPacking S), upperDensity S

def Claim : Prop := packingDensity = ENNReal.ofReal (Real.pi ^ 2 / 16)

end
end OpenProblems.QEDE131
