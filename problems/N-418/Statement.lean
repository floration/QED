import Mathlib
/-! N-418: Hyperdissipative forced blow-up
Fluids with extra strong viscosity never blow up above a known threshold. Show forced blow-up still happens just below it.
Informal statement: For $\partial_tu+(u\cdot\nabla)u+\nabla p=-(-\Delta)^{\alpha}u+f$ on $\mathbb{R}^3$, construct smooth compactly supported $f$ giving finite-time blow-up from rest for every $\alpha<5/4$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N418
def Claim : Prop := sorry
end OpenProblems.N418
