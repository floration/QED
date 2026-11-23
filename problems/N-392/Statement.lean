import Mathlib
/-! N-392: Doubled-twin sieve upper bound
Bound the number of doubled-twin quadruples up to x by the predicted count times at most 3.
Informal statement: Prove $\#\{p\le x: p,p+2,2p+1,2p+3\text{ prime}\}\le(3+o(1))\,\mathfrak{S}x/\log^4x$, with $\mathfrak S$ the singular series.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N392
def Claim : Prop := sorry
end OpenProblems.N392
