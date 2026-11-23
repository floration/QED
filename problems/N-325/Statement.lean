import Mathlib
/-! N-325: Lopsided neighbour map
Map n to P(n) + 2P(n+1). Except for the fixed point 8, every tested start from 3 upward falls into 23 → 29 → 39. Prove this for all starts.
Informal statement: For $f(n)=P(n)+2P(n+1)$, prove every orbit with $n\ge3$, $n\ne8$, reaches $(23,29,39)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N325
def Claim : Prop := sorry
end OpenProblems.N325
