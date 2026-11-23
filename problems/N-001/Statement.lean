import Mathlib
/-! N-001: Wind-driven fire
On a grid, fire spreads each turn only east, north and south (the wind blocks westward spread). How few firefighters per turn can always trap a single burning cell?
Informal statement: On $\mathbb{Z}^2$, burning cells ignite neighbours at offsets $(1,0),(0,\pm1)$ each turn; $k$ unburnt cells are protected per turn. Find the least $k$ that always yields a finite burned set.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N001
def Claim : Prop := sorry
end OpenProblems.N001
