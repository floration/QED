import Mathlib
/-! QED-E231: AKLT spectral gap on hat tilings
The AKLT model is a standard quantum spin model built on a graph, with a spin of size (degree)/2 at each vertex. Proofs that it has an energy gap exist for the honeycomb and several other periodic planar lattices, by computer-assisted finite-size criteria. Show the AKLT model on the graph of a hat tiling, which is not periodic, also has a gap that does not depend on which hat tiling or how large a region is taken.
Informal statement: For a hat tiling $\mathcal T$ let $G_{\mathcal T}$ be its planar graph: vertices are points lying in at least three tiles, edges are the boundary arcs between consecutive such points. Put spin $S_v=\deg(v)/2$ at each $v$ and, for finite $\Lambda$, $H_\Lambda=\sum_{uv\in E(\Lambda)}P^{(S_u+S_v)}_{uv}$ (projection onto total spin $S_u+S_v$). Prove there is $\gamma>0$ such that for every hat tiling $\mathcal T$ the infinite-volume AKLT model on $G_{\mathcal T}$ has a unique frustration-free ground state $\omega$, and its GNS Hamiltonian $H_\omega$ has $\ker H_\omega=\mathbb C\Omega_\omega$ and $\operatorname{spec}(H_\omega)\setminus\{0\}\subseteq[\gamma,\infty)$.
Formalization notes:
* Hat tilings. The hat is the 13-sided polykite of Smith–Myers–Kaplan–Goodman-Strauss, given by
  its vertices on the triangular lattice (`hp x y = x + y e^{iπ/3}`, coordinates as in Kaplan's
  `hatviz`; area `8√3` = 8 kites, edge lengths `1, √3` and one of length `2`), as the union of the
  11 closed triangles of a triangulation of the polygon. A hat tiling is a set of isometric copies
  (`ℂ ≃ᵢ ℂ`, so reflections are allowed; the scale is irrelevant) covering `ℂ` with pairwise
  disjoint interiors.
