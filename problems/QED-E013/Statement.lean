import Mathlib
/-! QED-E013: Burgers with degenerate critical dissipation
Critical half-Laplacian dissipation keeps Burgers smooth. Let that dissipation switch off quadratically at one point of the circle. Do shocks form there?
Informal statement: Let $a(x)=1-\cos x$ and consider $u_t+uu_x+\Lambda^{1/2}\big(a\,\Lambda^{1/2}u\big)=0$ on $\mathbb{T}$, $\Lambda=(-\partial_x^2)^{1/2}$. Decide whether every real $u_0\in C^\infty(\mathbb{T})$ yields a global smooth solution.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E013`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE013
def Claim : Prop := sorry
end OpenProblems.QEDE013
