import Mathlib
/-! QED-E122: The domination game 3/5 bound for all isolate-free graphs
In the domination game on a graph, Dominator and Staller take turns choosing vertices. Each chosen vertex must dominate (be, or be adjacent to) at least one vertex not yet dominated, and the game ends when every vertex is dominated. Dominator wants the game to be short and Staller wants it long. With Dominator moving first and optimal play, does the game always end within 3n/5 moves on an n-vertex graph with no isolated vertices?
Informal statement: For a finite graph $G$ on $n$ vertices with no isolated vertex, let $\gamma_g(G)$ be the
number of moves under optimal play: players alternately choose a vertex $v$ with $N[v]\not\subseteq N[S]$, where
$S$ is the set of vertices chosen so far; Dominator moves first and minimizes the length, Staller maximizes it, and
the game ends when $N[S]=V(G)$. Prove or disprove $\gamma_g(G)\le 3n/5$. Best known: $\gamma_g(G)\le 5n/8$.
Formalization notes:
* Graphs: `G : SimpleGraph V` with `V : Type` finite (`Fintype V`), `n = Fintype.card V`.
  No isolated vertex: `∀ v, ∃ u, G.Adj v u`.
* State: the set `D = N[S] ⊆ V` of dominated vertices (all that matters for legality and
  termination) and whose turn it is (`true` = Dominator). Closed neighbourhood
  `cnbhd G v = {v} ∪ N(v)`. A move `v` is legal iff `¬ cnbhd G v ⊆ D`; it updates
  `D ↦ D ∪ cnbhd G v`. The game ends when `D = univ`.
* `CanFinish G b D k` ("Dominator can force the game from state `(D, b)` to end within `k`
  further moves"), by recursion on `k`: with `k = 0` the game must already be over; with
  `k+1`, either it is over, or (Dominator to move) some legal move leads to `CanFinish … k`, or
  (Staller to move) every legal move does. Staller is never vacuously stuck: if `D ≠ univ`,
  any undominated `u` is a legal move. Thus `γ_g(G) ≤ k ↔ CanFinish G true ∅ k` (standard
  min–max over the finite game tree, which has depth ≤ n).
* Since `γ_g(G)` is an integer, `γ_g(G) ≤ 3n/5 ↔ γ_g(G) ≤ ⌊3n/5⌋ = 3 * n / 5` (ℕ division).
* `Claim` = the 3/5 conjecture (Kinnersley–West–Zamani) for all isolate-free graphs.
  `¬Claim` = a finite isolate-free graph with `γ_g(G) > 3n/5`.
-/
namespace OpenProblems.QEDE122
noncomputable section

variable {V : Type}

/-- Closed neighbourhood `N[v] = {v} ∪ N(v)`. -/
def cnbhd (G : SimpleGraph V) (v : V) : Set V := {u : V | u = v ∨ G.Adj v u}

/-- `CanFinish G b D k`: from dominated set `D` with Dominator to move iff `b = true`,
Dominator can force the domination game to end within `k` more moves. -/
def CanFinish (G : SimpleGraph V) : Bool → Set V → ℕ → Prop
  | _, D, 0 => D = Set.univ
  | true, D, k + 1 =>
      D = Set.univ ∨ ∃ v : V, ¬ cnbhd G v ⊆ D ∧ CanFinish G false (D ∪ cnbhd G v) k
  | false, D, k + 1 =>
      D = Set.univ ∨ ∀ v : V, ¬ cnbhd G v ⊆ D → CanFinish G true (D ∪ cnbhd G v) k

/-- The 3/5 conjecture: `γ_g(G) ≤ 3n/5` for every finite graph without isolated vertices. -/
def Claim : Prop :=
  ∀ (V : Type) [Fintype V] (G : SimpleGraph V), (∀ v : V, ∃ u : V, G.Adj v u) →
    CanFinish G true (∅ : Set V) (3 * Fintype.card V / 5)

end
end OpenProblems.QEDE122
