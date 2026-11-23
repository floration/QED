import Mathlib
/-! N-552: Digit-restricted Chowla
Show μ(n)μ(n+1) has no bias on numbers n where neither n nor n+1 contains the digit 7.
Informal statement: Prove $\sum_{n\le x,\ 7\notin n,\ 7\notin n+1}\mu(n)\mu(n+1)=o(x^{\log9/\log10})$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N552
def Claim : Prop := sorry
end OpenProblems.N552
