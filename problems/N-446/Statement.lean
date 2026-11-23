import Mathlib
/-! N-446: Seven-free squares
Count the numbers up to x whose square has no digit 7. Show the count matches the random-digit prediction.
Informal statement: Prove $\#\{n\le x: 7\notin n^2\}=x^{1+2\log_{10}(9/10)+o(1)}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N446
def Claim : Prop := sorry
end OpenProblems.N446
