import Mathlib
/-! N-629: Drum tones of superellipses
Among regions x^p + y^p ≤ r of unit area, the circle (p = 2) has the lowest tone and the square (p = ∞) is back up high. Show the tone rises steadily as p goes from 2 to infinity.
Informal statement: Let $D_p=\{|x|^p+|y|^p\le r_p^p\}$ with $r_p$ chosen so $|D_p|=1$, and let $\lambda_1(p)$ be its first Dirichlet eigenvalue. Prove $\lambda_1$ is strictly increasing on $[2,\infty)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N629
def Claim : Prop := sorry
end OpenProblems.N629
