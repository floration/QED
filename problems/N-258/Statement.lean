import Mathlib
/-! N-258: Max-cut of the square-sum graph
Split the numbers up to N into two groups to cut as many square-sum pairs as possible. Find how far above one half you can get.
Informal statement: Prove $\mathrm{MaxCut}(S_N)=\big(\tfrac12+(c+o(1))N^{-1/4}\big)e(S_N)$ and determine $c$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N258
def Claim : Prop := sorry
end OpenProblems.N258
