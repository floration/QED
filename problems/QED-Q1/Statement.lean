import Mathlib
/-! QED-Q1: Odd plus odd is even
The sum of two odd natural numbers is even.
Informal statement: For all $a,b\in\mathbb N$, if $a$ and $b$ are odd then $a+b$ is even.
Formalization notes: Uses Mathlib's `Odd` and `Even`.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ1
def Claim : Prop :=
  ∀ a b : ℕ, Odd a → Odd b → Even (a + b)

end OpenProblems.QEDQ1
