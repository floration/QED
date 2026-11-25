import Mathlib
/-! QED-M071: Hat Ising universality
Magnets on a hat tiling should behave at their critical point exactly like magnets on a square grid. Prove it.
Informal statement (sharpened): Let `G` be the tile-adjacency graph of a hat tiling `T` (any tiling of the plane by
isometric copies, reflections allowed, of the Smith–Myers–Kaplan–Goodman-Strauss hat). Prove: there is
`β_c ∈ (0,∞)`, the same for all hat tilings `T`, such that, with constants depending only on `T`,
(a) `M_T(β, x) = 0` for all tiles `x` and `0 ≤ β ≤ β_c`, and `c(β−β_c)^{1/8} ≤ M_T(β, x) ≤ C(β−β_c)^{1/8}` uniformly in
`x` for `β_c < β < β_c + δ`; (b) for `β_c − δ < β < β_c`, `χ_T(β) = sup_x Σ_y ⟨σ_xσ_y⟩_β` satisfies
`c(β_c−β)^{−7/4} ≤ χ_T(β) ≤ C(β_c−β)^{−7/4}`; (c) for `β_c − δ < β < β_c`, the inverse correlation length
`1/ξ_T(β) = liminf_{|x−y|→∞} (−log⟨σ_xσ_y⟩_β / |x−y|)` satisfies `c(β_c−β) ≤ 1/ξ_T(β) ≤ C(β_c−β)`.
Formalization notes:
* Hat: the polykite with vertices (hex coordinates `(a,b) ↦ a + b/2 + i(√3/2)b`)
  (0,0),(−1,−1),(0,−2),(2,−2),(2,−1),(4,−2),(5,−1),(4,0),(3,0),(2,2),(0,3),(0,2),(−1,2) (Kaplan's coordinates; area
  `8√3`), written as the union of its 8 kites of the deltoidal trihexagonal grid (each kite = convex hull of hex
  centre, edge midpoint, vertex, edge midpoint), so no polygon-filling API is needed. The decomposition was checked
  numerically (8 kites, total area = polygon area).
* Hat tiling: a set `T` of tiles, each `g '' hat` for an isometry `g : ℂ ≃ᵢ ℂ`, covering `ℂ`, with pairwise
  disjoint interiors. "The hull" is taken to be the set of all hat tilings: by Smith et al. every hat tiling has the
  hierarchical metatile structure, so all hat tilings are locally isomorphic and form the hull (up to isometry).
  Adjacency: distinct tiles whose intersection contains a nondegenerate segment.
* Ising model, `J = 1`, on the (countable, locally finite) graph. Finite volume `Λ` (finite set of tiles), spins
  `±1`. Plus b.c.: weight `exp(β(Σ_{xy ⊂ Λ} σ_xσ_y + Σ_{x∈Λ} σ_x·#{y ∉ Λ adjacent to x}))`; free b.c.: no boundary
  term. Infinite-volume quantities: by GKS, `⟨σ_x⟩^+_Λ` decreases and free `⟨σ_xσ_y⟩_Λ` increases in `Λ`, so the
  thermodynamic limits equal the `inf` resp. `sup` over finite `Λ` (this is how they are defined). For `β < β_c`
  (`M^+ ≡ 0`) the Gibbs state is unique (Lebowitz–Martin-Löf), so free correlations are the correlations; there
  truncated = untruncated, so `χ` is the sum of `⟨σ_xσ_y⟩`. `χ` is valued in `ℝ≥0∞` (no summability junk).
* Distance between tiles: `inf_{a∈x} dist(a, y)`; tiles have bounded diameter so any reference point gives the
  same rates. The correlation-length bounds are written out: `1/ξ ≥ lo` iff for every `a < lo` all sufficiently
  distant pairs have `−log⟨σ_xσ_y⟩ ≥ a·|x−y|`; `1/ξ ≤ hi` iff for every `b > hi` there are arbitrarily distant pairs
  with `−log⟨σ_xσ_y⟩ ≤ b·|x−y|`.
* Judgement call: the problem's `1/ξ = −liminf (log⟨σ_xσ_y⟩/|x−y|)` takes the fastest-decaying pairs; we use the
  standard slowest-decay definition `1/ξ = liminf (−log⟨σ_xσ_y⟩/|x−y|)` (so `⟨σ_xσ_y⟩ ≤ e^{−(1/ξ−ε)|x−y|}` for
  all distant pairs), which is what "correlation length" means; also each asymptotic is placed on the side of
  `β_c` where the quantity is nontrivial, and constants depend on `T` but not on tiles.
* (a) is restricted to `0 ≤ β`: for `β < 0` (antiferromagnet) the plus-state magnetization is not 0
  (already `Λ = {x}` gives `tanh(β·deg x) < 0`, and `mag` is an infimum), which would make `Claim`
  false for a reason unrelated to criticality.
-/
namespace OpenProblems.QEDM071
noncomputable section
open scoped Classical
open Filter

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

/-- `T` is a tiling of the plane by hats (reflections allowed). -/
def IsHatTiling (T : Set (Set ℂ)) : Prop :=
  (∀ t ∈ T, ∃ g : ℂ ≃ᵢ ℂ, t = g '' hat) ∧ ⋃₀ T = Set.univ ∧
  ∀ s ∈ T, ∀ t ∈ T, s ≠ t → Disjoint (interior s) (interior t)

/-- Tile adjacency: distinct tiles sharing a boundary segment. -/
def Adj (T : Set (Set ℂ)) (x y : T) : Prop :=
  x ≠ y ∧ ∃ a b : ℂ, a ≠ b ∧ segment ℝ a b ⊆ (x : Set ℂ) ∩ (y : Set ℂ)

