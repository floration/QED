import Mathlib
/-! QED-E205: A rational Diophantine septuple
A rational Diophantine m-tuple is a set of m distinct nonzero rational numbers such that the product of any two of them, plus 1, is a square of a rational number. Infinitely many such sets of size 6 are known, but nobody knows whether a set of size 7 exists. Find one, or prove that none exists.
Informal statement: Decide whether there exist seven distinct $a_1,\dots,a_7\in\mathbb Q\setminus\{0\}$ such that $a_ia_j+1$ is the square of a rational number for all $1\le i<j\le7$.
Formalization notes:
* A set of seven distinct rationals is a `Finset ℚ` of card 7. `IsSquare q` (Mathlib) means
  q = r * r for some r : ℚ, i.e. q is the square of a rational.
* The condition is required for every ordered pair of distinct elements (symmetric anyway).
* Claim: a rational Diophantine septuple exists. ¬Claim: none exists. An explicit witness
  would be checkable by `decide`/`norm_num` with the square roots supplied.
-/
namespace OpenProblems.QEDE205
noncomputable section

/-- `s` is a rational Diophantine tuple: nonzero elements, `ab + 1` a rational square for all
distinct `a, b ∈ s`. -/
def IsDiophTuple (s : Finset ℚ) : Prop :=
  (0 : ℚ) ∉ s ∧ ∀ a ∈ s, ∀ b ∈ s, a ≠ b → IsSquare (a * b + 1)

/-- There is a rational Diophantine septuple. -/
def Claim : Prop :=
  ∃ s : Finset ℚ, s.card = 7 ∧ IsDiophTuple s

end
end OpenProblems.QEDE205
