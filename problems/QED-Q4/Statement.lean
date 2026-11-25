import Mathlib
/-! QED-Q4: Nicomachus: sum of cubes
The sum of the first n cubes equals the square of the sum of the first n numbers.
Informal statement: For all $n$, $\sum_{i=0}^{n} i^3=\left(\sum_{i=0}^{n} i\right)^2$.
Formalization notes: Sums over `Finset.range (n + 1)` in ℕ.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ4
def Claim : Prop :=
  ∀ n : ℕ, ∑ i ∈ Finset.range (n + 1), i ^ 3 = (∑ i ∈ Finset.range (n + 1), i) ^ 2

end OpenProblems.QEDQ4
