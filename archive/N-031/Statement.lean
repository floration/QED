import Mathlib
/-! N-031: Shortest proof that √2 is irrational
Find the shortest possible Lean proof that the square root of 2 is irrational, and prove nothing shorter works.
Informal statement: Over Lean 4 core tactics on top of Mathlib's definitions, find the minimal tactic-step proof of `Irrational (Real.sqrt 2)` and certify minimality.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N031
def Claim : Prop := sorry
end OpenProblems.N031
