import Mathlib
/-! N-060: Monotile assembly threshold
With one tile shape, deciding whether a region can be tiled is easy in some cases; with many shapes it is hard. Find the smallest number of shapes where it becomes hard.
Informal statement: Find the least $t$ such that some fixed set of $t$ polygons makes "does this finite region admit an exact tiling?" NP-complete, and prove all sets of fewer polygons give polynomial-time problems.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N060
def Claim : Prop := sorry
end OpenProblems.N060
