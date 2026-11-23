import Mathlib
/-! N-332: Two small factors and one large
Add the smallest prime factors of n and n + 1 to the largest prime factor of n + 2. Every tested start falls into one seven-step loop through 16. Prove all do.
Informal statement: For $f(n)=p(n)+p(n+1)+P(n+2)$, prove every orbit with $n\ge2$ reaches $(16,22,28,36,58,66,86)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N332
def Claim : Prop := sorry
end OpenProblems.N332
