import Mathlib
/-! N-702: Sparse 3-LPN at noise n^{-1/2}: beating Gaussian elimination
STATUS: NOT YET FORMALIZED
For 3-sparse LPN with m = n^{1.4} samples and noise rate η = n^{-0.6}, is there an algorithm running in
time exp(o(ηn))? (The original also offers, as an alternative, lower bounds in restricted models such
as low-degree or SoS.)
Informal statement: Fix k = 3, m = ⌊n^{1.4}⌋ and η = n^{-0.6}. In the 3-sparse LPN problem a secret s ∈ F_2^n is uniform, each sample is (a_i, ⟨a_i,s⟩ + e_i) with a_i uniform among weight-3 vectors of F_2^n and e_i ~ Bernoulli(η) independent, i = 1..m. Prove or disprove: there is a (classical, randomized) algorithm that, given the m samples, outputs s with probability ≥ 2/3 in time exp(o(ηn)) = exp(o(n^{0.4})).
Formalization notes: Not formalized. The original M field contained only motivation, not a
statement; the informal statement above is the proposed fix (algorithmic side only). Missing pieces:
(1) a model of computation with running time (Turing machines or RAM with time bounds) and randomized
algorithms over families of input sizes; (2) the asymptotic class exp(o(ηn)) over a uniform algorithm
family. The alternative "lower bound" side is model-dependent (low-degree polynomials, SoS, SQ) and is
a different statement; it should become a separate problem if kept. Proving Claim means giving such an
algorithm; ¬Claim would be an unconditional lower bound against all algorithms, far beyond current
techniques.
-/
namespace OpenProblems.N702

def Claim : Prop := sorry

end OpenProblems.N702
