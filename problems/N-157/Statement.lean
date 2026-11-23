import Mathlib
/-! N-157: Lean golf is hard to approximate
Not only is the shortest basic-tactic proof hard to find; even a roughly short one is.
Informal statement: Prove intro/apply/exact/rfl proof minimization admits no constant-factor approximation unless P = NP.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N157
def Claim : Prop := sorry
end OpenProblems.N157
