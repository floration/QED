import Mathlib
/-! N-444: First appearances in Prime Nim
The smallest pile with Grundy value k in Prime Nim grows extremely fast. Show it grows at least exponentially in k.
Informal statement: Let $a(k)=\min\{n:G(n)=k\}$ for the prime subtraction game. Prove $a(k)\ge e^{ck}$ for some $c>0$ and all $k$ for which $a(k)$ exists.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N444
def Claim : Prop := sorry
end OpenProblems.N444
