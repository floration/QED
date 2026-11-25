import Mathlib
/-! N-427: Forced Navier–Stokes blow-up at a no-slip wall
In 2026 it was shown that a smooth, compactly supported force can drive the 3D Navier–Stokes
equations, started from rest, to blow up in finite time, but the construction is interior.
Show that blow-up can happen at the wall itself: in the half-space {x₃ > 0} with the no-slip
condition, a smooth finite-energy solution started from rest and driven by a smooth compactly
supported force becomes unbounded in finite time, while staying bounded away from the wall.
Informal statement: Let ℝ³₊ = {x₃ > 0}, ν > 0. Construct f ∈ C_c^∞(closure(ℝ³₊) × (0,∞); ℝ³) and a
solution (u,p) of ∂ₜu − νΔu + (u·∇)u + ∇p = f, ∇·u = 0 in ℝ³₊ × (0,T), u = 0 on {x₃ = 0},
u(·,0) = 0, with u ∈ C^∞(closure(ℝ³₊) × [0,T)), sup_{t<T} ‖u(t)‖_{L²} < ∞ and
limsup_{t↑T} ‖u(t)‖_{L^∞} = ∞, such that u stays bounded on {x₃ > r} × [0,T) for every r > 0
(all singular points lie on the wall).
Formalization notes: Space is `Fin 3 → ℝ`; coordinate `x 2` is the wall-normal x₃. Derivatives
are Fréchet derivatives (`fderiv`, `deriv`), so the norm on `Fin 3 → ℝ` is irrelevant; the
squared Euclidean length is written out as `sqNorm`. Smoothness up to the boundary on
closure(ℝ³₊) × [0,T) is encoded as: u and p are restrictions of functions that are C^k for every
k on the open set ℝ³ × (−∞,T) (equivalent by Seeley/Whitney extension); values with x₃ < 0 or
t < 0 are irrelevant. The force is C^k for all k on ℝ³ × ℝ and vanishes outside a box
{|xᵢ| ≤ R, δ ≤ t ≤ R} with δ > 0 (compact support in closure(ℝ³₊) × (0,∞)). Two side conditions
make "the singular points lie on (a bounded part of) the wall" precise and rule out cheap
solutions: (i) u is bounded on {x₃ ≥ 0, max(|x₁|,|x₂|) > R₀} × [0,T) (no escape to horizontal
infinity), and (ii) for each t < T the pressure p(·,t) is bounded on the closed half-space (this
excludes harmonic, e.g. linear, pressures acting as a hidden non-decaying force). Together with
boundedness on {x₃ > r} and smoothness on [0,T), unboundedness can only come from points of a
compact piece of the wall as t ↑ T. The energy condition requires x ↦ |u(x,t)|² integrable on
ℝ³₊ with uniformly bounded integral. Proving `Claim` = constructing such a blow-up for every
ν > 0; proving `¬Claim` = showing that for some ν > 0 no such boundary blow-up exists.
-/
namespace OpenProblems.N427

open MeasureTheory

/-- Points of ℝ³; the coordinate `x 2` is the wall-normal coordinate x₃. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Squared Euclidean length of a vector in ℝ³. -/
def sqNorm (v : R3) : ℝ := ∑ i : Fin 3, v i ^ 2

/-- Standard basis vector `eᵢ`. -/
def basisVec (i : Fin 3) : R3 := Pi.single i (1 : ℝ)

/-- Spatial partial derivative `∂ᵢ u (x,t)` of a time-dependent vector field. -/
noncomputable def dx (u : R3 → ℝ → R3) (i : Fin 3) (x : R3) (t : ℝ) : R3 :=
  fderiv ℝ (fun y : R3 => u y t) x (basisVec i)

