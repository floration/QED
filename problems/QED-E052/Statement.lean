import Mathlib
/-! QED-E052: A shape with Heesch number 7
Some shapes cannot tile the whole plane but can still be surrounded by a ring of copies of themselves, and that ring by another ring, and so on, up to some limit. The number of rings possible is the shape's Heesch number. The record is 6, found in 2021. Find a shape whose Heesch number is finite but at least 7.
Informal statement: For a closed topological disk $T\subset\mathbb R^2$ that does not tile the plane, the Heesch number $H(T)$ is the largest $k$ such that there is a patch of congruent copies of $T$ made of $T$ surrounded by $k$ successive coronas. Each corona is a ring of copies covering a neighbourhood of the previous patch's boundary, and each intermediate union must be a closed disk (no holes). Exhibit $T$ with $7\le H(T)<\infty$. Polyform version: exhibit a polyomino, polyhex or polyiamond with $7\le H<\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E052`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE052
def Claim : Prop := sorry
end OpenProblems.QEDE052
