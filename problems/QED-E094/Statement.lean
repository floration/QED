import Mathlib
/-! QED-E094: Graceful labellings of forests
Informal statement (narrowed per referee): every forest F with m edges and c ≥ 2 components
has a bijection ℓ : V(F) → {0, 1, …, m + c − 1} such that the values |ℓ(u) − ℓ(v)|, uv ∈ E(F),
are pairwise distinct. (Key case F = T ⊔ K₁: every tree with m edges has an injective labelling
into {0, …, m+1} with distinct edge differences.) The case c = 1 is the graceful tree
conjecture and is excluded.
Formalization notes: a forest on n vertices is an acyclic `SimpleGraph (Fin n)`
(`SimpleGraph.IsAcyclic`); for a forest m + c = n, so c ≥ 2 is m + 2 ≤ n with m the number of
edges (`Nat.card G.edgeSet`, finite since the vertex type is finite, so no ncard junk). The
label set {0, …, m+c−1} is {0, …, n−1} and a bijective labelling is an equivalence
`ℓ : Fin n ≃ Fin n`. Differences are computed in ℤ. "Pairwise distinct over edges": if two
adjacent pairs (u,v), (u',v') have equal differences then they are the same unordered edge.
`¬Claim` = an explicit forest with ≥ 2 components and no such labelling.
-/
namespace OpenProblems.QEDE094

/-- A bijective labelling `ℓ : Fin n ≃ Fin n` of the vertices of `G` whose edge differences
are pairwise distinct. -/
def DistinctDiffLabelling {n : ℕ} (G : SimpleGraph (Fin n)) (ℓ : Fin n ≃ Fin n) : Prop :=
  ∀ u v u' v' : Fin n, G.Adj u v → G.Adj u' v' →
    |((ℓ u : ℕ) : ℤ) - ((ℓ v : ℕ) : ℤ)| = |((ℓ u' : ℕ) : ℤ) - ((ℓ v' : ℕ) : ℤ)| →
    (u = u' ∧ v = v') ∨ (u = v' ∧ v = u')

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), G.IsAcyclic → Nat.card G.edgeSet + 2 ≤ n →
    ∃ ℓ : Fin n ≃ Fin n, DistinctDiffLabelling G ℓ

end OpenProblems.QEDE094
