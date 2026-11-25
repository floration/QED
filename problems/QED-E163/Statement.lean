import Mathlib
/-! QED-E163: Planar graphs with no cycles of length 4, 5 or 6: always 3-colourable?
Forbidding short cycles makes planar graphs easier to colour. Planar graphs with no cycles of
length 4, 5, 6 or 7 can always be properly 3-coloured, while forbidding only lengths 4 and 5 is not
enough (2017 counterexample). Decide the remaining case: is every planar graph with no cycle of
length 4, 5 or 6 3-colourable?
Informal statement: Let G be a finite simple planar graph with no cycle of length 4, 5 or 6
(triangles and cycles of length ≥ 7 allowed). Must χ(G) ≤ 3?
Formalization notes:
* Finite simple graphs are `SimpleGraph (Fin n)`.
* Planarity: by Wagner's theorem a finite graph is planar iff it has neither K₅ nor K₃,₃ as a
  minor; we take this as the definition. Minors are given by branch sets: pairwise disjoint vertex
  sets each inducing a connected subgraph (Mathlib's `Connected` includes nonemptiness), with an
  edge between the branch sets of adjacent vertices of the minor (same block as other QED
  planarity statements).
* "No cycle of length ℓ": no closed walk `p : G.Walk v v` with `p.IsCycle` and `p.length = ℓ`
  (Mathlib cycles have length ≥ 3 and visit distinct vertices), for ℓ ∈ {4,5,6}.
* 3-colourable: Mathlib's `G.Colorable 3`.
* Proving `Claim` = every such graph is 3-colourable (so k* = 6); `¬Claim` = an explicit finite
  planar graph without 4-,5-,6-cycles that is not 3-colourable (so k* = 7).
-/
namespace OpenProblems.QEDE163
noncomputable section

/-- `H` is a minor of `G` (branch-set definition). -/
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

/-- `G` has no cycle of length 4, 5 or 6. -/
def No456Cycles {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∀ (v : Fin n) (p : G.Walk v v), p.IsCycle → p.length ≠ 4 ∧ p.length ≠ 5 ∧ p.length ≠ 6

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), Planar G → No456Cycles G → G.Colorable 3

end
end OpenProblems.QEDE163
