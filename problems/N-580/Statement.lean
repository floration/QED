import Mathlib
/-! N-580: SOF Collatz is undecidable in general
Show some natural family of smallest-factor Collatz maps has an undecidable reach-1 question.
Informal statement: Prove the problem "given $a,b$, does every orbit of $n\mapsto n/2$ or $\mathrm{spf}(an+b)$ reach 1?" is undecidable.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N580
def Claim : Prop := sorry
end OpenProblems.N580
