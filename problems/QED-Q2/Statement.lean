import Mathlib
/-! QED-Q2: n² + n is even
For every integer n, the number n² + n is even.
Informal statement: For all $n\in\mathbb Z$, $2\mid n^2+n$.
Formalization notes: Divisibility in ℤ.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ2
def Claim : Prop :=
  ∀ n : ℤ, 2 ∣ n ^ 2 + n

end OpenProblems.QEDQ2
