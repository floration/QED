import Mathlib
/-! N-323: Sum of prime divisors of neighbours
Add the sum of the distinct prime factors of n to that of n + 1. Tested starts reach 33 or loops through 10, 17, 30 or 107. Prove there is nothing else.
Informal statement: For $f(n)=\mathrm{sopf}(n)+\mathrm{sopf}(n+1)$, prove every orbit reaches $\{33\}$, $(10,18,24)$, $(17,22,36,42,55,25,20)$, $(30,41,53,58,90)$ or $(107,112,122)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N323
def Claim : Prop := sorry
end OpenProblems.N323
