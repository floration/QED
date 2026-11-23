import Mathlib
/-! N-551: Undecidable prime-factor maps
Show no algorithm can decide, given a and b, whether every orbit of n ↦ n/2 (even) or the largest prime factor of an + b (odd) eventually loops.
Informal statement: Prove $\{(a,b)\in\mathbb{N}^2:$ every orbit of $n\mapsto n/2$ ($n$ even), $P(an+b)$ ($n$ odd) is eventually periodic$\}$ is not recursive, or prove it is.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N551
def Claim : Prop := sorry
end OpenProblems.N551
