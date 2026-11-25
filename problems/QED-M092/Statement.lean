import Mathlib
/-! QED-M092: Forced blow-up up to the Lions threshold
With an ordinary Laplacian, a smooth compactly supported push can make a fluid at rest blow up in
finite time (OpenAI, 2026). With dissipation (−Δ)^α for α ≥ 5/4, Lions proved that solutions stay
smooth. Does forced blow-up from rest still happen for every α strictly between 1 and 5/4?
Informal statement: For α ∈ (1,5/4) consider ∂ₜu + (u·∇)u + ∇p = −(−Δ)^α u + f, ∇·u = 0 on ℝ³,
u(·,0) = 0. Determine the set of α ∈ (1,5/4) for which there is f ∈ C_c^∞(ℝ³ × (0,∞); ℝ³) whose
unique smooth solution satisfies limsup_{t↑T} ‖u(t)‖_{L^∞} = ∞ for some T < ∞. `Claim` is the
board's precise target: this set is all of (1,5/4). (Nonemptiness is the weaker milestone
`ClaimSome`.)
Formalization notes:
* Space is `Fin 3 → ℝ`; derivatives are Fréchet derivatives in coordinate directions, so the
  (sup) norm Mathlib puts on `Fin 3 → ℝ` never matters; Euclidean length is written out (`eucl`,
  `sqNorm`). Lebesgue measure is `volume` on `Fin 3 → ℝ`.
* Fractional Laplacian. Write α = 1 + s with s ∈ (0, 1/4). On H^∞ fields (−Δ)^α = (−Δ)^s(−Δ),
  so −(−Δ)^α u = (−Δ)^s(Δu), and for 0 < s < 1/2 the operator (−Δ)^s on bounded C¹ functions
  with bounded gradient is the absolutely convergent singular integral
    (−Δ)^s ψ(x) = C(3,s) ∫ (ψ(x) − ψ(x+y)) / |y|^{3+2s} dy,
    C(3,s) = 4^s Γ(3/2 + s) / (π^{3/2} |Γ(−s)|),
  which equals the Fourier multiplier |ξ|^{2s} (Di Nezza–Palatucci–Valdinoci, Prop. 3.3). We
  require the integrand to be Lebesgue integrable at every (x,t) used, so no Bochner junk value
  can enter the equation; the true solution (u(t) ∈ H^∞) satisfies this.
