import Mathlib
/-! N-305: Percolation threshold of the square-sum graph
Keep each edge of the square-sum graph with probability p. Find the exact threshold for a giant component as N grows.
Informal statement: For bond percolation on $S_N$ with $p=c/\sqrt N$, determine $c^*$ such that a component of size $\Theta(N)$ appears w.h.p. iff $c>c^*$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N305
def Claim : Prop := sorry
end OpenProblems.N305
