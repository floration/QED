import Mathlib
/-! QED-M033: Binary-error LWE with linearly many samples
STATUS: NOT YET FORMALIZED
For LWE with secret in Z_q^n (q = poly(n)) and uniform binary errors, given m = Cn samples for a fixed C > 1: find a subexponential algorithm or prove hardness from standard LWE.
Informal statement: Binary-error LWE with linearly many samples: fix q = q(n) ≤ poly(n) and a constant C > 1. Given (A, As + e mod q) with A uniform in Z_q^{m×n}, s uniform in Z_q^n, e uniform in {0,1}^m, m = ⌈Cn⌉, either (a) give an algorithm recovering s (or distinguishing from uniform) with non-negligible advantage in time 2^{o(n)}, or (b) prove that this problem is as hard as standard LWE (or worst-case lattice problems) with polynomial loss in n. Known: Arora-Ge linearization solves it in poly time for m ≈ n²; Micciancio-Peikert prove hardness for m = n(1+O(1/log n)).
Formalization notes: Not formalized. Missing pieces: models of (randomized) algorithms with time bounds (polynomial, 2^{o(n)}), negligible advantage for families of distributions, and security reductions between LWE variants. Mathlib has the finite probability needed for the distributions but no complexity theory. The question is a disjunction of an algorithm (a) and a reduction (b); since neither is formalizable without a computation model, the statement is left as sorry.
-/
namespace OpenProblems.QEDM033

def Claim : Prop := sorry

end OpenProblems.QEDM033
