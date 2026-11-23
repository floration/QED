import Mathlib
/-! N-225: Affine prime maps, quantitative
Show that for the map p ↦ largest prime factor of 3p + 4, almost every prime reaches its loop within about log log p steps.
Informal statement: For $p\mapsto P(3p+4)$, prove that for all but $o(\pi(x))$ primes $p\le x$ the orbit of $p$ enters its (unique observed) 7-cycle within $C\log\log p$ steps.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N225
def Claim : Prop := sorry
end OpenProblems.N225
