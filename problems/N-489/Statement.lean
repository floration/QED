import Mathlib
/-! N-489: Two large factors and one small
Add P(n), P(n+1) and the smallest prime factor of n + 2. Tested starts reach 14, 33, or loops through 10, 42, 67, 97 or 3307. Prove these seven are the only fates.
Informal statement: For $f(n)=P(n)+P(n+1)+p(n+2)$, prove every orbit reaches $\{14\},\{33\},(10,18,24),(42,52,68),(67,87,129,187),(97,107,219)$ or $(3307,4137,6405)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N489
def Claim : Prop := sorry
end OpenProblems.N489
