import Mathlib
/-! N-139: An explicit, checkable counterexample to Hadwiger's conjecture
Hadwiger's conjecture says every graph with chromatic number ≥ t has K_t as a minor. A disproof
claimed in October 2026 (not peer reviewed) is non-constructive, with astronomically large
graphs. Find one explicit graph on fewer than a million vertices that violates the conjecture,
with a checkable proof.
Informal statement: For a finite graph G let h(G) = max{t : K_t ⪯ G} and χ(G) its chromatic
number. Exhibit an explicit graph G with |V(G)| < 10⁶ and h(G) < χ(G), with a complete checkable
proof of both bounds. (Sufficient route, Cambie: an explicit G with α(G) ≤ 2, |V(G)| = 4t − 1 and
no connected matching of size t violates the conjecture.)
Formalization notes: Graphs are `SimpleGraph (Fin n)`. `HasCliqueMinor G t` says there are t
pairwise disjoint vertex sets (branch sets), each inducing a connected (in particular nonempty)
subgraph, with an edge of G between every two of them; this is exactly K_t ⪯ G. A counterexample
is a graph that is not t-colourable (χ(G) ≥ t+1, via Mathlib's `SimpleGraph.Colorable`) and has
no K_{t+1} minor. `Claim` says such a graph exists with n < 10⁶ vertices. A Lean proof of `Claim`
is automatically "explicit and checkable" (the graph must be named and both bounds verified,
the minor-freeness possibly by a large computation). `¬Claim` means Hadwiger's conjecture holds
for all graphs on fewer than 10⁶ vertices (not expected to be provable). Known: Hadwiger holds
for t ≤ 6 (Robertson-Seymour-Thomas), so any counterexample has χ ≥ 7.
-/
namespace OpenProblems.N139

/-- `G` has the complete graph `K_t` as a minor: `t` disjoint connected branch sets,
pairwise joined by an edge. -/
def HasCliqueMinor {n : ℕ} (G : SimpleGraph (Fin n)) (t : ℕ) : Prop :=
  ∃ B : Fin t → Set (Fin n),
    (∀ i : Fin t, (G.induce (B i)).Connected) ∧
    (∀ i j : Fin t, i ≠ j → Disjoint (B i) (B j)) ∧
    (∀ i j : Fin t, i ≠ j → ∃ u ∈ B i, ∃ v ∈ B j, G.Adj u v)

def Claim : Prop :=
  ∃ n : ℕ, n < 10 ^ 6 ∧ ∃ G : SimpleGraph (Fin n), ∃ t : ℕ,
    ¬ G.Colorable t ∧ ¬ HasCliqueMinor G (t + 1)

end OpenProblems.N139
