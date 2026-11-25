import Mathlib
/-! QED-E030: Order of magnitude of ex(n, C_8)
How many edges can a graph on n vertices have without containing a cycle of length 8? It is known to be at most about n^{5/4}, but the best constructions are smaller by a polynomial factor, unlike lengths 4, 6 and 10 where matching constructions exist. Find a C_8-free graph with about n^{5/4} edges, or prove a smaller upper bound.
Informal statement: Determine whether $\mathrm{ex}(n,C_8)=\Theta(n^{5/4})$. Known: $\Omega(n^{6/5})\le\mathrm{ex}(n,C_8)\le O(n^{5/4})$. (In general $\mathrm{ex}(n,C_{2k})=O(n^{1+1/k})$ by Bondy-Simonovits, with matching order known only for $k\in\{2,3,5\}$; the lower bound $n^{6/5}$ comes from generalized hexagons and equals the Lazebnik-Ustimenko-Woldar bound $n^{1+2/(3k-3+\epsilon)}$ with $k=4,\epsilon=1$.) Equivalently: is there $c>0$ and $C_8$-free graphs with $\ge c\,n^{5/4}$ edges for infinitely many $n$? Any exponent above $6/5$ would also be progress.
Formalization notes: HasC8 G: there is an injective cyclic sequence of 8 vertices with consecutive ones adjacent (Fin 8 addition wraps around). Claim: there is c>0 such that for infinitely many n there is a C_8-free graph on Fin n with at least c·n^{5/4} edges, i.e. limsup ex(n,C_8)/n^{5/4} > 0 (since ex(n,C_8) is nondecreasing this matches ex(n,C_8)=Theta(n^{5/4}) up to the usual infinitely-often vs all-n distinction). ¬Claim means ex(n,C_8)=o(n^{5/4}).
-/
namespace OpenProblems.QEDE030
def HasC8 {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ f : Fin 8 → Fin n, Function.Injective f ∧ ∀ i : Fin 8, G.Adj (f i) (f (i + 1))

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧
    ∃ G : SimpleGraph (Fin n), ¬ HasC8 G ∧ c * (n : ℝ) ^ ((5 : ℝ) / 4) ≤ (G.edgeSet.ncard : ℝ)
end OpenProblems.QEDE030
