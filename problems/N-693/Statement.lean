import Mathlib
/-! N-693: Densest k-Subgraph and k-Biclique FPT-inapproximability from plain ETH
STATUS: NOT YET FORMALIZED
Prove, assuming only ETH (not Gap-ETH), that Densest k-Subgraph admits no FPT approximation within any
factor g(k) = ω(1).
Informal statement: Assuming only (deterministic) ETH, prove there is no f(k)·n^{O(1)}-time algorithm that
approximates (uncolored) Densest k-Subgraph within any factor g(k) = ω(1). (The k-Biclique disjunct of
the original W is already known under ETH: Lin, JACM 2018, arXiv:1406.3700.)
Formalization notes: Not formalized. Missing pieces: (1) a machine model with running-time
bounds (Turing machines or RAM) and encodings of graphs as inputs; (2) the Exponential Time Hypothesis
(no 2^{o(n)}-time algorithm for 3-SAT) as a Prop over that model; (3) parameterized running time
f(k)·poly(n) for arbitrary computable f and the notion of a g(k)-approximation algorithm for a
maximization problem; (4) the conditional implication ETH → no such algorithm. Mathlib's
`Turing` machines lack a usable time-complexity theory; building it is several hundred lines.
-/
namespace OpenProblems.N693

def Claim : Prop := sorry

end OpenProblems.N693
