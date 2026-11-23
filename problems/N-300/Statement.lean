import Mathlib
/-! N-300: Rotation-proof lattice-point-poor shapes
Find the shape in the plane with given area that contains the fewest integer lattice points after any rotation, asymptotically.
Informal statement: Determine the convex $K$ of area $A$ minimising $\sup_{\theta}\#(\rho_\theta K\cap\mathbb{Z}^2)$, asymptotically as $A\to\infty$, to second-order term.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N300
def Claim : Prop := sorry
end OpenProblems.N300
