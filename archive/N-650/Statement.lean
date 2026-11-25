import Mathlib
/-! N-650: Two vortices on a cube
Two identical point vortices on the surface of a cube have no symmetry to make them integrable. Show their motion is chaotic.
Informal statement: Let $G$ be the Green function of the flat unit-cube surface $S$ and $R$ its Robin function. Show the Hamiltonian $H(z_1,z_2)=G(z_1,z_2)+\tfrac12(R(z_1)+R(z_2))$ on $S\times S\setminus\Delta$, with symplectic form $dA_1+dA_2$, has an energy level on which the flow has positive topological entropy.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N650
def Claim : Prop := sorry
end OpenProblems.N650
