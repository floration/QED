import Mathlib
/-! N-010: Smallest-odd-factor Collatz
Halve even numbers; send an odd number to the smallest odd prime dividing 3n + 1. Find every cycle that occurs below a billion.
Informal statement: Let $g(n)=n/2$ ($n$ even) and $g(n)=q(3n+1)$ ($n$ odd), $q$ the least odd prime factor ($1$ if none). Classify all cycles of $g$ meeting $[1,10^9]$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N010
def Claim : Prop := sorry
end OpenProblems.N010
