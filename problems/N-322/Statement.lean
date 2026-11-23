import Mathlib
/-! N-322: Largest plus smallest neighbour factor
Add the largest prime factor of n to the smallest prime factor of n + 1. Tested starts reach 5 → 7 → 9 or 22 → 34. Prove all do.
Informal statement: For $f(n)=P(n)+p(n+1)$, with $p$ the least prime factor, prove every orbit with $n\ge3$ reaches $(5,7,9)$ or $(22,34)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N322
def Claim : Prop := sorry
end OpenProblems.N322
