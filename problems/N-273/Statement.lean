import Mathlib
/-! N-273: Doubling the largest factor
Replace n by twice its largest prime factor plus one. Every tested start falls into one loop of eight numbers. Prove all do.
Informal statement: Prove every orbit of $n\mapsto 2P(n)+1$ on $n\ge2$ enters the cycle $(7,15,11,23,47,95,39,27)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N273
def Claim : Prop := sorry
end OpenProblems.N273
