import Mathlib
/-! QED-E005: Drum tones of superellipses
Take the region |x|^p + |y|^p <= r^p, scaled to have area 1. At p = 2 it is a disk, which has the lowest possible bass note of any region of that area (Faber–Krahn). As p grows to infinity it becomes a square, whose note is higher. Show that the note rises steadily the whole way from p = 2 to infinity.
Informal statement: For $p\in[2,\infty)$ let $D_p=\{(x,y):|x|^p+|y|^p\le r_p^p\}$ with $r_p$ chosen so that $|D_p|=1$, and let $\lambda_1(p)$ be the first Dirichlet eigenvalue of $-\Delta$ on $D_p$. Prove that $\lambda_1$ is strictly increasing on $[2,\infty)$, with $\lambda_1(2)=\pi j_{0,1}^2$ and $\lambda_1(p)\uparrow2\pi^2$ as $p\to\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E005`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE005
def Claim : Prop := sorry
end OpenProblems.QEDE005
