import Mathlib
/-! N-610: Unforced blow-up near the forced one
Show the known forced Navier–Stokes blow-up can be made to work with forcing that decays to zero at the blow-up time.
Informal statement: Prove there exist smooth $u_0$ and $f\in L^1_tL^2_x\cap C^\infty$ with $\|f(t)\|_{L^2}\to0$ as $t\to T^-$ such that the forced 3D NS solution blows up at $T$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N610
def Claim : Prop := sorry
end OpenProblems.N610
