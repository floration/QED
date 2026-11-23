import Mathlib
/-! N-542: Three loops for 2p+3
Under p ↦ largest prime factor of 2p + 3, every tested prime ends in one of three loops. Prove there are no others.
Informal statement: Prove every orbit of $p\mapsto P(2p+3)$ on primes enters one of the cycles $\{3\}$, $\{5,13,29,61\}$, $\{43,89,181,73,149\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N542
def Claim : Prop := sorry
end OpenProblems.N542
