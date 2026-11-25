import Mathlib
/-! QED-M127: Are graphs with no K7 minor 7-colourable?
Graphs with no K7 minor are known to be 8-colourable, and the t = 7 case of Hadwiger's
conjecture predicts 6 colours, but even 7 colours is open. Prove or disprove that every graph
with no K7 minor is properly 7-colourable.
Informal statement: Let G be a finite simple graph with no K₇ minor, i.e. there are no pairwise
disjoint nonempty sets B₁,…,B₇ ⊆ V(G) with each G[Bᵢ] connected and at least one edge between
Bᵢ and Bⱼ for all i ≠ j. Claim: χ(G) ≤ 7. (Known: χ(G) ≤ 8.)
Formalization notes: Finite graphs are taken on vertex type `Fin n` (every finite simple graph
is isomorphic to one of these, and both minor-containment and colourability are isomorphism
invariant). `HasCliqueMinor G t` is the branch-set definition of a K_t minor: t sets of
vertices, each inducing a connected subgraph (`SimpleGraph.Connected` of the induced graph
`G.induce (B i)`, which includes nonemptiness), pairwise disjoint, and pairwise joined by an
edge. This is the standard equivalent of "K_t is obtained from G by deleting and contracting".
Colourability is Mathlib's `SimpleGraph.Colorable` (a proper colouring with colours in `Fin 7`).
`Claim` = every K₇-minor-free finite graph is 7-colourable; `¬Claim` = an explicit finite
K₇-minor-free graph with chromatic number 8.
-/
namespace OpenProblems.QEDM127
noncomputable section

/-- `G` has a `K_t` minor, via branch sets. -/
def HasCliqueMinor {V : Type} (G : SimpleGraph V) (t : ℕ) : Prop :=
  ∃ B : Fin t → Set V,
    (∀ i : Fin t, (G.induce (B i)).Connected) ∧
    (∀ i j : Fin t, i ≠ j → Disjoint (B i) (B j)) ∧
    (∀ i j : Fin t, i ≠ j → ∃ u ∈ B i, ∃ v ∈ B j, G.Adj u v)

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), ¬ HasCliqueMinor G 7 → G.Colorable 7

end
end OpenProblems.QEDM127
