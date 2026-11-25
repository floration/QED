import Mathlib
/-! QED-E117: Does a Moore graph of degree 57 exist?
A Moore graph of diameter 2 is a regular graph in which any two vertices are either adjacent or have exactly one common neighbour; with degree k it has k^2+1 vertices, the most a diameter-2 graph of degree k can have. Hoffman and Singleton (1960) showed such graphs can exist only for k = 2, 3, 7, 57, and the first three exist (pentagon, Petersen graph, Hoffman-Singleton graph). Does one exist for degree 57, with 3250 vertices?
Informal statement: Decide whether there exists a simple graph $G$ on $3250$ vertices that is $57$-regular, triangle-free, and in which every two distinct non-adjacent vertices have exactly one common neighbour; equivalently, whether a strongly regular graph with parameters $(3250,57,0,1)$ exists.
Formalization notes:
* Graphs on 3250 vertices are `SimpleGraph (Fin 3250)` (every 3250-vertex graph is isomorphic
  to one of these). Degrees and common-neighbour counts are cardinalities of explicit filters of
  `Finset.univ` (classical decidability), so no `DecidableRel` instance needs to be supplied.
* `IsMoore57 G`: every vertex has exactly 57 neighbours; no triangle (adjacent vertices have no
  common neighbour, i.e. λ = 0); distinct non-adjacent vertices have exactly one common
  neighbour (μ = 1). This is precisely an srg(3250, 57, 0, 1), i.e. a Moore graph of degree 57
  and diameter 2 (diameter ≤ 2 follows from μ = 1; the graph is not complete).
* This is a decision problem. Proving `Claim` = exhibiting (constructing) such a graph.
  Proving `¬Claim` = showing no Moore graph of degree 57 exists.
-/
namespace OpenProblems.QEDE117
noncomputable section
open Classical

/-- Neighbourhood of `v` in `G`, as a finset. -/
def nbhd (G : SimpleGraph (Fin 3250)) (v : Fin 3250) : Finset (Fin 3250) :=
  Finset.univ.filter (fun w : Fin 3250 => G.Adj v w)

/-- Common neighbours of `u` and `v`. -/
def common (G : SimpleGraph (Fin 3250)) (u v : Fin 3250) : Finset (Fin 3250) :=
  Finset.univ.filter (fun w : Fin 3250 => G.Adj u w ∧ G.Adj v w)

/-- `G` is a strongly regular graph with parameters (3250, 57, 0, 1), i.e. a Moore graph of
degree 57 and diameter 2. -/
def IsMoore57 (G : SimpleGraph (Fin 3250)) : Prop :=
  (∀ v : Fin 3250, (nbhd G v).card = 57) ∧
  (∀ u v : Fin 3250, G.Adj u v → (common G u v).card = 0) ∧
  (∀ u v : Fin 3250, u ≠ v → ¬ G.Adj u v → (common G u v).card = 1)

def Claim : Prop :=
  ∃ G : SimpleGraph (Fin 3250), IsMoore57 G

end
end OpenProblems.QEDE117
