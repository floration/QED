import Mathlib
/-! QED-M091: Euler with reversed stretching
Flip the sign of the vortex-stretching term in the 3D Euler vorticity equation on the torus, keeping advection and the
Biot–Savart law. Do smooth solutions stay smooth forever, or can they blow up in finite time?
Informal statement: On 𝕋³ let ω : 𝕋³ × [0,T) → ℝ³ solve ∂ₜω + (u·∇)ω = −Sω, where u = ∇ × (−Δ)⁻¹(ω − ⟨ω⟩),
S = ½(∇u + ∇uᵀ) and ⟨ω⟩ is the spatial mean. Decide whether every ω₀ ∈ C^∞(𝕋³; ℝ³) with ∇·ω₀ = 0 generates a global
smooth solution.
Formalization notes: 𝕋³ = (ℝ/2πℤ)³ is encoded by 2π-periodic functions on ℝ³ = (Fin 3 → ℝ). Spatial partial derivatives
are Fréchet derivatives in coordinate directions (`pd i F x = ∂ᵢF(x)`), the time derivative is `deriv`. The spatial mean is
(2π)⁻³ times the Bochner integral over the cell [0,2π]³. The Biot–Savart velocity is u = curl ψ where ψ is the
mean-zero periodic solution of Δψ = −(ω − ⟨ω⟩) (unique; ψ is required to exist as part of the solution, and its
joint smoothness is automatic for smooth ω, so requiring it loses nothing). We do NOT assume div ω = 0 for t > 0
(the reversed equation does not preserve it), which is why u is defined through ψ rather than by curl u = ω.
(Sω)ᵢ = Σⱼ ½(∂ⱼuᵢ + ∂ᵢuⱼ)ωⱼ. Smoothness is "C^k for every k ∈ ℕ" jointly in (t,x) on ℝ × ℝ³; since any smooth function on
[0,∞) × ℝ³ extends smoothly to t < 0, this is the same as smoothness on [0,∞) × 𝕋³. The equation is imposed for t > 0
(it then holds at t = 0 by continuity). Smooth solutions are unique, so existence of a global smooth solution is
the same as absence of finite-time blow-up. Proving Claim = global regularity for all smooth divergence-free data;
proving ¬Claim = some smooth periodic divergence-free ω₀ with no global smooth solution (finite-time blow-up).
-/
namespace OpenProblems.QEDM091

/-- Partial derivative `∂ᵢ F (x)` of a vector field `F : ℝ³ → ℝ³`. -/
noncomputable def pd (i : Fin 3) (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (x : Fin 3 → ℝ) : Fin 3 → ℝ :=
  fderiv ℝ F x (Pi.single i 1)

/-- Vector Laplacian. -/
noncomputable def lap (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (x : Fin 3 → ℝ) : Fin 3 → ℝ :=
  ∑ i : Fin 3, pd i (pd i F) x

/-- Curl `∇ × F`. -/
noncomputable def curl (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (x : Fin 3 → ℝ) : Fin 3 → ℝ :=
  ![pd 1 F x 2 - pd 2 F x 1, pd 2 F x 0 - pd 0 F x 2, pd 0 F x 1 - pd 1 F x 0]

/-- Divergence `∇ · F`. -/
noncomputable def divg (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (x : Fin 3 → ℝ) : ℝ :=
  ∑ i : Fin 3, pd i F x i

/-- `F` is `2π`-periodic in each coordinate (a field on `𝕋³`). -/
def IsPeriodic (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) : Prop :=
  ∀ (x : Fin 3 → ℝ) (i : Fin 3), F (x + Pi.single i (2 * Real.pi)) = F x

/-- The fundamental cell `[0, 2π]³`. -/
noncomputable def cell : Set (Fin 3 → ℝ) := Set.Icc (0 : Fin 3 → ℝ) (fun _ => 2 * Real.pi)

/-- Spatial mean over the torus. -/
noncomputable def mean (F : (Fin 3 → ℝ) → (Fin 3 → ℝ)) : Fin 3 → ℝ :=
  (1 / (2 * Real.pi) ^ 3) • MeasureTheory.integral (MeasureTheory.volume.restrict cell) F

/-- `(S ω)ᵢ = Σⱼ ½ (∂ⱼ uᵢ + ∂ᵢ uⱼ) ωⱼ` with `S` the symmetric gradient of `u` at `x`. -/
noncomputable def strainApply (u : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (w : Fin 3 → ℝ) (x : Fin 3 → ℝ) : Fin 3 → ℝ :=
  fun i => ∑ j : Fin 3, (1 / 2 : ℝ) * (pd j u x i + pd i u x j) * w j

/-- Joint smoothness in `(t, x)`: `C^k` for every `k`. -/
def IsSmoothTX (f : ℝ → (Fin 3 → ℝ) → (Fin 3 → ℝ)) : Prop :=
  ∀ k : ℕ, ContDiff ℝ k (fun p : ℝ × (Fin 3 → ℝ) => f p.1 p.2)

/-- `(ω, ψ)` is a global smooth solution with initial vorticity `ω₀`; the velocity is `u(t) = curl ψ(t)`. -/
def IsGlobalSolution (ω₀ : (Fin 3 → ℝ) → (Fin 3 → ℝ)) (ω ψ : ℝ → (Fin 3 → ℝ) → (Fin 3 → ℝ)) : Prop :=
  IsSmoothTX ω ∧ IsSmoothTX ψ ∧ ω 0 = ω₀ ∧
  (∀ t : ℝ, 0 ≤ t →
    IsPeriodic (ω t) ∧ IsPeriodic (ψ t) ∧ mean (ψ t) = 0 ∧
    ∀ x : Fin 3 → ℝ, lap (ψ t) x = -(ω t x - mean (ω t))) ∧
  (∀ t : ℝ, 0 < t → ∀ x : Fin 3 → ℝ,
    deriv (fun s : ℝ => ω s x) t + ∑ j : Fin 3, (curl (ψ t) x j) • pd j (ω t) x
      = -(strainApply (curl (ψ t)) (ω t x) x))

def Claim : Prop :=
  ∀ ω₀ : (Fin 3 → ℝ) → (Fin 3 → ℝ),
    (∀ k : ℕ, ContDiff ℝ k ω₀) → IsPeriodic ω₀ → (∀ x, divg ω₀ x = 0) →
      ∃ ω ψ : ℝ → (Fin 3 → ℝ) → (Fin 3 → ℝ), IsGlobalSolution ω₀ ω ψ

end OpenProblems.QEDM091
