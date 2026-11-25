import Mathlib
/-! QED-E026: Total colouring of planar graphs with maximum degree 6
A total colouring colours both vertices and edges so that touching objects (adjacent vertices, edges sharing an end, an edge and its endpoint) get different colours. It is conjectured that Δ+2 colours always suffice, where Δ is the maximum degree. For planar graphs this is proved for every Δ except Δ=6: show every planar graph with maximum degree 6 has a total colouring with 8 colours.
Informal statement: Prove that every simple planar graph $G$ with $\Delta(G)=6$ satisfies $\chi''(G)\le 8$ (or find a counterexample).
Formalization notes:
* Graphs: finite simple graphs, w.l.o.g. on vertex set `Fin n` (every finite graph is isomorphic
  to one; all notions here are isomorphism-invariant).
* Planarity: by Wagner's theorem a finite graph is planar (has an embedding in the plane) iff it
  has neither K₅ nor K₃,₃ as a minor; we take this as the definition. Minors are given by branch
  sets: pairwise disjoint vertex sets each inducing a connected subgraph (Mathlib's `Connected`
  includes nonemptiness), with an edge between the branch sets of adjacent vertices of the minor.
* Maximum degree exactly 6: every vertex has at most 6 neighbours and some vertex has exactly 6
  (degrees as `Set.ncard` of the neighbour set, which is finite).
* Total colouring with 8 colours: a vertex colouring `cv : Fin n → Fin 8` and an edge colouring
  `ce : Sym2 (Fin n) → Fin 8` (only values on edges matter) such that adjacent vertices get
  different colours, two distinct edges at a common vertex get different colours, and each edge
  differs from both its endpoints (the condition is stated for every ordered adjacent pair, so
  it covers both endpoints since `Sym2.mk (u,v) = Sym2.mk (v,u)`). This is exactly χ''(G) ≤ 8.
* Proving `Claim` = the Δ = 6 case of the Total Colouring Conjecture for planar graphs.
  Proving `¬Claim` = a planar graph with Δ = 6 and χ'' ≥ 9.
-/
namespace OpenProblems.QEDE026
noncomputable section

/-- `H` is a minor of `G`: there are pairwise disjoint branch sets `B w ⊆ V`, each inducing a
connected (in particular nonempty) subgraph of `G`, with a `G`-edge between `B w` and `B w'`
whenever `w w'` is an edge of `H`. -/
def IsMinor {V W : Type} (H : SimpleGraph W) (G : SimpleGraph V) : Prop :=
  ∃ B : W → Set V,
    (∀ w : W, (G.induce (B w)).Connected) ∧
    (∀ w w' : W, w ≠ w' → Disjoint (B w) (B w')) ∧
    (∀ w w' : W, H.Adj w w' → ∃ x ∈ B w, ∃ y ∈ B w', G.Adj x y)

/-- The complete graph `K₅`. -/
def K5 : SimpleGraph (Fin 5) := ⊤

/-- The complete bipartite graph `K₃,₃`. -/
def K33 : SimpleGraph (Fin 3 ⊕ Fin 3) := completeBipartiteGraph (Fin 3) (Fin 3)

/-- Planarity of a finite simple graph, via Wagner's theorem: no `K₅` and no `K₃,₃` minor. -/
def Planar {V : Type} (G : SimpleGraph V) : Prop :=
  ¬ IsMinor K5 G ∧ ¬ IsMinor K33 G


/-- A total colouring of `G` with colours `Fin k`. -/
def IsTotalColouring {n k : ℕ} (G : SimpleGraph (Fin n)) (cv : Fin n → Fin k)
    (ce : Sym2 (Fin n) → Fin k) : Prop :=
  (∀ u v : Fin n, G.Adj u v → cv u ≠ cv v) ∧
  (∀ u v : Fin n, G.Adj u v → ce (s(u, v)) ≠ cv u) ∧
  (∀ u v w : Fin n, G.Adj u v → G.Adj u w → v ≠ w →
    ce (s(u, v)) ≠ ce (s(u, w)))

/-- Maximum degree exactly `6`. -/
def MaxDegSix {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  (∀ v : Fin n, (G.neighborSet v).ncard ≤ 6) ∧ ∃ v : Fin n, (G.neighborSet v).ncard = 6

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), Planar G → MaxDegSix G →
    ∃ (cv : Fin n → Fin 8) (ce : Sym2 (Fin n) → Fin 8), IsTotalColouring G cv ce

end
end OpenProblems.QEDE026
