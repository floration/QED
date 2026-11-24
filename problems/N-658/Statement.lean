import Mathlib
/-! N-658: Jacobi matrix of primes
Use the primes as the off-diagonal entries of a Jacobi matrix. Known criteria for absolutely continuous spectrum just fail because prime gaps fluctuate. Decide the spectral type.
Informal statement: Let $J$ be the Jacobi matrix on $\ell^2(\mathbb N)$ with $a_n=p_n$ (the $n$-th prime) and $b_n=0$, which is self-adjoint since $\sum1/p_n=\infty$. Decide whether the spectrum of $J$ is purely absolutely continuous on $\mathbb R$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N658
def Claim : Prop := sorry
end OpenProblems.N658
