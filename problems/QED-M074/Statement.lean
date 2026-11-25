import Mathlib
/-! QED-M074: Ten Martini for the kagome lattice
A tight-binding electron hops on the kagome lattice in a uniform magnetic field. Is the spectrum,
after discarding isolated (flat-band) eigenvalues, a Cantor set whenever the flux per unit cell is
irrational? Known for the square, honeycomb and Lieb lattices (each by a reduction to a
one-dimensional quasi-periodic operator); kagome in a uniform field is the first open instance.
Informal statement: Let G be the kagome lattice with unit edge length: vertices
L + {(0,0), (1,0), (1/2, √3/2)} with L = ℤ(2,0) + ℤ(1,√3), edges = pairs of vertices at distance 1.
For a constant field B with vector potential A, (H_B ψ)(x) = ∑_{y∼x} e^{i∫_{[x,y]} A} ψ(y) on
ℓ²(V(G)), and 2πα = B·covol(L) = 2√3·B. Let Σ' be the derived set of σ(H_B). Prove or disprove:
for every irrational α, Σ' is a Cantor set (nonempty, compact, perfect, nowhere dense).
Formalization notes: The general "every periodic planar graph" version is FALSE for elementary
reasons (Aharonov–Bohm caging): replace each vertical edge of the square lattice by a rhombus of
area w through two degree-2 vertices and take B = π/w with α = 1/(2w) irrational; the two paths
through each rhombus cancel, the operator decouples into 1D chains, and σ(H_B) contains intervals.
Hence only the kagome case is formalized. Unit-distance pairs of kagome vertices are exactly the
kagome edges. The magnetic phase is taken in the symmetric gauge A = (B/2)(−x₂, x₁), for which
∫_{[x,y]} A = (B/2)(x₁y₂ − x₂y₁); the spectrum is gauge invariant. The spectrum of the bounded
self-adjoint H_B is encoded by the Weyl criterion with finitely supported test vectors (dense, H_B
bounded): E ∈ σ(H_B) iff for every ε > 0 there is a finitely supported ψ on V with ∑|ψ|² = 1 and
∑ₓ |(H_Bψ)(x) − Eψ(x)|² < ε (a finite sum, since every vertex has 4 neighbours).
Σ' = {E ∈ σ | E ∈ closure(σ \ {E})}. Proving `Claim` = Ten Martini for kagome; `¬Claim` = an
irrational flux for which Σ' is empty, contains an interval, or has an isolated point.
-/
namespace OpenProblems.QEDM074

noncomputable section

/-- Lattice vectors of the kagome lattice (unit edge length). -/
def va : ℝ × ℝ := (2, 0)
def vb : ℝ × ℝ := (1, Real.sqrt 3)

/-- The three sublattice offsets. -/
def offsets : Set (ℝ × ℝ) := {(0, 0), (1, 0), (1 / 2, Real.sqrt 3 / 2)}

/-- Vertices of the kagome lattice. -/
def V : Set (ℝ × ℝ) :=
  {p | ∃ s ∈ offsets, ∃ m n : ℤ, p = s + ((m : ℝ) • va + (n : ℝ) • vb)}

/-- Kagome adjacency: vertices at Euclidean distance 1. -/
def Adj (x y : ℝ × ℝ) : Prop :=
  x ∈ V ∧ y ∈ V ∧ (x.1 - y.1) ^ 2 + (x.2 - y.2) ^ 2 = 1

/-- Magnetic phase `exp(i (B/2)(x₁y₂ − x₂y₁))` for hopping from `y` to `x` (symmetric gauge). -/
def phase (B : ℝ) (x y : ℝ × ℝ) : ℂ :=
  Complex.exp (Complex.I * (((B / 2) * (x.1 * y.2 - x.2 * y.1) : ℝ) : ℂ))

/-- Magnetic adjacency operator applied to a finitely supported vector, evaluated at `x`. -/
def applyH (B : ℝ) (ψ : (ℝ × ℝ) →₀ ℂ) (x : ℝ × ℝ) : ℂ := by
  classical
  exact ψ.sum (fun y c => if Adj x y then phase B x y * c else 0)

/-- Spectrum of `H_B` via the Weyl criterion with finitely supported test vectors. -/
def spectrumH (B : ℝ) : Set ℝ :=
  {E : ℝ | ∀ ε : ℝ, 0 < ε → ∃ ψ : (ℝ × ℝ) →₀ ℂ,
    (∀ x ∈ ψ.support, x ∈ V) ∧
    ψ.sum (fun _ c => ‖c‖ ^ 2) = 1 ∧
    (∑' x : ℝ × ℝ, ‖applyH B ψ x - (E : ℂ) * ψ x‖ ^ 2) < ε}

/-- Derived set: points of `S` that are accumulation points of `S`. -/
def derived (S : Set ℝ) : Set ℝ := {E : ℝ | E ∈ S ∧ E ∈ closure (S \ {E})}

/-- A Cantor set in ℝ: nonempty, compact, perfect, with empty interior. -/
def IsCantorSet (S : Set ℝ) : Prop :=
  S.Nonempty ∧ IsCompact S ∧ (∀ x ∈ S, x ∈ closure (S \ {x})) ∧ interior S = ∅

/-- Flux per unit cell divided by `2π`; the cell area is `|2·√3 − 0·1| = 2√3`. -/
def fluxAlpha (B : ℝ) : ℝ := B * (2 * Real.sqrt 3) / (2 * Real.pi)

end

def Claim : Prop :=
  ∀ B : ℝ, Irrational (fluxAlpha B) → IsCantorSet (derived (spectrumH B))

end OpenProblems.QEDM074
