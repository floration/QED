import Mathlib
/-! QED-M074: Ten Martini for every periodic planar lattice
A tight-binding electron hops on a doubly periodic planar network in a uniform magnetic field.
Is the spectrum, after discarding isolated (flat-band) eigenvalues, always a Cantor set when the
flux per cell is irrational? Known for the square, triangular, honeycomb and Lieb lattices; the
first open case is kagome.
Informal statement: Let G ⊂ ℝ² be a connected planar graph with straight edges, invariant under a
lattice L ≅ ℤ² with finitely many L-orbits of vertices. For a constant field B let
(H_B ψ)(x) = ∑_{y∼x} e^{i∫_{[x,y]} A} ψ(y) on ℓ²(V(G)), 2πα = B·covol(L). Let Σ' be the derived
set of σ(H_B). Prove or disprove: for every such G and every irrational α, Σ' is a nonempty
Cantor set.
Formalization notes: A graph is a structure `PeriodicPlanarGraph`: nonempty vertex set `V ⊆ ℝ × ℝ`,
symmetric irreflexive adjacency, lattice vectors `a, b` with a₁b₂ − a₂b₁ ≠ 0, invariance of V
and of adjacency under all translations m·a + n·b (m n : ℤ), finitely many orbits, local
finiteness (each vertex has finitely many neighbours; needed for H_B to be bounded and implied
by the other axioms in practice), straight-line planarity (distinct edges' closed segments meet
only in common endpoints; no vertex lies on an edge other than its endpoints) and connectivity
(reflexive-transitive closure of adjacency). The magnetic phase is taken in the symmetric gauge
A = (B/2)(−x₂, x₁), for which ∫_{[x,y]} A = (B/2)(x₁y₂ − x₂y₁); the spectrum is gauge invariant.
The spectrum of the bounded self-adjoint H_B is encoded by the Weyl criterion with finitely
supported test vectors (dense, H_B bounded): E ∈ σ(H_B) iff for every ε > 0 there is a
finitely supported ψ on V with ∑|ψ|² = 1 and ∑ₓ |(H_Bψ)(x) − Eψ(x)|² < ε. (H_Bψ has finite
support, so the `tsum` is a finite sum.) Σ' = {E ∈ σ | E ∈ closure(σ \ {E})}. A Cantor set in ℝ
is a nonempty compact perfect set with empty interior. α = B·|a₁b₂ − a₂b₁|/(2π). Proving
`Claim` = Ten Martini for all such graphs; `¬Claim` = a graph and irrational flux where Σ' is
empty, contains an interval, or has an isolated point.
-/
namespace OpenProblems.QEDM074

/-- A connected, doubly periodic, locally finite planar graph with straight edges in ℝ². -/
structure PeriodicPlanarGraph where
  V : Set (ℝ × ℝ)
  V_nonempty : V.Nonempty
  Adj : ℝ × ℝ → ℝ × ℝ → Prop
  a : ℝ × ℝ
  b : ℝ × ℝ
  indep : a.1 * b.2 - a.2 * b.1 ≠ 0
  adj_symm : ∀ x y, Adj x y → Adj y x
  adj_irrefl : ∀ x, ¬ Adj x x
  adj_mem : ∀ x y, Adj x y → x ∈ V ∧ y ∈ V
  periodic_V : ∀ x ∈ V, ∀ m n : ℤ, x + ((m : ℝ) • a + (n : ℝ) • b) ∈ V
  periodic_adj : ∀ x y, ∀ m n : ℤ, Adj x y →
    Adj (x + ((m : ℝ) • a + (n : ℝ) • b)) (y + ((m : ℝ) • a + (n : ℝ) • b))
  finite_orbits : ∃ F : Finset (ℝ × ℝ), ∀ x ∈ V, ∃ z ∈ F, ∃ m n : ℤ,
    x = z + ((m : ℝ) • a + (n : ℝ) • b)
  locally_finite : ∀ x, Set.Finite {y | Adj x y}
  planar_edges : ∀ x y x' y', Adj x y → Adj x' y' →
    ({x, y} : Set (ℝ × ℝ)) ≠ {x', y'} →
    segment ℝ x y ∩ segment ℝ x' y' ⊆ ({x, y} : Set (ℝ × ℝ)) ∩ {x', y'}
  planar_vertices : ∀ x y z, Adj x y → z ∈ V → z ∈ segment ℝ x y → z = x ∨ z = y
  connected : ∀ x ∈ V, ∀ y ∈ V, Relation.ReflTransGen Adj x y

/-- Magnetic phase `exp(i (B/2)(x₁y₂ − x₂y₁))` for hopping from `y` to `x` (symmetric gauge). -/
noncomputable def phase (B : ℝ) (x y : ℝ × ℝ) : ℂ :=
  Complex.exp (Complex.I * (((B / 2) * (x.1 * y.2 - x.2 * y.1) : ℝ) : ℂ))

/-- Magnetic adjacency operator applied to a finitely supported vector, evaluated at `x`. -/
noncomputable def applyH (G : PeriodicPlanarGraph) (B : ℝ) (ψ : (ℝ × ℝ) →₀ ℂ)
    (x : ℝ × ℝ) : ℂ := by
  classical
  exact ψ.sum (fun y c => if G.Adj x y then phase B x y * c else 0)

/-- Spectrum of `H_B` via the Weyl criterion with finitely supported test vectors. -/
def spectrumH (G : PeriodicPlanarGraph) (B : ℝ) : Set ℝ :=
  {E : ℝ | ∀ ε : ℝ, 0 < ε → ∃ ψ : (ℝ × ℝ) →₀ ℂ,
    (∀ x ∈ ψ.support, x ∈ G.V) ∧
    ψ.sum (fun _ c => ‖c‖ ^ 2) = 1 ∧
    (∑' x : ℝ × ℝ, ‖applyH G B ψ x - (E : ℂ) * ψ x‖ ^ 2) < ε}

/-- Derived set: points of `S` that are accumulation points of `S`. -/
def derived (S : Set ℝ) : Set ℝ := {E : ℝ | E ∈ S ∧ E ∈ closure (S \ {E})}

/-- A Cantor set in ℝ: nonempty, compact, perfect, with empty interior. -/
def IsCantorSet (S : Set ℝ) : Prop :=
  S.Nonempty ∧ IsCompact S ∧ (∀ x ∈ S, x ∈ closure (S \ {x})) ∧ interior S = ∅

/-- Flux per unit cell divided by `2π`. -/
noncomputable def fluxAlpha (G : PeriodicPlanarGraph) (B : ℝ) : ℝ :=
  B * |G.a.1 * G.b.2 - G.a.2 * G.b.1| / (2 * Real.pi)

def Claim : Prop :=
  ∀ (G : PeriodicPlanarGraph) (B : ℝ), Irrational (fluxAlpha G B) →
    IsCantorSet (derived (spectrumH G B))

end OpenProblems.QEDM074
