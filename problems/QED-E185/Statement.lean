import Mathlib
/-! QED-E185: Dimension-free weak (1,1) bound for the ball maximal function
For a function f on d-dimensional space, the centred maximal function Mf(x) is the largest average
of |f| over balls centred at x. A classical theorem says the set where Mf exceeds lambda has volume
at most C_d ||f||_1 / lambda. Does one constant C work in every dimension d, or must the best C_d go
to infinity?
Informal statement: For d ≥ 1 and f ∈ L¹(ℝ^d) let Mf(x) = sup_{r>0} |B(x,r)|⁻¹ ∫_{B(x,r)} |f|,
with B(x,r) the Euclidean ball. Let C_d be the least constant with
|{x : Mf(x) > λ}| ≤ C_d λ⁻¹ ‖f‖_{L¹(ℝ^d)} for all f ∈ L¹(ℝ^d), λ > 0. Decide whether
sup_d C_d < ∞. Board claim (either direction accepted): Claim = "sup_d C_d < ∞".
Formalization notes:
* ℝ^d is `EuclideanSpace ℝ (Fin d)` with Lebesgue measure `volume` (Mathlib's measure on a
  finite-dimensional inner product space, the Haar measure giving the unit cube volume 1) and
  Euclidean balls `Metric.ball x r`.
* `maxFn f x = ⨆_{r>0} volume(B(x,r))⁻¹ · ∫⁻_{B(x,r)} |f|` in `ℝ≥0∞` (lower integral of
  `ENNReal.ofReal |f y|`; for integrable f this is the usual average of |f|; values are never junk
  since volume(B(x,r)) ∈ (0,∞) for r > 0).
* f ranges over real-valued `Integrable` functions (complex-valued f give the same constant since
  only |f| enters; it also suffices to take f ≥ 0).
* The level set `{x | ENNReal.ofReal λ < maxFn f x}` is compared with `ENNReal.ofReal (C/λ) · ‖f‖₁`
  where `‖f‖₁ = ∫⁻ ENNReal.ofReal |f|`. "sup_d C_d < ∞" is exactly "∃ C : ℝ, for all d ≥ 1, f, λ
  this inequality holds". Proving `Claim` = a dimension-free weak (1,1) constant; `¬Claim` = C_d
  unbounded.
-/
namespace OpenProblems.QEDE185
noncomputable section
open MeasureTheory

/-- The centred Hardy–Littlewood maximal function over Euclidean balls. -/
def maxFn {d : ℕ} (f : EuclideanSpace ℝ (Fin d) → ℝ) (x : EuclideanSpace ℝ (Fin d)) : ENNReal :=
  ⨆ (r : ℝ) (_ : 0 < r),
    (volume (Metric.ball x r))⁻¹ * ∫⁻ y in Metric.ball x r, ENNReal.ofReal |f y|

def Claim : Prop :=
  ∃ C : ℝ, ∀ (d : ℕ), 1 ≤ d → ∀ (f : EuclideanSpace ℝ (Fin d) → ℝ), Integrable f volume →
    ∀ (lam : ℝ), 0 < lam →
      volume {x : EuclideanSpace ℝ (Fin d) | ENNReal.ofReal lam < maxFn f x} ≤
        ENNReal.ofReal (C / lam) * ∫⁻ y, ENNReal.ofReal |f y|

end
end OpenProblems.QEDE185
