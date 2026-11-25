import Mathlib
/-! QED-E111: Quintic Szego growth
The cubic Szegő equation on the circle is completely integrable, and Gérard–Grellier showed that
its smooth solutions can have Sobolev norms that are unbounded in time. Decide whether the quintic
Szegő equation, which is presumably not integrable, also has smooth solutions with unbounded high
Sobolev norms.
Informal statement: On L²_+(𝕋) = {u ∈ L² : û(k) = 0 ∀ k < 0} with Szegő projector Π, consider
i∂ₜu = Π(|u|⁴u), which is globally well posed in H^s_+, s > 1/2, with conserved ‖u‖_{L²}, (Du,u) and
‖u‖_{L⁶}. Decide whether there exist u₀ ∈ C^∞(𝕋) ∩ L²_+ and s > 1/2 with
limsup_{t→∞} ‖u(t)‖_{H^s} = ∞. (`Claim`: such u₀ and s exist, and the solution is global.)
Formalization notes:
* 𝕋 = ℝ/2πℤ; functions on 𝕋 are 2π-periodic functions ℝ → ℂ. Fourier coefficients are
  û(k) = (1/2π) ∫₀^{2π} u(x) e^{−ikx} dx (`coef`).
* A global smooth solution is u : ℝ → ℝ → ℂ (time, space), C^n for every n jointly in (t,x)
  (values for t < 0 are irrelevant: a smooth function on [0,∞) × 𝕋 extends smoothly), 2π-periodic
  in x and with û(t,k) = 0 for k < 0 for all t ≥ 0, u(0) = u₀, and the equation tested on Fourier
  modes: i (d/dt) û(t,k) = (|u|⁴u)^(t,k) for all k ≥ 0, t > 0. For smooth u this is equivalent
  to the pointwise equation i∂ₜu = Π(|u|⁴u): both sides are smooth periodic functions, Πw has
  Fourier coefficients ŵ(k)·1_{k≥0}, and (∂ₜu)^ = d/dt û by differentiation under the integral;
  negative modes vanish on both sides. |u|⁴u is written (normSq u)²·u.
* H^s norm: ‖u‖²_{H^s} = Σ_k (1+k²)^s |û(k)|² (`tsum`; for smooth u(t) the series is summable,
  and a non-summable junk value 0 could only make growth harder, never fake it). Since u is smooth
  on [0,∞) × 𝕋, t ↦ ‖u(t)‖_{H^s} is continuous, so unboundedness on [0,∞) ⇔ limsup_{t→∞} = ∞.
* Existential form. `Claim` asks for a global smooth solution with unbounded H^s norm. Smooth
  solutions are unique (the nonlinearity is Lipschitz on bounded sets of H^s, s > 1/2), so this is
  the statement about "the" solution; and because existence of the global solution is part of
  `Claim`, a hypothetical failure of global well-posedness (flagged by the reviewer) cannot make
  `Claim` cheaply true: finite-time blow-up would not count as unbounded growth.
* Proving `Claim` = some smooth u₀ ∈ L²_+ has a global solution with unbounded H^s norm for some
  s > 1/2. Proving `¬Claim` = every global smooth solution has bounded H^s norms for every
  s > 1/2 (given GWP: all smooth solutions have bounded Sobolev norms).
-/
namespace OpenProblems.QEDE111
noncomputable section

/-- Fourier coefficient `û(k) = (1/2π) ∫₀^{2π} u(x) e^{−ikx} dx`. -/
def coef (w : ℝ → ℂ) (k : ℤ) : ℂ :=
  (1 / (2 * Real.pi) : ℂ) *
    ∫ x in (0 : ℝ)..(2 * Real.pi), w x * Complex.exp (-(Complex.I * (k : ℂ) * (x : ℂ)))

/-- Quintic nonlinearity `|z|⁴ z`. -/
def quintic (z : ℂ) : ℂ := ((Complex.normSq z ^ 2 : ℝ) : ℂ) * z

/-- Squared `H^s` norm `Σ_k (1+k²)^s |û(k)|²`. -/
def hsNormSq (s : ℝ) (w : ℝ → ℂ) : ℝ :=
  ∑' k : ℤ, (1 + (k : ℝ) ^ 2) ^ s * Complex.normSq (coef w k)

/-- `u₀` is a smooth function in `L²_+(𝕋)`. -/
def IsSmoothHardy (u₀ : ℝ → ℂ) : Prop :=
  (∀ n : ℕ, ContDiff ℝ n u₀) ∧ (∀ x : ℝ, u₀ (x + 2 * Real.pi) = u₀ x) ∧
    ∀ k : ℤ, k < 0 → coef u₀ k = 0

/-- `u` is a global smooth solution of the quintic Szegő equation with data `u₀`. -/
def IsGlobalSolution (u₀ : ℝ → ℂ) (u : ℝ → ℝ → ℂ) : Prop :=
  (∀ n : ℕ, ContDiff ℝ n (fun q : ℝ × ℝ => u q.1 q.2)) ∧
  (∀ t : ℝ, 0 ≤ t → ∀ x : ℝ, u t (x + 2 * Real.pi) = u t x) ∧
  (∀ t : ℝ, 0 ≤ t → ∀ k : ℤ, k < 0 → coef (u t) k = 0) ∧
  (∀ x : ℝ, u 0 x = u₀ x) ∧
  (∀ t : ℝ, 0 < t → ∀ k : ℤ, 0 ≤ k →
    Complex.I * deriv (fun τ : ℝ => coef (u τ) k) t = coef (fun x : ℝ => quintic (u t x)) k)

/-- Some smooth Hardy datum has a global solution whose `H^s` norm (some `s > 1/2`) is unbounded. -/
def Claim : Prop :=
  ∃ (u₀ : ℝ → ℂ) (s : ℝ) (u : ℝ → ℝ → ℂ), IsSmoothHardy u₀ ∧ 1 / 2 < s ∧
    IsGlobalSolution u₀ u ∧ ∀ M : ℝ, ∃ t : ℝ, 0 ≤ t ∧ M < hsNormSq s (u t)

end
end OpenProblems.QEDE111
