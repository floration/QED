import Mathlib
/-! QED-M095: KdV with a cosine coefficient
Put a cos x in front of the cubic term of the modified KdV equation on the circle. The energy
and the mean are still conserved, but the L² norm is not, and the energy is indefinite. Can
smooth solutions blow up in finite time?
Informal statement: Consider u_t + u_xxx + (cos(x) u³)_x = 0 on 𝕋 = ℝ/2πℤ with real
u₀ ∈ C^∞(𝕋). It is Hamiltonian with H = ∫(½u_x² − ¼cos(x)u⁴), conserves ∫u and H, and
d/dt ∫u² = ½∫ sin(x) u⁴. Decide whether every such u₀ yields a global smooth solution, or
whether ‖u(t)‖_{H¹} → ∞ in finite time for some u₀.
Formalization notes:
* Functions on 𝕋 are 2π-periodic functions on ℝ. A global smooth solution is
  u : ℝ × ℝ → ℝ (time, space), C^n for every n ∈ ℕ (i.e. C^∞; written this way to avoid
  `⊤` meaning analytic), 2π-periodic in x, with u(0,x) = u₀(x) and the equation holding
  pointwise for all t ≥ 0. Requiring u to be smooth on all of ℝ × ℝ (with the equation only
  for t ≥ 0) loses nothing: a C^∞ function on [0,∞) × 𝕋 extends smoothly to t < 0.
* Derivatives are partial derivatives via `deriv` of sections; `iteratedDeriv 3` for u_xxx.
* Proving `Claim`: every smooth periodic u₀ has a global smooth solution (global regularity).
  Proving `¬Claim`: some smooth u₀ has no global smooth solution; by standard local
  well-posedness in H^s (s large) with the blow-up alternative and persistence of regularity,
  this is equivalent to finite-time blow-up of ‖u(t)‖_{H¹} (the H¹ norm controls all higher
  norms for this equation), matching the dichotomy in the informal statement.
-/
namespace OpenProblems.QEDM095

/-- `u` is a global (forward in time) smooth 2π-periodic solution of
`u_t + u_xxx + (cos x · u³)_x = 0` with initial data `u₀`. -/
def IsGlobalSmoothSolution (u₀ : ℝ → ℝ) (u : ℝ × ℝ → ℝ) : Prop :=
  (∀ n : ℕ, ContDiff ℝ n u) ∧
  (∀ t x : ℝ, u (t, x + 2 * Real.pi) = u (t, x)) ∧
  (∀ x : ℝ, u (0, x) = u₀ x) ∧
  ∀ t : ℝ, 0 ≤ t → ∀ x : ℝ,
    deriv (fun s : ℝ => u (s, x)) t
      + iteratedDeriv 3 (fun y : ℝ => u (t, y)) x
      + deriv (fun y : ℝ => Real.cos y * (u (t, y)) ^ 3) x = 0

def Claim : Prop :=
  ∀ u₀ : ℝ → ℝ, (∀ n : ℕ, ContDiff ℝ n u₀) → Function.Periodic u₀ (2 * Real.pi) →
    ∃ u : ℝ × ℝ → ℝ, IsGlobalSmoothSolution u₀ u

end OpenProblems.QEDM095
