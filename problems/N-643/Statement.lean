import Mathlib
/-! N-643: Critical NLS mass on the cube
Focusing cubic Schrödinger blow-up in 2D needs the ground-state mass. On a cube surface the corners should lower the threshold to three quarters of it.
Informal statement: On the flat unit-cube surface $S$, consider $iu_t+\Delta u+|u|^2u=0$. Prove: $H^1$ data with $\|u_0\|_2^2<\tfrac34\|Q\|_{L^2(\mathbb R^2)}^2$ give global solutions, and for every $m>\tfrac34\|Q\|_2^2$ there is $H^1$ data of mass $m$ blowing up in finite time.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N643
def Claim : Prop := sorry
end OpenProblems.N643
