import Mathlib
/-! N-499: Largest-factor Collatz for all n
Prove every start reaches a loop under the largest-factor Collatz map.
Informal statement: Prove every orbit of $f(n)=n/2$ (even), $P(3n+1)$ (odd) is eventually periodic.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N499
def Claim : Prop := sorry
end OpenProblems.N499
