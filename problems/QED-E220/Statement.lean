import Mathlib
/-! QED-E220: Is there a cubic graph of girth 13 with fewer than 272 vertices?
A (3,g)-cage is a smallest 3-regular graph with no cycle shorter than g. Cubic cages are known for every girth up to 12. For girth 13 the best known graph has 272 vertices, while exhaustive computer searches only show that at least 202 vertices are needed. Is there a 3-regular graph of girth at least 13 on fewer than 272 vertices?
Informal statement: Does there exist a $3$-regular simple graph $G$ with $|V(G)|<272$ and girth at least $13$? Equivalently (by strict monotonicity $n(3,g)<n(3,g+1)$), is $n(3,13)<272$, given the known bounds $202\le n(3,13)\le272$?
Formalization notes: A simple graph on `Fin n`, n < 272. 3-regularity is stated as: every vertex has exactly
3 neighbours (`Nat.card (G.neighborSet v) = 3`, avoiding decidability instances). Girth ≥ 13 is stated by
hand: every cycle (`SimpleGraph.Walk.IsCycle`, a closed walk of length ≥ 3 with no repeated vertices other
than the endpoints and no repeated edges) has length ≥ 13. A 3-regular finite graph with n ≥ 1 vertices is
not acyclic, so the cycle condition is not vacuous; the empty graph on Fin 0 would satisfy both conditions
vacuously, so n ≥ 1 is required explicitly. Claim true ⇔ n(3,13) < 272; ¬Claim ⇔
n(3,13) = 272.
-/
namespace OpenProblems.QEDE220
noncomputable section

def Claim : Prop :=
  ∃ n : ℕ, 1 ≤ n ∧ n < 272 ∧ ∃ G : SimpleGraph (Fin n),
    (∀ v : Fin n, Nat.card (G.neighborSet v) = 3) ∧
    ∀ (u : Fin n) (p : G.Walk u u), p.IsCycle → 13 ≤ p.length

end
end OpenProblems.QEDE220
