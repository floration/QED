import Mathlib
/-! N-247: Largest factor of the midpoint
For consecutive primes p < q, look at the largest prime factor of (p + q)/2. Show it exceeds p^0.5 for a positive fraction.
Informal statement: Prove $\#\{n\le x: P(\tfrac{p_n+p_{n+1}}2)>p_n^{1/2}\}\gg \pi(x)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N247
def Claim : Prop := sorry
end OpenProblems.N247
