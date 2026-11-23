import Mathlib
/-! N-612: LF-Collatz loops classified forever
Show every largest-factor Collatz-type map for every odd multiplier has only finitely many loops, with a uniform recipe.
Informal statement: For every odd $a\ge3$, prove $f_a(n)=n/2$ (even), $P(an+1)$ (odd) has finitely many cycles, with an explicit bound in $a$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N612
def Claim : Prop := sorry
end OpenProblems.N612
