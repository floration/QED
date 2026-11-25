import Mathlib
/-! QED-Q5: Coins of 3 and 5
Every whole number from 8 upward can be paid exactly with coins worth 3 and 5.
Informal statement: For every $n\ge 8$ there are $a,b\in\mathbb N$ with $n=3a+5b$.
Formalization notes: Natural numbers throughout.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ5
def Claim : Prop :=
  ∀ n : ℕ, 8 ≤ n → ∃ a b : ℕ, n = 3 * a + 5 * b

end OpenProblems.QEDQ5
