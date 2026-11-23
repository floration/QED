import Mathlib
/-! N-271: The {5, 8} funnel
Replace n by the sum of the largest prime factors of n and n + 1. Every start tested falls into the loop 5 → 8 → 5. Prove all do.
Informal statement: Let $f(n)=P(n)+P(n+1)$ (with $P(1)=1$). Prove every orbit of $f$ on $n\ge2$ enters the cycle $\{5,8\}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N271
def Claim : Prop := sorry
end OpenProblems.N271
