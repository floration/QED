import Mathlib
/-! N-562: Exponential growth of square-plus-one orbits
Show square-plus-one sequences, when they don't loop, grow at a steady exponential rate in the number of digits.
Informal statement: Prove that for almost every $n$ (density 1), $\lim_{k}\frac1k\log\log Q^k(n)$ exists and equals a constant $\gamma>0$; identify $\gamma$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N562
def Claim : Prop := sorry
end OpenProblems.N562
