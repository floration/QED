import Mathlib
/-! QED-E017: Unforced blow-up near the forced one
The 2026 forced Navier–Stokes blow-up uses a force that is smooth through the blow-up time. Can
the force be made to vanish identically at the blow-up instant while staying smooth up to and
including that instant?

Informal statement: Do there exist T > 0 and f ∈ C_c^∞(ℝ³ × (0,∞)) with f(·,T) ≡ 0 such that the
3D Navier–Stokes solution on ℝ³ with u₀ = 0 and force f satisfies limsup_{t↑T} ‖u(t)‖_{L^∞} = ∞?
(Requiring f ≡ 0 on [T-δ, T] instead would be equivalent to unforced blow-up from smooth data,
the Millennium problem.)

Formalization notes:
* Viscosity ν = 1 (scaling: u_λ(x,t) = λu(λx,λ²t) maps C_c^∞ forces to C_c^∞ forces and
  preserves f(·,T) ≡ 0 at the rescaled time).
* f : ℝ × ℝ³ → ℝ³ is C^∞ with compact support contained in {t > 0}, and f(T, ·) ≡ 0.
* A smooth solution on [0,T) is (u, p) jointly C^∞ on [0,T) × ℝ³, solving
  ∂ₜu + (u·∇)u + ∇p = Δu + f for 0 < t < T, div u = 0, u(0) = 0, with u(t), ∇u(t), p(t) ∈ L²
  and u bounded on [0,t'] × ℝ³ for every t' < T. Such a solution coincides with the unique
  (mild/Leray–Hopf) smooth solution; the L² conditions exclude the pressure/Galilean
  non-uniqueness u ↦ u + a(t), p ↦ p - a'(t)·x.
* Blow-up: sup_{[0,T)×ℝ³} |u| = ∞, which given local boundedness is limsup_{t↑T}‖u(t)‖_∞ = ∞.
* f = 0 gives u = 0, so the Claim is not trivial.
-/
namespace OpenProblems.QEDE017
noncomputable section
open MeasureTheory
open scoped ContDiff

abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- Standard basis vector `e_i`. -/
def e (i : Fin 3) : E3 := EuclideanSpace.single i 1

/-- Divergence of a vector field on `ℝ³`. -/
def divg (v : E3 → E3) (x : E3) : ℝ := ∑ i : Fin 3, fderiv ℝ v x (e i) i

/-- Vector Laplacian `Σᵢ ∂ᵢ∂ᵢ v`. -/
def lap (v : E3 → E3) (x : E3) : E3 :=
  ∑ i : Fin 3, fderiv ℝ (fun y => fderiv ℝ v y (e i)) x (e i)

/-- `f ∈ C_c^∞(ℝ³ × (0, ∞))` and `f(·, T) ≡ 0`. -/
def IsAdmissibleForce (T : ℝ) (f : ℝ × E3 → E3) : Prop :=
  ContDiff ℝ ∞ f ∧ HasCompactSupport f ∧ (∀ q ∈ tsupport f, 0 < q.1) ∧ ∀ x, f (T, x) = 0

/-- `(u, p)` is a smooth finite-energy solution of the forced 3D Navier–Stokes equations
(viscosity 1) on `[0, T)` with `u(0) = 0`, bounded on every `[0, t'] × ℝ³`, `t' < T`. -/
def IsSmoothNSSol (f : ℝ × E3 → E3) (T : ℝ) (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ) : Prop :=
  ContDiffOn ℝ ∞ (fun q : ℝ × E3 => u q.1 q.2) (Set.Ico 0 T ×ˢ Set.univ) ∧
  ContDiffOn ℝ ∞ (fun q : ℝ × E3 => p q.1 q.2) (Set.Ico 0 T ×ˢ Set.univ) ∧
  (∀ x, u 0 x = 0) ∧
  (∀ t ∈ Set.Ioo 0 T, ∀ x,
    deriv (fun s => u s x) t + fderiv ℝ (u t) x (u t x) + gradient (p t) x
      = lap (u t) x + f (t, x)) ∧
  (∀ t ∈ Set.Ico 0 T, ∀ x, divg (u t) x = 0) ∧
  (∀ t ∈ Set.Ico 0 T, MemLp (u t) 2 ∧ MemLp (fun x => fderiv ℝ (u t) x) 2 ∧ MemLp (p t) 2) ∧
  (∀ t' < T, ∃ C : ℝ, ∀ t ∈ Set.Icc 0 t', ∀ x, ‖u t x‖ ≤ C)

/-- There is a force `f ∈ C_c^∞(ℝ³ × (0,∞))` vanishing identically at time `T` for which the
Navier–Stokes solution from rest is smooth on `[0, T)` and unbounded as `t ↑ T`. -/
def Claim : Prop :=
  ∃ T : ℝ, 0 < T ∧ ∃ f : ℝ × E3 → E3, IsAdmissibleForce T f ∧
    ∃ (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ), IsSmoothNSSol f T u p ∧
      ∀ C : ℝ, ∃ t ∈ Set.Ico 0 T, ∃ x, C < ‖u t x‖

end
end OpenProblems.QEDE017
