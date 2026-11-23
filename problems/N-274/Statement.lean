import Mathlib
/-! N-274: Doubling minus one
Replace n by twice its largest prime factor minus one. Every tested start ends in 5 ↔ 9 or in the loop 37 → 73 → 145 → 57 → 37. Prove there is nothing else.
Informal statement: Prove every orbit of $n\mapsto 2P(n)-1$ on $n\ge2$ enters $\{5,9\}$ or $(37,73,145,57)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N274
def Claim : Prop := sorry
end OpenProblems.N274
