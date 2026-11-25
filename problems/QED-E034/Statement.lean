import Mathlib
/-! QED-E034: Two sixth powers equal to four
Can the sum of two sixth powers of positive integers equal the sum of four sixth powers?
Informal statement: Does $x_1^6+x_2^6=y_1^6+y_2^6+y_3^6+y_4^6$ have a solution in positive integers?
Formalization notes: All six variables are positive naturals. No triviality loophole: with all terms positive, cancelling a common term would leave a 6.1.3 identity, which is itself a nontrivial (unknown) solution. Claim = a solution exists; ¬Claim = none exists.
-/
namespace OpenProblems.QEDE034

def Claim : Prop :=
  ∃ x₁ x₂ y₁ y₂ y₃ y₄ : ℕ,
    0 < x₁ ∧ 0 < x₂ ∧ 0 < y₁ ∧ 0 < y₂ ∧ 0 < y₃ ∧ 0 < y₄ ∧
    x₁ ^ 6 + x₂ ^ 6 = y₁ ^ 6 + y₂ ^ 6 + y₃ ^ 6 + y₄ ^ 6

end OpenProblems.QEDE034
