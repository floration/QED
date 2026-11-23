import Mathlib
/-! N-471: Two long loops
Replace n by P(3n + 1) + P(n). Every tested start ends in one of two long loops, through 46 or through 80. Prove there are no others.
Informal statement: Prove every orbit of $n\mapsto P(3n+1)+P(n)$ on $n\ge2$ enters the 9-cycle through 46 or the 7-cycle through 80.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N471
def Claim : Prop := sorry
end OpenProblems.N471
