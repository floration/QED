import Mathlib
/-! N-638: Minimal-mass blow-up with reflection
In the 2D Schrödinger equation where each point feels the density at its mirror point, blow-up needs at least the ground-state mass. Classify the solutions that blow up with exactly that mass.
Informal statement: For $i u_t+\Delta u+|u(-x,t)|^2u=0$ on $\mathbb R^2$ with $\|u_0\|_{L^2}=\|Q\|_{L^2}$ ($Q$ the cubic ground state), prove that every $H^1$ solution blowing up in finite time equals, up to phase and scaling, the pseudo-conformal transform of $Q$ centred at the origin.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N638
def Claim : Prop := sorry
end OpenProblems.N638
