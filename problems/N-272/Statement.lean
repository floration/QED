import Mathlib
/-! N-272: Two loops for P(n)+P(n+2)
Replace n by P(n) + P(n + 2). Every tested start ends in 7 → 10 → 8 → 7 or in 9 → 14 → 9. Prove there are no other outcomes.
Informal statement: Prove every orbit of $n\mapsto P(n)+P(n+2)$ on $n\ge2$ enters $\{7,10,8\}$ or $\{9,14\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N272
def Claim : Prop := sorry
end OpenProblems.N272
