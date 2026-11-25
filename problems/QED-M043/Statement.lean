import Mathlib
/-! QED-M043: Three collinear points after the fall of 3SUM
STATUS: NOT YET FORMALIZED
Now that 3SUM is truly subquadratic (Alman–Vassilevska Williams 2026), the n² lower bound for
deciding whether n points in the plane contain three collinear points has no support. Decide
whether 3-point collinearity is solvable in O(n^{2−ε}) time.
Informal statement: Prove or disprove: for every constant c ≥ 1 there are ε > 0 and a word-RAM
algorithm (word size Θ(log n)) that decides, in O(n^{2−ε}) time, whether a set of n points of
Z² ∩ [−n^c, n^c]² contains three collinear points. (Real-RAM variant: same question for n points
of ℝ² on the real RAM.)
Formalization notes: Needs a machine model with running-time bounds (word RAM with Θ(log n)-bit
words, or the real RAM), asymptotic time-complexity classes over such machines, and an input
encoding of point sets. Mathlib has Turing machines and `Computable`/`Primrec` but no word-RAM or
real-RAM model and no time-complexity framework; building one is several hundred lines and the
result would be very sensitive to model details. The alternative 'hardness under a hypothesis not
refuted by AVW' is a conditional, open-ended research program, not a single proposition.
Proving `Claim` would mean exhibiting the algorithm; `¬Claim` would be an unconditional
super-n^{2−ε} lower bound, far beyond current techniques.
-/
namespace OpenProblems.QEDM043

def Claim : Prop := sorry

end OpenProblems.QEDM043
