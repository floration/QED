import Mathlib
/-! N-334: The P(n)+P(n+2)−1 map
Map n to P(n) + P(n+2) − 1. Tested starts reach 4 or loops of length 18, 11 and 4. Prove these are all.
Informal statement: For $f(n)=P(n)+P(n+2)-1$, prove every orbit reaches $\{4\}$, the 18-cycle through $23$, the 11-cycle through $7$, or $(223,227,455,469)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N334
def Claim : Prop := sorry
end OpenProblems.N334
