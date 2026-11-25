import Mathlib
/-! QED-E013: Burgers with degenerate critical dissipation
Informal statement: let $a(x)=1-\cos x$ and consider $u_t+uu_x+\Lambda^{1/2}(a\,\Lambda^{1/2}u)=0$ on
$\mathbb T=\mathbb R/2\pi\mathbb Z$, $\Lambda=(-\partial_x^2)^{1/2}$. Decide whether every real $u_0\in C^\infty(\mathbb T)$
yields a global smooth solution.
Formalization notes:
* Functions on 𝕋 are 2π-periodic functions ℝ → ℝ. Λ^s is the Fourier multiplier |k|^s:
  (Λ^s f)(x) = Re Σ_{k∈ℤ} |k|^s f̂(k) e^{ikx}, f̂(k) = (2π)⁻¹∫₀^{2π} f(y)e^{-iky}dy. Only applied to smooth
  periodic functions (u(t,·) and a·Λ^{1/2}u(t,·) are smooth for a smooth solution), whose coefficients decay
  rapidly, so the tsum converges absolutely (no junk value); Re is harmless as the series is real.
  `(0:ℝ) ^ (1/2) = 0`, so the k = 0 mode is killed, as it should be.
* Global smooth solution: u : ℝ → ℝ → ℝ (time, space), C^k on [0,∞)×ℝ for every k (smooth up to t = 0),
  2π-periodic in x, u(0,·) = u₀, and the equation holds pointwise for all t > 0 and x.
* Claim = global regularity for all smooth periodic data; ¬Claim = some smooth datum admits no global smooth
  solution (finite-time blow-up/shock). Uniqueness is not required (classical solutions are unique anyway).
-/

namespace OpenProblems.QEDE013
noncomputable section


/-- Fourier coefficient of a `2π`-periodic function. -/
def fc (f : ℝ → ℝ) (k : ℤ) : ℂ :=
  (1 / (2 * Real.pi) : ℂ) *
    ∫ y in (0 : ℝ)..(2 * Real.pi), (f y : ℂ) * Complex.exp (-((k : ℂ) * (y : ℂ) * Complex.I))

/-- Fractional derivative `Λ^s f` as a Fourier multiplier `|k|^s`. -/
def Lam (s : ℝ) (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  (∑' k : ℤ, ((|(k : ℝ)| ^ s : ℝ) : ℂ) * fc f k * Complex.exp ((k : ℂ) * (x : ℂ) * Complex.I)).re

/-- The degenerate coefficient `a(x) = 1 - cos x`. -/
def a (x : ℝ) : ℝ := 1 - Real.cos x

/-- `u` is a global smooth solution with initial datum `u₀`. -/
def GlobalSmoothSolution (u0 : ℝ → ℝ) (u : ℝ → ℝ → ℝ) : Prop :=
  (∀ k : ℕ, ContDiffOn ℝ k (fun p : ℝ × ℝ => u p.1 p.2) (Set.Ici (0 : ℝ) ×ˢ Set.univ)) ∧
  (∀ t : ℝ, 0 ≤ t → ∀ x : ℝ, u t (x + 2 * Real.pi) = u t x) ∧
  u 0 = u0 ∧
  ∀ t : ℝ, 0 < t → ∀ x : ℝ,
    deriv (fun s => u s x) t + u t x * deriv (u t) x +
      Lam (1 / 2) (fun y => a y * Lam (1 / 2) (u t) y) x = 0

def Claim : Prop :=
  ∀ u0 : ℝ → ℝ, (∀ k : ℕ, ContDiff ℝ k u0) → (∀ x : ℝ, u0 (x + 2 * Real.pi) = u0 x) →
    ∃ u : ℝ → ℝ → ℝ, GlobalSmoothSolution u0 u

end
end OpenProblems.QEDE013
