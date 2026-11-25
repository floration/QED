import Mathlib
/-! QED-M067: Ringel for forests
Ringel's conjecture (a theorem for large n, by Montgomery-Pokrovskiy-Sudakov and Keevash-Staden)
says K_{2m+1} decomposes into 2m+1 copies of any tree with m edges. Does the same hold for every
forest with m edges (and no isolated vertices)?
Informal statement: Prove that for every m ≥ 1 and every forest F with m edges and no isolated
vertices, E(K_{2m+1}) can be partitioned into 2m+1 subgraphs each isomorphic to F.
(Stronger form, not formalized here: every such F has a ρ-labelling, an injective
f : V(F) → ℤ_{2m+1} whose edge lengths min(|f(u)−f(v)|, 2m+1−|f(u)−f(v)|) are exactly 1,…,m.)
Formalization notes: A forest is a `SimpleGraph (Fin k)` that is acyclic (`IsAcyclic`), with
every vertex having a neighbour (no isolated vertices) and exactly m edges (`edgeSet.ncard`, which
is finite here). Then k ≤ 2m < 2m+1. A decomposition is a family of 2m+1 injective vertex maps
φ_i : Fin k ↪ Fin (2m+1) such that every edge {a,b} of K_{2m+1} is the image of exactly one pair
(i, e) with e an edge of F; the i-th copy is the subgraph with edge set φ_i(E(F)), which is
isomorphic to F because F has no isolated vertices. Uniqueness makes the copies edge-disjoint;
existence makes them cover. Proving `Claim` proves the forest version for all m; `¬Claim` means
exhibiting a forest (without isolated vertices) with no such decomposition. Computer search
found ρ-labellings for all such forests with m ≤ 9.
-/
namespace OpenProblems.QEDM067

/-- `φ` decomposes the edges of `K_{2m+1}` into `2m+1` copies of `F`. -/
def IsDecomposition (k m : ℕ) (F : SimpleGraph (Fin k))
    (φ : Fin (2 * m + 1) → (Fin k ↪ Fin (2 * m + 1))) : Prop :=
  ∀ a b : Fin (2 * m + 1), a ≠ b →
    ∃! ie : Fin (2 * m + 1) × Sym2 (Fin k),
      ie.2 ∈ F.edgeSet ∧ Sym2.map (⇑(φ ie.1)) ie.2 = s(a, b)

def Claim : Prop :=
  ∀ m k : ℕ, 1 ≤ m → ∀ F : SimpleGraph (Fin k),
    F.IsAcyclic → (∀ v : Fin k, ∃ w : Fin k, F.Adj v w) → F.edgeSet.ncard = m →
      ∃ φ : Fin (2 * m + 1) → (Fin k ↪ Fin (2 * m + 1)), IsDecomposition k m F φ

end OpenProblems.QEDM067
