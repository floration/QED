import Mathlib
/-! QED-E225: Is the hat-tiling spectrum a Cantor set?
Put a quantum particle on the vertices of a hat tiling, hopping along tile edges with equal amplitude. Decide whether the set of allowed energies is a Cantor set (closed, with no intervals); if it is, decide whether it has Lebesgue measure zero.
Informal statement: Let $\mathcal T$ be a tiling of $\mathbb R^2$ by isometric copies (reflections allowed) of the Smith--Myers--Kaplan--Goodman-Strauss hat, and let $G_{\mathcal T}$ be its vertex--edge graph (vertices: the 13 polygon corners of each tile; edges: the boundary segments between consecutive vertices). Let $A_{\mathcal T}$ be the adjacency operator on $\ell^2(V(G_{\mathcal T}))$ and $\Sigma_{\mathcal T}$ its spectrum (expected to be independent of $\mathcal T$ by minimality of the hull). (a) Decide whether $\Sigma_{\mathcal T}$ is nowhere dense, i.e. contains no interval, for every hat tiling $\mathcal T$. (b) If so, decide whether $|\Sigma_{\mathcal T}|=0$.
Formalization notes:
* Hat: Kaplan's 13-gon with corners (hex coordinates `(a,b) ↦ a + b/2 + i(√3/2) b`)
  (0,0),(−1,−1),(0,−2),(2,−2),(2,−1),(4,−2),(5,−1),(4,0),(3,0),(2,2),(0,3),(0,2),(−1,2) in cyclic order (area 8√3;
  no straight angles — both checked numerically), and as a set it is the union of its 8 kites of the deltoidal
  trihexagonal grid (same encoding as QED-E096). The long edge (0,−2)–(2,−2) is one edge of the 13-gon; its
  midpoint is a graph vertex only if it is a corner of some tile.
* A hat tiling is a set `S` of isometries `g : ℂ ≃ᵢ ℂ` (reflections allowed) such that the tiles `g '' hat` cover ℂ
  and distinct `g` give tiles with disjoint interiors (the hat has no symmetry, so tiles and isometries correspond).
* Vertex–edge graph: `Vert S` = all corners `g(cornerᵢ)`. `x, y` are adjacent iff `x ≠ y`, the segment `[x,y]` lies in
  one edge `[g(cornerᵢ), g(cornerᵢ₊₁)]` of some tile, and no vertex lies in the open segment `(x,y)`. This is exactly
  "boundary segments between consecutive vertices", including the subdivision of an edge by corners of other tiles
  (hat tilings need not be edge-to-edge). Degrees are bounded (each vertex meets boundedly many tiles), so the
  adjacency operator A is bounded self-adjoint on ℓ²(V).
* Spectrum via Weyl's criterion: for bounded self-adjoint A, λ ∈ σ(A) iff for every ε > 0 there is ψ ≠ 0 with
  ‖(A − λ)ψ‖ ≤ ε‖ψ‖. Finitely supported ψ are dense and A is bounded, so ψ may be taken finitely supported; A is a
  real symmetric operator, so ψ may be taken real (if ψ = u + iv then ‖(A−λ)ψ‖² = ‖(A−λ)u‖² + ‖(A−λ)v‖² and
  ‖ψ‖² = ‖u‖² + ‖v‖², so u or v works). `InSpec S λ` is that condition with ψ given by a finset `F ⊆ Vert S` and
  values `c`. The residual norm is a `tsum` in `ℝ≥0∞` (no summability junk; it is in fact a finite sum).
* `Claim` = part (a): for every hat tiling, the spectrum contains no nondegenerate interval (closed sets with no
  interior are exactly the nowhere dense closed sets; the spectrum is automatically closed). `¬Claim` = some hat
  tiling has an interval in its spectrum (by hull minimality then all do). Part (b) is recorded as
  `SpecNullMeasure`, not part of `Claim`.
-/
namespace OpenProblems.QEDE225
noncomputable section
open scoped Classical

/-- Hex-grid point `(a, b) ↦ a + b/2 + i·(√3/2)·b`. -/
def hexPt (a b : ℤ) : ℂ := ⟨(a : ℝ) + (b : ℝ) / 2, Real.sqrt 3 / 2 * (b : ℝ)⟩

/-- A kite with the given four grid vertices. -/
def kite (p q r s : ℤ × ℤ) : Set ℂ :=
  convexHull ℝ {hexPt p.1 p.2, hexPt q.1 q.2, hexPt r.1 r.2, hexPt s.1 s.2}

