import Mathlib
/-! N-640: Heat with a cosine reaction
In u_t = u_xx + cos(x)u², the reaction averages to zero, but a second-order effect looks like +u³, the borderline Fujita case. Does every positive start blow up?
Informal statement: Prove or disprove: for every $0\le u_0\in C_c(\mathbb R)$, $u_0\not\equiv0$, the solution of $u_t=u_{xx}+\cos(x)\,u^2$ on $\mathbb R$ blows up in finite time.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N640
def Claim : Prop := sorry
end OpenProblems.N640
