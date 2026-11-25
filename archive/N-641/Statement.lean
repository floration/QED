import Mathlib
/-! N-641: Burgers with degenerate critical dissipation
Critical half-Laplacian dissipation keeps Burgers smooth. Let that dissipation switch off at one point of the circle. Do shocks form there?
Informal statement: Let $a(x)=1-\cos x$ and consider $u_t+uu_x+\Lambda^{1/2}\big(a\,\Lambda^{1/2}u\big)=0$ on $\mathbb T$, $\Lambda=(-\partial_x^2)^{1/2}$. Decide whether every $u_0\in C^\infty(\mathbb T)$ yields a global smooth solution.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N641
def Claim : Prop := sorry
end OpenProblems.N641
