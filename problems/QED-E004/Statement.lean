import Mathlib
/-! QED-E004: Closed-form Euler blow-up
Smooth compactly supported starting data for the 3D Euler equations that blow up in finite time are now known to exist, but the construction is an infinite iterative series. Give such data as an explicit formula.
Informal statement: Find an explicit divergence-free $u_0=\nabla\times\big(P(x)e^{-|x|^2}\big)$ with $P\in\mathbb{Q}[x_1,x_2,x_3]^3$ (or another explicitly specified finite closed-form class) such that the unforced 3D incompressible Euler solution on $\mathbb{R}^3$ with $u(0)=u_0$ has finite maximal smooth lifespan.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E004`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE004
def Claim : Prop := sorry
end OpenProblems.QEDE004
