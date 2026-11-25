import Mathlib
/-! QED-E230: Bounded-degree spanning trees in the prime-sum graph
Join two numbers from 1 to 2n when their sum is prime. Show that every tree on 2n vertices with
bounded degree and two equal colour classes can be found inside this graph.
Informal statement: Let 𝒫_{2n} be the graph on [2n] = {1,…,2n} with ij ∈ E iff i + j is prime
(𝒫_{2n} is bipartite between odds and evens). Prove that for every Δ there is n₀(Δ) such that for
all n ≥ n₀, every tree T on 2n vertices with maximum degree ≤ Δ and both bipartition classes of size
n is isomorphic to a spanning subgraph of 𝒫_{2n}.
Formalization notes: Trees are `SimpleGraph (Fin (2*n))` with `IsTree` (connected and acyclic);
every tree on 2n labelled vertices is isomorphic to one of these. Vertex `i : Fin (2*n)` of the host
stands for the integer i + 1 ∈ [2n], so the host edge condition is `Nat.Prime (i + 1 + (j + 1))`.
Maximum degree ≤ Δ: every finite set of neighbours of a vertex has at most Δ elements (avoids
decidability instances for `degree`). Balanced bipartition: there is a proper 2-colouring with
exactly n vertices coloured `true`; a tree is connected, so its proper 2-colouring is unique up to
swapping colours and this says both classes have size n. "Isomorphic to a spanning subgraph" = a
bijection φ of the vertex set mapping every tree edge to a host edge. Proving `Claim` = the
embedding theorem; proving `¬Claim` = some Δ with infinitely many n admitting a balanced tree of
maximum degree ≤ Δ that does not embed.
-/
namespace OpenProblems.QEDE230
noncomputable section

/-- The tree `T` on `Fin (2n)` has maximum degree at most `Δ`. -/
def MaxDegLE {n : ℕ} (T : SimpleGraph (Fin (2 * n))) (Δ : ℕ) : Prop :=
  ∀ v : Fin (2 * n), ∀ s : Finset (Fin (2 * n)), (∀ u ∈ s, T.Adj v u) → s.card ≤ Δ

/-- `T` has a proper 2-colouring with exactly `n` vertices in one class. -/
def Balanced {n : ℕ} (T : SimpleGraph (Fin (2 * n))) : Prop :=
  ∃ c : Fin (2 * n) → Bool, (∀ u v : Fin (2 * n), T.Adj u v → c u ≠ c v) ∧
    (Finset.univ.filter (fun v : Fin (2 * n) => c v = true)).card = n

/-- `T` is isomorphic to a spanning subgraph of the prime-sum graph on `{1,…,2n}`
(vertex `i` represents the integer `i + 1`). -/
def EmbedsInPrimeSum {n : ℕ} (T : SimpleGraph (Fin (2 * n))) : Prop :=
  ∃ φ : Fin (2 * n) ≃ Fin (2 * n), ∀ u v : Fin (2 * n), T.Adj u v →
    Nat.Prime (((φ u : ℕ) + 1) + ((φ v : ℕ) + 1))

/-- Every balanced tree of maximum degree ≤ Δ on 2n vertices embeds spanningly in the prime-sum
graph, for all large n. -/
def Claim : Prop :=
  ∀ Δ : ℕ, ∃ n₀ : ℕ, ∀ n : ℕ, n₀ ≤ n → ∀ T : SimpleGraph (Fin (2 * n)),
    T.IsTree → MaxDegLE T Δ → Balanced T → EmbedsInPrimeSum T

end
end OpenProblems.QEDE230
