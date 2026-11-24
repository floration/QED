import Mathlib
/-! N-659: Fibonacci-modulated growing Jacobi matrix
Off-diagonal weights grow like √n but are doubled wherever the Fibonacci word has a 1. Periodic modulations give spectral phase transitions. Decide what this aperiodic one gives.
Informal statement: Let $f\in\{0,1\}^{\mathbb N}$ be the Fibonacci word and $J$ the Jacobi matrix with $a_n=\sqrt n\,(1+f_n)$, $b_n=0$. Determine the spectral type of $J$; in particular decide whether $J$ has absolutely continuous spectrum.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N659
def Claim : Prop := sorry
end OpenProblems.N659
