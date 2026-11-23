import Mathlib
/-! N-311: Stopping time law for P(n)+P(n+1)
For the map n ↦ P(n) + P(n+1), find the distribution of the number of steps to the {5, 8} loop.
Informal statement: Prove the stopping time $\sigma(n)$ of $f(n)=P(n)+P(n+1)$ satisfies $\sigma(n)/\log\log n\to c$ in density, and determine $c$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N311
def Claim : Prop := sorry
end OpenProblems.N311
