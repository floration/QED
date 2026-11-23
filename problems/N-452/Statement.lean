import Mathlib
/-! N-452: Largest factor of n²+1 mod 8
The largest prime factor of n² + 1 is always 1 or 5 mod 8 (or 2). Show both happen equally often.
Informal statement: Prove $\#\{n\le x: P(n^2+1)\equiv1\ (8)\}\sim\#\{n\le x:P(n^2+1)\equiv5\ (8)\}\sim x/2$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N452
def Claim : Prop := sorry
end OpenProblems.N452
