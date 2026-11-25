import Mathlib
/-! QED-M099: Ising spin at a cube corner
Glue three quarter-planes of the square grid into the surface of an infinite cube corner (a flat cone
of angle 3π/2) and run the critical Ising model with free boundary conditions. The spin at the corner
should decorrelate from a far spin with exponent 7/24 (apex dimension 1/6 plus bulk dimension 1/8),
as predicted by conformal field theory.
Informal statement: Let Γ be the surface of the octant ℤ_{≥0}^3 (points with at least one zero
coordinate), with nearest-neighbour edges (apex o of degree 3, all other vertices degree 4). Let ⟨·⟩ be
the infinite-volume limit of the nearest-neighbour Ising model at β_c = ½ log(1+√2) with free boundary
conditions on Γ ∩ {‖x‖_∞ ≤ n}. Prove ⟨σ_o σ_x⟩ ≍ |x|^{-7/24} as |x| → ∞.
Formalization notes: `Box n` is the finite vertex set Γ ∩ [0,n]^3; edges join surface points at ℓ¹
distance 1 (all such edges lie in a common face, so this is exactly the glued-quadrant graph).
Spins are `Bool` (true ↦ +1, false ↦ -1). The Hamiltonian sums over ordered adjacent pairs, so the
Boltzmann weight is `exp (β_c/2 · ∑_{(a,c) ordered, adjacent} σ_a σ_c) = exp (β_c ∑_{edges} σσ)`.
`corr n x` is the finite-volume correlation ⟨σ_o σ_x⟩_n (with `σ_x` read as 0 if x is outside the box,
irrelevant since only large n matter). The infinite-volume limit exists (GKS monotonicity) but is not
used: the asymptotic statement "∃ c, C > 0 with c|x|^{-7/24} ≤ lim_n corr n x ≤ C|x|^{-7/24} for |x|
large" is encoded equivalently as "eventually in n" bounds (constants may be halved/doubled).
|x| is the ℓ¹ norm x₁+x₂+x₃ (comparable to any other norm and to graph distance).
Proving `Claim` = the ≍ |x|^{-7/24} two-sided bound. Proving `¬Claim` = for every c, C, R some far
surface point x violates one of the bounds for infinitely many n (so the exponent is not 7/24).
-/
namespace OpenProblems.QEDM099

open Classical

/-- Point of ℕ³ lies on the boundary surface of the octant. -/
def OnSurface (p : ℕ × ℕ × ℕ) : Prop := p.1 = 0 ∨ p.2.1 = 0 ∨ p.2.2 = 0

/-- Vertices of the surface inside the box `[0,n]^3`. -/
abbrev Box (n : ℕ) : Type :=
  {p : Fin (n + 1) × Fin (n + 1) × Fin (n + 1) //
    (p.1 : ℕ) = 0 ∨ (p.2.1 : ℕ) = 0 ∨ (p.2.2 : ℕ) = 0}

/-- Natural-number coordinates of a box vertex. -/
def coords {n : ℕ} (a : Box n) : ℕ × ℕ × ℕ := ((a.1.1 : ℕ), (a.1.2.1 : ℕ), (a.1.2.2 : ℕ))

/-- Nearest-neighbour adjacency (ℓ¹ distance one). -/
def Adj (p r : ℕ × ℕ × ℕ) : Prop :=
  |(p.1 : ℤ) - (r.1 : ℤ)| + |(p.2.1 : ℤ) - (r.2.1 : ℤ)| + |(p.2.2 : ℤ) - (r.2.2 : ℤ)| = 1

/-- Spin value of a Boolean. -/
def spin (b : Bool) : ℝ := if b then 1 else -1

/-- Critical inverse temperature of the square-lattice Ising model. -/
noncomputable def betaC : ℝ := Real.log (1 + Real.sqrt 2) / 2

/-- Sum over ordered adjacent pairs of `σ_a σ_c` (each edge counted twice). -/
noncomputable def energy {n : ℕ} (σ : Box n → Bool) : ℝ :=
  ∑ a : Box n, ∑ c : Box n, if Adj (coords a) (coords c) then spin (σ a) * spin (σ c) else 0

/-- Boltzmann weight at β_c (the factor 1/2 compensates the double counting). -/
noncomputable def weight {n : ℕ} (σ : Box n → Bool) : ℝ := Real.exp (betaC / 2 * energy σ)

/-- Spin at a point of ℕ³ (zero if the point is not a vertex of the box). -/
noncomputable def spinAt {n : ℕ} (σ : Box n → Bool) (x : ℕ × ℕ × ℕ) : ℝ :=
  ∑ a : Box n, if coords a = x then spin (σ a) else 0

/-- Finite-volume free-boundary correlation ⟨σ_o σ_x⟩ on `Box n`. -/
noncomputable def corr (n : ℕ) (x : ℕ × ℕ × ℕ) : ℝ :=
  (∑ σ : Box n → Bool, spinAt σ (0, 0, 0) * spinAt σ x * weight σ) /
    (∑ σ : Box n → Bool, weight σ)

/-- ℓ¹ norm. -/
def norm1 (x : ℕ × ℕ × ℕ) : ℝ := ((x.1 + x.2.1 + x.2.2 : ℕ) : ℝ)

def Claim : Prop :=
  ∃ c C : ℝ, 0 < c ∧ 0 < C ∧ ∃ R : ℕ, 1 ≤ R ∧
    ∀ x : ℕ × ℕ × ℕ, OnSurface x → R ≤ x.1 + x.2.1 + x.2.2 →
      ∀ᶠ n in Filter.atTop,
        c * norm1 x ^ (-(7 : ℝ) / 24) ≤ corr n x ∧ corr n x ≤ C * norm1 x ^ (-(7 : ℝ) / 24)

end OpenProblems.QEDM099
