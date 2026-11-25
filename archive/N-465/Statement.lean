import Mathlib
/-! N-465: Prime Nim's mod-3 bias
Losing pile sizes in Prime Nim are about three times as likely to be 1 mod 3 as 0 mod 3. Find the exact limiting proportions.
Informal statement: For the prime subtraction game, prove the limits $\lim_x\#\{n\le x:G(n)=0,\ n\equiv r\ (3)\}/\#\{n\le x:G(n)=0\}$ exist for $r=0,1,2$, and determine them.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N465
def Claim : Prop := sorry
end OpenProblems.N465
