import Mathlib
/-! N-277: Three halves of the largest factor
Replace n by the integer part of (3P(n) + 1)/2. Every tested start falls into the loop 3 → 5 → 8 → 3. Prove all do.
Informal statement: Prove every orbit of $n\mapsto\lfloor(3P(n)+1)/2\rfloor$ on $n\ge2$ enters $(3,5,8)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N277
def Claim : Prop := sorry
end OpenProblems.N277