* The graph: `Vert 𝒯` = points in ≥ 3 tiles; `u ~ w` iff for two distinct tiles `A, B`, `u` and `w`
  lie in the same connected component of `A ∩ B` (a maximal common boundary arc; its interior
  points lie in exactly two tiles, so the arc's endpoints are consecutive vertices). Arcs may bend
  at tile corners where only two tiles meet, which is why arcs rather than straight segments are
  used. Parallel arcs between the same two vertices would be merged (simple graph).
* Spins: at `v` the Hilbert space is `ℂ^{deg v + 1}` with the standard spin-`S` matrices
  (`S = deg v / 2`, basis `m = S, S-1, …, -S`, `S^z = diag m`,
  `⟨m+1|S^+|m⟩ = √(S(S+1) - m(m+1))`, `S^- = (S^+)^†`, `S^x = (S^+ + S^-)/2`,
  `S^y = (S^+ - S^-)/(2i)`). On a finite `Λ` the space is `⊗_{v∈Λ} ℂ^{d_v}`, written as matrices
  indexed by configurations `Config Λ`. `P_uv` is the spectral projection of the Casimir
  `C = (S_u + S_v)²` onto its top eigenvalue `J(J+1)`, `J = S_u + S_v`, via the Lagrange product
  over the other eigenvalues `j(j+1)`, `j = J-1, …, |S_u - S_v|` (there are `min(deg u, deg v)` of
  them). `H_Λ` sums `P_uv` over edges with both ends in `Λ` (each edge appears twice in the ordered
  sum, hence the factor 1/2).
* Infinite volume. A state of the quasi-local algebra is the same as a consistent family of
  positive normalised linear functionals on the local matrix algebras (a positive functional on
  the unital local *-algebra is bounded and extends uniquely to the norm closure). `embed`
  realises `A ↦ A ⊗ 1` from `Λ` into `Λ' ⊇ Λ`. Frustration-free ground state: `ω(P_e) = 0` for
  all edges.
* Gap. For a frustration-free state, `ω(B P_e) = 0` for all `B` (Cauchy–Schwarz), so for local
  `A` supported in `Λ` and any finite `Λ'` containing `Λ` and all its neighbours,
  `⟨π(A)Ω, H_ω π(A)Ω⟩ = ω(A^*[H, A]) = ω(A^* H_{Λ'} A)`. Local vectors `π(A)Ω` form a form core
  of `H_ω` (bounded finite-range interactions on a graph of bounded degree; hat tilings have finite
  local complexity), and `π(A - ω(A))Ω` runs over a dense subspace of `Ω^⊥`. Hence `H_ω` has
  simple eigenvalue 0 and gap `≥ γ` iff `ω(A^* H_{Λ'} A) ≥ γ ω(A^* A)` for all local `A` with
  `ω(A) = 0`; this is `GapAtLeast`.
* `Claim` also asserts that hat tilings exist (a theorem of Smith et al.), so it cannot hold
  vacuously because of an error in the tile description. Proving `Claim` = existence of hat
  tilings plus a uniform gap with uniqueness. Proving `¬Claim` = for every `γ > 0` some hat tiling
  has no frustration-free ground state, several, or one with GNS gap `< γ`.
-/
namespace OpenProblems.QEDE231
noncomputable section
open scoped Classical

/-- The point `x + y·e^{iπ/3}` of the triangular lattice. -/
def hp (x y : ℤ) : ℂ := ⟨(x : ℝ) + (y : ℝ) / 2, Real.sqrt 3 / 2 * (y : ℝ)⟩

/-- A triangulation (11 triangles) of the hat polygon with vertices, in lattice coordinates,
(0,0),(-1,-1),(0,-2),(2,-2),(2,-1),(4,-2),(5,-1),(4,0),(3,0),(2,2),(0,3),(0,2),(-1,2). -/
def hatTriangles : List ((ℤ × ℤ) × (ℤ × ℤ) × (ℤ × ℤ)) :=
  [((0, 0), (-1, -1), (0, -2)), ((0, 0), (0, -2), (2, -2)), ((-1, 2), (0, 0), (2, -2)),
   ((-1, 2), (2, -2), (2, -1)), ((-1, 2), (2, -1), (4, -2)), ((4, -2), (5, -1), (4, 0)),
   ((4, -2), (4, 0), (3, 0)), ((-1, 2), (4, -2), (3, 0)), ((3, 0), (2, 2), (0, 3)),
   ((3, 0), (0, 3), (0, 2)), ((3, 0), (0, 2), (-1, 2))]

/-- The closed hat tile (Smith–Myers–Kaplan–Goodman-Strauss), as the union of the closed
triangles of a triangulation of its boundary polygon. -/
def hat : Set ℂ :=
  ⋃ t ∈ hatTriangles,
    convexHull ℝ ({hp t.1.1 t.1.2, hp t.2.1.1 t.2.1.2, hp t.2.2.1 t.2.2.2} : Set ℂ)

/-- `𝒯` is a hat tiling of the plane: every tile is an isometric copy of the hat (reflections
allowed), the tiles cover `ℂ`, and distinct tiles have disjoint interiors. -/
def IsHatTiling (𝒯 : Set (Set ℂ)) : Prop :=
  (∀ A ∈ 𝒯, ∃ g : ℂ ≃ᵢ ℂ, A = g '' hat) ∧
  ⋃₀ 𝒯 = Set.univ ∧
  (∀ A ∈ 𝒯, ∀ B ∈ 𝒯, A ≠ B → interior A ∩ interior B = ∅)

/-- Vertices of the tiling graph: points lying in at least three tiles. -/
def Vert (𝒯 : Set (Set ℂ)) : Set ℂ := {p : ℂ | (3 : ℕ∞) ≤ {A : Set ℂ | A ∈ 𝒯 ∧ p ∈ A}.encard}

/-- `u, w` are joined by an edge of the tiling graph along the common boundary of tiles `A ≠ B`:
both are vertices and lie in the same connected component of `A ∩ B` (a common boundary arc;
interior points of such an arc lie in exactly two tiles, so its endpoints are consecutive
vertices). -/
def ArcOf (𝒯 : Set (Set ℂ)) (A B : Set ℂ) (u w : ℂ) : Prop :=
  u ∈ Vert 𝒯 ∧ w ∈ Vert 𝒯 ∧ u ≠ w ∧ A ≠ B ∧ w ∈ connectedComponentIn (A ∩ B) u

/-- The planar graph `G_𝒯` on the vertex set of the tiling. -/
def tilingGraph (𝒯 : Set (Set ℂ)) : SimpleGraph (Vert 𝒯) :=
  SimpleGraph.fromRel (fun u w : Vert 𝒯 => ∃ A ∈ 𝒯, ∃ B ∈ 𝒯, ArcOf 𝒯 A B u.1 w.1)

/-! ### Spin matrices -/

/-- Spin `S = (D-1)/2` of the `D`-dimensional irreducible representation. -/
def spinS (D : ℕ) : ℝ := ((D : ℝ) - 1) / 2

/-- Magnetic quantum number of basis vector `i`: `m_i = S - i`. -/
def mval (D : ℕ) (i : Fin D) : ℝ := spinS D - (i : ℝ)

def Sz (D : ℕ) : Matrix (Fin D) (Fin D) ℂ := Matrix.diagonal (fun i : Fin D => ((mval D i : ℝ) : ℂ))

def Splus (D : ℕ) : Matrix (Fin D) (Fin D) ℂ := fun i j : Fin D =>
  if (i : ℕ) + 1 = (j : ℕ) then
    ((Real.sqrt (spinS D * (spinS D + 1) - mval D j * (mval D j + 1)) : ℝ) : ℂ)
  else 0

def Sminus (D : ℕ) : Matrix (Fin D) (Fin D) ℂ := (Splus D).conjTranspose

def Sx (D : ℕ) : Matrix (Fin D) (Fin D) ℂ := (1 / 2 : ℂ) • (Splus D + Sminus D)

def Sy (D : ℕ) : Matrix (Fin D) (Fin D) ℂ := (-Complex.I / 2) • (Splus D - Sminus D)

/-! ### The AKLT model on a hat tiling graph -/

section AKLT
variable (𝒯 : Set (Set ℂ))

/-- Degree in `G_𝒯`. -/
def deg (v : Vert 𝒯) : ℕ := ((tilingGraph 𝒯).neighborSet v).ncard

/-- Local dimension `2 S_v + 1 = deg v + 1`. -/
def dim (v : Vert 𝒯) : ℕ := deg 𝒯 v + 1

/-- Product basis of `⊗_{v ∈ Λ} ℂ^{dim v}`. -/
abbrev Config (Λ : Finset (Vert 𝒯)) : Type := (v : Λ) → Fin (dim 𝒯 v.1)

/-- Local observables on `Λ`. -/
abbrev Obs (Λ : Finset (Vert 𝒯)) : Type := Matrix (Config 𝒯 Λ) (Config 𝒯 Λ) ℂ

/-- A one-site operator `M` acting at `u ∈ Λ` (identity elsewhere). -/
def siteOp {Λ : Finset (Vert 𝒯)} (u : Λ) (M : Matrix (Fin (dim 𝒯 u.1)) (Fin (dim 𝒯 u.1)) ℂ) :
    Obs 𝒯 Λ :=
  fun σ τ => if ∀ w : Λ, w ≠ u → σ w = τ w then M (σ u) (τ u) else 0

/-- Casimir `(S_u + S_v)²` on `Λ`. -/
def casimir {Λ : Finset (Vert 𝒯)} (u v : Λ) : Obs 𝒯 Λ :=
  (siteOp 𝒯 u (Sx (dim 𝒯 u.1)) + siteOp 𝒯 v (Sx (dim 𝒯 v.1))) ^ 2 +
  (siteOp 𝒯 u (Sy (dim 𝒯 u.1)) + siteOp 𝒯 v (Sy (dim 𝒯 v.1))) ^ 2 +
  (siteOp 𝒯 u (Sz (dim 𝒯 u.1)) + siteOp 𝒯 v (Sz (dim 𝒯 v.1))) ^ 2

/-- `x(x+1)`. -/
def lam (x : ℝ) : ℝ := x * (x + 1)

/-- Projection onto total spin `J = S_u + S_v` on the bond `uv`: Lagrange interpolation
polynomial in the Casimir killing the eigenvalues `j(j+1)`, `j = J-1, …, |S_u - S_v|`. -/
def bondProj {Λ : Finset (Vert 𝒯)} (u v : Λ) : Obs 𝒯 Λ :=
  let J : ℝ := spinS (dim 𝒯 u.1) + spinS (dim 𝒯 v.1)
  ((List.range (min (deg 𝒯 u.1) (deg 𝒯 v.1))).map (fun t : ℕ =>
    ((((lam J - lam (J - ((t : ℝ) + 1)))⁻¹ : ℝ) : ℂ)) •
      (casimir 𝒯 u v - (((lam (J - ((t : ℝ) + 1)) : ℝ) : ℂ)) • (1 : Obs 𝒯 Λ)))).prod

/-- AKLT Hamiltonian `H_Λ = Σ_{uv ∈ E(Λ)} P_uv`. -/
def ham (Λ : Finset (Vert 𝒯)) : Obs 𝒯 Λ :=
  (1 / 2 : ℂ) • ∑ p ∈ (Finset.univ : Finset (Λ × Λ)).filter
      (fun p : Λ × Λ => (tilingGraph 𝒯).Adj p.1.1 p.2.1), bondProj 𝒯 p.1 p.2

/-- Restriction of a configuration on `Λ'` to `Λ ⊆ Λ'`. -/
def restr {Λ Λ' : Finset (Vert 𝒯)} (h : Λ ⊆ Λ') (σ : Config 𝒯 Λ') : Config 𝒯 Λ :=
  fun w => σ ⟨w.1, h w.2⟩

/-- `A ↦ A ⊗ 1` from `Λ` to `Λ' ⊇ Λ`. -/
def embed {Λ Λ' : Finset (Vert 𝒯)} (h : Λ ⊆ Λ') (A : Obs 𝒯 Λ) : Obs 𝒯 Λ' :=
  fun σ τ => if ∀ w : Λ', w.1 ∉ Λ → σ w = τ w then A (restr 𝒯 h σ) (restr 𝒯 h τ) else 0

/-- A state of the quasi-local algebra, as a consistent family of positive normalised linear
functionals on the local algebras. -/
def IsState (ω : (Λ : Finset (Vert 𝒯)) → Obs 𝒯 Λ → ℂ) : Prop :=
  (∀ (Λ : Finset (Vert 𝒯)) (A B : Obs 𝒯 Λ), ω Λ (A + B) = ω Λ A + ω Λ B) ∧
  (∀ (Λ : Finset (Vert 𝒯)) (c : ℂ) (A : Obs 𝒯 Λ), ω Λ (c • A) = c * ω Λ A) ∧
  (∀ (Λ : Finset (Vert 𝒯)) (A : Obs 𝒯 Λ),
      (ω Λ (A.conjTranspose * A)).im = 0 ∧ 0 ≤ (ω Λ (A.conjTranspose * A)).re) ∧
  (∀ Λ : Finset (Vert 𝒯), ω Λ 1 = 1) ∧
  (∀ (Λ Λ' : Finset (Vert 𝒯)) (h : Λ ⊆ Λ') (A : Obs 𝒯 Λ), ω Λ' (embed 𝒯 h A) = ω Λ A)

/-- Frustration-free: every bond projection has expectation zero. -/
def IsFF (ω : (Λ : Finset (Vert 𝒯)) → Obs 𝒯 Λ → ℂ) : Prop :=
  ∀ (Λ : Finset (Vert 𝒯)) (u v : Λ), (tilingGraph 𝒯).Adj u.1 v.1 → ω Λ (bondProj 𝒯 u v) = 0

/-- The GNS Hamiltonian of the frustration-free state `ω` has a simple ground state and gap
`≥ γ` (variational form on the core of local vectors, see the notes). -/
def GapAtLeast (ω : (Λ : Finset (Vert 𝒯)) → Obs 𝒯 Λ → ℂ) (γ : ℝ) : Prop :=
  ∀ (Λ Λ' : Finset (Vert 𝒯)) (h : Λ ⊆ Λ'),
    (∀ u ∈ Λ, ∀ v : Vert 𝒯, (tilingGraph 𝒯).Adj u v → v ∈ Λ') →
    ∀ A : Obs 𝒯 Λ, ω Λ A = 0 →
      γ * (ω Λ (A.conjTranspose * A)).re ≤
        (ω Λ' ((embed 𝒯 h A).conjTranspose * ham 𝒯 Λ' * embed 𝒯 h A)).re

end AKLT

def Claim : Prop :=
  (∃ 𝒯 : Set (Set ℂ), IsHatTiling 𝒯) ∧
  ∃ γ : ℝ, 0 < γ ∧ ∀ 𝒯 : Set (Set ℂ), IsHatTiling 𝒯 →
    ∃ ω : (Λ : Finset (Vert 𝒯)) → Obs 𝒯 Λ → ℂ,
      IsState 𝒯 ω ∧ IsFF 𝒯 ω ∧
      (∀ ω' : (Λ : Finset (Vert 𝒯)) → Obs 𝒯 Λ → ℂ, IsState 𝒯 ω' → IsFF 𝒯 ω' → ω' = ω) ∧
      GapAtLeast 𝒯 ω γ

end
end OpenProblems.QEDE231
