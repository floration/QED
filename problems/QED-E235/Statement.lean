import Mathlib
/-! QED-E235: Is tiling by a single polykite decidable?
A polykite is a shape glued from kites of the kite grid (the hat monotile is one). Find an algorithm that decides, for any single polykite, whether copies of it can tile the plane, or prove that no such algorithm exists.
Informal statement: Let $\mathcal K$ be the deltoidal trihexagonal (Laves $[3.4.6.4]$) tiling of $\mathbb R^2$ by congruent kites. A polykite is a union $P$ of finitely many tiles of $\mathcal K$ that is a closed topological disk. $P$ tiles the plane if $\mathbb R^2=\bigcup_j g_j(P)$ with $g_j$ isometries of $\mathbb R^2$ (reflections allowed) and the $g_j(P)$ having pairwise disjoint interiors. Is the set $\{P:\ P$ tiles the plane$\}$ decidable? (Variant: restrict to $g_j$ in the symmetry group of $\mathcal K$, i.e. kite-grid-aligned tilings.)
Formalization notes:
* Kite grid: hex coordinates `(a,b) ↦ a + b/2 + i(√3/2) b` (as in QED-E096). The underlying hexagonal tiling has
  hexagon centres at the lattice `{(4s + 2t, −2s + 2t) : s, t ∈ ℤ}`, hexagon vertices at `centre + vtx d`
  (d ∈ Fin 6, circumradius 2) and edge midpoints at `centre + mid d` (`mid d` = midpoint of `vtx d`, `vtx (d+1)`,
  inradius √3). Every kite of 𝒦 is uniquely `convexHull {c, c + mid (d−1), c + vtx d, c + mid d}` for a centre c
  and d ∈ Fin 6 (each kite lies in exactly one hexagon, six per hexagon). Sanity check: the hat of QED-E096 is
  the union of the kites (c, d) = ((0,0),0), ((0,0),1), ((0,0),4), ((0,0),5), ((4,−2),1), ((4,−2),2),
  ((2,2),3), ((2,2),4), i.e. its 8 kites are of this form (checked by hand against the E096 kite list).
* Input encoding: a list of triples `(s, t, d) ∈ ℕ³` meaning the kite with centre `(4s+2t, −2s+2t)` and direction
  `d mod 6`. Centres are restricted to s, t ≥ 0: any finite polykite has a lattice translate of this form, and
  tileability is invariant under isometries, so nothing is lost; duplicates are harmless. This makes the input
  type `List (ℕ × ℕ × ℕ)`, which is `Primcodable`.
* Disk condition: `P` homeomorphic to the closed unit disk. Inputs that are not disks (incl. the empty list) are
  "no" instances. Being a disk is a decidable combinatorial property of a finite union of grid kites, so
  `Claim` is equivalent to decidability of tiling restricted to genuine polykites.
* Tiling: a set `T` of isometric copies `g '' P` (`g : ℂ ≃ᵢ ℂ`, reflections allowed, not necessarily grid-aligned)
  covering ℂ with pairwise disjoint interiors.
* `Claim` = `ComputablePred` (Mathlib's computability, via partial recursive functions) of "is a polykite and
  tiles the plane"; `¬Claim` = undecidable. The grid-aligned variant is not encoded.
-/
namespace OpenProblems.QEDE235
noncomputable section

/-- Hex-grid point `(a, b) ↦ a + b/2 + i·(√3/2)·b`. -/
def hexPt (p : ℤ × ℤ) : ℂ := ⟨(p.1 : ℝ) + (p.2 : ℝ) / 2, Real.sqrt 3 / 2 * (p.2 : ℝ)⟩

/-- Hexagon vertices relative to the centre (hex coordinates). -/
def vtx : Fin 6 → ℤ × ℤ := ![(2, 0), (0, 2), (-2, 2), (-2, 0), (0, -2), (2, -2)]

/-- Hexagon edge midpoints relative to the centre: `mid d` is the midpoint of `vtx d` and `vtx (d+1)`. -/
def mid : Fin 6 → ℤ × ℤ := ![(1, 1), (-1, 2), (-2, 1), (-1, -1), (1, -2), (2, -1)]

/-- The kite of the grid with centre `c` (hex coordinates) and direction `d`. -/
def kite (c : ℤ × ℤ) (d : Fin 6) : Set ℂ :=
  convexHull ℝ {hexPt c, hexPt (c + mid (d - 1)), hexPt (c + vtx d), hexPt (c + mid d)}

/-- Decode a triple `(s, t, d)` to a kite: centre `(4s+2t, -2s+2t)`, direction `d mod 6`. -/
def kiteOf (x : ℕ × ℕ × ℕ) : Set ℂ :=
  kite (4 * (x.1 : ℤ) + 2 * (x.2.1 : ℤ), -2 * (x.1 : ℤ) + 2 * (x.2.1 : ℤ)) (⟨x.2.2 % 6, Nat.mod_lt _ (by norm_num)⟩ : Fin 6)

/-- The union of the listed kites. -/
def shape (L : List (ℕ × ℕ × ℕ)) : Set ℂ := ⋃ x ∈ L, kiteOf x

/-- `P` is a closed topological disk. -/
def IsDisk (P : Set ℂ) : Prop := Nonempty (P ≃ₜ Metric.closedBall (0 : ℂ) 1)

/-- Isometric copies of `P` (reflections allowed) tile the plane. -/
def Tiles (P : Set ℂ) : Prop :=
  ∃ T : Set (Set ℂ), (∀ t ∈ T, ∃ g : ℂ ≃ᵢ ℂ, t = g '' P) ∧ ⋃₀ T = Set.univ ∧
    ∀ s ∈ T, ∀ t ∈ T, s ≠ t → Disjoint (interior s) (interior t)

/-- Tiling by a single polykite is decidable. -/
def Claim : Prop :=
  ComputablePred (fun L : List (ℕ × ℕ × ℕ) => IsDisk (shape L) ∧ Tiles (shape L))

end
end OpenProblems.QEDE235
