import Mathlib
/-! QED-E159: Are the edges of a uniformly random forest negatively correlated?
Pick a forest (an acyclic set of edges) uniformly at random from a finite graph. If edge e is in the forest, does that make edge f less likely to be in it? For uniformly random spanning trees the answer is yes (Kirchhoff), but for forests, the independent sets of the graphic matroid, it has been open since about 2000. It has been checked on all graphs with at most 8 vertices and proved for complete and complete bipartite graphs.
Informal statement: For a finite simple graph $G=(V,E)$ let $\mathcal F$ be the set of acyclic subsets of $E$, and for $S\subseteq E$ let $N_S=\#\{F\in\mathcal F: S\subseteq F\}$, $N=|\mathcal F|$. Claim: for all distinct $e,f\in E$, $N_{\{e,f\}}\,N\le N_{\{e\}}\,N_{\{f\}}$.
Formalization notes:
* Graphs: finite simple graphs on vertex set `Fin n` (every finite graph is isomorphic to one;
  the statement is isomorphism-invariant). Edges are elements of `Sym2 (Fin n)` lying in
  `G.edgeSet`; `edges G` is the finset of these.
* Forests: a subset `F ⊆ edges G` is acyclic iff the spanning subgraph with edge set `F`
  (`SimpleGraph.fromEdgeSet F`, which has no loops because `F` contains no diagonal) is
  `IsAcyclic` in Mathlib's sense (no walk that is a cycle). These are exactly the independent
  sets of the graphic matroid. The empty forest is included, as in the literature.
* `count G P` counts forests satisfying `P`; `N = count G (fun _ => True)`,
  `N_e = count G (e ∈ ·)`, `N_{ef} = count G (fun F => e ∈ F ∧ f ∈ F)`.
* The inequality is stated multiplicatively in ℕ, which is exactly
  P(e ∈ F, f ∈ F) ≤ P(e ∈ F) P(f ∈ F) for the uniform forest (N ≥ 1 always). It is
  non-strict: equality holds e.g. when e and f lie in different blocks.
* Proving `Claim` = the negative correlation conjecture for uniform forests (all graphs).
  Proving `¬Claim` = a finite simple graph and two distinct edges with positive correlation.
-/
namespace OpenProblems.QEDE159
noncomputable section
open scoped Classical

/-- The edges of `G` as a finset of unordered pairs. -/
def edges {n : ℕ} (G : SimpleGraph (Fin n)) : Finset (Sym2 (Fin n)) :=
  (Finset.univ : Finset (Sym2 (Fin n))).filter (fun e : Sym2 (Fin n) => e ∈ G.edgeSet)

/-- The forests of `G`: acyclic subsets of its edge set. -/
def forests {n : ℕ} (G : SimpleGraph (Fin n)) : Finset (Finset (Sym2 (Fin n))) :=
  (edges G).powerset.filter (fun F : Finset (Sym2 (Fin n)) =>
    (SimpleGraph.fromEdgeSet (F : Set (Sym2 (Fin n)))).IsAcyclic)

/-- Number of forests of `G` with property `P`. -/
def count {n : ℕ} (G : SimpleGraph (Fin n)) (P : Finset (Sym2 (Fin n)) → Prop) : ℕ :=
  ((forests G).filter (fun F : Finset (Sym2 (Fin n)) => P F)).card

def Claim : Prop :=
  ∀ (n : ℕ) (G : SimpleGraph (Fin n)) (e f : Sym2 (Fin n)),
    e ∈ G.edgeSet → f ∈ G.edgeSet → e ≠ f →
      count G (fun F => e ∈ F ∧ f ∈ F) * count G (fun _ => True) ≤
        count G (fun F => e ∈ F) * count G (fun F => f ∈ F)

end
end OpenProblems.QEDE159
