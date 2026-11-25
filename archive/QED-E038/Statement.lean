import Mathlib
/-! QED-E038: Squeezing the square-lattice site percolation threshold
Colour each square of an infinite chessboard black independently with probability p. There is a critical p above which an infinite connected black cluster appears; simulations put it at about 0.5927, but nobody has a formula. The best proved statements only say it lies between 0.556 and 0.6669. Prove a tighter bound on either side.
Informal statement: Let $p_c=p_c^{\mathrm{site}}(\mathbb Z^2)$ be the critical probability for
Bernoulli site percolation on the square lattice (nearest-neighbour adjacency). Known
rigorously: $0.556 < p_c < 0.666894$ (lower: van den Berg–Ermakov 1996; upper: Wierman–Oberly,
reported to six decimals). Formal target (improvement of the UPPER bound at its published
precision): prove $p_c < 0.6668$.
Formalization notes:
* Configurations: `ω : ℤ × ℤ → Bool`, `ω x = true` meaning site x is open (black). The law
  `perc p` is Mathlib's infinite product measure `Measure.infinitePi` of Bernoulli(p) measures
  (`PMF.bernoulli p h` gives `true` with probability p), i.e. the product Bernoulli measure on
  {0,1}^(ℤ²) with the product σ-algebra.
* Clusters: sites are adjacent iff they differ by 1 in exactly one coordinate (ℓ¹ distance 1).
  The open cluster of the origin is the set of sites reachable from (0,0) along adjacent open
  sites (`Relation.ReflTransGen` of the open-adjacency relation; the step relation requires both
  ends open, so if the origin is closed its "cluster" is {0}). θ(p) = probability that this set
  is infinite (= the origin lies in an infinite open cluster; the event is measurable, being a
  countable union/intersection of cylinder events).
* p_c := sup {p ∈ [0,1] : θ(p) = 0}. θ is nondecreasing in p (standard coupling), so this is the
  usual critical probability; the set contains 0 and is bounded by 1, so `sSup` in `ℝ≥0` is
  meaningful.
* Choice of target: the known bounds are reported as strict inequalities with rounded constants
  (the upper bound is the rounded-up value of an algebraic number), so restating them would not be
  an improvement and their exact values are not encoded here. We take the improvement of the
  upper bound in the fourth decimal: p_c < 0.6668 (any rigorous bound ≤ 0.6668 − ε, e.g. by
  further substitution-method computations). Proving `Claim` = this new upper bound. Proving
  `¬Claim` = p_c ≥ 0.6668 (false according to all numerics, p_c ≈ 0.592746).
-/
namespace OpenProblems.QEDE038
noncomputable section
open MeasureTheory
open scoped NNReal ENNReal

/-- Site configurations on `ℤ²`. -/
abbrev Config : Type := ℤ × ℤ → Bool

/-- Nearest-neighbour adjacency on `ℤ²`. -/
def Adj (x y : ℤ × ℤ) : Prop := |x.1 - y.1| + |x.2 - y.2| = 1

/-- One step between adjacent open sites. -/
def OpenStep (ω : Config) (x y : ℤ × ℤ) : Prop := Adj x y ∧ ω x = true ∧ ω y = true

/-- The open cluster of the origin is infinite. -/
def Percolates (ω : Config) : Prop :=
  {z : ℤ × ℤ | Relation.ReflTransGen (OpenStep ω) (0, 0) z}.Infinite

/-- Product Bernoulli(`p`) site percolation measure. -/
def perc (p : ℝ≥0) (h : p ≤ 1) : Measure Config :=
  Measure.infinitePi (fun _ : ℤ × ℤ => (PMF.bernoulli p h).toMeasure)

/-- `θ(p)`: probability that the origin is in an infinite open cluster. -/
def theta (p : ℝ≥0) (h : p ≤ 1) : ℝ≥0∞ := perc p h {ω : Config | Percolates ω}

/-- Critical probability `p_c = sup {p : θ(p) = 0}`. -/
def pc : ℝ≥0 := sSup {p : ℝ≥0 | ∃ h : p ≤ 1, theta p h = 0}

/-- New upper bound `p_c < 0.6668`. -/
def Claim : Prop := (pc : ℝ) < 6668 / 10000

end
end OpenProblems.QEDE038
