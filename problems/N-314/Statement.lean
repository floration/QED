import Mathlib
/-! N-314: Four fates of P(n)+P(n+1)+1
Map n to P(n) + P(n+1) + 1. Tested starts reach the fixed point 9 or loops through 6, 19 or 61. Prove these are the only fates.
Informal statement: For $f(n)=P(n)+P(n+1)+1$, prove every orbit reaches $\{9\}$, $(6,11,15,8)$, $(19,25)$ or the 4-cycle through $61$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N314
def Claim : Prop := sorry
end OpenProblems.N314
