import Mathlib
/-! N-276: P(n)+P(n+1)−1
Replace n by P(n) + P(n + 1) − 1. Every tested start ends in one of three loops. Prove these are the only ones.
Informal statement: Prove every orbit of $n\mapsto P(n)+P(n+1)-1$ on $n\ge2$ enters $(4,6,9,7,8)$, $(17,19,23,25)$ or $(167,173,201)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N276
def Claim : Prop := sorry
end OpenProblems.N276
