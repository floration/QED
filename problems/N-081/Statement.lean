import Mathlib
/-! N-081: Building a firebreak
Firefighters must build one connected wall, one cell per turn, each next to the last. Can they ever enclose the fire?
Informal statement: On $\mathbb{Z}^2$, each turn add one protected cell 8-adjacent to the previous one. Decide whether a single fire can be enclosed, and for which build rates.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N081
def Claim : Prop := sorry
end OpenProblems.N081
