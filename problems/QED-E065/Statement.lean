import Mathlib
/-! QED-E065: Is there an aperiodic polyomino?
A polyomino is a shape made of unit squares glued edge to edge with no holes. In 2023 a single tile was found that tiles the plane only non-periodically, but it is built from kites, not squares. Is there a polyomino that tiles the plane (rotations and reflections allowed) but has no tiling that a translation maps onto itself?
Informal statement: A polyomino is a finite $P\subset\mathbb Z^2$ such that the union of the closed unit squares $c+[0,1]^2$, $c\in P$, is a closed topological disk. A tiling by $P$ is a set $\mathcal T$ of tiles $g(P)$, with $g(x)=Ax+b$, $A\in D_4\subset GL_2(\mathbb Z)$ and $b\in\mathbb Z^2$, that partition $\mathbb Z^2$. $P$ is aperiodic if some tiling exists but no tiling satisfies $\mathcal T+v=\mathcal T$ for any $v\in\mathbb Z^2\setminus\{0\}$. Board Claim: an aperiodic polyomino exists.
Formalization notes:
* Cells are `ℤ × ℤ` (cell `c` is the closed square `c + [0,1]²`). Two cells are 4-adjacent
  (`Adj4`) if they share an edge (`|Δx| + |Δy| = 1`). `Conn4 S`: any two cells of `S` are joined by
  a path of 4-adjacent cells inside `S`.
* Polyomino (`IsPolyomino`): `P` finite (a `Finset`), nonempty, `P` 4-connected, and the complement
  `ℤ² \ P` 4-connected. This is the standard combinatorial characterization of "the union of the
  squares is a closed topological disk": if both are 4-connected then there are no holes (a bounded
  complement component would be a separate 4-component) and no pinch points (two diagonal cells of
  `P` whose other two neighbours at that corner are outside `P`: a 4-path in `P` joining the two
  diagonal cells closes up, with the diagonal, into an 8-connected closed curve of cells, which
  encloses one of the two outside corner cells and so cuts it off from the infinite complement,
  since 4-paths cannot cross 8-closed curves). Without holes or pinches the union is a compact
  connected 2-manifold with boundary in the plane with connected complement, hence a disk; the
  converse is immediate. (Using a homeomorphism to the closed disk directly would make
  any existence proof require a Schoenflies-type argument for the specific tile, so the
  combinatorial form is used.)
* `D₄` is enumerated as `Bool × Bool × Bool`: optionally swap coordinates, then optionally negate
  each coordinate. These are exactly the 8 signed permutation matrices, i.e. the full dihedral
  group `D₄ ⊂ GL₂(ℤ)` of the square lattice. Placed copy: `place P g b = {d4 g c + b | c ∈ P}`.
  (Applying `A` to cell labels rather than to squares just reindexes the cells of the image
  square set by a fixed lattice translation, which is absorbed into `b`.)
* A tiling is a SET of placed copies (sets of cells), not a family of placements, so a tile with
  symmetries is not counted twice; every cell lies in exactly one tile. Tiling `ℤ²` by cells is the
  same as tiling the plane by the closed unit squares (with interiors disjoint).
* Periodic: `T + v = T` for some `v ≠ 0` (translation of the set of tiles). `Aperiodic P`: some
  tiling exists and no tiling has any nonzero period (as in the informal statement). For a single
  tile in `ℤ²` (a 2D shift of finite type) this coincides with "no doubly periodic tiling", since
  a tiling with one period yields a doubly periodic one.
* `Claim` = an aperiodic polyomino exists. `¬Claim` = every polyomino that tiles the plane with
  rotations/reflections also admits a tiling with a nonzero translational period. Neither is
  vacuous: `IsTiling` is satisfiable (e.g. the monomino) and forces all tiles to be copies of `P`.
  The variant allowing holes (dropping the complement condition) is not encoded.
-/
namespace OpenProblems.QEDE065
noncomputable section

/-- Edge adjacency of cells. -/
def Adj4 (a b : ℤ × ℤ) : Prop := |a.1 - b.1| + |a.2 - b.2| = 1

/-- `S` is 4-connected: any two of its cells are joined by an edge-adjacent path inside `S`. -/
def Conn4 (S : Set (ℤ × ℤ)) : Prop :=
  ∀ a ∈ S, ∀ b ∈ S,
    Relation.ReflTransGen (fun x y : ℤ × ℤ => x ∈ S ∧ y ∈ S ∧ Adj4 x y) a b

/-- Polyomino (simply connected): nonempty, 4-connected, with 4-connected complement. -/
def IsPolyomino (P : Finset (ℤ × ℤ)) : Prop :=
  P.Nonempty ∧ Conn4 (P : Set (ℤ × ℤ)) ∧ Conn4 ((P : Set (ℤ × ℤ))ᶜ)

/-- The 8 elements of `D₄ ⊂ GL₂(ℤ)`: optional coordinate swap, then optional sign changes. -/
def d4 (g : Bool × Bool × Bool) (c : ℤ × ℤ) : ℤ × ℤ :=
  let s : ℤ × ℤ := if g.1 then (c.2, c.1) else c
  ((if g.2.1 then -s.1 else s.1), (if g.2.2 then -s.2 else s.2))

/-- The copy `g(P) + b` of `P`. -/
def place (P : Finset (ℤ × ℤ)) (g : Bool × Bool × Bool) (b : ℤ × ℤ) : Set (ℤ × ℤ) :=
  {z : ℤ × ℤ | ∃ c ∈ P, z = d4 g c + b}

/-- `T` is a tiling of `ℤ²` by isometric copies of `P`. -/
def IsTiling (P : Finset (ℤ × ℤ)) (T : Set (Set (ℤ × ℤ))) : Prop :=
  (∀ t ∈ T, ∃ g : Bool × Bool × Bool, ∃ b : ℤ × ℤ, t = place P g b) ∧
    ∀ z : ℤ × ℤ, ∃! t : Set (ℤ × ℤ), t ∈ T ∧ z ∈ t

/-- Translate every tile of `T` by `v`. -/
def translateTiling (v : ℤ × ℤ) (T : Set (Set (ℤ × ℤ))) : Set (Set (ℤ × ℤ)) :=
  {t : Set (ℤ × ℤ) | ∃ s ∈ T, t = (fun z : ℤ × ℤ => z + v) '' s}

/-- `P` tiles, but no tiling by `P` has a nonzero translational period. -/
def Aperiodic (P : Finset (ℤ × ℤ)) : Prop :=
  (∃ T : Set (Set (ℤ × ℤ)), IsTiling P T) ∧
    ∀ T : Set (Set (ℤ × ℤ)), IsTiling P T → ∀ v : ℤ × ℤ, v ≠ 0 → translateTiling v T ≠ T

/-- There exists an aperiodic (simply connected) polyomino. -/
def Claim : Prop :=
  ∃ P : Finset (ℤ × ℤ), IsPolyomino P ∧ Aperiodic P

end
end OpenProblems.QEDE065
