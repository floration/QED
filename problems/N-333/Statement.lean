import Mathlib
/-! N-333: The P(n)+P(n+2)+1 map
Map n to P(n) + P(n+2) + 1. Tested starts reach 6, 8, or loops through 9 (12 steps), 19 or 37. Prove these are all.
Informal statement: For $f(n)=P(n)+P(n+2)+1$, prove every orbit reaches $\{6\},\{8\}$, the 12-cycle through $9$, $(19,27,33)$ or $(37,51,71,145)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N333
def Claim : Prop := sorry
end OpenProblems.N333
