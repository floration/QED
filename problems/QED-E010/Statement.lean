import Mathlib
/-! QED-E010: Rotation-proof lattice-point-poor shapes
Among convex shapes of area A, how few lattice points can a shape be guaranteed to contain under every rotation about the origin? Can any shape do much better than a disc centred at the origin?
Informal statement: For $A>0$ let $m(A)=\inf\{\sup_{\theta}\#(\rho_\theta K\cap\mathbb Z^2): K\subset\mathbb R^2\text{ compact convex},\ |K|=A\}$. Decide whether $m(A)\ge A-O_\varepsilon(A^{1/4+\varepsilon})$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E010`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE010
def Claim : Prop := sorry
end OpenProblems.QEDE010
