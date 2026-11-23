import Mathlib
/-! N-472: Neighbours' largest factors
Replace n by P(n − 1) + P(n + 1). Every tested start ends at 5 or in one of three loops, of lengths 11, 18 and 4. Prove there is nothing else.
Informal statement: Prove every orbit of $n\mapsto P(n-1)+P(n+1)$ on $n\ge3$ enters $\{5\}$, the 11-cycle through 8, the 18-cycle through 24, or $(224,228,456,470)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N472
def Claim : Prop := sorry
end OpenProblems.N472
