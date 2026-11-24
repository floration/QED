import Mathlib
/-! N-561: Escaping p²+p+1
Start at 2 and repeatedly take the largest prime factor of p² + p + 1. Show the sequence grows without bound.
Informal statement: Prove the orbit of $2$ under $p\mapsto P(p^2+p+1)$ is unbounded.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N561
def Claim : Prop := sorry
end OpenProblems.N561
