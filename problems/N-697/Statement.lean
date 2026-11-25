import Mathlib
/-! N-697: Matching lower bound for OMv on low-VC-dimension matrices
STATUS: NOT YET FORMALIZED
Anand–van den Brand–McCarty give Õ(n²) preprocessing and Õ(n^{2−1/d}) query time for online Boolean matrix–vector
multiplication when the matrix has VC-dimension d. Show that query time n^{2−c/d} is necessary for some constant c
(assuming the OMv conjecture, or unconditionally in the cell-probe model), for d up to some ω(1) function; or improve
the upper bound to n^{2−f(d)} with f(d) ≫ 1/d.
Informal statement (corrected, the original M field was motivation text, not a statement): Assuming the OMv
conjecture, prove there are a constant c > 0 and a function D(n) → ∞ such that for every d ≤ D(n), no algorithm with
poly(n) preprocessing answers online Boolean matrix–vector queries for n×n Boolean matrices of VC-dimension at most d in
amortized time O(n^{2−c/d−ε}) per query for any fixed ε > 0. Alternatively, give an algorithm with query time
n^{2−f(d)} for f(d)/(1/d) → ∞.
Formalization notes: Needs pieces Mathlib lacks: an online computation model with time bounds (word-RAM or cell-probe),
the OMv conjecture as a hypothesis about all algorithms, and amortized query-time accounting. VC-dimension of a 0/1
matrix itself is easy to define, but the algorithmic content is not. Proving Claim = the conditional lower bound.
-/
namespace OpenProblems.N697

def Claim : Prop := sorry

end OpenProblems.N697
