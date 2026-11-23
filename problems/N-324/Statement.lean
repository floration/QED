import Mathlib
/-! N-324: Mixed divisor-sum map
Add the sum of distinct prime factors of n to the largest prime factor of n + 1. Tested starts reach 14, 21, or loops through 5, 10, 31 or 82. Prove these are the only fates.
Informal statement: For $f(n)=\mathrm{sopf}(n)+P(n+1)$, prove every orbit reaches $\{14\},\{21\},(5,8),(10,18,24),(31,33)$ or $(82,126,139,146)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N324
def Claim : Prop := sorry
end OpenProblems.N324
