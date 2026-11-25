import Mathlib
/-! N-665: Frozen vortices for Kuramoto on a cube
Identical Kuramoto oscillators on the grid of a cube surface tend to synchronize. Show that for large grids a stable state that is not synchronized also exists.
Informal statement: Let $Q_n$ be the vertex–edge graph of the $n\times n$ subdivided cube surface and $\dot\theta_i=\sum_{j\sim i}\sin(\theta_j-\theta_i)$. Prove that for all large $n$ there is a linearly stable equilibrium that is not of the form $\theta_i\equiv c$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N665
def Claim : Prop := sorry
end OpenProblems.N665
