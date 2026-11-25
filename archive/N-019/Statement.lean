import Mathlib
/-! N-019: Voice leading is NP-hard
Moving n voices through a chord progression with the least total motion while avoiding parallel fifths should be computationally hard.
Informal statement: Show NP-hardness of minimizing $\sum_t\sum_i |x_{t+1,i}-x_{t,i}|$ over voicings of a given chord sequence with $n$ voices, subject to no parallel perfect fifths.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N019
def Claim : Prop := sorry
end OpenProblems.N019