/-- The hat monotile, as a union of 8 kites. -/
def hat : Set ℂ :=
  kite (0, 0) (2, -1) (2, 0) (1, 1) ∪ kite (0, 0) (1, 1) (0, 2) (-1, 2) ∪
  kite (0, 0) (-1, -1) (0, -2) (1, -2) ∪ kite (0, 0) (1, -2) (2, -2) (2, -1) ∪
  kite (4, -2) (5, -1) (4, 0) (3, 0) ∪ kite (4, -2) (3, 0) (2, 0) (2, -1) ∪
  kite (2, 2) (0, 3) (0, 2) (1, 1) ∪ kite (2, 2) (1, 1) (2, 0) (3, 0)

/-- The 13 corners of the hat polygon, in cyclic order (hex coordinates). -/
def corner : Fin 13 → ℤ × ℤ :=
  ![(0, 0), (-1, -1), (0, -2), (2, -2), (2, -1), (4, -2), (5, -1), (4, 0), (3, 0), (2, 2),
    (0, 3), (0, 2), (-1, 2)]

/-- The corners as points of `ℂ`. -/
def cornerPt (i : Fin 13) : ℂ := hexPt (corner i).1 (corner i).2

/-- `S` is a tiling of the plane by hats (one isometry per tile, reflections allowed). -/
def IsHatTiling (S : Set (ℂ ≃ᵢ ℂ)) : Prop :=
  (⋃ g ∈ S, g '' hat) = Set.univ ∧
    ∀ g ∈ S, ∀ h ∈ S, g ≠ h → Disjoint (interior (g '' hat)) (interior (h '' hat))

/-- Vertices of the tiling: all tile corners. -/
def Vert (S : Set (ℂ ≃ᵢ ℂ)) : Set ℂ :=
  {z : ℂ | ∃ g ∈ S, ∃ i : Fin 13, z = g (cornerPt i)}

/-- Consecutive vertices along a tile edge. -/
def Adj (S : Set (ℂ ≃ᵢ ℂ)) (x y : ℂ) : Prop :=
  x ≠ y ∧
    (∃ g ∈ S, ∃ i : Fin 13,
      segment ℝ x y ⊆ segment ℝ (g (cornerPt i)) (g (cornerPt (i + 1)))) ∧
    ∀ z ∈ Vert S, z ∉ openSegment ℝ x y

/-- The finitely supported vector `ψ = c` on `F`, `0` elsewhere. -/
def psi (F : Finset ℂ) (c : ℂ → ℝ) (x : ℂ) : ℝ :=
  if x ∈ F then c x else 0

/-- Adjacency operator applied to `psi F c`, evaluated at `x`. -/
def adjApply (S : Set (ℂ ≃ᵢ ℂ)) (F : Finset ℂ) (c : ℂ → ℝ) (x : ℂ) : ℝ :=
  ∑ y ∈ F, if Adj S x y then c y else 0

/-- Weyl criterion: `λ` is in the spectrum of the adjacency operator of the tiling `S`. -/
def InSpec (S : Set (ℂ ≃ᵢ ℂ)) (lam : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ F : Finset ℂ, ∃ c : ℂ → ℝ,
    (↑F : Set ℂ) ⊆ Vert S ∧ 0 < ∑ y ∈ F, c y ^ 2 ∧
    (∑' x : Vert S, ENNReal.ofReal ((adjApply S F c x - lam * psi F c x) ^ 2)) ≤
      ENNReal.ofReal (ε ^ 2 * ∑ y ∈ F, c y ^ 2)

/-- The spectrum of the adjacency operator. -/
def spec (S : Set (ℂ ≃ᵢ ℂ)) : Set ℝ := {lam : ℝ | InSpec S lam}

/-- Part (b), not part of `Claim`: the spectrum has Lebesgue measure zero. -/
def SpecNullMeasure : Prop :=
  ∀ S : Set (ℂ ≃ᵢ ℂ), IsHatTiling S → MeasureTheory.volume (spec S) = 0

/-- Part (a): the spectrum of every hat tiling contains no interval. -/
def Claim : Prop :=
  ∀ S : Set (ℂ ≃ᵢ ℂ), IsHatTiling S →
    ∀ a b : ℝ, a < b → ¬ (Set.Icc a b ⊆ spec S)

end
end OpenProblems.QEDE225
