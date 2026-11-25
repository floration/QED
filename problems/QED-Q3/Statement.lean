import Mathlib
/-! QED-Q3: Sum of the first n odd numbers
Adding up the first n odd numbers 1 + 3 + 5 + … gives n².
Informal statement: For all $n$, $\sum_{i<n}(2i+1)=n^2$.
Formalization notes: Sum over `Finset.range n` in ℕ.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ3
def Claim : Prop :=
  ∀ n : ℕ, ∑ i ∈ Finset.range n, (2 * i + 1) = n ^ 2

end OpenProblems.QEDQ3
