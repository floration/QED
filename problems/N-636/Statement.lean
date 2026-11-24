import Mathlib
/-! N-636: Euler with reversed stretching
Flip the sign of the vortex-stretching term in the 3D Euler equations, keeping the usual Biot–Savart law. Do smooth solutions stay smooth forever?
Informal statement: Consider $\omega_t+(u\cdot\nabla)\omega=-S\omega$ on $\mathbb T^3$, where $u=\nabla\times(-\Delta)^{-1}\omega$ and $S=\tfrac12(\nabla u+\nabla u^{T})$. Decide whether every $\omega_0\in C^\infty(\mathbb T^3)$ with mean zero yields a global smooth solution.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N636
def Claim : Prop := sorry
end OpenProblems.N636
