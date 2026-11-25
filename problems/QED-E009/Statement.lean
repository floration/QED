import Mathlib
/-! QED-E009: Non-flat free-boundary minimal disks in the superball
Informal statement: for $p>2$ let $B_p=\{|x|^p+|y|^p+|z|^p\le1\}$. Decide whether $B_4$ (more generally $B_p$)
contains an embedded minimal disk $\Sigma$ with $\partial\Sigma\subset\partial B_p$, meeting $\partial B_p$
orthogonally, that is not contained in a plane. Specifically, show that there is one invariant under the
rotation by $2\pi/3$ about the axis $\mathbb R(1,1,1)$ and under $v\mapsto -v$.
Background (referee): a ℤ₃-invariant free-boundary disk cannot be planar, since the plane x+y+z=0 meets
∂B_p orthogonally only where xyz=0. Refs: Nitsche (ARMA 1985), Grüter–Jost (1986), Ketover arXiv:1612.08692.
Formalization notes:
* Claim is the "specifically" part for p = 4: B₄ = {x⁴+y⁴+z⁴ ≤ 1}, f(y) = Σ yᵢ⁴, ∇f(y) = (4yᵢ³).
* A free-boundary minimal disk is given by a conformal harmonic immersion u of the closed unit disk
  D̄ ⊂ ℝ² (every embedded minimal disk smooth up to the boundary admits such a parametrisation: isothermal
  coordinates + Riemann mapping + boundary regularity). u : ℝ×ℝ → ℝ³ is required C² on all of ℝ² (any map
  smooth up to ∂D̄ extends); only its behaviour on D̄ matters.
  - conformal immersion on D̄: |u_s|=|u_t| ≠ 0, ⟨u_s,u_t⟩=0;  harmonic (Δu=0) on the open disk;
  - embedded: injective on D̄;  u(open disk) ⊆ int B₄, u(∂D̄) ⊆ ∂B₄;
  - free boundary: at each boundary point x of D̄ the outward conormal du_x(x) is a positive multiple of
    ∇f(u x) (meets ∂B₄ orthogonally).
* Symmetry: the image is invariant under the cyclic coordinate permutation (x,y,z) ↦ (z,x,y), which is the
  rotation by 2π/3 about ℝ(1,1,1), and under v ↦ -v. Non-planarity is stated explicitly though implied.
-/

namespace OpenProblems.QEDE009
noncomputable section

/-- Standard dot product on `ℝ³`. -/
def dot (a b : Fin 3 → ℝ) : ℝ := ∑ i, a i * b i

/-- Defining function of the superball `B₄`. -/
def f4 (y : Fin 3 → ℝ) : ℝ := ∑ i, y i ^ 4

/-- Gradient of `f4`. -/
def gradf4 (y : Fin 3 → ℝ) : Fin 3 → ℝ := fun i => 4 * y i ^ 3

/-- Closed unit disk in `ℝ²`. -/
def Dbar : Set (ℝ × ℝ) := {x | x.1 ^ 2 + x.2 ^ 2 ≤ 1}

/-- Partial derivatives `u_s`, `u_t`. -/
def du1 (u : ℝ × ℝ → Fin 3 → ℝ) (x : ℝ × ℝ) : Fin 3 → ℝ := fderiv ℝ u x (1, 0)
def du2 (u : ℝ × ℝ → Fin 3 → ℝ) (x : ℝ × ℝ) : Fin 3 → ℝ := fderiv ℝ u x (0, 1)

/-- `u` parametrises an embedded free-boundary minimal disk in `B₄`. -/
def IsFBMinimalDisk (u : ℝ × ℝ → Fin 3 → ℝ) : Prop :=
  ContDiff ℝ 2 u ∧
  Set.InjOn u Dbar ∧
  (∀ x ∈ Dbar, du1 u x ≠ 0 ∧ dot (du1 u x) (du1 u x) = dot (du2 u x) (du2 u x) ∧
      dot (du1 u x) (du2 u x) = 0) ∧
  (∀ x : ℝ × ℝ, x.1 ^ 2 + x.2 ^ 2 < 1 →
      fderiv ℝ (du1 u) x (1, 0) + fderiv ℝ (du2 u) x (0, 1) = 0) ∧
  (∀ x : ℝ × ℝ, x.1 ^ 2 + x.2 ^ 2 < 1 → f4 (u x) < 1) ∧
  (∀ x : ℝ × ℝ, x.1 ^ 2 + x.2 ^ 2 = 1 →
      f4 (u x) = 1 ∧ ∃ c : ℝ, 0 < c ∧ fderiv ℝ u x x = c • gradf4 (u x))

/-- Rotation by `2π/3` about `ℝ(1,1,1)`: cyclic permutation of coordinates. -/
def rot (v : Fin 3 → ℝ) : Fin 3 → ℝ := ![v 2, v 0, v 1]

def Claim : Prop :=
  ∃ u : ℝ × ℝ → Fin 3 → ℝ, IsFBMinimalDisk u ∧
    rot '' (u '' Dbar) = u '' Dbar ∧
    (fun v => -v) '' (u '' Dbar) = u '' Dbar ∧
    ¬ ∃ a : Fin 3 → ℝ, a ≠ 0 ∧ ∃ c : ℝ, ∀ x ∈ Dbar, dot a (u x) = c

end
end OpenProblems.QEDE009
