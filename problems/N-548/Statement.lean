import Mathlib
/-! N-548: Affine prime maps all settle
Fix whole numbers a and b. Send a prime p to the largest prime factor of ap + b. Every case tested falls into a loop. Prove this always happens.
Informal statement: Prove that for all fixed integers $a\ge2$, $b\ge1$, every orbit of $p\mapsto P(ap+b)$ on primes is eventually periodic.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N548
def Claim : Prop := sorry
end OpenProblems.N548
