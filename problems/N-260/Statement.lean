import Mathlib
/-! N-260: The 89–233 basin
The square-plus-one map has the loop 89 ↔ 233. Each prime has only finitely many direct predecessors, so the question is whether the tree of predecessors is infinite. Decide whether infinitely many starting numbers fall into the loop.
Informal statement: Decide whether infinitely many $n$ have $Q^k(n)\in\{89,233\}$ for some $k$, where $Q(n)=P(n^2+1)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N260
def Claim : Prop := sorry
end OpenProblems.N260
