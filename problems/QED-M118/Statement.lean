import Mathlib
/-! QED-M118: Exponentially beat Minkowski's sphere packing lower bound
In high dimension n the best sphere packings known have density only about n²·2^{-n} (up to log
factors), barely above the trivial 2^{-n} from greedy/saturated packings, while the best upper bound
is about 2^{-0.599n}. Is there a constant c>1 with packings of density at least c^n·2^{-n} in all
large dimensions?
Informal statement: Let $\Delta_n$ be the supremum of upper densities of packings of congruent balls
in $\mathbb{R}^n$. Prove or disprove: there exist $c>1$ and $N$ such that $\Delta_n\ge c^n2^{-n}$ for
all $n\ge N$.
Formalization notes:
* Space: `EuclideanSpace ℝ (Fin n)` with its `volume` (Lebesgue measure) and Euclidean metric.
  The definitions follow the packing-density definitions of QED-E040, specialised to balls.
* Packing: congruent copies of the closed unit ball are exactly its translates (the ball is
  invariant under orthogonal maps), so a packing is a sequence of centres `x : ℕ → E` with
  `dist (x i) (x j) ≥ 2` for `i ≠ j`, i.e. the balls have pairwise disjoint interiors (they may
  touch). Indexing by ℕ loses nothing: a ball packing is countable, and finite packings have
  density 0. The radius 1 is no loss since density is scale-invariant.
* Density: upper density = limsup over R → ∞ of vol(⋃ balls ∩ B(0,R)) / vol(B(0,R)), computed in
  `ℝ≥0∞` (numerator ≤ denominator < ∞, denominator > 0 for R > 0 and n ≥ 1). Δ_n is the supremum
  over packings (the standard definition, as in Rogers / Conway–Sloane; limsup vs lim and centring
  at the origin do not change the supremum).
* `Claim` = ∃ c > 1, ∃ N, ∀ n ≥ N, Δ_n ≥ (c/2)^n. Since Δ_n is a supremum, this is equivalent (after
  shrinking c) to the existence of individual packings of density ≥ c^n 2^{-n}. Proving `¬Claim` =
  for every c > 1 there are infinitely many n with Δ_n < c^n 2^{-n}, i.e. no exponential improvement
  over 2^{-n} holds in all large dimensions.
-/
namespace OpenProblems.QEDM118
noncomputable section
open scoped ENNReal

/-- Ambient Euclidean space `ℝⁿ`. -/
abbrev E (n : ℕ) : Type := EuclideanSpace ℝ (Fin n)

/-- A packing of unit balls with centres `x i`: distinct centres are at distance at least 2. -/
def IsPacking {n : ℕ} (x : ℕ → E n) : Prop :=
  ∀ i j : ℕ, i ≠ j → 2 ≤ dist (x i) (x j)

/-- Fraction of the ball of radius `R` about the origin covered by the packing. -/
def coveredFraction {n : ℕ} (x : ℕ → E n) (R : ℝ) : ℝ≥0∞ :=
  MeasureTheory.volume ((⋃ i : ℕ, Metric.closedBall (x i) 1) ∩ Metric.ball (0 : E n) R) /
    MeasureTheory.volume (Metric.ball (0 : E n) R)

/-- Upper density of a packing: `limsup_{R → ∞}` of the covered fraction. -/
def upperDensity {n : ℕ} (x : ℕ → E n) : ℝ≥0∞ :=
  Filter.limsup (fun R : ℝ => coveredFraction x R) Filter.atTop

/-- Sphere packing density `Δ_n` of `ℝⁿ`. -/
def packingDensity (n : ℕ) : ℝ≥0∞ :=
  ⨆ (x : ℕ → E n) (_ : IsPacking x), upperDensity x

def Claim : Prop :=
  ∃ c : ℝ, 1 < c ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ENNReal.ofReal ((c / 2) ^ n) ≤ packingDensity n

end
end OpenProblems.QEDM118
