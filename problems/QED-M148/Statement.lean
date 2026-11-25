import Mathlib
/-! QED-M148: Critical Ising interfaces on the hat tiling converge to SLE(3)
Put an Ising spin on every tile of a hat tiling, with neighbouring tiles (sharing an edge segment) interacting, at the critical temperature. Take a large simply connected region with plus spins forced on one boundary arc and minus spins on the other. Show that, as the tiles shrink, the interface between the plus and minus clusters converges to the random curve SLE(3), just as on the square lattice, although the hat graph is neither periodic nor isoradial.
Informal statement: Let $G_T$ be the tile-adjacency graph of a hat tiling $T$ (Smith–Myers–Kaplan–Goodman-Strauss hat, reflections allowed; tiles adjacent iff they share a boundary segment of positive length), with the ferromagnetic nearest-neighbour Ising model, $J\equiv1$. Prove: (i) there is $\beta_c\in(0,\infty)$, independent of $T$, such that the plus-state magnetisation of every tile vanishes for $0<\beta\le\beta_c$ and is positive for $\beta>\beta_c$; (ii) for every hat tiling $T$, every Jordan domain $\Omega$ with distinct boundary points $a,b$, and all discretisations $(\Omega_\delta,a_\delta,b_\delta)$ by simply connected unions of tiles of $\delta T$ whose boundary curves converge to $\partial\Omega$ uniformly up to reparametrisation, with $a_\delta\to a$, $b_\delta\to b$: with Dobrushin boundary conditions ($+$ on the boundary arc from $a_\delta$ to $b_\delta$, $-$ on the other) at $\beta=\beta_c$, the interface from $a_\delta$ to $b_\delta$ (any interface path, whatever choice is made at vertices where several interface edges meet) converges in law, in the topology of curves up to reparametrisation, to chordal $\mathrm{SLE}_3$ in $(\Omega,a,b)$.
Formalization notes:
* Hat tilings, as in the AKLT problem of the same batch: the hat polygon (lattice coordinates from
  Kaplan's `hatviz`, checked: area `8√3` = 8 kites) as a union of 11 closed triangles; a tiling is a
  set of isometric copies (`ℂ ≃ᵢ ℂ`, reflections allowed) covering `ℂ` with disjoint interiors.
  `Vert` = points in ≥ 3 tiles; `ArcOf 𝒯 A B u w` = `u, w` are the ends of a common boundary arc
  of the distinct tiles `A, B` (same connected component of `A ∩ B`). Tiles are Ising sites;
  `tAdj A B` iff `A ∩ B` is infinite, i.e. they share a segment of positive length (two polygons
  with disjoint interiors meet in finitely many points otherwise).
* (i) Critical point. Plus-state magnetisation at tile `x`: `⟨σ_x⟩^+_Λ` in finite `Λ ∋ x` with all
  tiles outside `Λ` fixed to `+` (each outside neighbour contributes field 1). By GKS it is
  non-increasing in `Λ`, so the infinite-volume value is the infimum over finite `Λ ∋ x`
  (`mPlus`). The problem allowed assuming or proving the existence of a `T`-independent `β_c`; we
  require proving it (asserted inside `Claim` with `∃ β_c`), which avoids an implication that
  would be vacuous if no such `β_c` existed.
* Domain. A Jordan domain with two marked points is given by `f`, continuous and injective on the
  closed unit disc and holomorphic on the open disc (Carathéodory: every Jordan domain arises so),
  `Ω = f(𝔻)`, `a = f(-1)`, `b = f(1)`. Restricting from general bounded simply connected domains
  with Carathéodory convergence to Jordan domains with uniform (Fréchet) convergence of boundary
  curves is the one sharpening made; by Radó's theorem this convergence implies Carathéodory
  convergence with the marked points converging as prime ends, so it is a special case of the
  original.
* Discrete domain (`DiscDomain`, `IsDisc`), in units of the unscaled tiling `𝒯` (positions are
  multiplied by `δ`): a finite set `D` of tiles and a simple cycle `v_0, …, v_{L+2}` of vertices
  that lists every boundary edge (arc between a tile in `D` and one outside) exactly as consecutive
  pairs; hence `D` is the set of tiles enclosed by a simple closed curve (simply connected).
  `a = v_0`, `b = v_j`. Dobrushin boundary condition per boundary arc: `+1` on arcs
  `v_i v_{i+1}` with `i < j`, else `-1` (edge-based, so a tile meeting both arcs is not ambiguous).
  Energy: `-Σ_{tAdj pairs in D} σσ' - Σ_{boundary arcs} σ_{inner tile}·bc`. Convergence: the
  closed polygon through `δ v_i` is `ε`-close to `s ↦ f(e^{2πis})` after an increasing or
  decreasing reparametrisation of the circle, and `δ v_0 → a`, `δ v_j → b`. Replacing arcs by
  chords moves curves by `O(δ)`, which is invisible in the limit.
* Interface. A disagreement edge joins `u, w` along an arc of tiles `A ∈ D` and `B` where the
  spins differ (for `B ∉ D` the "spin" of `B` is the boundary value). All vertices other than
  `a, b` meet an even number of disagreement edges, `a, b` an odd number, so trails from `a` to
  `b` (walks using each edge at most once) exist. At vertices where 4 or more interface edges meet
  the interface is ambiguous; `Claim` requires convergence for every selection rule `sel` (any
  deterministic choice of a valid trail per configuration). The curve is the
  polygon through `δ`·(trail vertices), parametrised by `[0,1]`.
* Convergence in law in the space of curves modulo increasing reparametrisation (metric
  `reparamDist`): by the portmanteau theorem it suffices, and is necessary, to have convergence of
  expectations of all `F` with `|F| ≤ 1` that are 1-Lipschitz for `reparamDist` (such `F` are
  reparametrisation-invariant; bounded Lipschitz functions on the subspace of continuous curves
  extend to all functions with the same bounds, so quantifying over functions on all maps
  `[0,1] → ℂ` is equivalent).
* SLE₃. A process `W` is `√κ·`(standard Brownian motion) if `W_0 = 0`, its paths are continuous
  on `[0,∞)`, and the increments over any partition `0 = τ_0 < … < τ_k` are independent centred
  Gaussians with variances `κ(τ_{i+1} - τ_i)` (joint law = product measure). A curve `η` in `ℍ`
  from `0` is driven by `W` if it is simple, `η(t) ∈ ℍ` for `t > 0`, and for each `t` there is a
  conformal map `g_t : ℍ \ η(0,t] → ℍ` with hydrodynamic normalisation
  `g_t(z) = z + 2t/z + o(1/z)` (half-plane capacity parametrisation) and `g_t(η(t)) = W_t` as a
  boundary limit. This is the Loewner characterisation; for `κ = 3 ≤ 4` the SLE trace is a.s. a
  simple curve (Rohde–Schramm), so this describes chordal SLE₃ in `ℍ`, which is transient
  (`|η(t)| → ∞`). The curve in `(Ω, a, b)` is `f ∘ m ∘ η` with `m(z) = (z - i)/(z + i)`
  (`ℍ → 𝔻`, `0 ↦ -1`, `∞ ↦ 1`), reparametrised to `[0,1]`; this law does not depend on the choice
  of `f` (scale invariance of SLE). `IsSLE3Setup` asks for a probability space with such `W` and a
  Borel-measurable random continuous curve `Γ` that is a.s. this curve; `Claim` asserts such a
  setup exists (no vacuity) and the convergence holds for every one.
* Proving `Claim` = (i) and (ii). Proving `¬Claim` = no `T`-independent critical point, or failure
  of convergence for some hat tiling, Jordan domain, discretisation and interface selection.
-/
namespace OpenProblems.QEDM148
noncomputable section
open scoped Classical
open MeasureTheory Filter Topology

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

/-! ### Ising model on tiles -/

/-- Tiles sharing a boundary segment of positive length. -/
def tAdj (𝒯 : Set (Set ℂ)) (A B : 𝒯) : Prop := A ≠ B ∧ (A.1 ∩ B.1).Infinite

/-- Spin value `±1`. -/
def spinv (b : Bool) : ℝ := if b then 1 else -1

/-- Number of neighbours of `A` outside `Λ`. -/
def outDeg (𝒯 : Set (Set ℂ)) (Λ : Finset 𝒯) (A : 𝒯) : ℕ :=
  {B : 𝒯 | B ∉ Λ ∧ tAdj 𝒯 A B}.ncard

/-- Energy in `Λ` with plus boundary condition. -/
def energyPlus (𝒯 : Set (Set ℂ)) (Λ : Finset 𝒯) (σ : Λ → Bool) : ℝ :=
  -(1 / 2) * ∑ p ∈ (Finset.univ : Finset (Λ × Λ)).filter (fun p : Λ × Λ => tAdj 𝒯 p.1.1 p.2.1),
      spinv (σ p.1) * spinv (σ p.2)
  - ∑ A : Λ, spinv (σ A) * (outDeg 𝒯 Λ A.1 : ℝ)

/-- `⟨σ_x⟩` in `Λ ∋ x` with plus boundary condition at inverse temperature `β`. -/
def magPlus (𝒯 : Set (Set ℂ)) (β : ℝ) (Λ : Finset 𝒯) (x : 𝒯) (hx : x ∈ Λ) : ℝ :=
  (∑ σ : Λ → Bool, spinv (σ ⟨x, hx⟩) * Real.exp (-β * energyPlus 𝒯 Λ σ)) /
    ∑ σ : Λ → Bool, Real.exp (-β * energyPlus 𝒯 Λ σ)

/-- Infinite-volume plus-state magnetisation at `x` (monotone limit = infimum, by GKS). -/
def mPlus (𝒯 : Set (Set ℂ)) (β : ℝ) (x : 𝒯) : ℝ :=
  ⨅ Λ : {Λ : Finset 𝒯 // x ∈ Λ}, magPlus 𝒯 β Λ.1 x Λ.2

/-! ### Discrete Dobrushin domains and interfaces -/

/-- A finite set of tiles with a boundary cycle `v`, `a = v 0`, `b = v j`. -/
structure DiscDomain (𝒯 : Set (Set ℂ)) where
  D : Finset 𝒯
  L : ℕ
  v : Fin (L + 3) → ℂ
  j : ℕ

namespace DiscDomain
variable {𝒯 : Set (Set ℂ)} (Dd : DiscDomain 𝒯)

/-- Cyclic indexing of the boundary cycle. -/
def vAt (k : ℕ) : ℂ := Dd.v ⟨k % (Dd.L + 3), Nat.mod_lt k (by omega)⟩

/-- `u w` is a boundary arc: between a tile of `D` and a tile outside `D`. -/
def BEdge (u w : ℂ) : Prop :=
  ∃ A : 𝒯, A ∈ Dd.D ∧ ∃ B : 𝒯, B ∉ Dd.D ∧ ArcOf 𝒯 A.1 B.1 u w

/-- Well-formed discrete domain: `v` is a simple cycle listing exactly the boundary arcs. -/
def IsDisc : Prop :=
  Function.Injective Dd.v ∧ 0 < Dd.j ∧ Dd.j < Dd.L + 3 ∧
  (∀ i : ℕ, i < Dd.L + 3 → Dd.BEdge (Dd.vAt i) (Dd.vAt (i + 1))) ∧
  (∀ u w : ℂ, Dd.BEdge u w → ∃ i : ℕ, i < Dd.L + 3 ∧
      ((Dd.vAt i = u ∧ Dd.vAt (i + 1) = w) ∨ (Dd.vAt i = w ∧ Dd.vAt (i + 1) = u)))

/-- Dobrushin boundary value of the boundary arc `u w`: `+1` on the arc from `a` to `b`. -/
def bcVal (u w : ℂ) : ℝ :=
  if ∃ i : ℕ, i < Dd.j ∧ s(Dd.vAt i, Dd.vAt (i + 1)) = s(u, w) then 1 else -1

/-- Ising energy with Dobrushin boundary conditions. -/
def energy (σ : Dd.D → Bool) : ℝ :=
  -(1 / 2) * ∑ p ∈ (Finset.univ : Finset (Dd.D × Dd.D)).filter
      (fun p : Dd.D × Dd.D => tAdj 𝒯 p.1.1 p.2.1), spinv (σ p.1) * spinv (σ p.2)
  - ∑ i ∈ Finset.range (Dd.L + 3), ∑ A : Dd.D,
      (if ∃ B : 𝒯, B ∉ Dd.D ∧ ArcOf 𝒯 A.1.1 B.1 (Dd.vAt i) (Dd.vAt (i + 1))
        then spinv (σ A) * (if i < Dd.j then 1 else -1) else 0)

/-- `u w` is an interface (disagreement) edge for `σ`. -/
def Disagree (σ : Dd.D → Bool) (u w : ℂ) : Prop :=
  ∃ A : Dd.D, ∃ B : 𝒯, ArcOf 𝒯 A.1.1 B.1 u w ∧
    (if hB : B ∈ Dd.D then σ A ≠ σ ⟨B, hB⟩ else spinv (σ A) ≠ Dd.bcVal u w)

/-- `l` is an interface trail from `a` to `b`: consecutive vertices joined by disagreement edges,
no edge used twice. -/
def ValidTrail (σ : Dd.D → Bool) (l : List ℂ) : Prop :=
  2 ≤ l.length ∧ l.getD 0 0 = Dd.vAt 0 ∧ l.getD (l.length - 1) 0 = Dd.vAt Dd.j ∧
  (∀ i : ℕ, i + 1 < l.length → Dd.Disagree σ (l.getD i 0) (l.getD (i + 1) 0)) ∧
  (∀ i k : ℕ, i < k → k + 1 < l.length →
    s(l.getD i 0, l.getD (i + 1) 0) ≠ s(l.getD k 0, l.getD (k + 1) 0))

/-- Closed boundary polygon through `δ v_i`, 1-periodic in `s`. -/
def cyclePoly (δ : ℝ) (s : ℝ) : ℂ :=
  let x : ℝ := Int.fract s * ((Dd.L : ℝ) + 3)
  let k : ℕ := ⌊x⌋₊
  (δ : ℂ) * (Dd.vAt k + ((x - k : ℝ) : ℂ) * (Dd.vAt (k + 1) - Dd.vAt k))

end DiscDomain

/-- Polygonal curve on `[0,1]` through the points of `l` (at least two points). -/
def polyCurve (l : List ℂ) (t : unitInterval) : ℂ :=
  let m : ℕ := l.length - 1
  let s : ℝ := (t : ℝ) * (m : ℝ)
  let k : ℕ := min ⌊s⌋₊ (m - 1)
  l.getD k 0 + ((s - k : ℝ) : ℂ) * (l.getD (k + 1) 0 - l.getD k 0)

/-- Expectation of `F(δ · interface)` under the Dobrushin Ising measure at `β`. -/
def expect {𝒯 : Set (Set ℂ)} (β : ℝ) (Dd : DiscDomain 𝒯) (δ : ℝ)
    (sel : (Dd.D → Bool) → List ℂ) (F : (unitInterval → ℂ) → ℝ) : ℝ :=
  (∑ σ : Dd.D → Bool, Real.exp (-β * Dd.energy σ) *
      F (fun t : unitInterval => (δ : ℂ) * polyCurve (sel σ) t)) /
    ∑ σ : Dd.D → Bool, Real.exp (-β * Dd.energy σ)

/-! ### Curves, domains, SLE -/

/-- Distance between curves up to increasing reparametrisation. -/
def reparamDist (γ₁ γ₂ : unitInterval → ℂ) : ENNReal :=
  ⨅ (φ : unitInterval ≃ₜ unitInterval) (_ : Monotone φ), ⨆ t : unitInterval, edist (γ₁ t) (γ₂ (φ t))

/-- Test functions: bounded by 1 and 1-Lipschitz for `reparamDist`. -/
def TestFn (F : (unitInterval → ℂ) → ℝ) : Prop :=
  (∀ γ : unitInterval → ℂ, |F γ| ≤ 1) ∧
  ∀ γ₁ γ₂ : unitInterval → ℂ, ENNReal.ofReal |F γ₁ - F γ₂| ≤ reparamDist γ₁ γ₂

/-- `f` maps the closed disc homeomorphically onto the closure of a Jordan domain, conformally on
the open disc. -/
def IsJordanMap (f : ℂ → ℂ) : Prop :=
  ContinuousOn f (Metric.closedBall 0 1) ∧ Set.InjOn f (Metric.closedBall 0 1) ∧
  DifferentiableOn ℂ f (Metric.ball 0 1)

/-- `p` and `q` (1-periodic closed curves) are `ε`-close up to reparametrisation of the circle. -/
def FrechetClose (ε : ℝ) (p q : ℝ → ℂ) : Prop :=
  ∃ φ : ℝ → ℝ, Continuous φ ∧
    ((StrictMono φ ∧ ∀ s : ℝ, φ (s + 1) = φ s + 1) ∨
     (StrictAnti φ ∧ ∀ s : ℝ, φ (s + 1) = φ s - 1)) ∧
    ∀ s : ℝ, ‖p (φ s) - q s‖ ≤ ε

/-- The scaled discrete domains converge to `(f(𝔻), f(-1), f(1))`. -/
def DomConv {𝒯 : Set (Set ℂ)} (f : ℂ → ℂ) (δ : ℕ → ℝ) (Dd : ℕ → DiscDomain 𝒯) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∀ᶠ n : ℕ in atTop,
    FrechetClose ε ((Dd n).cyclePoly (δ n))
        (fun s : ℝ => f (Complex.exp (((2 * Real.pi * s : ℝ) : ℂ) * Complex.I))) ∧
    ‖(δ n : ℂ) * (Dd n).vAt 0 - f (-1)‖ ≤ ε ∧ ‖(δ n : ℂ) * (Dd n).vAt (Dd n).j - f 1‖ ≤ ε

/-- `W = √κ ·` standard Brownian motion. -/
def IsBM {Ω' : Type} [MeasurableSpace Ω'] (P : Measure Ω') (W : ℝ → Ω' → ℝ) (κ : ℝ) : Prop :=
  (∀ ω : Ω', W 0 ω = 0) ∧ (∀ ω : Ω', ContinuousOn (fun t : ℝ => W t ω) (Set.Ici 0)) ∧
  (∀ t : ℝ, Measurable (W t)) ∧
  ∀ (k : ℕ) (τ : Fin (k + 1) → ℝ), τ 0 = 0 → StrictMono τ →
    P.map (fun ω : Ω' => fun i : Fin k => W (τ i.succ) ω - W (τ (Fin.castSucc i)) ω) =
      Measure.pi (fun i : Fin k =>
        ProbabilityTheory.gaussianReal 0 (Real.toNNReal (κ * (τ i.succ - τ (Fin.castSucc i)))))

/-- Upper half-plane. -/
def UHP : Set ℂ := {z : ℂ | 0 < z.im}

/-- `ℍ \ η(0,t]`. -/
def slitDomain (η : ℝ → ℂ) (t : ℝ) : Set ℂ := UHP \ η '' Set.Ioc 0 t

/-- `η` is the simple chordal Loewner curve in `ℍ` from `0` with driving function `W`
(half-plane capacity parametrisation). -/
def DrivenBy (η : ℝ → ℂ) (W : ℝ → ℝ) : Prop :=
  ContinuousOn η (Set.Ici 0) ∧ η 0 = 0 ∧ Set.InjOn η (Set.Ici 0) ∧
  (∀ t : ℝ, 0 < t → 0 < (η t).im) ∧
  ∀ t : ℝ, 0 ≤ t → ∃ g : ℂ → ℂ,
    DifferentiableOn ℂ g (slitDomain η t) ∧ Set.InjOn g (slitDomain η t) ∧
    g '' slitDomain η t = UHP ∧
    Tendsto (fun z : ℂ => z * (g z - z - 2 * (t : ℂ) / z))
      (Bornology.cobounded ℂ ⊓ 𝓟 (slitDomain η t)) (𝓝 0) ∧
    Tendsto g (𝓝[slitDomain η t] (η t)) (𝓝 (W t : ℂ))

/-- Möbius map `ℍ → 𝔻`, `0 ↦ -1`, `∞ ↦ 1`. -/
def mob (z : ℂ) : ℂ := (z - Complex.I) / (z + Complex.I)

/-- `Γ` is a reparametrisation to `[0,1]` of `f ∘ mob ∘ η` (ending at `f 1 = b`). -/
def IsSLECurve (f : ℂ → ℂ) (η : ℝ → ℂ) (Γ : unitInterval → ℂ) : Prop :=
  ∃ θ : ℝ → ℝ, θ 0 = 0 ∧ ContinuousOn θ (Set.Ico 0 1) ∧ StrictMonoOn θ (Set.Ico 0 1) ∧
    Tendsto θ (𝓝[<] 1) atTop ∧
    (∀ s : unitInterval, (s : ℝ) < 1 → Γ s = f (mob (η (θ s)))) ∧ Γ 1 = f 1

/-- A probability space with `W = √3 B` and a Borel random curve `Γ` that is a.s. chordal SLE₃ in
`(f(𝔻), f(-1), f(1))`. -/
def IsSLE3Setup (f : ℂ → ℂ) {Ω' : Type} [MeasurableSpace Ω'] (P : Measure Ω')
    (W : ℝ → Ω' → ℝ) (Γ : Ω' → C(unitInterval, ℂ)) : Prop :=
  IsProbabilityMeasure P ∧ IsBM P W 3 ∧
  @Measurable Ω' C(unitInterval, ℂ) _ (borel C(unitInterval, ℂ)) Γ ∧
  ∀ᵐ ω ∂P, ∃ η : ℝ → ℂ, DrivenBy η (fun t : ℝ => W t ω) ∧
    Tendsto (fun t : ℝ => ‖η t‖) atTop atTop ∧ IsSLECurve f η (Γ ω)

def Claim : Prop :=
  ∃ βc : ℝ, 0 < βc ∧ (∃ 𝒯 : Set (Set ℂ), IsHatTiling 𝒯) ∧
  (∀ 𝒯 : Set (Set ℂ), IsHatTiling 𝒯 → ∀ (x : 𝒯) (β : ℝ), 0 < β →
      (β ≤ βc → mPlus 𝒯 β x = 0) ∧ (βc < β → 0 < mPlus 𝒯 β x)) ∧
  ∀ 𝒯 : Set (Set ℂ), IsHatTiling 𝒯 → ∀ f : ℂ → ℂ, IsJordanMap f →
    (∃ (Ω' : Type) (_ : MeasurableSpace Ω') (P : Measure Ω') (W : ℝ → Ω' → ℝ)
        (Γ : Ω' → C(unitInterval, ℂ)), IsSLE3Setup f P W Γ) ∧
    ∀ (Ω' : Type) [MeasurableSpace Ω'] (P : Measure Ω') (W : ℝ → Ω' → ℝ)
      (Γ : Ω' → C(unitInterval, ℂ)), IsSLE3Setup f P W Γ →
    ∀ (δ : ℕ → ℝ) (Dd : ℕ → DiscDomain 𝒯), (∀ n : ℕ, 0 < δ n) → Tendsto δ atTop (𝓝 0) →
      (∀ n : ℕ, (Dd n).IsDisc) → DomConv f δ Dd →
    ∀ sel : (n : ℕ) → ((Dd n).D → Bool) → List ℂ,
      (∀ (n : ℕ) (σ : (Dd n).D → Bool), (Dd n).ValidTrail σ (sel n σ)) →
    ∀ F : (unitInterval → ℂ) → ℝ, TestFn F →
      Tendsto (fun n : ℕ => expect βc (Dd n) (δ n) (sel n) F) atTop
        (𝓝 (∫ ω, F (Γ ω) ∂P))

end
end OpenProblems.QEDM148
