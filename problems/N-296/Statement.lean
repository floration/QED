import Mathlib
/-! N-296: Primes in the {5,8} funnel's tree
Look at which starting numbers reach 5 versus 8 first under n ↦ P(n) + P(n+1). Show both happen for a positive fraction of starts.
Informal statement: For $f(n)=P(n)+P(n+1)$, prove both $\{n:$ the orbit first meets the cycle at $5\}$ and $\{n:$ first at $8\}$ have positive lower density.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N296
def Claim : Prop := sorry
end OpenProblems.N296
