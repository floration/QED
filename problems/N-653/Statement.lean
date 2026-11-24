import Mathlib
/-! N-653: Ising spin at a cube corner
Glue three quarter-planes of the square grid into the surface of an infinite cube corner and run the critical Ising model. Prove the corner spin decorrelates with the exponent 7/24 that conformal field theory predicts.
Informal statement: Let $\Gamma$ be the union of the three quadrant grids $\mathbb Z_{\ge0}^2$ on the faces of the octant boundary, glued along the axes, with apex $o$. For the critical nearest-neighbour Ising model on $\Gamma$ prove $\langle\sigma_o\sigma_x\rangle\asymp|x|^{-7/24}$ as $|x|\to\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N653
def Claim : Prop := sorry
end OpenProblems.N653
