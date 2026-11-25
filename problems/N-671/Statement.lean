import Mathlib
/-! N-671: All-Edges Triangle in the (n, n, sqrt n) tripartite regime
STATUS: NOT YET FORMALIZED
Given a tripartite graph with parts A, B, C of sizes n, n, ceil(sqrt n) and O(n^{3/2}) edges,
report for every edge whether it lies in a triangle. Bitset methods give O(n^2 / log n) time.
The question is whether some algorithm runs in time O(n^{2-ε}).
Informal statement: Is there ε > 0 and a randomized word-RAM algorithm that, given a tripartite
graph on parts A, B, C with |A| = |B| = n, |C| = ceil(sqrt n) and O(n^{3/2}) edges, decides for
every edge whether it lies in a triangle in time O(n^{2-ε}) (with success probability ≥ 2/3)?
(A negative answer would be a fine-grained reduction showing this regime is as hard as balanced
All-Edges Sparse Triangle, m^{4/3-o(1)}, noting m^{4/3} = n^2 here.)
Formalization notes: Not formalized. A faithful statement needs a model of computation with
running-time accounting (word-RAM with O(log n)-bit words and randomness), the notion of an
algorithm solving the All-Edges Triangle problem on all inputs of the given shape, and
asymptotic time bounds over that model. Mathlib has none of this (Turing machines exist only
without a usable time-complexity theory for RAM algorithms). The "show it is as hard as" branch
is a fine-grained reduction statement, which additionally needs a notion of reductions between
problems. Proving `Claim` would mean exhibiting such an algorithm; `¬Claim` would be an
unconditional lower bound, far beyond current techniques.
-/
namespace OpenProblems.N671
def Claim : Prop := sorry
end OpenProblems.N671
