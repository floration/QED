import Mathlib
/-! QED-E008: Two vortices on a cube
Two identical point vortices moving on the surface of a cube form a two-degree-of-freedom Hamiltonian system with no continuous symmetry, so there is no second conserved quantity to make it integrable. Prove their motion is genuinely chaotic.
Informal statement: Let $S$ be the boundary of the unit cube with its flat cone metric (eight cone points $v_i$ of angle $3\pi/2$), area $A=6$. Let $G$ solve $-\Delta_zG(z,w)=\delta_w-1/A$ with $\int_SG(\cdot,w)\,dA=0$, and let $R(z)=\lim_{w\to z}\big[G(z,w)+\tfrac1{2\pi}\log d(z,w)\big]$ for $z\notin\{v_i\}$. On $M=\{(z_1,z_2):z_1\ne z_2,\ z_j\notin\{v_i\}\}$ with $\omega=dA(z_1)+dA(z_2)$, let $H=G(z_1,z_2)+\tfrac12(R(z_1)+R(z_2))$. Prove that the Hamiltonian flow has a compact invariant set, inside one energy level, on which its topological entropy is positive.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E008`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE008
def Claim : Prop := sorry
end OpenProblems.QEDE008
