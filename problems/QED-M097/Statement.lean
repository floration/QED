import Mathlib
/-! QED-M097: Mass-critical scattering on flat cones
Dodson proved that the defocusing cubic Schrödinger equation in the plane scatters for every finite-mass initial state. Prove the same on every flat cone, a plane with a single conical singularity of total angle alpha. For alpha = 2pi/k it follows from Dodson by symmetry, and radial data are also easy. Every other angle, such as the surface of a cube corner (alpha = 3pi/2) or alpha > 2pi, is open.
Informal statement: For α > 0 let C_α = (0,∞) × (ℝ/αℤ) with metric dr² + r²dθ² and Δ the Friedrichs
extension of the Laplacian on C_c^∞(C_α). Prove that for every α > 0 and every u₀ ∈ L²(C_α) the
solution of iu_t + Δu = |u|²u, u(0) = u₀, is global with ‖u‖_{L⁴_{t,x}(ℝ × C_α)} < ∞, hence scatters in L².
(Known: α = 2π/k, and radial data for any α.)
Formalization notes: Polar model. A point of C_α is (r, θ) ∈ (0,∞) × [0,α) (`Rg α`; [0,α) is a
fundamental domain of ℝ/αℤ), with area measure r dr dθ, so L²(C_α) pairings are
`cip α u v = ∫_{Rg α} conj(u) v r`. Spectral resolution of the Friedrichs Laplacian (Cheeger; Ford):
L²(C_α) = ⊕_{m∈ℤ} L²((0,∞), r dr) · e^{2πimθ/α}; on the m-th mode Δ = ∂_r² + r⁻¹∂_r − ν²/r² with
ν = ν_m = 2π|m|/α, and the Friedrichs extension (which selects the regular solution at r = 0; for ν ≥ 1
it is the only self-adjoint extension) is diagonalised by the Hankel transform
H_ν g(ρ) = ∫_0^∞ J_ν(ρr) g(r) r dr (unitary and self-inverse on L²(r dr)), with Δ ↦ −ρ². Hence on the
dense class D₀ of finite mode sums φ = Σ_{m∈F} f_m(r) e^{2πimθ/α} with f_m ∈ C_c^∞((0,∞)) (`testFn`),
e^{isΔ}φ = Σ_m e^{2πimθ/α} ∫_0^∞ J_ν(rρ) e^{−isρ²} H_ν f_m(ρ) ρ dρ (`flow`); here H_ν f_m is rapidly
decreasing (H_ν(L_ν f) = −ρ² H_ν f with L_ν f ∈ C_c^∞(0,∞)) and |J_ν| ≤ 1, so all integrals converge
absolutely. J_ν is defined by its power series (`besselJ`, using `Real.Gamma`). The solution concept is
the standard L²-critical one: u ∈ C(ℝ; L²(C_α)) ∩ L⁴_{t,x}(ℝ × C_α) satisfying the Duhamel formula
u(t) = e^{itΔ}u₀ − i ∫_0^t e^{i(t−τ)Δ}(|u|²u)(τ) dτ (from u_t = iΔu − i|u|²u). Since e^{isΔ} is unitary
with adjoint e^{−isΔ}, Duhamel is imposed weakly by pairing with every φ ∈ D₀:
⟨φ, u(t)⟩ = ⟨e^{−itΔ}φ, u₀⟩ − i ∫_0^t ⟨e^{i(τ−t)Δ}φ, |u|²u(τ)⟩ dτ; D₀ is dense in L², so this determines
u(t), and conversely it is equivalent to the strong Duhamel formula. The space-time integrand is
required to be integrable on [0,t] × C_α (true for genuine solutions by Hölder: e^{isΔ}φ ∈ L⁴_{t,x} by
Strichartz, |u|²u ∈ L^{4/3}_{t,x}) so the pairing is not a junk value. Global finiteness of
∫_ℝ∫ |u|⁴ r dr dθ dt is part of the solution notion; with uniqueness of such solutions (standard, via
Strichartz on cones) this is exactly "global with finite L⁴ norm" (scattering then follows by the usual
argument). `Claim`: for every α > 0 and every u₀ ∈ L²(C_α) such a solution exists. ¬Claim means some
angle α and datum u₀ for which no global finite-L⁴ solution exists (finite-time blow-up of the L⁴
norm or infinite global L⁴ norm). Functions are only used on `Rg α`; values elsewhere are irrelevant.
-/
namespace OpenProblems.QEDM097
noncomputable section

open MeasureTheory Filter Topology

/-- Polar fundamental domain of the cone `C_α`: `r > 0`, `θ ∈ [0, α)`. Points are `(r, θ)`. -/
def Rg (α : ℝ) : Set (ℝ × ℝ) := Set.Ioi (0 : ℝ) ×ˢ Set.Ico (0 : ℝ) α

/-- `L²(C_α)` inner product with the area element `r dr dθ`, conjugate-linear in the first slot. -/
def cip (α : ℝ) (u v : ℝ × ℝ → ℂ) : ℂ :=
  ∫ p in Rg α, (starRingEnd ℂ) (u p) * v p * (p.1 : ℂ)

/-- `∫_{C_α} |u|²` restricted to `Rg α`, as a real number. -/
def cnormSq (α : ℝ) (u : ℝ × ℝ → ℂ) : ℝ := ∫ p in Rg α, ‖u p‖ ^ 2 * p.1

