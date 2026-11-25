import Mathlib
/-! QED-M066: Graceful labellings of forests
A forest with m edges and c trees has n = m + c vertices. Label them bijectively with
0, 1, …, n − 1 so that the m edge differences |ℓ(u) − ℓ(v)| are pairwise distinct. Show that
every forest has such a labelling. (The case tree + isolated vertex says every tree has an
injective labelling into {0, …, m+1} with distinct edge differences.)
Informal statement: Every forest F with m edges and c ≥ 1 components has a bijection
ℓ : V(F) → {0, 1, …, m + c − 1} such that the values |ℓ(u) − ℓ(v)|, uv ∈ E(F), are pairwise
distinct.
Formalization notes: A forest on n vertices is an acyclic `SimpleGraph (Fin n)`
(`SimpleGraph.IsAcyclic`); for a forest m + c = n, so the label set {0, …, m+c−1} is
{0, …, n−1} and a bijective labelling is an equivalence `ℓ : Fin n ≃ Fin n`. Differences are
computed in ℤ (no ℕ subtraction). "Pairwise distinct over edges" is: if two adjacent pairs
(u,v), (u',v') have equal differences then they are the same unordered edge. n = 0 (c = 0) is
included but trivial. Proving `Claim` proves the statement for all forests (it would follow
from the Graceful Tree Conjecture); `¬Claim` = an explicit forest with no such labelling.
-/
namespace OpenProblems.QEDM066

/-- A bijective labelling `ℓ : Fin n ≃ Fin n` of the vertices of `G` whose edge differences
are pairwise distinct. -/
def DistinctDiffLabelling {n : ℕ} (G : SimpleGraph (Fin n)) (ℓ : Fin n ≃ Fin n) : Prop :=
  ∀ u v u' v' : Fin n, G.Adj u v → G.Adj u' v' →
    |((ℓ u : ℕ) : ℤ) - ((ℓ v : ℕ) : ℤ)| = |((ℓ u' : ℕ) : ℤ) - ((ℓ v' : ℕ) : ℤ)| →
    (u = u' ∧ v = v') ∨ (u = v' ∧ v = u')

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), G.IsAcyclic →
    ∃ ℓ : Fin n ≃ Fin n, DistinctDiffLabelling G ℓ

end OpenProblems.QEDM066