/-- Spin value of a Boolean. -/
def spin (b : Bool) : ℝ := if b then 1 else -1

/-- Spin at tile `x` for a configuration on `Λ` (plus outside `Λ`). -/
def sAt {T : Set (Set ℂ)} (Λ : Finset T) (σ : Λ → Bool) (x : T) : ℝ :=
  if h : x ∈ Λ then spin (σ ⟨x, h⟩) else 1

/-- `Σ_{x,y ∈ Λ, x ~ y} σ_x σ_y` over ordered pairs (each edge twice). -/
def bulk {T : Set (Set ℂ)} (Λ : Finset T) (σ : Λ → Bool) : ℝ :=
  ∑ x ∈ Λ, ∑ y ∈ Λ, if Adj T x y then sAt Λ σ x * sAt Λ σ y else 0

/-- Number of neighbours of `x` outside `Λ`. -/
def outDeg {T : Set (Set ℂ)} (Λ : Finset T) (x : T) : ℝ :=
  (({y : T | Adj T x y ∧ y ∉ Λ} : Set T).ncard : ℝ)

/-- Plus-boundary-condition Boltzmann weight. -/
def wPlus {T : Set (Set ℂ)} (β : ℝ) (Λ : Finset T) (σ : Λ → Bool) : ℝ :=
  Real.exp (β * (bulk Λ σ / 2 + ∑ x ∈ Λ, sAt Λ σ x * outDeg Λ x))

/-- Free-boundary-condition Boltzmann weight. -/
def wFree {T : Set (Set ℂ)} (β : ℝ) (Λ : Finset T) (σ : Λ → Bool) : ℝ :=
  Real.exp (β * (bulk Λ σ / 2))

/-- Finite-volume expectation. -/
def expect {T : Set (Set ℂ)} (Λ : Finset T) (w : (Λ → Bool) → ℝ) (f : (Λ → Bool) → ℝ) : ℝ :=
  (∑ σ : Λ → Bool, f σ * w σ) / (∑ σ : Λ → Bool, w σ)

/-- Plus-state magnetization `⟨σ_x⟩^+_β` (thermodynamic limit = infimum over finite volumes). -/
def mag (T : Set (Set ℂ)) (β : ℝ) (x : T) : ℝ :=
  ⨅ Λ : {Λ : Finset T // x ∈ Λ}, expect Λ.1 (wPlus β Λ.1) (fun σ => sAt Λ.1 σ x)

/-- Two-point function `⟨σ_xσ_y⟩_β` (free state; thermodynamic limit = supremum over finite volumes). -/
def corr (T : Set (Set ℂ)) (β : ℝ) (x y : T) : ℝ :=
  ⨆ Λ : {Λ : Finset T // x ∈ Λ ∧ y ∈ Λ},
    expect Λ.1 (wFree β Λ.1) (fun σ => sAt Λ.1 σ x * sAt Λ.1 σ y)

/-- Susceptibility `sup_x Σ_y ⟨σ_xσ_y⟩_β`. -/
def susc (T : Set (Set ℂ)) (β : ℝ) : ENNReal :=
  ⨆ x : T, ∑' y : T, ENNReal.ofReal (corr T β x y)

/-- Distance between tiles. -/
def tileDist (s t : Set ℂ) : ℝ := ⨅ a : s, Metric.infDist (a : ℂ) t

/-- `lo ≤ 1/ξ_T(β) ≤ hi`, with `1/ξ = liminf_{|x−y|→∞} (−log⟨σ_xσ_y⟩ / |x−y|)`. -/
def InvCorrLengthBetween (T : Set (Set ℂ)) (β lo hi : ℝ) : Prop :=
  (∀ a : ℝ, a < lo → ∃ R : ℝ, ∀ x y : T, R ≤ tileDist (x : Set ℂ) (y : Set ℂ) →
      a * tileDist (x : Set ℂ) (y : Set ℂ) ≤ -Real.log (corr T β x y)) ∧
  (∀ b : ℝ, hi < b → ∀ R : ℝ, ∃ x y : T, R ≤ tileDist (x : Set ℂ) (y : Set ℂ) ∧
      -Real.log (corr T β x y) ≤ b * tileDist (x : Set ℂ) (y : Set ℂ))

def Claim : Prop :=
  ∃ βc : ℝ, 0 < βc ∧ ∀ T : Set (Set ℂ), IsHatTiling T →
    (∀ β : ℝ, 0 ≤ β → β ≤ βc → ∀ x : T, mag T β x = 0) ∧
    ∃ δ c C : ℝ, 0 < δ ∧ 0 < c ∧ 0 < C ∧
      (∀ β : ℝ, βc < β → β < βc + δ → ∀ x : T,
        c * (β - βc) ^ ((1 : ℝ) / 8) ≤ mag T β x ∧ mag T β x ≤ C * (β - βc) ^ ((1 : ℝ) / 8)) ∧
      (∀ β : ℝ, βc - δ < β → β < βc →
        ENNReal.ofReal (c * (βc - β) ^ (-(7 : ℝ) / 4)) ≤ susc T β ∧
        susc T β ≤ ENNReal.ofReal (C * (βc - β) ^ (-(7 : ℝ) / 4))) ∧
      (∀ β : ℝ, βc - δ < β → β < βc →
        InvCorrLengthBetween T β (c * (βc - β)) (C * (βc - β)))

end
end OpenProblems.QEDM071
