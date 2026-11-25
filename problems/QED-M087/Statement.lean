import Mathlib
/-! QED-M087: Blow-up under a steady force
Can a smooth, compactly supported, time-independent force drive the incompressible Navier–Stokes
fluid on ℝ³, starting at rest, to a finite-time singularity?
Informal statement: Decide whether there is f ∈ C_c^∞(ℝ³;ℝ³), independent of t, such that the solution
of ∂_t u + (u·∇)u + ∇p = Δu + f, ∇·u = 0, u(·,0) = 0 on ℝ³ loses smoothness in finite time.
(Claim: such an f exists.)
Formalization notes: Following the Clay formulation, "loses smoothness in finite time" means there is
no global smooth solution: no pair (u, P) smooth on ℝ³ × [0,∞) (`ContDiffOn ℝ n` on {t ≥ 0} for every
n) with u(x,0) = 0, satisfying the equations pointwise for t > 0, with locally-in-time bounded energy
∫|u(x,t)|² dx (a steady force can make energy grow, so a uniform-in-time bound as in Clay's (A)/(B)
would be wrong here; the lintegral avoids Bochner-integral junk values). Smooth finite-energy
solutions are unique, so this matches blow-up of the unique local smooth solution. Gradient forces
are trivially excluded (u = 0, P = potential).
Proving `Claim` = exhibiting a steady C_c^∞ force with finite-time blow-up. Proving `¬Claim` = global
regularity from rest for every steady C_c^∞ force.
-/
namespace OpenProblems.QEDM087

/-- ℝ³. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Space-time ℝ³ × ℝ. -/
abbrev ST : Type := R3 × ℝ

/-- Spatial partial derivative ∂_j of a scalar field. -/
noncomputable def dx (j : Fin 3) (g : ST → ℝ) (z : ST) : ℝ :=
  fderiv ℝ g z ((Pi.single j (1 : ℝ) : R3), (0 : ℝ))

/-- Time derivative of a scalar field. -/
noncomputable def dtt (g : ST → ℝ) (z : ST) : ℝ := fderiv ℝ g z ((0 : R3), (1 : ℝ))

/-- `(u, P)` is a global smooth locally-finite-energy solution from rest with steady force `f`. -/
def IsGlobalSmoothSolution (f : R3 → R3) (u : ST → R3) (P : ST → ℝ) : Prop :=
  (∀ n : ℕ, ContDiffOn ℝ n u {z : ST | 0 ≤ z.2}) ∧
  (∀ n : ℕ, ContDiffOn ℝ n P {z : ST | 0 ≤ z.2}) ∧
  (∀ x : R3, u (x, 0) = 0) ∧
  (∀ z : ST, 0 < z.2 → ∀ i : Fin 3,
    dtt (fun w => u w i) z + ∑ j : Fin 3, u z j * dx j (fun w => u w i) z + dx i P z =
      ∑ j : Fin 3, dx j (fun w => dx j (fun w' => u w' i) w) z + f z.1 i) ∧
  (∀ z : ST, 0 < z.2 → ∑ j : Fin 3, dx j (fun w => u w j) z = 0) ∧
  (∀ T : ℝ, ∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → t ≤ T →
    ∫⁻ x : R3, ENNReal.ofReal (∑ i : Fin 3, (u (x, t) i) ^ 2) ≤ ENNReal.ofReal C)

def Claim : Prop :=
  ∃ f : R3 → R3, (∀ n : ℕ, ContDiff ℝ n f) ∧ HasCompactSupport f ∧
    ¬ ∃ (u : ST → R3) (P : ST → ℝ), IsGlobalSmoothSolution f u P

end OpenProblems.QEDM087
