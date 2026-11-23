import Mathlib
/-! N-275: Three consecutive largest factors
Replace n by P(n) + P(n + 1) + P(n + 2). Every tested start reaches the fixed point 14 or the loop 77 → 103 → 123 → 77. Prove it.
Informal statement: Prove every orbit of $n\mapsto P(n)+P(n+1)+P(n+2)$ on $n\ge2$ enters $\{14\}$ or $(77,103,123)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N275
def Claim : Prop := sorry
end OpenProblems.N275
