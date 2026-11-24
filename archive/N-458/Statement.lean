import Mathlib
/-! N-458: Digit-restricted Liouville
Show the Liouville function has no bias on seven-free numbers in short intervals.
Informal statement: Prove $\sum_{x<n\le x+H,\ 7\notin n}\lambda(n)=o(\#\{x<n\le x+H:7\notin n\})$ for almost all $x\le X$, with $H=X^{0.1}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N458
def Claim : Prop := sorry
end OpenProblems.N458
