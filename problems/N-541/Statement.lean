import Mathlib
/-! N-541: The 4p+1 funnel
Map a prime p to the largest prime factor of 4p + 1. Every prime tested falls into one loop of eight primes. Prove all do.
Informal statement: Prove every orbit of $p\mapsto P(4p+1)$ on primes enters the cycle $5\to7\to29\to13\to53\to71\to19\to11\to5$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N541
def Claim : Prop := sorry
end OpenProblems.N541
