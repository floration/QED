import Mathlib
/-! QED-M116: Spectral gap of the spin-2 AKLT model on the square lattice
Put a quantum spin 2 (a 5-dimensional space) at every site of an L x L periodic square grid. For each edge, add the energy of projecting the two neighbouring spins onto their joint spin-4 state. The resulting Hamiltonian has ground energy 0, attained by the AKLT valence-bond state. Show that the first excited level stays a fixed distance above 0 however large L is. This gap was proved for the hexagonal lattice in 2020 and for many decorated square lattices, but not for the plain square lattice.
Informal statement: Let $\mathcal H_L=\bigotimes_{x\in(\mathbb Z/L\mathbb Z)^2}\mathbb C^5$, let $\mathbf S_x$ be the
spin-2 operators at $x$, and for a nearest-neighbour edge $xy$ of the torus let $P^{(4)}_{xy}$ be the orthogonal
projection onto the eigenspace $\{(\mathbf S_x+\mathbf S_y)^2=20\}$ (total spin 4). Let $H_L=\sum_{xy}P^{(4)}_{xy}$,
so $H_L\ge0$ and $\ker H_L\neq\{0\}$. Prove there is $\gamma>0$ with
$\mathrm{spec}(H_L)\subset\{0\}\cup[\gamma,\infty)$ for all $L\ge3$.
Formalization notes:
* Sites: the discrete torus `Fin L × Fin L` with periodic successor `succMod i = (i+1) mod L`.
  Each site `x` contributes the two edges `x — right x` and `x — up x`; for `L ≥ 3` these are
  the `2L²` nearest-neighbour edges of the torus, each counted exactly once, with no loops or
  multi-edges.
* Hilbert space: `ℂ^(Config L)` where `Config L = Site L → Fin 5` is the product basis
  (basis vector `k : Fin 5` at a site is the `S^z` eigenvector with `m = 2 - k`). Operators are
  matrices `Matrix (Config L) (Config L) ℂ`; this is exactly `⊗_x ℂ^5` in the product basis.
* Spin-2 matrices: `Sz = diag(2,1,0,-1,-2)`, `S⁺|m⟩ = √(6 - m(m+1)) |m+1⟩` (entries 2, √6, √6, 2
  on the superdiagonal), `S⁻ = (S⁺)ᵀ`. Two-site `S·S = Sz⊗Sz + ½(S⁺⊗S⁻ + S⁻⊗S⁺)`, and the
  two-site Casimir `C = (S₁+S₂)² = S₁² + S₂² + 2 S₁·S₂ = 12 + 2 S₁·S₂` (since `S² = s(s+1) = 6`).
  `C` is Hermitian with spectrum `{j(j+1) : j = 0..4} = {0,2,6,12,20}`, so the spectral
  projection onto `C = 20` (total spin 4, a 9-dimensional space) is the Lagrange polynomial
  `P4 = C(C-2)(C-6)(C-12)/(20·18·14·8)`, `20·18·14·8 = 40320`. (Checked numerically: `P4² = P4`,
  `tr P4 = 9`.)
* Embedding at an edge `(x,y)`: matrix entry `⟨σ|P_{xy}|τ⟩ = P4[(σx,σy),(τx,τy)]` if `σ` and `τ`
  agree off `{x,y}`, else 0. The off-edge agreement is written decidably as
  `τ = update (update σ x (τ x)) y (τ y)`.
* Gap: `H L` is Hermitian and positive semidefinite, so its spectrum is real and ⊆ [0,∞);
  the spectrum of a finite matrix is its set of eigenvalues, stated here directly via
  `H.mulVec v = μ • v`, `v ≠ 0`. `Claim`: one `γ > 0` works for all `L ≥ 3` — no eigenvalue in
  `(0, γ)` (kernel degeneracy allowed). Each fixed `L` trivially has some positive gap, so `Claim`
  is equivalent to `inf_{L ≥ 3} gap(H_L) > 0`, the uniform spectral gap of the AKLT literature.
  Proving `¬Claim` = the gaps above the ground space tend to 0 along a sequence of `L`
  (gaplessness).
-/
namespace OpenProblems.QEDM116
noncomputable section

/-- Sites of the `L × L` discrete torus. -/
abbrev Site (L : ℕ) : Type := Fin L × Fin L

