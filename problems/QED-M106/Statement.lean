import Mathlib
/-! QED-M106: Beat the 4-cycle lower bound for cube-free graphs
How many edges can an n-vertex graph have without containing the 3-dimensional cube Q3 (8 vertices, 12 edges)? Erdos and Simonovits proved about n^{8/5} is an upper bound, but the best lower bound is still about n^{3/2}, from graphs with no 4-cycle at all (every 4-cycle-free graph is cube-free). Find cube-free graphs with polynomially more edges than that, or show that no such graphs exist.
Informal statement: Let $\mathrm{ex}(n,Q_3)$ be the maximum number of edges in an $n$-vertex simple graph with no subgraph isomorphic to the cube $Q_3$. Known: $(\tfrac12+o(1))n^{3/2}\le \mathrm{ex}(n,Q_3)= O(n^{8/5})$. Decide whether $\liminf_{n\to\infty}\log \mathrm{ex}(n,Q_3)/\log n>3/2$, i.e. whether there is $\varepsilon>0$ with $\mathrm{ex}(n,Q_3)\ge n^{3/2+\varepsilon}$ for all large $n$. (Erdos conjectured the stronger $\mathrm{ex}(n,Q_3)=\Theta(n^{8/5})$.)
Formalization notes:
* `Q3` is the 3-cube on vertex set `Fin 3 → Bool` (8 vertices), two vertices adjacent iff they
  differ in exactly one coordinate (`SimpleGraph.fromRel` adds irreflexivity and symmetry; the
  relation is already symmetric and irreflexive, so this is exactly the cube, 12 edges).
* `SimpleGraph.extremalNumber n Q3` is Mathlib's Turán number: the maximum of `#G.edgeFinset`
  over simple graphs `G` on `Fin n` with `Q3.Free G`, i.e. with no injective homomorphic copy of
  `Q3` (= no subgraph, not necessarily induced, isomorphic to `Q3`). This is the standard ex(n,Q3).
* `Claim` : ∃ ε > 0, ∃ N, ∀ n ≥ N, n^(3/2+ε) ≤ ex(n,Q3) (real powers, n ≥ 0 so `rpow` is
  standard). Since ex(n,Q3) ≤ n² is finite and ex(n,Q3) ≥ 1 for n ≥ 2, this is equivalent to
  liminf log ex(n,Q3)/log n > 3/2 (a multiplicative constant c > 0 can be absorbed by shrinking ε).
* Proving `Claim`: cube-free graphs with n^{3/2+ε} edges for all large n.
  Proving `¬Claim`: for every ε > 0 there are infinitely many n with ex(n,Q3) < n^{3/2+ε}, i.e.
  the liminf exponent equals 3/2 (given the known lower bound n^{3/2}/2 for large n).
-/
namespace OpenProblems.QEDM106
noncomputable section

/-- The 3-dimensional cube graph on `{0,1}^3`. -/
def Q3 : SimpleGraph (Fin 3 → Bool) :=
  SimpleGraph.fromRel (fun x y : Fin 3 → Bool =>
    (Finset.univ.filter (fun i : Fin 3 => x i ≠ y i)).card = 1)

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
    (n : ℝ) ^ ((3 : ℝ) / 2 + ε) ≤ (SimpleGraph.extremalNumber n Q3 : ℝ)

end
end OpenProblems.QEDM106
