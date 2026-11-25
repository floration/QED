import Mathlib
/-! QED-E038: The first decimal digit of the square-lattice site percolation threshold
Colour each square of an infinite chessboard black independently with probability p. Above a
critical value p_c an infinite connected black region appears. Simulations put p_c at 0.592746…,
and a randomised computer method certifies 0.5925 ≤ p_c ≤ 0.5930 with 99.9999% confidence, but
the best proved bounds are only 0.556 < p_c < 0.666894. Those bounds do not even determine the
first decimal digit of p_c. Prove that p_c < 0.6, i.e. that the first digit is 5.
Informal statement: Let $p_c=p_c^{\mathrm{site}}(\mathbb Z^2)$ be the critical probability for
Bernoulli site percolation on the square lattice (nearest-neighbour adjacency). Prove, by a
deterministic (non-statistical) argument, that $p_c < 3/5$. Together with the known lower bound
$p_c > 0.556$ this pins $p_c$ to $(0.5, 0.6)$, so its decimal expansion begins $0.5\ldots$.
Formalization notes:
* Configurations: `ω : ℤ × ℤ → Bool`, `ω x = true` meaning site x is open (black). The law
  `perc p` is Mathlib's infinite product measure `Measure.infinitePi` of Bernoulli(p) measures
  on `Bool` (`ProbabilityTheory.bernoulliMeasure true false p`, mass p on `true`), i.e. the
  product Bernoulli measure on {0,1}^(ℤ²) with the product σ-algebra. Parameters are taken in
  `unitInterval`.
* Clusters: sites are adjacent iff they differ by 1 in exactly one coordinate (ℓ¹ distance 1).
  The open cluster of the origin is the set of sites reachable from (0,0) along adjacent open
  sites (`Relation.ReflTransGen` of the open-adjacency relation; the step relation requires both
  ends open, so if the origin is closed its "cluster" is {0}). θ(p) = probability that this set
  is infinite.
* p_c := sup {p ∈ [0,1] : θ(p) = 0} as a real number. The set contains 0 (θ(0) = 0) and is
  bounded above by 1, so `sSup` is the usual critical probability (θ is nondecreasing).
* The number 3/5 is not a tuning knob: it is the coarsest bound that fixes a decimal digit, and
  the current rigorous interval (0.556, 0.666894) straddles 0.6. A proof must be a mathematical
  proof (possibly computer-assisted with exact arithmetic); a Monte Carlo confidence interval
  does not count. Proving `Claim` settles the problem. Proving `¬Claim` would mean p_c ≥ 0.6,
  contradicting all numerics.
-/
namespace OpenProblems.QEDE038
noncomputable section
open MeasureTheory ProbabilityTheory
open scoped ENNReal

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
def perc (p : unitInterval) : Measure Config :=
  Measure.infinitePi (fun _ : ℤ × ℤ => bernoulliMeasure true false p)

/-- `θ(p)`: probability that the origin is in an infinite open cluster. -/
def theta (p : unitInterval) : ℝ≥0∞ := perc p {ω : Config | Percolates ω}

/-- Critical probability `p_c = sup {p ∈ [0,1] : θ(p) = 0}`. -/
def pc : ℝ := sSup {p : ℝ | ∃ hp : p ∈ unitInterval, theta ⟨p, hp⟩ = 0}

/-- The first decimal digit of `p_c` is 5: `p_c < 3/5`. -/
def Claim : Prop := pc < 3 / 5

end
end OpenProblems.QEDE038
