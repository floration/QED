import Mathlib
/-! QED-E021: Is R(3,10) equal to 40 or 41?
The Ramsey number R(3,10) is the fewest people at a party that guarantees either 3 mutual acquaintances or 10 mutual strangers. It is known to be 40 or 41, and nobody knows which. Settle it: either build a 40-vertex triangle-free graph with no 10 pairwise non-adjacent vertices, or show none exists.
Informal statement: Let $R(3,10)$ be the least $n$ such that every graph on $n$ vertices contains $K_3$ or an independent set of size $10$. Known: $40\le R(3,10)\le 41$. Decide whether there exists a triangle-free graph $G$ on $40$ vertices with $\alpha(G)\le 9$ (equivalently whether $R(3,10)=41$).
Formalization notes: Claim says every graph on 40 vertices has a triangle or an independent set of size 10, i.e. R(3,10) <= 40. Given the known 40 <= R(3,10) <= 41: Claim true means R(3,10)=40, and ¬Claim (a triangle-free graph on 40 vertices with independence number <= 9 exists) means R(3,10)=41. Adjacency is irreflexive, so a triangle's vertices are automatically distinct.
-/
namespace OpenProblems.QEDE021
def Claim : Prop :=
  ∀ G : SimpleGraph (Fin 40),
    (∃ a b c : Fin 40, G.Adj a b ∧ G.Adj b c ∧ G.Adj a c) ∨
    (∃ s : Finset (Fin 40), s.card = 10 ∧ ∀ x ∈ s, ∀ y ∈ s, x ≠ y → ¬ G.Adj x y)
end OpenProblems.QEDE021
