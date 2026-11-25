import Mathlib
/-! QED-E029: Oriented chromatic number of planar graphs (18 vs 80)
Orient every edge of a planar graph. An oriented colouring colours vertices so adjacent vertices differ and all arcs between two colour classes point the same way. Every oriented planar graph can be coloured with 80 colours, and some need 18. The gap has barely moved since 1994: narrow it.
Informal statement: Let $\chi_o(\mathcal P)=\max\chi_o(\vec G)$ over orientations $\vec G$ of simple planar graphs, where $\chi_o(\vec G)$ is the least order of a tournament $T$ admitting a homomorphism $\vec G\to T$. Known: $18\le\chi_o(\mathcal P)\le80$ (upper bound: Raspaud–Sopena 1994). Formal target (strict improvement of the UPPER bound): prove $\chi_o(\mathcal P)\le 79$, i.e. every oriented planar graph has an oriented colouring with 79 colours. (Improving the lower bound, an oriented planar graph with $\chi_o\ge19$, is the other direction and is not what `Claim` asks.)
Formalization notes:
* Oriented graphs: a relation `A` on `Fin n` (arcs `u → v`) that is asymmetric (`A u v → ¬A v u`,
  hence also irreflexive: no loops, no digons). Its underlying simple graph is
  `SimpleGraph.fromRel A` (u ~ v iff u ≠ v and an arc joins them). Every orientation of a finite
  simple graph arises this way, up to relabelling vertices by `Fin n`.
* Planarity of the underlying graph via Wagner's theorem: no K₅ and no K₃,₃ minor (branch-set
  definition of minors; Mathlib's `Connected` includes nonemptiness).
* Oriented k-colouring: `f : Fin n → Fin k` with `f u ≠ f v` on every arc, and no two arcs in
  opposite directions between two colour classes (`A u v`, `A x y`, `f u = f y` forces
  `f v ≠ f x`). Such `f` is exactly a homomorphism to an oriented graph on ≤ k vertices, which
  extends to a tournament on k vertices; so this is χ_o ≤ k.
* Proving `Claim` = χ_o(𝒫) ≤ 79. Proving `¬Claim` = some oriented planar graph needs ≥ 80
  colours, i.e. (with Raspaud–Sopena) χ_o(𝒫) = 80.
-/
namespace OpenProblems.QEDE029
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


/-- `f` is an oriented colouring of the oriented graph `A` with colours `Fin k`. -/
def IsOrientedColouring {n k : ℕ} (A : Fin n → Fin n → Prop) (f : Fin n → Fin k) : Prop :=
  (∀ u v : Fin n, A u v → f u ≠ f v) ∧
  (∀ u v x y : Fin n, A u v → A x y → f u = f y → f v ≠ f x)

def Claim : Prop :=
  ∀ (n : ℕ) (A : Fin n → Fin n → Prop), (∀ u v : Fin n, A u v → ¬ A v u) →
    Planar (SimpleGraph.fromRel A) →
    ∃ f : Fin n → Fin 79, IsOrientedColouring A f

end
end OpenProblems.QEDE029
