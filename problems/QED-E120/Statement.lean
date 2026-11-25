import Mathlib
/-! QED-E120: Does ex(n, K_{4,4}) grow faster than n^{5/3}?
How many edges can a graph on n vertices have if it contains no complete bipartite graph K_{4,4}? The general upper bound is of order n^{7/4}. The best known constructions give only order n^{5/3}, which is already achieved by graphs that avoid the smaller K_{3,3}. Can one do better than a constant times n^{5/3}?
Informal statement: Let $\mathrm{ex}(n,K_{4,4})$ be the maximum number of edges in a $K_{4,4}$-free graph on $n$ vertices. Known: $c\,n^{5/3}\le\mathrm{ex}(n,K_{4,4})\le C\,n^{7/4}$. Decide whether $\mathrm{ex}(n,K_{4,4})=O(n^{5/3})$, i.e. whether $\limsup_n \mathrm{ex}(n,K_{4,4})/n^{5/3}<\infty$. (Stronger target: $\mathrm{ex}(n,K_{4,4})=\Theta(n^{7/4})$.)
Formalization notes:
* A simple graph `G` on `Fin n` contains `K_{4,4}` (as a not necessarily induced subgraph) iff
  there are disjoint 4-sets `A`, `B` with every `a ∈ A` adjacent to every `b ∈ B`; `K44Free G`
  is the negation.
* `edgeCount G` counts pairs `(i,j)` with `i < j` and `G.Adj i j`, i.e. the number of edges
  (each edge counted once). `ex n` is the maximum of `edgeCount` over the finite set of
  `K_{4,4}`-free graphs on `Fin n` (a `Finset.sup` over a nonempty set, since the empty graph
  is `K_{4,4}`-free, so it is a genuine maximum).
* `Claim`: `ex(n, K_{4,4})` is not `O(n^{5/3})`, i.e. there is no `C` with
  `ex n ≤ C n^{5/3}` for all `n` (real power `n ^ (5/3 : ℝ)`; at `n = 0` both sides are `0`).
  This is exactly "one can do better than a constant times `n^{5/3}`" (equivalently
  `limsup ex n / n^{5/3} = ∞`). Proving `¬Claim` means `ex(n, K_{4,4}) = O(n^{5/3})`, which with
  the known lower bound gives `ex(n, K_{4,4}) = Θ(n^{5/3})`. Both sides are genuine answers.
  The stronger target `Θ(n^{7/4})` is not formalized.
-/
namespace OpenProblems.QEDE120
noncomputable section
open scoped Classical
open Filter

/-- `G` contains no copy of `K_{4,4}`. -/
def K44Free {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ¬ ∃ A B : Finset (Fin n), A.card = 4 ∧ B.card = 4 ∧ Disjoint A B ∧
    ∀ a ∈ A, ∀ b ∈ B, G.Adj a b

/-- Number of edges of `G`. -/
def edgeCount {n : ℕ} (G : SimpleGraph (Fin n)) : ℕ :=
  ((Finset.univ : Finset (Fin n × Fin n)).filter
    (fun q : Fin n × Fin n => q.1 < q.2 ∧ G.Adj q.1 q.2)).card

/-- The Turán number `ex(n, K_{4,4})`. -/
def ex (n : ℕ) : ℕ :=
  ((Finset.univ : Finset (SimpleGraph (Fin n))).filter
    (fun G : SimpleGraph (Fin n) => K44Free G)).sup (fun G : SimpleGraph (Fin n) => edgeCount G)

def Claim : Prop :=
  ¬ ∃ C : ℝ, ∀ n : ℕ, (ex n : ℝ) ≤ C * (n : ℝ) ^ ((5 : ℝ) / 3)

end
end OpenProblems.QEDE120
