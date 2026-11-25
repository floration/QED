import Mathlib
/-! N-347: Alternating prime residues
Find ten consecutive primes whose remainders mod 4 alternate 1, 3, 1, 3, …, and infinitely many such runs.
Informal statement: Prove infinitely many $n$ with $p_{n+i}\equiv 2+(-1)^{i}\pmod 4$ for $0\le i<10$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N347
def Claim : Prop := sorry
end OpenProblems.N347
