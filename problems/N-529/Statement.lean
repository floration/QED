import Mathlib
/-! N-529: SOF Collatz with 5n + 1
Use the smallest odd factor of 5n + 1 instead of 3n + 1. Show every start ends in a loop.
Informal statement: Prove every orbit of $n\mapsto n/2$ (even), $\mathrm{spf}_{\text{odd}}(5n+1)$ (odd) is eventually periodic.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N529
def Claim : Prop := sorry
end OpenProblems.N529
