import Mathlib
/-! N-250: Midpoint-prime orbit lengths
Find the average number of steps the midpoint-prime map takes to reach 1, on a logarithmic scale.
Informal statement: For the midpoint-prime map $m$, prove $\frac1x\sum_{n\le x}\frac{T_m(n)}{\log n}\to c$ and compute $c$, where $T_m(n)=\min\{k:m^k(n)=1\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N250
def Claim : Prop := sorry
end OpenProblems.N250
