import Mathlib
/-! N-621: Chaos in the symmetric ABC flow
The ABC flow with all three coefficients equal to 1 is a classical steady solution of the Euler equations on the 3-torus. Prove it is genuinely chaotic.
Informal statement: Prove that the flow of $\dot x=\sin z+\cos y,\ \dot y=\sin x+\cos z,\ \dot z=\sin y+\cos x$ on $\mathbb T^3$ has positive topological entropy.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N621
def Claim : Prop := sorry
end OpenProblems.N621
