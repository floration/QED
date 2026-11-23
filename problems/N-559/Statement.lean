import Mathlib
/-! N-559: The 3p+4 seven-cycle
Send a prime p to the largest prime factor of 3p + 4. Every prime tested ends in the loop 11 → 37 → 23 → 73 → 223 → 673 → 17 → 11. Prove all do.
Informal statement: Prove every orbit of $p\mapsto P(3p+4)$ on primes enters the cycle $(11,37,23,73,223,673,17)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N559
def Claim : Prop := sorry
end OpenProblems.N559