* Solution class (making "the unique smooth solution blows up at T" precise, cf. QED-M093):
  u, p are restrictions of functions that are C^k for all k on ℝ³ × (−∞,T) (values for t < 0 are
  irrelevant); the equations hold for 0 < t < T; u(·,0) = 0; uniformly bounded energy
  sup_{t<T} ∫|u|² < ∞; for each t < T the pressure is bounded (rules out harmonic, e.g. linear,
  pressures acting as a hidden force); u is bounded on ℝ³ × [0,T'] for every T' < T (rules out
  Tychonoff-type solutions with spatial growth or sup-norm infinite at fixed times, so that
  unboundedness can only come from t ↑ T); and u is unbounded on ℝ³ × [0,T). In this class
  (L^∞_t L²_x ∩ L^∞_t L^∞_x on each [0,T']) smooth solutions are unique by weak–strong uniqueness,
  so such a (u,p) is the unique smooth solution and limsup_{t↑T} ‖u(t)‖_∞ = ∞.
* The force f is C^k for all k on ℝ³ × ℝ and vanishes outside {|xᵢ| ≤ R, δ ≤ t ≤ R}, δ > 0
  (compact support in ℝ³ × (0,∞)).
* Proving `Claim` = forced blow-up from rest for every α ∈ (1,5/4). Proving `¬Claim` = some
  α ∈ (1,5/4) admits no such blow-up (global regularity from rest for all C_c^∞ forces).
-/
namespace OpenProblems.QEDM092
noncomputable section

open MeasureTheory

/-- Points of ℝ³. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Squared Euclidean length. -/
def sqNorm (v : R3) : ℝ := ∑ i : Fin 3, v i ^ 2

/-- Euclidean length. -/
def eucl (v : R3) : ℝ := Real.sqrt (sqNorm v)

/-- Standard basis vector `eᵢ`. -/
def basisVec (i : Fin 3) : R3 := Pi.single i (1 : ℝ)

/-- Spatial partial derivative `∂ᵢ u (x,t)`. -/
def dx (u : R3 → ℝ → R3) (i : Fin 3) (x : R3) (t : ℝ) : R3 :=
  fderiv ℝ (fun y : R3 => u y t) x (basisVec i)

/-- Spatial Laplacian. -/
def lap (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ i : Fin 3, dx (fun y s => dx u i y s) i x t

/-- Time derivative. -/
def dt (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  deriv (fun s : ℝ => u x s) t

/-- Convective term `(u·∇)u`. -/
def convec (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ j : Fin 3, (u x t j) • dx u j x t

/-- Spatial gradient of a scalar field. -/
def grad (p : R3 → ℝ → ℝ) (x : R3) (t : ℝ) : R3 :=
  fun i => fderiv ℝ (fun y : R3 => p y t) x (basisVec i)

/-- Divergence. -/
def divg (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : ℝ :=
  ∑ i : Fin 3, dx u i x t i

/-- Normalising constant `C(3,s) = 4^s Γ(3/2+s) / (π^{3/2} |Γ(−s)|)`. -/
def fracConst (s : ℝ) : ℝ :=
  (4 : ℝ) ^ s * Real.Gamma (3 / 2 + s) / (Real.pi ^ (3 / 2 : ℝ) * |Real.Gamma (-s)|)

/-- Integrand of the singular-integral form of `(−Δ)^s ψ (x)`. -/
def kernelIntegrand (s : ℝ) (ψ : R3 → R3) (x y : R3) : R3 :=
  (eucl y ^ (3 + 2 * s))⁻¹ • (ψ x - ψ (x + y))

/-- `(−Δ)^s ψ (x)` for `0 < s < 1/2`. -/
def fracLap (s : ℝ) (ψ : R3 → R3) (x : R3) : R3 :=
  fracConst s • ∫ y : R3, kernelIntegrand s ψ x y

/-- `(f,u,p,T)`: forced hyperdissipative Navier–Stokes from rest, smooth on `[0,T)`, blowing up
in `L^∞` as `t ↑ T`; dissipation `(−Δ)^α`, written as `−(−Δ)^α u = (−Δ)^{α−1}(Δu)`. -/
def ForcedBlowup (α T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ) : Prop :=
  0 < T ∧
  -- smooth force with compact support in ℝ³ × (0, ∞)
  (∀ k : ℕ, ContDiff ℝ k (fun q : R3 × ℝ => f q.1 q.2)) ∧
  (∃ R δ : ℝ, 0 < δ ∧ ∀ (x : R3) (t : ℝ), f x t ≠ 0 →
      (δ ≤ t ∧ t ≤ R ∧ ∀ i : Fin 3, |x i| ≤ R)) ∧
  -- smoothness of u and p up to (but excluding) time T
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => u q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => p q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  -- the fractional dissipation is given by an absolutely convergent integral
  (∀ (x : R3) (t : ℝ), 0 ≤ t → t < T →
      Integrable (fun y : R3 => kernelIntegrand (α - 1) (fun z : R3 => lap u z t) x y)) ∧
  -- the equations on ℝ³ × (0,T)
  (∀ (x : R3) (t : ℝ), 0 < t → t < T →
      dt u x t + convec u x t + grad p x t
        = fracLap (α - 1) (fun z : R3 => lap u z t) x + f x t) ∧
  (∀ (x : R3) (t : ℝ), 0 < t → t < T → divg u x t = 0) ∧
  -- start from rest
  (∀ x : R3, u x 0 = 0) ∧
  -- uniformly bounded energy
  (∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → t < T →
      Integrable (fun x : R3 => sqNorm (u x t)) ∧ ∫ x : R3, sqNorm (u x t) ≤ C) ∧
  -- bounded pressure at each time
  (∀ t : ℝ, 0 ≤ t → t < T → ∃ C : ℝ, ∀ x : R3, |p x t| ≤ C) ∧
  -- bounded on ℝ³ × [0,T'] for every T' < T
  (∀ T' : ℝ, T' < T → ∃ C : ℝ, ∀ (x : R3) (t : ℝ), 0 ≤ t → t ≤ T' → sqNorm (u x t) ≤ C) ∧
  -- but unbounded on ℝ³ × [0,T)
  (∀ M : ℝ, ∃ (x : R3) (t : ℝ), 0 ≤ t ∧ t < T ∧ M < sqNorm (u x t))

/-- For every `α ∈ (1, 5/4)` some smooth compactly supported force blows the fluid up from rest. -/
def Claim : Prop :=
  ∀ α : ℝ, 1 < α → α < 5 / 4 →
    ∃ (T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ), ForcedBlowup α T f u p

/-- Weaker milestone (not part of `Claim`): the set of such `α` is nonempty. -/
def ClaimSome : Prop :=
  ∃ α : ℝ, 1 < α ∧ α < 5 / 4 ∧
    ∃ (T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ), ForcedBlowup α T f u p

end
end OpenProblems.QEDM092
