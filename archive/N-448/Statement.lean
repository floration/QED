import Mathlib
/-! N-448: Few periodic points of square-plus-one
Count the numbers up to X that lie on a loop of the square-plus-one map. Show there are very few.
Informal statement: Prove $\#\{n\le X: Q^k(n)=n\text{ for some }k\ge1\}=X^{o(1)}$, where $Q(n)=P(n^2+1)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N448
def Claim : Prop := sorry
end OpenProblems.N448
