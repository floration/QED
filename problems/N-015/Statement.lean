import Mathlib
/-! N-015: Delayed firefighters
Fire spreads in four directions, but a firefighter assigned now only takes effect a turn later. How many per turn are needed?
Informal statement: On $\mathbb{Z}^2$ with 4-neighbour spread, cells chosen at turn $t$ become protected at turn $t+1$. Find the least per-turn number that contains a single fire.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N015
def Claim : Prop := sorry
end OpenProblems.N015
