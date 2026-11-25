import Mathlib
/-! QED-M140: Least volume of a Kakeya set for discs
A set in space contains a flat unit disc in every orientation. How small can its volume be? Such sets
cannot have zero volume, unlike sets containing a needle in every direction.
Informal statement: For a unit vector ν let D_ν = {x ∈ ℝ³ : x·ν = 0, |x| ≤ 1}. Let
c_* = inf{|E| : E ⊂ ℝ³ compact, ∀ν ∃x_ν, x_ν + D_ν ⊂ E}. By Marstrand and Falconer's L² bound for the
2-plane maximal operator, c_* > 0. Determine c_*. The Claim formalized here is the sharp sub-question
"is the unit ball beaten?": c_* < (4/3)π, i.e. there is a compact set containing a translate of every
D_ν whose Lebesgue measure is less than that of the unit ball.
Formalization notes: ℝ³ is modelled as `Fin 3 → ℝ` with its product Lebesgue measure `volume`; the
Euclidean structure is written out explicitly (dot product `∑ i, x i * ν i`, squared norm `∑ i, x i ^ 2`),
avoiding the sup-norm that Mathlib puts on `Fin 3 → ℝ`. A set E is a "disc Kakeya set" if it is compact
and for every unit vector ν some translate x + D_ν lies in E. Since c_* is an infimum over these sets
and the unit ball (all x_ν = 0) is admissible with volume 4π/3, "c_* < 4π/3" is equivalent to the
existence of an admissible E with volume < 4π/3, which is how `Claim` is stated (no `sInf` needed).
Proving `Claim` = exhibiting a disc Kakeya set beating the ball; `¬Claim` = the ball is optimal
(c_* = 4π/3, attained). The other sub-questions (exact value of c_* if < 4π/3; whether the infimum is
attained) are not captured by this Claim.
-/
namespace OpenProblems.QEDM140

noncomputable section

/-- Euclidean dot product on `ℝ³ = Fin 3 → ℝ`. -/
def dot (x y : Fin 3 → ℝ) : ℝ := ∑ i : Fin 3, x i * y i

/-- The unit disc through the origin perpendicular to `ν`. -/
def disc (ν : Fin 3 → ℝ) : Set (Fin 3 → ℝ) :=
  {y | dot y ν = 0 ∧ dot y y ≤ 1}

/-- `E` is compact and contains a translate of the unit disc perpendicular to every unit vector. -/
def IsDiscKakeya (E : Set (Fin 3 → ℝ)) : Prop :=
  IsCompact E ∧ ∀ ν : Fin 3 → ℝ, dot ν ν = 1 → ∃ x : Fin 3 → ℝ, ∀ y ∈ disc ν, x + y ∈ E

def Claim : Prop :=
  ∃ E : Set (Fin 3 → ℝ), IsDiscKakeya E ∧
    MeasureTheory.volume E < ENNReal.ofReal (4 / 3 * Real.pi)

end

end OpenProblems.QEDM140
