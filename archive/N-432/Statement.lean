import Mathlib
/-! N-432: Square Nim from both ends
Two piles; a move removes a square from one pile or the same square from both. Find the losing positions' asymptotic density.
Informal statement: For moves $(a,b)\to(a-k^2,b),(a,b-k^2),(a-k^2,b-k^2)$, prove $\#\{(a,b)\in[N]^2:\mathcal P\}=N^{1+\theta+o(1)}$ and find $\theta$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N432
def Claim : Prop := sorry
end OpenProblems.N432