/-- Product-basis labels: a spin-2 basis state (`k : Fin 5`, `m = 2 - k`) at each site. -/
abbrev Config (L : ℕ) : Type := Site L → Fin 5

/-- Periodic successor `i ↦ (i + 1) mod L`. -/
def succMod {L : ℕ} (i : Fin L) : Fin L :=
  ⟨(i.val + 1) % L, Nat.mod_lt _ (Nat.lt_of_le_of_lt (Nat.zero_le _) i.isLt)⟩

/-- Horizontal neighbour. -/
def right {L : ℕ} (x : Site L) : Site L := (succMod x.1, x.2)

/-- Vertical neighbour. -/
def up {L : ℕ} (x : Site L) : Site L := (x.1, succMod x.2)

/-- Spin-2 `S^z = diag(2,1,0,-1,-2)`. -/
def Sz : Matrix (Fin 5) (Fin 5) ℂ := Matrix.diagonal ![2, 1, 0, -1, -2]

/-- Spin-2 raising operator, `S⁺|m⟩ = √(6 - m(m+1)) |m+1⟩`. -/
def Splus : Matrix (Fin 5) (Fin 5) ℂ :=
  Matrix.of ![![0, 2, 0, 0, 0],
              ![0, 0, (Real.sqrt 6 : ℂ), 0, 0],
              ![0, 0, 0, (Real.sqrt 6 : ℂ), 0],
              ![0, 0, 0, 0, 2],
              ![0, 0, 0, 0, 0]]

/-- Spin-2 lowering operator `S⁻ = (S⁺)ᵀ` (real entries). -/
def Sminus : Matrix (Fin 5) (Fin 5) ℂ := Splus.transpose

/-- Kronecker product of two single-site operators. -/
def kron2 (A B : Matrix (Fin 5) (Fin 5) ℂ) : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ :=
  Matrix.of fun p q => A p.1 q.1 * B p.2 q.2

/-- `S₁·S₂ = Sz⊗Sz + ½ (S⁺⊗S⁻ + S⁻⊗S⁺)`. -/
def SdotS : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ :=
  kron2 Sz Sz + (1 / 2 : ℂ) • (kron2 Splus Sminus + kron2 Sminus Splus)

/-- Two-site Casimir `(S₁ + S₂)² = 12 + 2 S₁·S₂`, spectrum `{0, 2, 6, 12, 20}`. -/
def casimir : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ :=
  (12 : ℂ) • (1 : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ) + (2 : ℂ) • SdotS

/-- Orthogonal projection onto total spin 4 (`casimir = 20`). -/
def P4 : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ :=
  (1 / 40320 : ℂ) •
    (casimir * (casimir - (2 : ℂ) • (1 : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ)) *
      (casimir - (6 : ℂ) • (1 : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ)) *
      (casimir - (12 : ℂ) • (1 : Matrix (Fin 5 × Fin 5) (Fin 5 × Fin 5) ℂ)))

/-- `P4` acting on the sites `x, y` of the torus (identity elsewhere). -/
def edgeOp {L : ℕ} (x y : Site L) : Matrix (Config L) (Config L) ℂ :=
  Matrix.of fun σ τ : Config L =>
    if τ = Function.update (Function.update σ x (τ x)) y (τ y) then
      P4 (σ x, σ y) (τ x, τ y)
    else 0

/-- The spin-2 AKLT Hamiltonian on the `L × L` torus: one `P4` per nearest-neighbour edge. -/
def H (L : ℕ) : Matrix (Config L) (Config L) ℂ :=
  ∑ x : Site L, (edgeOp x (right x) + edgeOp x (up x))

/-- Uniform spectral gap: some `γ > 0` such that, for every `L ≥ 3`, every eigenvalue of `H L`
is `0` or has real part at least `γ` (all eigenvalues are real since `H L` is Hermitian). -/
def Claim : Prop :=
  ∃ γ : ℝ, 0 < γ ∧ ∀ L : ℕ, 3 ≤ L →
    ∀ (μ : ℂ) (v : Config L → ℂ), v ≠ 0 → (H L).mulVec v = μ • v → μ = 0 ∨ γ ≤ μ.re

end
end OpenProblems.QEDM116
