import Mathlib
/-! N-316: Formal verification depth of RH
The Riemann hypothesis now has a Lean proof. Show it cannot be proved in a weak arithmetic like I-Sigma-1 plus exponentiation, or show it can.
Informal statement: Decide whether RH (as a $\Pi^0_1$ sentence) is provable in $\mathrm{I}\Sigma_1$, or in $\mathrm{EFA}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N316
def Claim : Prop := sorry
end OpenProblems.N316
