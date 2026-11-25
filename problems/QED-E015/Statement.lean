import Mathlib
/-! QED-E015: Riesz-transform Schrodinger equation
Informal statement (made precise, see math_new): consider i u_t + Δu = u R₁(|u|²) on ℝ × ℝ²,
with (R₁f)^(ξ) = −i (ξ₁/|ξ|) f̂(ξ). Decide whether every Schwartz initial datum u₀ gives a global
(t ∈ ℝ) smooth solution. Background: R₁ is real and antisymmetric, so mass is conserved, there
is no conserved energy, small-mass data are global by Strichartz; the question is large data.
Formalization notes: `Claim` is the global-existence alternative; `¬Claim` means some Schwartz
datum has no global solution (blow-up). Solutions: u : ℝ → 𝓢(ℝ², ℂ) continuous for the Schwartz
topology, u 0 = u₀, and for every x the map t ↦ u t x is differentiable with
u_t = i(Δu − u R₁(|u|²)) pointwise. Continuity in 𝓢 gives locally uniform bounds on all
seminorms, so solutions in this class are unique (energy estimate) and no pathological
non-unique solutions can be used. Δ is Σᵢ D²u(x)(eᵢ,eᵢ). R₁ is defined by Mathlib's Fourier
transform 𝓕 (kernel e^{−2πi⟨x,ξ⟩}) and its inverse; the multiplier is homogeneous of degree 0,
so the 2π convention does not matter, and replacing −i by +i is the reflection x₁ ↦ −x₁, so the
sign convention does not affect the question. At ξ = 0 the multiplier is 0/0 = 0, a null set.
|u|² is Schwartz, so its Fourier transform is integrable and R₁(|u|²) is an honest integral.
-/
namespace OpenProblems.QEDE015
noncomputable section
open FourierTransform
open scoped SchwartzMap

abbrev E2 := EuclideanSpace ℝ (Fin 2)

/-- Standard basis vector. -/
def e (i : Fin 2) : E2 := EuclideanSpace.single i 1

/-- The Laplacian `∂₁² f + ∂₂² f`. -/
def lap (f : E2 → ℂ) (x : E2) : ℂ :=
  ∑ i : Fin 2, iteratedFDeriv ℝ 2 f x ![e i, e i]

/-- The Riesz transform `R₁`, Fourier multiplier `−i ξ₁/|ξ|`. -/
def riesz1 (g : E2 → ℂ) : E2 → ℂ :=
  𝓕⁻ (fun ξ : E2 => (-Complex.I * (((inner ℝ ξ (e 0)) / ‖ξ‖ : ℝ) : ℂ)) * 𝓕 g ξ)

/-- The density `|f|²` as a complex-valued function. -/
def density (f : E2 → ℂ) : E2 → ℂ := fun x => ((‖f x‖ ^ 2 : ℝ) : ℂ)

/-- `u` is a global Schwartz-class solution with initial datum `u₀`. -/
def IsGlobalSolution (u₀ : 𝓢(E2, ℂ)) (u : ℝ → 𝓢(E2, ℂ)) : Prop :=
  Continuous u ∧ u 0 = u₀ ∧
    ∀ (t : ℝ) (x : E2), HasDerivAt (fun s : ℝ => u s x)
      (Complex.I * (lap (⇑(u t)) x - u t x * riesz1 (density (⇑(u t))) x)) t

def Claim : Prop := ∀ u₀ : 𝓢(E2, ℂ), ∃ u : ℝ → 𝓢(E2, ℂ), IsGlobalSolution u₀ u

end
end OpenProblems.QEDE015