/-- Spatial Laplacian `Δu (x,t) = ∑ᵢ ∂ᵢ∂ᵢ u`. -/
noncomputable def lap (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ i : Fin 3, dx (fun y s => dx u i y s) i x t

/-- Time derivative `∂ₜ u (x,t)`. -/
noncomputable def dt (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  deriv (fun s : ℝ => u x s) t

/-- Convective term `(u·∇)u (x,t) = ∑ⱼ uⱼ ∂ⱼ u`. -/
noncomputable def convec (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : R3 :=
  ∑ j : Fin 3, (u x t j) • dx u j x t

/-- Spatial gradient of a scalar field. -/
noncomputable def grad (p : R3 → ℝ → ℝ) (x : R3) (t : ℝ) : R3 :=
  fun i => fderiv ℝ (fun y : R3 => p y t) x (basisVec i)

/-- Divergence `∇·u (x,t)`. -/
noncomputable def divg (u : R3 → ℝ → R3) (x : R3) (t : ℝ) : ℝ :=
  ∑ i : Fin 3, dx u i x t i

/-- The open half-space `{x₃ > 0}`. -/
def halfSpace : Set R3 := {x : R3 | 0 < x 2}

/-- `(f,u,p,T)` is a boundary blow-up solution of forced Navier–Stokes with viscosity `ν`
in the half-space with no-slip condition, as described in the header. -/
def BoundaryBlowup (ν T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ) : Prop :=
  0 < T ∧
  -- smooth force with compact support in closure(ℝ³₊) × (0, ∞)
  (∀ k : ℕ, ContDiff ℝ k (fun q : R3 × ℝ => f q.1 q.2)) ∧
  (∃ R δ : ℝ, 0 < δ ∧ ∀ (x : R3) (t : ℝ), f x t ≠ 0 →
      (δ ≤ t ∧ t ≤ R ∧ ∀ i : Fin 3, |x i| ≤ R)) ∧
  -- smoothness of u and p up to the wall and up to (but excluding) time T
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => u q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  (∀ k : ℕ, ContDiffOn ℝ k (fun q : R3 × ℝ => p q.1 q.2) (Set.univ ×ˢ Set.Iio T)) ∧
  -- the equations in ℝ³₊ × (0,T)
  (∀ (x : R3) (t : ℝ), 0 < x 2 → 0 < t → t < T →
      dt u x t - ν • lap u x t + convec u x t + grad p x t = f x t) ∧
  (∀ (x : R3) (t : ℝ), 0 < x 2 → 0 < t → t < T → divg u x t = 0) ∧
  -- no-slip and initial condition
  (∀ (x : R3) (t : ℝ), x 2 = 0 → 0 ≤ t → t < T → u x t = 0) ∧
  (∀ x : R3, 0 ≤ x 2 → u x 0 = 0) ∧
  -- finite energy, uniformly in time
  (∃ C : ℝ, ∀ t : ℝ, 0 ≤ t → t < T →
      IntegrableOn (fun x : R3 => sqNorm (u x t)) halfSpace ∧
      ∫ x in halfSpace, sqNorm (u x t) ≤ C) ∧
  -- pressure bounded at each time (excludes harmonic pressures)
  (∀ t : ℝ, 0 ≤ t → t < T → ∃ C : ℝ, ∀ x : R3, 0 ≤ x 2 → |p x t| ≤ C) ∧
  -- blow-up: u is unbounded on closure(ℝ³₊) × [0,T)
  (∀ M : ℝ, ∃ (x : R3) (t : ℝ), 0 ≤ x 2 ∧ 0 ≤ t ∧ t < T ∧ M < sqNorm (u x t)) ∧
  -- bounded away from the wall
  (∀ r : ℝ, 0 < r → ∃ C : ℝ, ∀ (x : R3) (t : ℝ), r < x 2 → 0 ≤ t → t < T →
      sqNorm (u x t) ≤ C) ∧
  -- bounded far out along the wall (singularities in a compact part of the wall)
  (∃ R₀ C : ℝ, ∀ (x : R3) (t : ℝ), 0 ≤ x 2 → 0 ≤ t → t < T →
      (R₀ < |x 0| ∨ R₀ < |x 1|) → sqNorm (u x t) ≤ C)

/-- For every viscosity there is a forced boundary blow-up at a no-slip wall. -/
def Claim : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∃ (T : ℝ) (f u : R3 → ℝ → R3) (p : R3 → ℝ → ℝ), BoundaryBlowup ν T f u p

end OpenProblems.N427
