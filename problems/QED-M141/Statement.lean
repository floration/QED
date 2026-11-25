import Mathlib
/-! QED-M141: Forced blow-up for the surface quasi-geostrophic equation
The surface quasi-geostrophic (SQG) equation is a 2D model of geophysical flow. Whether it can
blow up from smooth data is a famous open problem. Can at least a smooth, compactly supported push,
applied to a fluid that starts at rest, make it blow up in finite time, as was done for 3D
Navier–Stokes in 2026?
Informal statement: Consider inviscid SQG on ℝ²: ∂ₜθ + u·∇θ = f, u = ∇^⊥(−Δ)^{−1/2}θ,
θ(·,0) = 0. Decide whether there is f ∈ C_c^∞(ℝ² × (0,∞)) whose unique smooth solution on [0,T)
satisfies limsup_{t↑T} ‖∇θ(t)‖_{L^∞} = ∞ for some T < ∞. (Variant, not part of `Claim`: the same
for supercritical dissipative SQG, + κ(−Δ)^{α/2}θ with 0 < α < 1.)
Formalization notes: Space is `Fin 2 → ℝ` with Lebesgue measure; derivatives are Fréchet
derivatives, and the Euclidean length is written out (`eucl`), so the sup norm on `Fin 2 → ℝ`
plays no role. Velocity: ∇^⊥ = (−∂₂, ∂₁) and (−Δ)^{−1/2} on ℝ² is the Riesz potential with kernel
1/(2π|x|). For θ(·,t) smooth and compactly supported, ∂ⱼ(−Δ)^{−1/2}θ = (−Δ)^{−1/2}∂ⱼθ, so
u(x,t) = (1/2π) (−∫ ∂₂θ(y,t)/|x−y| dy, ∫ ∂₁θ(y,t)/|x−y| dy); these integrals converge absolutely
(|·|⁻¹ is locally integrable in 2D), so there is no principal value and no Bochner junk. (The other
sign convention u = −∇^⊥Λ⁻¹θ is equivalent via the reflection x₁ ↦ −x₁, which maps C_c^∞ forces to
C_c^∞ forces.)
"The unique smooth solution on [0,T)": θ is C^k for every k on the open set ℝ² × (−∞,T) (values for
t < 0 irrelevant), θ(·,0) = 0, the equation holds pointwise for 0 < t < T, and for every T' < T the
supports of θ(·,t), t ∈ [0,T'], lie in a fixed bounded set. The true solution has this property
(θ is transported by a bounded smooth velocity and the force has compact support), and smooth
solutions in this class are unique (Lipschitz velocity, Riesz transforms bounded on L², energy
estimate for the difference), so exhibiting one such θ is the same as speaking of "the" solution.
The force is C^k for all k on ℝ² × ℝ and vanishes outside a box {|xᵢ| ≤ R, δ ≤ t ≤ R}, δ > 0.
Blow-up: ∇θ is unbounded on ℝ² × [0,T). Because θ is smooth with uniformly bounded support on each
[0,T'], T' < T, ∇θ is bounded there, so this is exactly limsup_{t↑T} ‖∇θ(t)‖_{L^∞} = ∞ (and the
solution genuinely cannot be continued smoothly past T). |∂₁θ| + |∂₂θ| is equivalent to |∇θ|.
Proving `Claim` = constructing a smooth compactly supported force and finite-time gradient blow-up
from rest. Proving `¬Claim` = global regularity of forced inviscid SQG from rest for every such
force (which would imply global regularity for all smooth compactly supported unforced data).
-/
namespace OpenProblems.QEDM141
noncomputable section

open MeasureTheory

/-- Points of ℝ². -/
abbrev R2 : Type := Fin 2 → ℝ

/-- Euclidean length in ℝ². -/
def eucl (v : R2) : ℝ := Real.sqrt (v 0 ^ 2 + v 1 ^ 2)

/-- Spatial partial derivative `∂ᵢθ(x,t)` of a time-dependent scalar field. -/
def pd (θ : R2 → ℝ → ℝ) (i : Fin 2) (x : R2) (t : ℝ) : ℝ :=
  fderiv ℝ (fun y : R2 => θ y t) x (Pi.single i (1 : ℝ))

/-- Time derivative `∂ₜθ(x,t)`. -/
def dt (θ : R2 → ℝ → ℝ) (x : R2) (t : ℝ) : ℝ :=
  deriv (fun s : ℝ => θ x s) t

/-- SQG velocity `u = ∇^⊥(−Δ)^{−1/2}θ = (−∂₂ψ, ∂₁ψ)` with `ψ = θ * (2π|·|)⁻¹`,
written as `∂ⱼψ = (∂ⱼθ) * (2π|·|)⁻¹`. -/
def vel (θ : R2 → ℝ → ℝ) (x : R2) (t : ℝ) : Fin 2 → ℝ := fun i =>
  if i = 0 then
    -((1 / (2 * Real.pi)) * ∫ y : R2, pd θ 1 y t / eucl (x - y))
  else
    (1 / (2 * Real.pi)) * ∫ y : R2, pd θ 0 y t / eucl (x - y)

/-- `(f, θ)` is a smooth solution from rest of forced inviscid SQG on `ℝ² × [0,T)` whose gradient
blows up as `t ↑ T`. -/
def SQGBlowup (f : R2 → ℝ → ℝ) (T : ℝ) (θ : R2 → ℝ → ℝ) : Prop :=
  0 < T ∧
  -- smooth force with compact support in ℝ² × (0, ∞)
  (∀ k : ℕ, ContDiff ℝ k (fun q : R2 × ℝ => f q.1 q.2)) ∧
  (∃ R δ : ℝ, 0 < δ ∧ ∀ (x : R2) (t : ℝ), f x t ≠ 0 →
      (δ ≤ t ∧ t ≤ R ∧ ∀ i : Fin 2, |x i| ≤ R)) ∧
  -- smooth solution up to (but excluding) time T
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R2 × ℝ => θ q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  -- start from rest
  (∀ x : R2, θ x 0 = 0) ∧
  -- uniformly compact spatial support on every [0,T'], T' < T
  (∀ T' : ℝ, T' < T → ∃ R : ℝ, ∀ (x : R2) (t : ℝ), 0 ≤ t → t ≤ T' → θ x t ≠ 0 →
      ∀ i : Fin 2, |x i| ≤ R) ∧
  -- the equation on ℝ² × (0,T)
  (∀ (x : R2) (t : ℝ), 0 < t → t < T →
      dt θ x t + ∑ i : Fin 2, vel θ x t i * pd θ i x t = f x t) ∧
  -- gradient blow-up: ∇θ unbounded on ℝ² × [0,T)
  (∀ M : ℝ, ∃ (x : R2) (t : ℝ), 0 ≤ t ∧ t < T ∧ M < |pd θ 0 x t| + |pd θ 1 x t|)

/-- Some smooth compactly supported force drives inviscid SQG from rest to finite-time blow-up. -/
def Claim : Prop :=
  ∃ (f : R2 → ℝ → ℝ) (T : ℝ) (θ : R2 → ℝ → ℝ), SQGBlowup f T θ

end
end OpenProblems.QEDM141
