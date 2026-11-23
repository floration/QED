import Mathlib
/-! N-313: Neighbour factors plus one
Map n to P(n − 1) + P(n + 1) + 1. Tested starts reach 8 → 11 → 9 or 10 → 15. Prove all do.
Informal statement: For $f(n)=P(n-1)+P(n+1)+1$, prove every orbit with $n\ge3$ reaches $(8,11,9)$ or $(10,15)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N313
def Claim : Prop := sorry
end OpenProblems.N313