/-- `u ∈ L²(C_α)`. -/
def IsL2 (α : ℝ) (u : ℝ × ℝ → ℂ) : Prop :=
  AEStronglyMeasurable u (volume.restrict (Rg α)) ∧
    Integrable (fun p : ℝ × ℝ => ‖u p‖ ^ 2 * p.1) (volume.restrict (Rg α))

/-- Bessel function of the first kind `J_ν(x)` (`ν ≥ 0`, `x ≥ 0`) by its power series. -/
def besselJ (ν x : ℝ) : ℝ :=
  ∑' k : ℕ, (-1 : ℝ) ^ k / ((k.factorial : ℝ) * Real.Gamma ((k : ℝ) + ν + 1)) *
    (x / 2) ^ (2 * (k : ℝ) + ν)

/-- Bessel order of the angular mode `m`: `ν_m = 2π|m|/α`. -/
def order (α : ℝ) (m : ℤ) : ℝ := 2 * Real.pi * |(m : ℝ)| / α

/-- Angular mode `e^{2πimθ/α}`. -/
def angular (α : ℝ) (m : ℤ) (θ : ℝ) : ℂ :=
  Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (m : ℂ) * (θ : ℂ) / (α : ℂ))

/-- Hankel transform of order `ν`: `H_ν g(ρ) = ∫_0^∞ J_ν(ρ r) g(r) r dr`. -/
def hankel (ν : ℝ) (g : ℝ → ℂ) (ρ : ℝ) : ℂ :=
  ∫ r in Set.Ioi (0 : ℝ), (besselJ ν (ρ * r) : ℂ) * g r * (r : ℂ)

/-- Radial profiles of test functions: `C^∞` with compact support in `(0, ∞)`. -/
def IsProfile (g : ℝ → ℂ) : Prop :=
  (∀ k : ℕ, ContDiff ℝ k g) ∧ ∃ a b : ℝ, 0 < a ∧ a < b ∧ ∀ r : ℝ, (r < a ∨ b < r) → g r = 0

/-- Test function `φ(r, θ) = Σ_{m ∈ F} f_m(r) e^{2πimθ/α}` (the dense class `D₀`). -/
def testFn (α : ℝ) (F : Finset ℤ) (f : ℤ → ℝ → ℂ) (p : ℝ × ℝ) : ℂ :=
  ∑ m ∈ F, f m p.1 * angular α m p.2

/-- `e^{isΔ} φ` for `φ = testFn α F f`, via the Hankel transform on each angular mode. -/
def flow (α : ℝ) (F : Finset ℤ) (f : ℤ → ℝ → ℂ) (s : ℝ) (p : ℝ × ℝ) : ℂ :=
  ∑ m ∈ F, angular α m p.2 *
    ∫ ρ in Set.Ioi (0 : ℝ), (besselJ (order α m) (p.1 * ρ) : ℂ) *
      Complex.exp (-(Complex.I * (s : ℂ) * ((ρ ^ 2 : ℝ) : ℂ))) * hankel (order α m) (f m) ρ * (ρ : ℂ)

/-- The defocusing cubic nonlinearity `|v|² v`. -/
def cubic (v : ℝ × ℝ → ℂ) : ℝ × ℝ → ℂ := fun p => ((‖v p‖ ^ 2 : ℝ) : ℂ) * v p

/-- `u` is a global solution of `i u_t + Δu = |u|²u`, `u(0) = u₀`, in `C(ℝ; L²) ∩ L⁴_{t,x}(ℝ × C_α)`,
satisfying the Duhamel formula weakly against the dense class `D₀`. -/
def GlobalScatteringSol (α : ℝ) (u0 : ℝ × ℝ → ℂ) (u : ℝ → ℝ × ℝ → ℂ) : Prop :=
  (∀ t : ℝ, IsL2 α (u t)) ∧
  (∀ t₀ : ℝ, Tendsto (fun t : ℝ => cnormSq α (u t - u t₀)) (𝓝 t₀) (𝓝 0)) ∧
  Integrable (fun q : ℝ × (ℝ × ℝ) => ‖u q.1 q.2‖ ^ 4 * q.2.1)
    (volume.restrict (Set.univ ×ˢ Rg α)) ∧
  ∀ (F : Finset ℤ) (f : ℤ → ℝ → ℂ), (∀ m : ℤ, IsProfile (f m)) → ∀ t : ℝ,
    IntegrableOn (fun q : ℝ × (ℝ × ℝ) =>
        (starRingEnd ℂ) (flow α F f (q.1 - t) q.2) * cubic (u q.1) q.2 * (q.2.1 : ℂ))
      (Set.uIcc 0 t ×ˢ Rg α) ∧
    cip α (testFn α F f) (u t) =
      cip α (flow α F f (-t)) u0 -
        Complex.I * ∫ τ in (0 : ℝ)..t, cip α (flow α F f (τ - t)) (cubic (u τ))

/-- Global well-posedness with finite `L⁴_{t,x}` norm (hence scattering) for the defocusing
mass-critical NLS on every flat cone, for all `L²` data. -/
def Claim : Prop :=
  ∀ α : ℝ, 0 < α → ∀ u0 : ℝ × ℝ → ℂ, IsL2 α u0 →
    ∃ u : ℝ → ℝ × ℝ → ℂ, GlobalScatteringSol α u0 u

end
end OpenProblems.QEDM097
