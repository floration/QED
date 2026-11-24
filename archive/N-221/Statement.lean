import Mathlib
/-! N-221: The square-sum avoidance game
Players take turns choosing unused numbers from 1 to N. Whoever picks a number summing to a square with any already-chosen number loses. Decide the winner for all large N.
Informal statement: Determine the outcome class of the avoidance game on $S_N$ (normal play, a move creating an $S_N$-edge inside the chosen set loses) for all sufficiently large $N$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N221
def Claim : Prop := sorry
end OpenProblems.N221
