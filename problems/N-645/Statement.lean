import Mathlib
/-! N-645: Quintic Szegő growth
The cubic Szegő equation on the circle is integrable and its solutions' high Sobolev norms can grow without bound. Decide what the quintic version does.
Informal statement: For $iu_t=\Pi(|u|^4u)$ on $L^2_+(\mathbb T)$ ($\Pi$ the Szegő projector), decide whether there is $u_0\in C^\infty\cap L^2_+$ with $\limsup_{t\to\infty}\|u(t)\|_{H^s}=\infty$ for some $s>\tfrac12$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N645
def Claim : Prop := sorry
end OpenProblems.N645
