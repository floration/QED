import Mathlib
/-! N-128: Prime factor plus digit sum
Add the largest prime factor of n to its digit sum. Every tested start ends in 6 → 9 → 12. Prove all do, which needs ruling out endless chains of primes p → p + digit sum.
Informal statement: For $f(n)=P(n)+s_{10}(n)$, prove every orbit with $n\ge2$ reaches the cycle $(6,9,12)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N128
def Claim : Prop := sorry
end OpenProblems.N128
