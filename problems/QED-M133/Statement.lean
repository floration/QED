import Mathlib
/-! QED-M133: Polynomial-size linear extended formulations for stable set polytopes of perfect graphs
For a perfect graph, the convex hull of its independent sets is cut out by the inequalities 'each clique contains at most one chosen vertex', and maximum-weight independent set is solvable in polynomial time, but only via semidefinite programming. Is this polytope always the projection of a polytope with polynomially many facets, i.e. does it have a polynomial-size linear program? The best upper bound is n^{O(log n)}, and lower bounds are barely superlinear.
Informal statement: For a graph $G$ on $[n]$ let $M_G$ have rows indexed by cliques $K$, columns by stable sets $S$, entries $M_G(K,S)=1-|K\cap S|\ (\ge0)$. Determine whether there is a constant $C$ such that $\operatorname{rank}_+(M_G)\le n^C$ for every perfect graph $G$ on $n\ge2$ vertices. (By Yannakakis' theorem and $\mathrm{STAB}(G)=\mathrm{QSTAB}(G)$, $\operatorname{rank}_+(M_G)$ equals the linear extension complexity of $\mathrm{STAB}(G)$ up to an additive $O(n)$.) Known: $\operatorname{rank}_+(M_G)\le n^{O(\log n)}$.
Formalization notes:
* Graphs are `SimpleGraph (Fin n)`; all notions are isomorphism-invariant.
* Cliques and stable sets are `Finset (Fin n)` with the obvious pairwise conditions (written out
  by hand; the empty set and singletons count, as in the informal statement; including the
  empty clique row (all ones) or non-maximal cliques changes rank₊ by at most n+1, since a
  non-maximal clique row is a maximal clique row plus nonnegativity slacks).
* Perfect: for every vertex subset s, the induced graph on s has a proper colouring with k
  colours where k is the size of some clique inside s (colours are naturals < k on s; values
  off s are irrelevant, so s = ∅ is satisfied with the empty clique). Since every colouring needs at least as
  many colours as any clique, this says exactly χ(G[s]) = ω(G[s]) for all s, i.e. G is perfect.
* Nonnegative rank ≤ r: there are nonnegative real matrices U (cliques × r) and V (r × stable
  sets) with M_G(K,S) = Σᵢ U(K,i) V(i,S) for all cliques K and stable sets S. U and V are given
  on all finsets; only their values on cliques / stable sets matter.
* Claim: ∃ C, every perfect graph on n ≥ 2 vertices has rank₊(M_G) ≤ n^C, i.e. stable set
  polytopes of perfect graphs have polynomial linear extension complexity. ¬Claim: for every C
  some perfect graph has rank₊(M_G) > n^C (superpolynomial lower bound). The trivial
  factorisation has r = number of stable sets (exponential), so neither side is trivial.
-/
namespace OpenProblems.QEDM133
noncomputable section

/-- `K` is a clique of `G`. -/
def IsCliqueF {n : ℕ} (G : SimpleGraph (Fin n)) (K : Finset (Fin n)) : Prop :=
  ∀ x ∈ K, ∀ y ∈ K, x ≠ y → G.Adj x y

/-- `S` is a stable (independent) set of `G`. -/
def IsStableF {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : Prop :=
  ∀ x ∈ S, ∀ y ∈ S, ¬ G.Adj x y

/-- `G` is perfect: every induced subgraph `G[s]` can be properly coloured with as many colours
as the size of some clique contained in `s` (equivalently χ(G[s]) = ω(G[s])). -/
def IsPerfect {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∀ s : Finset (Fin n), ∃ K : Finset (Fin n), K ⊆ s ∧ IsCliqueF G K ∧
    ∃ c : Fin n → ℕ, (∀ x ∈ s, c x < K.card) ∧
      ∀ x ∈ s, ∀ y ∈ s, G.Adj x y → c x ≠ c y

/-- The clique/stable-set slack matrix `M_G(K,S) = 1 - |K ∩ S|`. -/
def slack {n : ℕ} (K S : Finset (Fin n)) : ℝ := 1 - ((K ∩ S).card : ℝ)

/-- `rank₊(M_G) ≤ r`. -/
def NonnegRankLE {n : ℕ} (G : SimpleGraph (Fin n)) (r : ℕ) : Prop :=
  ∃ U : Finset (Fin n) → Fin r → ℝ, ∃ V : Fin r → Finset (Fin n) → ℝ,
    (∀ K : Finset (Fin n), ∀ i : Fin r, 0 ≤ U K i) ∧
    (∀ i : Fin r, ∀ S : Finset (Fin n), 0 ≤ V i S) ∧
    ∀ K S : Finset (Fin n), IsCliqueF G K → IsStableF G S →
      slack K S = ∑ i : Fin r, U K i * V i S

/-- Stable set polytopes of perfect graphs have polynomial-size linear extended formulations. -/
def Claim : Prop :=
  ∃ C : ℕ, ∀ n : ℕ, 2 ≤ n → ∀ G : SimpleGraph (Fin n), IsPerfect G →
    ∃ r : ℕ, r ≤ n ^ C ∧ NonnegRankLE G r

end
end OpenProblems.QEDM133
