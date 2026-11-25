import Mathlib
/-! QED-E184: A flat cyclotomic polynomial with five odd prime factors
Call the cyclotomic polynomial Phi_n flat if every coefficient is -1, 0 or 1. Flat examples are known when n has up to four distinct odd prime factors (for example Phi_{3*5*31*929}). Is there a flat Phi_n where n has five distinct odd prime factors? None has ever been found, and no reason is known why they cannot exist.
Informal statement: Let $\omega_{\mathrm{odd}}(n)$ be the number of distinct odd primes dividing $n$. Does there exist $n$ with $\omega_{\mathrm{odd}}(n)=5$ such that every coefficient of $\Phi_n(x)\in\mathbb Z[x]$ lies in $\{-1,0,1\}$? (Since $\Phi_{2m}(x)=\pm\Phi_m(-x)$ for odd $m>1$ and $\Phi_{n}(x)=\Phi_{\mathrm{rad}(n)}(x^{n/\mathrm{rad}(n)})$, one may assume $n=p_1p_2p_3p_4p_5$ with distinct odd primes.)
Formalization notes: Uses Mathlib's `Polynomial.cyclotomic n ℤ` (the n-th cyclotomic polynomial over ℤ; it is 1 for n = 0, but n = 0 has no prime factors so is excluded) and `Nat.primeFactors` (the finset of primes dividing n). `Claim` = some n with exactly five distinct odd prime factors has all coefficients of Φ_n in {−1, 0, 1} (coefficients beyond the degree are 0, which is allowed). `¬Claim` = no flat cyclotomic polynomial of odd order 5 exists. Either settles the problem. The reduction to squarefree odd n in the informal statement is a remark, not used.
-/
namespace OpenProblems.QEDE184

/-- Some `Φ_n` with exactly five distinct odd prime factors of `n` is flat. -/
def Claim : Prop :=
  ∃ n : ℕ, (n.primeFactors.filter (fun p : ℕ => p ≠ 2)).card = 5 ∧
    ∀ i : ℕ, (Polynomial.cyclotomic n ℤ).coeff i ∈ ({-1, 0, 1} : Set ℤ)

end OpenProblems.QEDE184
