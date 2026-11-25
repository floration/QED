import Mathlib
/-! QED-E164: Smallest triangle-free 6-chromatic graph: is 40 vertices optimal?
Triangle-free graphs can need arbitrarily many colours, but they must be large. The smallest triangle-free graph needing 4 colours has 11 vertices (the Grötzsch graph), and the smallest needing 5 colours has 22 vertices. For 6 colours, the smallest such graph is known to have between 32 and 40 vertices. Either find a triangle-free graph on at most 39 vertices that cannot be properly coloured with 5 colours, or prove that every triangle-free graph on 39 vertices is 5-colourable.
Informal statement: Let $n(k)$ be the minimum order of a triangle-free graph $G$ with $\chi(G)=k$. Known: $n(4)=11$, $n(5)=22$, $32\le n(6)\le 40$. Decide whether $n(6)=40$, i.e. whether every triangle-free graph on $39$ vertices satisfies $\chi(G)\le 5$.
Formalization notes:
* Claim: every simple graph on `Fin 39` with no triangle (three pairwise adjacent vertices;
  distinctness is automatic since adjacency is irreflexive) has a proper colouring
  `c : Fin 39 → Fin 5` (adjacent vertices get different colours), i.e. χ ≤ 5.
* Equivalence with n(6) = 40 given the known bound n(6) ≤ 40: if a triangle-free graph H with
  χ(H) = 6 had ≤ 39 vertices, adding isolated vertices gives a triangle-free graph on exactly 39
  vertices with χ = 6, violating Claim. Conversely a triangle-free graph on 39 vertices with
  χ ≥ 6 contains (deleting vertices one at a time, χ drops by ≤ 1 each step) a triangle-free
  induced subgraph with χ = 6 on ≤ 39 vertices, so n(6) ≤ 39.
* Proving `Claim` = n(6) = 40. Proving `¬Claim` = n(6) ≤ 39 (a triangle-free graph on 39
  vertices that is not 5-colourable).
-/
namespace OpenProblems.QEDE164
noncomputable section

/-- `G` has no triangle. -/
def TriangleFree (G : SimpleGraph (Fin 39)) : Prop :=
  ∀ a b c : Fin 39, ¬ (G.Adj a b ∧ G.Adj b c ∧ G.Adj a c)

def Claim : Prop :=
  ∀ G : SimpleGraph (Fin 39), TriangleFree G →
    ∃ col : Fin 39 → Fin 5, ∀ u v : Fin 39, G.Adj u v → col u ≠ col v

end
end OpenProblems.QEDE164
