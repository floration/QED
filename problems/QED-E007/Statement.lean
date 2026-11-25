import Mathlib
/-! QED-E007: Frozen vortices for Kuramoto on a cube
Identical Kuramoto oscillators sit on the grid of a cube's surface. Besides full synchrony, there is a 'longitude' state with a vortex at the centre of the top face and an antivortex at the centre of the bottom face. Prove that this state is a linearly stable equilibrium for every grid size.
Informal statement: Let $Q_n$ be the vertex–edge graph of the $n\times n$ subdivided surface of the cube, and $\dot\theta_i=\sum_{j\sim i}\sin(\theta_j-\theta_i)$. Prove that for every odd $n\ge3$ there is an equilibrium $\theta^*$ with the cube's 4-fold rotational symmetry about the vertical axis and winding number $\pm1$ around the central plaquettes of the top and bottom faces, whose Jacobian (the Laplacian with edge weights $\cos(\theta^*_j-\theta^*_i)$) has kernel exactly $\mathrm{span}(\mathbf 1)$ and is otherwise positive. (More generally: for which $n$ does $Q_n$ have a stable non-synchronous equilibrium?)
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E007`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE007
def Claim : Prop := sorry
end OpenProblems.QEDE007
