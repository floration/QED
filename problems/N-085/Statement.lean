import Mathlib
/-! N-085: Benford orbits
The leading digits of largest-factor Collatz orbits should follow Benford's law.
Informal statement: Prove that for almost all $n$ the leading digits of $(f^k(n))_{k\le T(n)}$ satisfy Benford's law as $n\to\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N085
def Claim : Prop := sorry
end OpenProblems.N085
