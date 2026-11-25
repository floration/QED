import Mathlib
/-! N-672: A uniformly samplable counterexample to the poly-time low-degree conjecture
STATUS: NOT YET FORMALIZED
Find a uniform randomized polynomial-time sampler for a permutation-invariant graph distribution with vanishing low-degree advantage up to degree Theta((log n)^{r-1}) that is nevertheless detected by a polynomial-time test after constant-rate edge resampling (removing the non-uniform advice in Mao's counterexample).
Informal statement: For some fixed r>=3, give a single randomized algorithm that, given 1^n, samples in expected poly(n) time from a permutation-invariant distribution P_n on n-vertex graphs whose low-degree advantage over G(n,1/2) vanishes up to degree D_n=Theta((log n)^{r-1}), while after independent edge resampling at a fixed rate delta>0 a poly-time test distinguishes it from G(n,1/2) w.p. 1-o(1). A sufficient route via Mao's construction: find in poly(n) time evaluation points with every <=L of the vectors phi(x_i) linearly independent.
Formalization notes: Not formalized. Missing pieces: (1) a model of randomized polynomial-time algorithms (expected running time on input 1^n) and of polynomial-time tests, which Mathlib does not have (it has only Turing machines/partial recursive functions without a usable time-complexity theory); (2) the low-degree advantage (norm of the low-degree projection of the likelihood ratio over G(n,1/2)) and the noise operator for edge resampling; (3) the 1-o(1) distinguishing success over a family indexed by n. Items (2)-(3) are a few dozen lines of finite probability; item (1) is the blocker. Proving Claim would mean exhibiting such a sampler; ¬Claim would mean no uniform sampler exists.
-/
namespace OpenProblems.N672

def Claim : Prop := sorry

end OpenProblems.N672
