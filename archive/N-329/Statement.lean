import Mathlib
/-! N-329: Density of the basin of 22 ↔ 34
For n ↦ P(n) + p(n+1), about 6% of tested starts reach the 22 ↔ 34 loop. Show the fraction has a limit and it is positive.
Informal statement: For $f(n)=P(n)+p(n+1)$, prove $\lim_{x}\frac1x\#\{n\le x:\text{orbit reaches }(22,34)\}$ exists and is positive.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N329
def Claim : Prop := sorry
end OpenProblems.N329
