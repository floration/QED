import Mathlib
/-! N-115: Leaky firefighting
Fire spreads to each neighbour only with probability p. Find the largest p at which one firefighter per turn wins.
Informal statement: On $\mathbb{Z}^2$ with each burning–unburnt edge transmitting independently with probability $p$, find $p^*$ such that one protection per turn contains the fire a.s. iff $p<p^*$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N115
def Claim : Prop := sorry
end OpenProblems.N115
