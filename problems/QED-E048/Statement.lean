import Mathlib
/-! QED-E048: Equilateral stick number versus stick number
Build a knot out of straight sticks joined end to end. The stick number of a knot is the fewest sticks that can make it. If all the sticks must also be the same length, you might need more. Is there any knot that really does need more sticks when they all have to be the same length?
Informal statement: For a knot type $K$ let $s(K)$ be the minimum number of edges of a polygonal knot in $\mathbb R^3$ of type $K$, and $s_{eq}(K)$ the minimum over polygons with all edges of equal length. Trivially $s_{eq}(K)\ge s(K)$. Is there a knot type $K$ with $s_{eq}(K)>s(K)$? Alternatively, prove $s_{eq}=s$ for all $K$, or for an infinite family such as all torus knots.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E048`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE048
def Claim : Prop := sorry
end OpenProblems.QEDE048
