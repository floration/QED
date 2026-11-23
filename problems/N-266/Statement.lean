import Mathlib
/-! N-266: Codes avoiding square distances
Find the largest set of binary strings of length n in which no two differ in a perfect-square number of positions. Find the exponential rate.
Informal statement: Let $A(n)$ be the largest $C\subseteq\{0,1\}^n$ with $d_H(x,y)$ never a positive perfect square for $x\ne y\in C$. Determine $\lim_n\frac1n\log_2A(n)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N266
def Claim : Prop := sorry
end OpenProblems.N266
