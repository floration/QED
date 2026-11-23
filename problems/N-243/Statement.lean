import Mathlib
/-! N-243: Discrete sofa
Slide and rotate a polyomino by unit steps and quarter turns around the corner of a corridor k cells wide. Find the largest area possible, asymptotically.
Informal statement: Let $D(k)$ be the maximal number of cells of a polyomino that can pass the width-$k$ L-shaped corridor of $\mathbb{Z}^2$ by unit translations and $90^\circ$ rotations about lattice points (staying inside at all times). Prove $D(k)\sim ck^2$ and find $c$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N243
def Claim : Prop := sorry
end OpenProblems.N243
