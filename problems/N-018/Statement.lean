import Mathlib
/-! N-018: Mod-3 Collatz map
Divide by 3 when you can; otherwise double and add or subtract 1. Find all loops below a billion.
Informal statement: Let $h(n)=n/3$ if $3\mid n$, $2n+1$ if $n\equiv1$, $2n-1$ if $n\equiv2 \pmod 3$. Classify all cycles of $h$ meeting $[1,10^9]$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N018
def Claim : Prop := sorry
end OpenProblems.N018
