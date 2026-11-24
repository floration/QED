import Mathlib
/-! N-308: Hitting probability for 2P(n)+1 random variant
With probability one half use 2P(n) + 1 and otherwise 2P(n) − 1. Show the walk visits 5 infinitely often.
Informal statement: For $X_{t+1}=2P(X_t)\pm1$ with fair signs, prove $X_t=5$ infinitely often almost surely.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N308
def Claim : Prop := sorry
end OpenProblems.N308
