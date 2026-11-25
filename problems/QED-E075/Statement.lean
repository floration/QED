import Mathlib
/-! QED-E075: Wind-driven fire confinement threshold
A fire spreads from a bounded region with speed 1 + b cos θ in direction θ (0 ≤ b < 1, wind along the
positive x-axis); firefighters build barriers at speed σ (total length ≤ σt at time t). Bressan's
non-isotropic construction confines the fire whenever σ > U(b) := 2 max_θ (1 + b cos θ) sin θ.
Can one do strictly better for some wind strength?
Informal statement: (corrected) With F_b = conv{r e^{iθ} : 0 ≤ r ≤ 1 + b cos θ}, R₀ the open unit disc
and Bressan-admissible barriers (rectifiable, increasing, H¹(γ(t)) ≤ σt), show that for some fixed
b ∈ (0,1) some σ < 2 max_θ (1 + b cos θ) sin θ confines the fire (i.e. Bressan's upper bound is not
sharp for some fixed wind ratio). The original target "liminf_{b→a} σ*(a,b)/a > 0" is trivially true:
conv F contains the disc of radius ρ = min_u h_F(u) about 0, which equals a²/(4b) for b ≥ a/2, so
the comparison argument already gives σ* ≥ Λ·a²/(4b) → Λa/4 > 0.
Formalization notes: Scaling a = 1 loses nothing (σ*(a,b) = aσ*(1,b/a)). The plane is ℂ (Euclidean
metric, so `hausdorffMeasure 1` is length). R₀ is the open unit disc (with R₀ = {0} a single point
barrier at the origin would trivially block everything; the threshold does not depend on the bounded
open R₀). A barrier strategy γ is admissible at speed σ if it is increasing in t, each γ(t) is empty
or a countable union of Lipschitz images of [0,1] (Bressan's rectifiability condition), and
H¹(γ(t)) ≤ σt. Burned points at time t are x(t) for Lipschitz paths with |x(0)| < 1, ẋ(s) ∈ F_b
a.e. on [0,t] (Lipschitz paths are a.e. differentiable; any absolutely continuous path with
ẋ ∈ F_b is Lipschitz), and x(s) ∉ γ(s) for s ∈ [0,t]. Confinement: all burned points stay in a fixed
ball. Known: Λ·ρ(b) ≤ σ*(1,b) ≤ U(b), Λ ≈ 1.6262 (isotropic lower bound).
Proving `Claim` = exhibiting b ∈ (0,1) and a confining strategy of speed σ < U(b).
Proving `¬Claim` = Bressan's anisotropic construction is optimal for every b ∈ (0,1).
-/
namespace OpenProblems.QEDE075
noncomputable section

/-- Convexified spreading set for wind strength `b` (unit base speed). -/
def Fset (b : ℝ) : Set ℂ :=
  convexHull ℝ {z : ℂ | ∃ r θ : ℝ, 0 ≤ r ∧ r ≤ 1 + b * Real.cos θ ∧
    z = (r : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)}

/-- Bressan-admissible barrier strategy of construction speed `σ`. -/
def Admissible (σ : ℝ) (γ : ℝ → Set ℂ) : Prop :=
  (∀ s t : ℝ, 0 ≤ s → s ≤ t → γ s ⊆ γ t) ∧
  (∀ t : ℝ, 0 ≤ t → MeasureTheory.Measure.hausdorffMeasure (1 : ℝ) (γ t) ≤ ENNReal.ofReal (σ * t)) ∧
  (∀ t : ℝ, 0 ≤ t → γ t = ∅ ∨
    ∃ c : ℕ → ℝ → ℂ, (∀ m : ℕ, ∃ K : NNReal, LipschitzWith K (c m)) ∧
      γ t = ⋃ m : ℕ, c m '' Set.Icc (0 : ℝ) 1)

/-- `z` is burned at time `t` (reached by an admissible fire path avoiding the barrier). -/
def Burned (b : ℝ) (γ : ℝ → Set ℂ) (t : ℝ) (z : ℂ) : Prop :=
  ∃ x : ℝ → ℂ, (∃ K : NNReal, LipschitzWith K x) ∧ ‖x 0‖ < 1 ∧ x t = z ∧
    (∀ᵐ s ∂MeasureTheory.volume, s ∈ Set.Icc (0 : ℝ) t → ∀ v : ℂ, HasDerivAt x v s → v ∈ Fset b) ∧
    ∀ s ∈ Set.Icc (0 : ℝ) t, x s ∉ γ s

/-- Speed `σ` suffices to confine the fire with wind `b`. -/
def Confines (b σ : ℝ) : Prop :=
  ∃ γ : ℝ → Set ℂ, Admissible σ γ ∧ ∃ M : ℝ, ∀ t : ℝ, 0 ≤ t → ∀ z : ℂ, Burned b γ t z → ‖z‖ ≤ M

/-- Bressan's upper bound `2 max_θ (1 + b cos θ) sin θ`. -/
noncomputable def U (b : ℝ) : ℝ :=
  2 * sSup (Set.range fun θ : ℝ => (1 + b * Real.cos θ) * Real.sin θ)

def Claim : Prop :=
  ∃ b : ℝ, 0 < b ∧ b < 1 ∧ ∃ σ : ℝ, σ < U b ∧ Confines b σ

end

end OpenProblems.QEDE075
