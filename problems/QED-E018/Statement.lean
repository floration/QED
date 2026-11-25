import Mathlib
/-! QED-E018: Random Wang tiles
(Corrected.) Draw n Wang tiles whose four edge colours are chosen uniformly at random from c colours, and let c grow with n ≈ λc². How likely is the set to tile the plane? Show the probability has a limit F(λ) and find the critical λ above which tiling is almost certain.
Informal statement: Let $T_1,\dots,T_n$ be i.i.d. Wang tiles, each with its four edge colours i.i.d. uniform in $[c]$ and no rotations allowed. Let $n=\lfloor\lambda c^2\rfloor$ and $c\to\infty$. Prove that $F(\lambda)=\lim_{c\to\infty}\Pr(\{T_i\}\text{ tiles }\mathbb Z^2)$ exists for every $\lambda>0$. Determine $\lambda_c=\inf\{\lambda:F(\lambda)=1\}$; a first-moment heuristic suggests $\lambda_c=1$. Also determine $F$ on $(0,\lambda_c)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E018`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE018
def Claim : Prop := sorry
end OpenProblems.QEDE018
