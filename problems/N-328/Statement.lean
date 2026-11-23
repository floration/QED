import Mathlib
/-! N-328: Factor plus next divisor-sum
Map n to P(n) plus the sum of distinct primes dividing n + 1. Every tested start falls into 16 → 19 → 26. Prove all do.
Informal statement: For $f(n)=P(n)+\mathrm{sopf}(n+1)$, prove every orbit with $n\ge2$ reaches $(16,19,26)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N328
def Claim : Prop := sorry
end OpenProblems.N328
