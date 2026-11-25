import Mathlib
/-! QED-E007: Frozen vortices for Kuramoto on a cube
Informal statement: Let Q_n be the vertex–edge graph of the n×n subdivided surface of the
cube, and θ̇_i = Σ_{j∼i} sin(θ_j − θ_i). For every odd n ≥ 3 there is an equilibrium θ* with
the cube's 4-fold rotational symmetry about the vertical axis and winding number ±1 around
the central plaquettes of the top and bottom faces, whose Jacobian (the Laplacian with edge
weights cos(θ*_j − θ*_i)) has kernel exactly span(1) and is otherwise positive (i.e. −Jacobian
is positive semidefinite with kernel span(1): linear stability modulo the global phase).
Formalization notes: vertices of Q_n are the grid points (x,y,z) ∈ {0,…,n}³ with some
coordinate in {0,n}; θ is a function on all of {0,…,n}³ but every condition only involves
surface points. Two surface points are adjacent iff their ℓ¹ distance is 1 (such a segment
always lies in a face). The vertical 4-fold rotation is rot(x,y,z) = (n−y, x, z); the symmetry
of a vortex state is equivariance up to a phase shift ±π/2 (mod 2π). The winding around a
plaquette v₀→v₁→v₂→v₃→v₀ (vₖ = rotᵏ v₀, v₀ = (m,m,·), m = (n−1)/2) is (1/2π)Σ wrap(θ_{v_{k+1}}−θ_{v_k})
with wrap into (−π, π]. Stability: Σ_{i∼j} cos(θ_j−θ_i)(x_j−x_i)² > 0 for every x that is
non-constant on the surface; this is equivalent to "kernel = span(1), otherwise positive".
Pitfall (referee): symmetry forces the four central-plaquette differences to be π/2, so those
weights are 0; the claim still makes sense since the remaining edges may connect the graph.
-/
namespace OpenProblems.QEDE007
noncomputable section

/-- Grid points of the cube `[0,n]³`. -/
abbrev Pt (n : ℕ) := Fin (n + 1) × Fin (n + 1) × Fin (n + 1)

/-- The point lies on the surface of the cube. -/
def OnSurface {n : ℕ} (p : Pt n) : Prop :=
  p.1 = 0 ∨ p.1 = Fin.last n ∨ p.2.1 = 0 ∨ p.2.1 = Fin.last n ∨
    p.2.2 = 0 ∨ p.2.2 = Fin.last n

/-- Adjacency in `Q_n`: two surface points at ℓ¹-distance 1. -/
def Adj {n : ℕ} (p q : Pt n) : Prop :=
  OnSurface p ∧ OnSurface q ∧
    |((p.1 : ℕ) : ℤ) - ((q.1 : ℕ) : ℤ)| + |((p.2.1 : ℕ) : ℤ) - ((q.2.1 : ℕ) : ℤ)| +
      |((p.2.2 : ℕ) : ℤ) - ((q.2.2 : ℕ) : ℤ)| = 1

/-- Rotation by 90° about the vertical axis: `(x, y, z) ↦ (n − y, x, z)`. -/
def rot {n : ℕ} (p : Pt n) : Pt n := (Fin.rev p.2.1, p.1, p.2.2)

open Classical in
/-- `θ` is an equilibrium of `θ̇_i = Σ_{j∼i} sin(θ_j − θ_i)` on `Q_n`. -/
def IsEquilibrium {n : ℕ} (θ : Pt n → ℝ) : Prop :=
  ∀ i : Pt n, OnSurface i → ∑ j : Pt n, (if Adj i j then Real.sin (θ j - θ i) else 0) = 0

open Classical in
/-- The weighted Laplacian with weights `cos(θ_j − θ_i)` is positive on every vector that is
not constant on the surface (kernel exactly `span 1`, otherwise positive). -/
def IsLinearlyStable {n : ℕ} (θ : Pt n → ℝ) : Prop :=
  ∀ x : Pt n → ℝ, (∃ i j : Pt n, OnSurface i ∧ OnSurface j ∧ x i ≠ x j) →
    0 < ∑ i : Pt n, ∑ j : Pt n,
      (if Adj i j then Real.cos (θ j - θ i) * (x j - x i) ^ 2 else 0)

/-- Equivariance under the vertical 4-fold rotation, up to a phase shift `σ·π/2`, `σ = ±1`. -/
def IsRotSymmetric {n : ℕ} (θ : Pt n → ℝ) : Prop :=
  ∃ σ : ℤ, (σ = 1 ∨ σ = -1) ∧ ∀ p : Pt n, OnSurface p →
    ∃ k : ℤ, θ (rot p) = θ p + σ * (Real.pi / 2) + 2 * Real.pi * k

/-- Phase difference reduced to `(−π, π]`. -/
def wrap (x : ℝ) : ℝ := toIocMod Real.two_pi_pos (-Real.pi) x

/-- `2π ×` the winding number of `θ` around the 4-cycle `v 0 → v 1 → v 2 → v 3 → v 0`. -/
def windingSum {n : ℕ} (θ : Pt n → ℝ) (v : Fin 4 → Pt n) : ℝ :=
  ∑ k : Fin 4, wrap (θ (v (k + 1)) - θ (v k))

/-- Central plaquette of the face `z = h`, listed counterclockwise. -/
def plaquette (n : ℕ) (h : Fin (n + 1)) : Fin 4 → Pt n :=
  fun k => rot^[k.val] ((((n - 1) / 2 : ℕ) : Fin (n + 1)), (((n - 1) / 2 : ℕ) : Fin (n + 1)), h)

def Claim : Prop :=
  ∀ n : ℕ, Odd n → 3 ≤ n →
    ∃ θ : Pt n → ℝ, IsEquilibrium θ ∧ IsRotSymmetric θ ∧
      (windingSum θ (plaquette n (Fin.last n)) = 2 * Real.pi ∨
        windingSum θ (plaquette n (Fin.last n)) = -(2 * Real.pi)) ∧
      (windingSum θ (plaquette n 0) = 2 * Real.pi ∨
        windingSum θ (plaquette n 0) = -(2 * Real.pi)) ∧
      IsLinearlyStable θ

end
end OpenProblems.QEDE007
