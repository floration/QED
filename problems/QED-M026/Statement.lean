import Mathlib
/-! QED-M026: The complex of planar graphs
Planar graphs on n labelled vertices form a simplicial complex Πₙ on the vertex set E(Kₙ) (deleting an edge keeps a graph
planar); it is pure of dimension 3n − 7. For n = 6 its rational reduced homology is ℚ^15 in degree 9 = 3n − 9 and zero
elsewhere, while its mod-2 homology also has classes in degrees 10 and 11, so it is not a wedge of spheres.
Informal statement: Let Πₙ be the simplicial complex on vertex set E(Kₙ) whose faces are edge sets of planar graphs.
Determine H̃_*(Πₙ; ℤ), or at least H̃_*(Πₙ; ℚ). Main question (a): is H̃_*(Πₙ; ℚ) concentrated in degree 3n − 9 for all
n ≥ 6? (Further: its rank and Sₙ-module structure; whether H̃_{3n−7}(Πₙ; 𝔽₂) ≠ 0 for all n ≥ 5; whether all torsion is
2-torsion.)
Formalization notes: Claim formalizes question (a) only (the main yes/no question): for all n ≥ 6 the rational reduced
Betti numbers vanish in every degree other than 3n − 9 ("concentrated" does not assert non-vanishing there).
Edges of Kₙ are pairs (i, j) with i < j in Fin n, linearly ordered by the key i·n + j. Planarity is defined by Wagner's
theorem: no K₅ minor and no K₃,₃ minor, where a minor model is a family of pairwise disjoint vertex sets, each inducing a
connected subgraph, with an edge between the required pairs. `Face n j` = planar edge sets of size j (simplices of
dimension j − 1; the empty face gives the augmentation, so homology is reduced). `bd n j` is the oriented boundary
matrix from size-(j+1) faces to size-j faces, with sign (−1)^(position of the removed edge). The reduced Betti number in
degree j − 1 is `redBetti n j` = dim C_j − rank(∂ out of C_j) − rank(∂ into C_j), computed over ℚ with `Matrix.rank`.
Degree 3n − 9 corresponds to face size 3n − 8. Proving Claim = concentration for all n ≥ 6; ¬Claim = some n ≥ 6 with
nonzero rational homology in another degree.
-/
namespace OpenProblems.QEDM026

/-- Edges of `Kₙ`: ordered pairs `(i, j)` with `i < j`. -/
abbrev Edge (n : ℕ) := {p : Fin n × Fin n // p.1 < p.2}

/-- A linear-order key on edges, used for orientation signs. -/
def edgeKey {n : ℕ} (e : Edge n) : ℕ := e.1.1.val * n + e.1.2.val

/-- The simple graph on `Fin n` with edge set `s`. -/
def graphOf {n : ℕ} (s : Finset (Edge n)) : SimpleGraph (Fin n) :=
  SimpleGraph.fromRel (fun u v => ∃ e ∈ s, e.1.1 = u ∧ e.1.2 = v)

/-- `G` has a `K₅` minor. -/
def HasK5Minor {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ B : Fin 5 → Set (Fin n),
    (∀ i, (SimpleGraph.induce (B i) G).Connected) ∧
    (∀ i j, i ≠ j → Disjoint (B i) (B j)) ∧
    (∀ i j, i ≠ j → ∃ u ∈ B i, ∃ v ∈ B j, G.Adj u v)

/-- `G` has a `K₃,₃` minor (branch sets `0,1,2` on one side, `3,4,5` on the other). -/
def HasK33Minor {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ B : Fin 6 → Set (Fin n),
    (∀ i, (SimpleGraph.induce (B i) G).Connected) ∧
    (∀ i j, i ≠ j → Disjoint (B i) (B j)) ∧
    (∀ i j : Fin 6, i.val < 3 → 3 ≤ j.val → ∃ u ∈ B i, ∃ v ∈ B j, G.Adj u v)

/-- Planarity, via Wagner's theorem. -/
def IsPlanar {n : ℕ} (G : SimpleGraph (Fin n)) : Prop := ¬ HasK5Minor G ∧ ¬ HasK33Minor G

/-- Faces of `Πₙ` with `j` elements (simplices of dimension `j - 1`). -/
abbrev Face (n j : ℕ) := {s : Finset (Edge n) // s.card = j ∧ IsPlanar (graphOf s)}

noncomputable instance instFintypeFace (n j : ℕ) : Fintype (Face n j) := Fintype.ofFinite _

/-- Oriented boundary matrix from faces of size `j + 1` (columns) to faces of size `j` (rows). -/
noncomputable def bd (n j : ℕ) : Matrix (Face n j) (Face n (j + 1)) ℚ :=
  fun τ σ =>
    if τ.1 ⊆ σ.1 then
      (-1 : ℚ) ^ (σ.1.filter (fun f => ∀ e ∈ σ.1 \ τ.1, edgeKey f < edgeKey e)).card
    else 0

/-- Rational reduced Betti number of `Πₙ` in degree `j - 1` (faces of size `j`). -/
noncomputable def redBetti (n : ℕ) : ℕ → ℕ
  | 0 => Fintype.card (Face n 0) - (bd n 0).rank
  | (j + 1) => Fintype.card (Face n (j + 1)) - (bd n j).rank - (bd n (j + 1)).rank

def Claim : Prop :=
  ∀ n : ℕ, 6 ≤ n → ∀ j : ℕ, j ≠ 3 * n - 8 → redBetti n j = 0

end OpenProblems.QEDM026
