import Mathlib
/-! N-483: Doubled prime map with a 1231 loop
Map n to twice its largest prime factor plus the largest prime factor of n + 1. Starts below 150,000 reach either a five-step loop through 93 or a three-step loop through 1231. Prove there are no other fates.
Informal statement: For $f(n)=2P(n)+P(n+1)$, prove every orbit reaches $(93,109,229,481,315)$ or $(1231,2473,6183)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N483
def Claim : Prop := sorry
end OpenProblems.N483
