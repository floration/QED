import Mathlib
/-! N-278: Three pairs
Replace n by P(n) + P(2n + 1). Every tested start ends in one of three two-step loops: 13 ↔ 16, 30 ↔ 66, 36 ↔ 76. Prove it.
Informal statement: Prove every orbit of $n\mapsto P(n)+P(2n+1)$ on $n\ge2$ enters $\{13,16\}$, $\{30,66\}$ or $\{36,76\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N278
def Claim : Prop := sorry
end OpenProblems.N278
