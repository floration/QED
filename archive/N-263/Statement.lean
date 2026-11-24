import Mathlib
/-! N-263: Square-sum ordering with bounded displacement
Order all positive integers so neighbours always sum to squares, and no number moves more than a fixed distance from its natural place.
Informal statement: Decide whether there is a bijection $\pi:\mathbb{N}\to\mathbb{N}$ with $\pi(i)+\pi(i+1)$ always a square and $\sup_i|\pi(i)-i|/\sqrt i<\infty$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N263
def Claim : Prop := sorry
end OpenProblems.N263
