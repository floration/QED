import Mathlib
/-! N-626: Sup norms on the Fermat quartic
On a sphere, some eigenfunctions pile up at the poles as much as possible. Show this cannot happen on the surface x⁴+y⁴+z⁴ = 1.
Informal statement: Let $S=\{x^4+y^4+z^4=1\}$ with the induced metric and $\Delta\varphi=-\lambda\varphi$, $\|\varphi\|_{L^2(S)}=1$. Prove that $\|\varphi\|_{L^\infty(S)}=o(\lambda^{1/4})$ as $\lambda\to\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N626
def Claim : Prop := sorry
end OpenProblems.N626
