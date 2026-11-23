import Mathlib
/-! N-312: The shift-3 prime map
Add the largest prime factors of n and n + 3. Every tested start falls into 6, the loop 8 → 13 → 15, or the loop 10 → 18. Prove all do.
Informal statement: For $f(n)=P(n)+P(n+3)$, prove every orbit with $n\ge3$ reaches $\{6\}$, $(8,13,15)$ or $(10,18)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N312
def Claim : Prop := sorry
end OpenProblems.N312
