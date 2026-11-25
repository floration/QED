import Mathlib
/-! QED-E004: Closed-form Euler blow-up
Smooth compactly supported starting data for the 3D Euler equations that blow up in finite time
are now known to exist, but the construction is an infinite iterative series. Give such data as an
explicit formula.

Informal statement: Find P ∈ ℚ[x₁,x₂,x₃]³ such that, for u₀ = ∇ × (P(x) e^{-|x|²}), the unforced
3D incompressible Euler solution on ℝ³ with u(0) = u₀ has finite maximal smooth lifespan.

Formalization notes:
* The "explicit class" is fixed to curl(P · Gaussian), P with rational coefficients (the board's
  "or another explicitly specified class" is dropped; a formula in another class does not count).
  u₀ is automatically divergence-free and Schwartz.
* A smooth solution on [0,T) is (u, p) jointly C^∞ on [0,T) × ℝ³ (within-derivatives at t = 0),
  solving ∂ₜu + (u·∇)u + ∇p = 0 for 0 < t < T and div u = 0, with u(0) = u₀, u(t), p(t) ∈ L²,
  energy ∫|u(t)|² ≤ ∫|u₀|², and ∇u bounded on [0,t'] × ℝ³ for each t' < T.
* Finite lifespan is encoded as: such a solution exists with sup_{[0,T)×ℝ³} |∇u| = ∞. By
  weak–strong uniqueness (u is an admissible weak solution, the H^s solution is strong) u agrees
  with the classical H^s solution, and by Beale–Kato–Majda the latter cannot be continued past T.
  Conversely the classical solution with finite lifespan T* yields such (u, p) with T = T*.
* P = 0 gives the zero solution, which does not blow up, so the Claim is not trivial.
-/
namespace OpenProblems.QEDE004
noncomputable section
open MeasureTheory
open scoped ContDiff

abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- Standard basis vector `e_i`. -/
def e (i : Fin 3) : E3 := EuclideanSpace.single i 1

/-- `∂_j ψ_i (x)`. -/
def pd (ψ : E3 → E3) (x : E3) (i j : Fin 3) : ℝ := fderiv ℝ ψ x (e j) i

/-- Curl of a vector field on `ℝ³`. -/
def curl (ψ : E3 → E3) (x : E3) : E3 :=
  WithLp.toLp 2 ![pd ψ x 2 1 - pd ψ x 1 2, pd ψ x 0 2 - pd ψ x 2 0, pd ψ x 1 0 - pd ψ x 0 1]

/-- Divergence of a vector field on `ℝ³`. -/
def divg (v : E3 → E3) (x : E3) : ℝ := ∑ i : Fin 3, fderiv ℝ v x (e i) i

/-- The vector potential `P(x) e^{-|x|²}`. -/
def potential (P : Fin 3 → MvPolynomial (Fin 3) ℚ) (x : E3) : E3 :=
  WithLp.toLp 2 (fun i => MvPolynomial.aeval (fun j => x j) (P i) * Real.exp (-‖x‖ ^ 2))

/-- Initial datum `u₀ = ∇ × (P e^{-|x|²})`. -/
def initData (P : Fin 3 → MvPolynomial (Fin 3) ℚ) : E3 → E3 := curl (potential P)

/-- `(u, p)` is a smooth finite-energy solution of the 3D Euler equations on `[0, T)` with
initial datum `u₀`, with gradient bounded on every `[0, t'] × ℝ³`, `t' < T`. -/
def IsSmoothEulerSol (u₀ : E3 → E3) (T : ℝ) (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ) : Prop :=
  ContDiffOn ℝ ∞ (fun q : ℝ × E3 => u q.1 q.2) (Set.Ico 0 T ×ˢ Set.univ) ∧
  ContDiffOn ℝ ∞ (fun q : ℝ × E3 => p q.1 q.2) (Set.Ico 0 T ×ˢ Set.univ) ∧
  (∀ x, u 0 x = u₀ x) ∧
  (∀ t ∈ Set.Ioo 0 T, ∀ x,
    deriv (fun s => u s x) t + fderiv ℝ (u t) x (u t x) + gradient (p t) x = 0) ∧
  (∀ t ∈ Set.Ico 0 T, ∀ x, divg (u t) x = 0) ∧
  (∀ t ∈ Set.Ico 0 T, MemLp (u t) 2 ∧ MemLp (p t) 2 ∧
    ∫ x, ‖u t x‖ ^ 2 ≤ ∫ x, ‖u₀ x‖ ^ 2) ∧
  (∀ t' < T, ∃ C : ℝ, ∀ t ∈ Set.Icc 0 t', ∀ x, ‖fderiv ℝ (u t) x‖ ≤ C)

/-- Some explicit datum `curl(P e^{-|x|²})`, `P ∈ ℚ[x₁,x₂,x₃]³`, has a smooth Euler solution
whose gradient becomes unbounded at a finite time `T`. -/
def Claim : Prop :=
  ∃ P : Fin 3 → MvPolynomial (Fin 3) ℚ, ∃ T : ℝ, 0 < T ∧
    ∃ (u : ℝ → E3 → E3) (p : ℝ → E3 → ℝ), IsSmoothEulerSol (initData P) T u p ∧
      ∀ C : ℝ, ∃ t ∈ Set.Ico 0 T, ∃ x, C < ‖fderiv ℝ (u t) x‖

end
end OpenProblems.QEDE004
