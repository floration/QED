import Mathlib
/-! QED-E121: Linear arboricity of graphs with maximum degree 7
A linear forest is a graph whose components are paths. The linear arboricity conjecture says the edges of any graph with maximum degree D can be split into ceil((D+1)/2) linear forests. It was proved for D = 3, 4, 5, 6, 8 and 10 by 1988, but D = 7 is the smallest open case. Can the edges of every graph with maximum degree 7 be split into 4 linear forests?
Informal statement: Prove or disprove: every finite simple graph $G$ with $\Delta(G)\le 7$ admits a map $c:E(G)\to\{1,2,3,4\}$ such that every colour class is a linear forest (acyclic, with maximum degree at most $2$). Equivalently, $\mathrm{la}(G)\le 4$ whenever $\Delta(G)\le 7$.
Formalization notes:
* Finite simple graphs are `SimpleGraph (Fin n)` for `n : ℕ` (every finite graph is isomorphic
  to one of these). Degrees are cards of classical filters of `Finset.univ`.
* A linear forest is a graph that is acyclic (`SimpleGraph.IsAcyclic`: no walk that is a cycle)
  with every vertex of degree ≤ 2; equivalently every component is a path (isolated vertices
  are trivial paths). This is the standard definition.
* A colouring is any function `c : Sym2 (Fin n) → Fin 4`; only its values on `G.edgeSet` matter.
  Colour class `i` is the graph `fromEdgeSet {e ∈ G.edgeSet | c e = i}` (a spanning subgraph of
  `G`), so the four classes partition the edges of `G`.
* Proving `Claim` = the linear arboricity conjecture for Δ = 7 (then 4 is tight, since 7-regular
  graphs need 4 linear forests). Proving `¬Claim` = a finite graph with Δ ≤ 7 whose edges cannot
  be split into 4 linear forests (a counterexample to the linear arboricity conjecture).
-/
namespace OpenProblems.QEDE121
noncomputable section
open Classical

/-- Degree of `v` in a graph on `Fin n`. -/
def deg {n : ℕ} (H : SimpleGraph (Fin n)) (v : Fin n) : ℕ :=
  (Finset.univ.filter (fun w : Fin n => H.Adj v w)).card

/-- A linear forest: acyclic with maximum degree at most 2 (components are paths). -/
def IsLinearForest {n : ℕ} (H : SimpleGraph (Fin n)) : Prop :=
  H.IsAcyclic ∧ ∀ v : Fin n, deg H v ≤ 2

/-- Colour class `i` of the edge colouring `c` of `G`. -/
def colourClass {n : ℕ} (G : SimpleGraph (Fin n)) (c : Sym2 (Fin n) → Fin 4) (i : Fin 4) :
    SimpleGraph (Fin n) :=
  SimpleGraph.fromEdgeSet {e : Sym2 (Fin n) | e ∈ G.edgeSet ∧ c e = i}

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)), (∀ v : Fin n, deg G v ≤ 7) →
    ∃ c : Sym2 (Fin n) → Fin 4, ∀ i : Fin 4, IsLinearForest (colourClass G c i)

end
end OpenProblems.QEDE121
