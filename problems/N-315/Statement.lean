import Mathlib
/-! N-315: Triple factor map minus two
Map n to P(n) + P(n+1) + P(n+2) − 2. Tested starts reach the fixed points 8 or 33, a 13-step loop through 20, or a 9-step loop through 177. Prove nothing else happens.
Informal statement: For $f(n)=P(n)+P(n+1)+P(n+2)-2$, prove every orbit reaches $\{8\}$, $\{33\}$, the 13-cycle through $20$, or the 9-cycle through $177$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N315
def Claim : Prop := sorry
end OpenProblems.N315
