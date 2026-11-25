import Mathlib
/-! N-007: Lean golf is NP-hard
Show that finding the shortest proof using only a few basic Lean tactics is computationally hard.
Informal statement: Prove NP-hardness of: given a Lean 4 goal and $k$ in unary, is there a proof using only intro, apply, exact, rfl with at most $k$ steps?
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N007
def Claim : Prop := sorry
end OpenProblems.N007
