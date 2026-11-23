import Mathlib
/-! N-327: The shift-6 prime map
Map n to P(n) + P(n+6). Tested starts reach 6 or the loop 8 ↔ 9. Prove all do.
Informal statement: For $f(n)=P(n)+P(n+6)$, prove every orbit with $n\ge3$ reaches $\{6\}$ or $(8,9)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N327
def Claim : Prop := sorry
end OpenProblems.N327
