import Mathlib
/-! N-003: Lonely runner with one fast runner
Runners have speeds 1, 2, 3 and some larger speed m. Work out exactly how lonely a stationary runner is guaranteed to get, depending on m.
Informal statement: Compute $\delta(m)=\sup_t\min(\|t\|,\|2t\|,\|3t\|,\|mt\|)$ in closed form for all integers $m\ge4$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N003
def Claim : Prop := sorry
end OpenProblems.N003
