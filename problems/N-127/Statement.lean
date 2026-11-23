import Mathlib
/-! N-127: Random sequential prime-sum packing
Add random numbers from 1 to N one at a time, keeping a number only if it forms no prime sum with any kept number. Find the final density.
Informal statement: Determine $\lim_N\mathbb{E}|A_N|/N$ for the random sequential independent set of the prime-sum graph on $[N]$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N127
def Claim : Prop := sorry
end OpenProblems.N127
