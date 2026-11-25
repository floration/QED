import Mathlib
/-! QED-M090: Does an oscillating source lower the Strauss exponent?
For the 3D wave equation with source |u|^p, small smooth data give global solutions exactly when
p > 1+√2 (Strauss). Multiply the source by a factor that oscillates periodically in time with
average zero, such as cos t. The global-existence proof still works above 1+√2. Every blow-up
proof below it breaks, because they all need the source to be positive. Is the true threshold
strictly smaller?
Informal statement: For u_tt − Δu = cos(t)|u|^p on ℝ^{1+3} with data ε(f,h), f,h ∈ C_c^∞(ℝ³;ℝ),
let p_c = inf{p > 1 : ∀ f,h ∃ ε₀ > 0 such that the solution is global for all 0 < ε < ε₀}
(p_c ≤ 1+√2 by the John/Zhou/Glassey argument). Is p_c < 1+√2? (`Claim`: yes, for the model
g = cos t. The general mean-zero periodic g, the exact value of p_c (heuristically 2) and the
lifespan asymptotics are not part of `Claim`; `ClaimGeneral` below is the all-g version.)
Formalization notes:
* Solution class: continuous mild solutions defined by the Kirchhoff–Duhamel formula, the class
  in which John's and Glassey's theorems are proved in 3D:
    u(x,t) = ε·[∂ₜ(t M_f(x,t)) + t M_h(x,t)] + ∫₀ᵗ (t−s) M_{F(s)}(x, t−s) ds,
  F(s)(y) = g(s)|u(y,s)|^p, with M_φ(x,r) = (1/4π)∫_{S²} φ(x + rω) dω the spherical mean
  (written in spherical coordinates θ ∈ [0,π], ϕ ∈ [0,2π] with weight sin θ). The first bracket
  is the free wave with data (εf, εh) (Kirchhoff). u is required continuous on ℝ³ × [0,∞), so
  every integrand is continuous on a compact domain and no Bochner-integral junk value arises.
* For p > 1 the nonlinearity is locally Lipschitz, and the Kirchhoff kernel is positive and
  bounded on backward cones, so continuous mild solutions are unique (Gronwall); hence "the
  solution is global" ⇔ "a continuous mild solution exists on all of [0,∞)". For C² data/
  solutions this class coincides with classical solutions; for 1 < p < 2 (where |u|^p is not C²)
  it is the standard weak notion. John's theorem (p > 1+√2 small-data global existence) and,
  for g ≡ 1, blow-up for p < 1+√2 both hold in this class, so the class is non-degenerate.
* p_c < 1+√2 ⇔ some p ∈ (1, 1+√2) has the small-data global existence property (definition of
  infimum), which is how `Claim` is written; no sInf junk is involved. Note the property is
  required for every pair of real C_c^∞ data (f,h), as in the definition of p_c.
* Proving `Claim` = an oscillating source lowers the critical exponent. Proving `¬Claim` = for
  every p ∈ (1, 1+√2) some data blow up for arbitrarily small ε, i.e. the Strauss exponent is
  robust for g = cos t.
-/
namespace OpenProblems.QEDM090
noncomputable section

/-- Points of ℝ³. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Unit vector with spherical coordinates `(θ, ϕ)`. -/
def sph (θ ϕ : ℝ) : R3 := ![Real.sin θ * Real.cos ϕ, Real.sin θ * Real.sin ϕ, Real.cos θ]

/-- Spherical mean `M_φ(x, r) = (1/4π) ∫_{S²} φ(x + r ω) dω`. -/
def sphereMean (φ : R3 → ℝ) (x : R3) (r : ℝ) : ℝ :=
  (1 / (4 * Real.pi)) *
    ∫ θ in (0 : ℝ)..Real.pi, ∫ ϕ in (0 : ℝ)..(2 * Real.pi), φ (x + r • sph θ ϕ) * Real.sin θ

/-- Kirchhoff solution of the free wave equation with data `(f, h)`. -/
def freeWave (f h : R3 → ℝ) (x : R3) (t : ℝ) : ℝ :=
  deriv (fun τ : ℝ => τ * sphereMean f x τ) t + t * sphereMean h x t

/-- `u` is a global continuous mild solution of `u_tt − Δu = g(t)|u|^p` with data `ε(f,h)`. -/
def IsGlobalMild (g : ℝ → ℝ) (p ε : ℝ) (f h : R3 → ℝ) (u : R3 → ℝ → ℝ) : Prop :=
  ContinuousOn (fun z : R3 × ℝ => u z.1 z.2) (Set.univ ×ˢ Set.Ici (0 : ℝ)) ∧
  ∀ (x : R3) (t : ℝ), 0 ≤ t →
    u x t = ε * freeWave f h x t +
      ∫ s in (0 : ℝ)..t, (t - s) * sphereMean (fun y : R3 => g s * |u y s| ^ p) x (t - s)

/-- Small-data global existence for every pair of smooth compactly supported data. -/
def SmallDataGlobal (g : ℝ → ℝ) (p : ℝ) : Prop :=
  ∀ f h : R3 → ℝ, (∀ k : ℕ, ContDiff ℝ k f) → HasCompactSupport f →
    (∀ k : ℕ, ContDiff ℝ k h) → HasCompactSupport h →
    ∃ ε₀ : ℝ, 0 < ε₀ ∧ ∀ ε : ℝ, 0 < ε → ε < ε₀ → ∃ u : R3 → ℝ → ℝ, IsGlobalMild g p ε f h u

/-- For `g = cos t` the critical exponent is strictly below the Strauss exponent `1 + √2`. -/
def Claim : Prop :=
  ∃ p : ℝ, 1 < p ∧ p < 1 + Real.sqrt 2 ∧ SmallDataGlobal Real.cos p

/-- Admissible oscillating coefficients: smooth, `2π`-periodic, mean zero, not identically 0. -/
def Admissible (g : ℝ → ℝ) : Prop :=
  (∀ k : ℕ, ContDiff ℝ k g) ∧ Function.Periodic g (2 * Real.pi) ∧
    (∫ t in (0 : ℝ)..(2 * Real.pi), g t) = 0 ∧ ∃ t : ℝ, g t ≠ 0

/-- Secondary (not part of `Claim`): the same for every admissible `g`. -/
def ClaimGeneral : Prop :=
  ∀ g : ℝ → ℝ, Admissible g → ∃ p : ℝ, 1 < p ∧ p < 1 + Real.sqrt 2 ∧ SmallDataGlobal g p

end
end OpenProblems.QEDM090
