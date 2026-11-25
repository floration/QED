import Mathlib
/-! QED-M137: Navier–Stokes blow-up with the force kept away from the singularity
In 2026 OpenAI built a smooth, compactly supported force that drives the 3D Navier–Stokes
equations, started from rest, to blow up in finite time. In that construction the force acts
right where the singularity forms. Can it be done with a force that never acts anywhere near the
blow-up point, so that the fluid near the singularity obeys the unforced equations the whole time?
Informal statement: Let ν > 0. Decide whether there exist f ∈ C_c^∞(ℝ³ × (0,∞); ℝ³), T > 0 and
x_* ∈ ℝ³ with supp f ∩ (B(x_*,1) × (0,∞)) = ∅ such that the unique smooth solution of
∂ₜu + (u·∇)u + ∇p = νΔu + f, ∇·u = 0, u(·,0) = 0 on ℝ³ × [0,T) satisfies
sup_{t<T} ‖u(t)‖_{L²} < ∞ and limsup_{t↑T} ‖u(t)‖_{L^∞(B(x_*,r))} = ∞ for every r > 0.
(By the scaling u_λ(x,t) = λu(λx,λ²t) the radius 1 can be replaced by any ρ > 0.)
Formalization notes: Space is `Fin 3 → ℝ`; derivatives are Fréchet derivatives (`fderiv`,
`deriv`), so the (sup) norm on `Fin 3 → ℝ` plays no role; Euclidean lengths are written out via
`sqNorm`. The force is C^k for every k on ℝ³ × ℝ and vanishes outside a box
{|xᵢ| ≤ R, δ ≤ t ≤ R} with δ > 0 (compact support in ℝ³ × (0,∞)). "supp f misses B(x_*,1) × (0,∞)"
is encoded as f = 0 on the open ball {|x − x_*| < 1} at all times; since the ball is open this is
equivalent to the closure of {f ≠ 0} not meeting it.
"The unique smooth solution on [0,T)" is encoded as: a pair (u,p), C^k for every k on the open set
ℝ³ × (−∞,T) (values for t < 0 are irrelevant; since f = 0 for t < δ the true solution is 0 there),
satisfying the equations pointwise for 0 < t < T and u(·,0) = 0, in the standard classical
uniqueness class: for every T' < T, u and ∇u are bounded on ℝ³ × [0,T'] and ∫|∇u(t)|² is bounded
on [0,T'], plus finite energy uniformly on [0,T) (the sup_{t<T} ‖u(t)‖_{L²} < ∞ requirement of the
problem), and the pressure is bounded at each time (this excludes harmonic, e.g. linear in x,
pressures acting as a hidden non-decaying force; with it, p is determined up to a function of t by
the velocity and the force, and the energy method gives uniqueness in this class). The local smooth
solution from rest exists and lies in this class up to its maximal time, so exhibiting one such
(u,p) is the same as saying the unique smooth solution behaves as required.
Blow-up at x_*: for every r > 0, u is unbounded on B(x_*,r) × [0,T). As u is continuous on the
compact sets closure(B(x_*,r)) × [0,T'], T' < T, this is exactly limsup_{t↑T}
‖u(t)‖_{L^∞(B(x_*,r))} = ∞. Blow-up elsewhere in addition is not excluded (the problem does not
exclude it).
Viscosity: the claim is stated for every ν > 0. By the scaling v(x,t) = ν⁻¹u(x,t/ν),
q = ν⁻²p, g = ν⁻²f(x,t/ν), which preserves the support condition, the existence for one ν is
equivalent to existence for all ν, so this matches "Let ν > 0".
Proving `Claim` = constructing, for every ν > 0, such a force and a blow-up at a point at distance
≥ 1 from the support of the force. Proving `¬Claim` = showing for some (equivalently every) ν > 0
that no smooth force supported away from a ball can produce a (finite-energy) singularity inside it.
-/
namespace OpenProblems.QEDM137
noncomputable section

open MeasureTheory

/-- Points of ℝ³. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Squared Euclidean length of a vector in ℝ³. -/
def sqNorm (v : R3) : ℝ := ∑ i : Fin 3, v i ^ 2

/-- Standard basis vector `eᵢ`. -/
def basisVec (i : Fin 3) : R3 := Pi.single i (1 : ℝ)

/-- Spatial partial derivative `∂ᵢ u (x,t)` of a time-dependent vector field. -/
def dx (u : R3 → ℝ → R3) (i : Fin 3) (x : R3) (t : ℝ) : R3 :=
  fderiv ℝ (fun y : R3 => u y t) x (basisVec i)

/-- Spatial Laplacian `Δu (x,t) = ∑ᵢ ∂ᵢ∂ᵢ u`. -/
def lap (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ i : Fin 3, dx (fun y s => dx u i y s) i x t

/-- Time derivative `∂ₜ u (x,t)`. -/
def dt (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  deriv (fun s : ℝ => u x s) t

/-- Convective term `(u·∇)u (x,t) = ∑ⱼ uⱼ ∂ⱼ u`. -/
def convec (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ j : Fin 3, (u x t j) • dx u j x t

/-- Spatial gradient of a scalar field. -/
def grad (p : R3 → ℝ → ℝ) (x : R3) (t : ℝ) : R3 :=
  fun i => fderiv ℝ (fun y : R3 => p y t) x (basisVec i)

/-- Divergence `∇·u (x,t)`. -/
def divg (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : ℝ :=
  ∑ i : Fin 3, dx u i x t i

/-- `|∇u(x,t)|² = ∑ᵢ |∂ᵢ u(x,t)|²`. -/
def gradSq (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : ℝ :=
  ∑ i : Fin 3, sqNorm (dx u i x t)

/-- `(f,u,p)` is a smooth finite-energy solution from rest of forced Navier–Stokes with viscosity
`ν` on `ℝ³ × [0,T)`, the force vanishes on the unit ball around `xs` at all times, and `u` blows up
at `xs` as `t ↑ T`. -/
def AwayBlowup (ν T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ) (xs : R3) : Prop :=
  0 < T ∧
  -- smooth force with compact support in ℝ³ × (0, ∞)
  (∀ k : ℕ, ContDiff ℝ k (fun q : R3 × ℝ => f q.1 q.2)) ∧
  (∃ R δ : ℝ, 0 < δ ∧ ∀ (x : R3) (t : ℝ), f x t ≠ 0 →
      (δ ≤ t ∧ t ≤ R ∧ ∀ i : Fin 3, |x i| ≤ R)) ∧
  -- the force never acts in the unit ball around xs
  (∀ (x : R3) (t : ℝ), sqNorm (x - xs) < 1 → f x t = 0) ∧
  -- smoothness of u and p up to (but excluding) time T
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => u q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => p q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  -- the equations on ℝ³ × (0,T)
  (∀ (x : R3) (t : ℝ), 0 < t → t < T →
      dt u x t + convec u x t + grad p x t = ν • lap u x t + f x t) ∧
  (∀ (x : R3) (t : ℝ), 0 < t → t < T → divg u x t = 0) ∧
  -- start from rest
  (∀ x : R3, u x 0 = 0) ∧
  -- finite energy, uniformly on [0,T)
  (∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → t < T →
      Integrable (fun x : R3 => sqNorm (u x t)) ∧ ∫ x : R3, sqNorm (u x t) ≤ C) ∧
  -- classical uniqueness class on every [0,T'], T' < T
  (∀ T' : ℝ, T' < T → ∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → t ≤ T' →
      (∀ x : R3, sqNorm (u x t) ≤ C ∧ gradSq u x t ≤ C) ∧
      Integrable (fun x : R3 => gradSq u x t) ∧ ∫ x : R3, gradSq u x t ≤ C) ∧
  -- pressure bounded at each time (excludes harmonic pressures)
  (∀ t : ℝ, 0 ≤ t → t < T → ∃ C : ℝ, ∀ x : R3, |p x t| ≤ C) ∧
  -- blow-up at xs: u is unbounded on B(xs,r) × [0,T) for every r > 0
  (∀ r : ℝ, 0 < r → ∀ M : ℝ, ∃ (x : R3) (t : ℝ),
      sqNorm (x - xs) < r ^ 2 ∧ 0 ≤ t ∧ t < T ∧ M < sqNorm (u x t))

/-- For every viscosity there is a forced finite-energy blow-up from rest at a point whose unit
neighbourhood the force never touches. -/
def Claim : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∃ (T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ) (xs : R3), AwayBlowup ν T f u p xs

end
end OpenProblems.QEDM137
