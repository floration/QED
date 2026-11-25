import Mathlib
/-! N-020: Real-rank hyperoperations
Addition, multiplication and exponentiation are ranks 1, 2, 3 of one ladder. Find natural rules that fix a unique operation at every real rank in between.
Informal statement: Find axioms (analytic in $s$, $a[s{+}1](b{+}1)=a[s](a[s{+}1]b)$, agreement with $+,\times,\uparrow$ at $s=1,2,3$) that determine $a[s]b$ uniquely for real $s\in[1,3]$, and prove uniqueness.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N020
def Claim : Prop := sorry
end OpenProblems.N020
