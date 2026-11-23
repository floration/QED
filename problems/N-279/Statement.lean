import Mathlib
/-! N-279: Last digits of consecutive largest factors
Look at the last digits of P(n) and P(n + 1). Show the 16 possible pairs of last digits from {1, 3, 7, 9} occur equally often.
Informal statement: Prove $\#\{n\le x: P(n)\equiv a,\ P(n+1)\equiv b\ (10)\}\sim\frac{x}{16}$ for all $a,b\in\{1,3,7,9\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N279
def Claim : Prop := sorry
end OpenProblems.N279
