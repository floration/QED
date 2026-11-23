import Mathlib
/-! N-326: The parity-switch prime map
For even n add P(n) and P(n+1); for odd n add P(n) and P(n−1). Every tested start falls into one nine-step loop through 5. Prove all do.
Informal statement: For $f(n)=P(n)+P(n+(-1)^n)$, prove every orbit with $n\ge3$ reaches $(5,7,10,16,19,22,34,24,8)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N326
def Claim : Prop := sorry
end OpenProblems.N326
