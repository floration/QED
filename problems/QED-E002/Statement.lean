import Mathlib
/-! QED-E002: Keller maps injective on integer points
Take a polynomial map of 3-space with integer coefficients whose Jacobian determinant is identically 1 (a Keller map). Show that if it never sends two different integer points to the same point, then it is a polynomial automorphism.
Informal statement: Let $F\in\mathbb{Z}[x,y,z]^3$ with $\det JF\equiv 1$. Prove that if $F|_{\mathbb{Z}^3}$ is injective, then $F$ has a polynomial inverse (equivalently, by Bia{\l}ynicki-Birula--Rosenlicht, $F$ is injective on $\mathbb{C}^3$).
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E002`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE002
def Claim : Prop := sorry
end OpenProblems.QEDE002
