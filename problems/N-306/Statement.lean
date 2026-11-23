import Mathlib
/-! N-306: Random greedy square-sum path
Build a path through 1 to N by always stepping to a random unused neighbour summing to a square. Find the expected length.
Informal statement: Determine $\lim_N\mathbb{E}[L_N]/N$ for the random greedy path in $S_N$ started at a uniform vertex.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N306
def Claim : Prop := sorry
end OpenProblems.N306
