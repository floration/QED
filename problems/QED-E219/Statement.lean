import Mathlib
/-! QED-E219: A triangle-free strongly regular graph on 162 vertices
Only seven triangle-free strongly regular graphs are known (pentagon, Petersen, Clebsch, Hoffman-Singleton,
Gewirtz, M22 and Higman-Sims graphs). The smallest parameter set for which such a graph is neither known nor ruled
out has 162 vertices, every vertex of degree 21, no triangles, and every pair of non-adjacent vertices with exactly
3 common neighbours. Does such a graph exist?
Informal statement: Decide whether there exists a simple graph on $162$ vertices that is strongly regular with
parameters $(162,21,0,3)$: $21$-regular, adjacent vertices have no common neighbours, and distinct non-adjacent
vertices have exactly $3$ common neighbours.
Formalization notes: Vertices are Fin 162 (any 162-vertex graph is isomorphic to one on Fin 162). Strong
regularity is spelled out by hand (equivalent to Mathlib's `SimpleGraph.IsSRGWith G 162 21 0 3`, avoiding
dependence on its instance arguments): every vertex has exactly 21 neighbours; for distinct v, w the number of
common neighbours u is 0 if v ~ w and 3 otherwise. Counting uses classical decidability. `Claim` = such a graph
exists; `¬Claim` = no srg(162,21,0,3) exists.
-/
namespace OpenProblems.QEDE219

noncomputable section

open Classical

/-- G is strongly regular with parameters (162, 21, 0, 3). -/
def IsSRG162 (G : SimpleGraph (Fin 162)) : Prop :=
  (∀ v : Fin 162, (Finset.univ.filter (fun u : Fin 162 => G.Adj v u)).card = 21) ∧
    ∀ v w : Fin 162, v ≠ w →
      (G.Adj v w → (Finset.univ.filter (fun u : Fin 162 => G.Adj v u ∧ G.Adj w u)).card = 0) ∧
      (¬ G.Adj v w → (Finset.univ.filter (fun u : Fin 162 => G.Adj v u ∧ G.Adj w u)).card = 3)

def Claim : Prop := ∃ G : SimpleGraph (Fin 162), IsSRG162 G

end

end OpenProblems.QEDE219
