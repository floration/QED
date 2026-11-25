import Mathlib
/-! QED-E162: Is the Ramsey number R(5,5) equal to 43?
R(5,5) is the least n such that every graph on n vertices contains either 5 mutually adjacent vertices or 5 mutually non-adjacent vertices. Exoo's 1989 graph on 42 vertices has neither, so R(5,5) >= 43; computer-assisted work of Angeltveit and McKay (2024) gives R(5,5) <= 46. Determine R(5,5); the expected answer is 43, i.e. every graph on 43 vertices has a clique or an independent set of size 5.
Informal statement: Let $R(5,5)=\min\{n:\ \forall G \text{ on } n \text{ vertices},\ \omega(G)\ge5 \text{ or } \alpha(G)\ge5\}$. Known: $43\le R(5,5)\le 46$. Claim: $R(5,5)=43$, i.e. every simple graph $G$ on $43$ vertices has $\omega(G)\ge5$ or $\alpha(G)\ge5$.
Formalization notes: `Claim` says every simple graph on `Fin 43` has a 5-element vertex set that is a clique or an independent set, i.e. R(5,5) ≤ 43. Given the known lower bound R(5,5) ≥ 43 (Exoo), `Claim` true means R(5,5) = 43; `¬Claim` (a graph on 43 vertices with no K₅ and no independent 5-set) means R(5,5) ≥ 44, i.e. R(5,5) ∈ {44, 45, 46}. Pairwise conditions quantify over distinct vertices only, so the diagonal is irrelevant (adjacency is irreflexive anyway).
-/
namespace OpenProblems.QEDE162

/-- Every graph on 43 vertices has a clique or an independent set of size 5. -/
def Claim : Prop :=
  ∀ G : SimpleGraph (Fin 43),
    ∃ s : Finset (Fin 43), s.card = 5 ∧
      ((∀ x ∈ s, ∀ y ∈ s, x ≠ y → G.Adj x y) ∨ (∀ x ∈ s, ∀ y ∈ s, x ≠ y → ¬ G.Adj x y))

end OpenProblems.QEDE162
