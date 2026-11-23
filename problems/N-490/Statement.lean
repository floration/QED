import Mathlib
/-! N-490: The 2n+3 map
Map n to P(2n + 3) + P(n). Orbits can climb past seven million before falling, yet every tested start ends in loops through 6, 9 or 50. Prove all do.
Informal statement: For $f(n)=P(2n+3)+P(n)$, prove every orbit reaches $(6,8,21,12)$, $(9,10,28,66,16)$ or $(50,108,76)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N490
def Claim : Prop := sorry
end OpenProblems.N490
