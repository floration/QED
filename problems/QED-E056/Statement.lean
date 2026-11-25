import Mathlib
/-! QED-E056: Do minimum-order k-chromatic graphs of girth at least g have girth exactly g?
Let n_g(k) be the fewest vertices of a graph that needs k colours and has no cycle shorter than g. Exoo and Goedgebeur asked whether a smallest such graph must have a cycle of length exactly g; equivalently, whether n_g(k) strictly increases with g. For k = 3 this fails (the 5-cycle is smallest for both g = 4 and g = 5), so the question is for k >= 4. The analogous statement for cages is a classical theorem of Erdos and Sachs.
Informal statement: Let $n_g(k)=\min\{|V(G)|:\chi(G)=k,\ \mathrm{girth}(G)\ge g\}$. Decide whether $n_g(k)<n_{g+1}(k)$ for all $k\ge 4$ and $g\ge 3$; equivalently, whether every graph with $\chi=k$, girth $\ge g$ and exactly $n_g(k)$ vertices has girth exactly $g$.
Formalization notes:
* Graphs are Mathlib `SimpleGraph (Fin n)` (finite simple graphs on n labelled vertices; every
  finite graph is isomorphic to one). `χ(G) = k` is `G.chromaticNumber = (k : ℕ∞)` (Mathlib's
  chromatic number, the least n with a proper n-colouring). Girth uses `G.egirth : ℕ∞`, the
  length of a shortest cycle, `⊤` for forests; "girth ≥ g" is `(g : ℕ∞) ≤ G.egirth` and
  "girth exactly g" is `G.egirth = (g : ℕ∞)`.
* `Good k g G` : χ(G) = k and girth(G) ≥ g. `IsMinimum k g n G` : `Good k g G` and no graph on
  fewer than n vertices is `Good k g`; i.e. n = n_g(k) and G is a smallest such graph.
* `Claim` is the second (equivalent) form: for all k ≥ 4, g ≥ 3, every minimum-order graph with
  χ = k and girth ≥ g has girth exactly g. Equivalence with strict monotonicity: always
  n_g(k) ≤ n_{g+1}(k) (girth ≥ g+1 implies girth ≥ g), and n_g(k) = n_{g+1}(k) iff some
  minimum-order graph for (k,g) has girth ≥ g+1, i.e. girth ≠ g. Graphs with χ = k and girth ≥ g
  exist for all k, g (Erdős 1959), so the sets defining n_g(k) are nonempty and the universal
  statement is not vacuous; this form avoids `sInf` junk values.
* Proving `Claim`: n_g(k) < n_{g+1}(k) for all k ≥ 4, g ≥ 3. Proving `¬Claim`: some k ≥ 4,
  g ≥ 3 and a smallest graph with χ = k, girth ≥ g that has girth > g (so n_g(k) = n_{g+1}(k)).
* Sanity: for k = 3, g = 4 the 5-cycle is a minimum graph of girth 5, which is why k ≥ 4.
-/
namespace OpenProblems.QEDE056
noncomputable section

/-- `G` has chromatic number exactly `k` and girth at least `g`. -/
def Good (k g : ℕ) {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  G.chromaticNumber = (k : ℕ∞) ∧ (g : ℕ∞) ≤ G.egirth

/-- `G` is a smallest graph with chromatic number `k` and girth at least `g`
(so `n = n_g(k)`). -/
def IsMinimum (k g n : ℕ) (G : SimpleGraph (Fin n)) : Prop :=
  Good k g G ∧ ∀ m : ℕ, m < n → ∀ H : SimpleGraph (Fin m), ¬ Good k g H

def Claim : Prop :=
  ∀ k g : ℕ, 4 ≤ k → 3 ≤ g →
    ∀ n : ℕ, ∀ G : SimpleGraph (Fin n), IsMinimum k g n G → G.egirth = (g : ℕ∞)

end
end OpenProblems.QEDE056
