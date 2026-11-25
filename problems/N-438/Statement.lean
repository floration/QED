import Mathlib
/-! N-438: Monochromatic square-sum triangles, many colours
Colour the positive integers with finitely many colours. Show there are always three distinct
numbers of the same colour whose three pairwise sums are all perfect squares.
Informal statement: For every r ≥ 1 and every colouring χ : ℕ → {1,…,r} there exist distinct
positive integers a, b, c with χ(a) = χ(b) = χ(c) and a+b, a+c, b+c all perfect squares.
Formalization notes:
* Colours are `Fin r`; the integers are naturals required to be positive (0 is excluded, as
  ℕ in the statement means positive integers). The colouring is given on all of ℕ but only
  its values on positive integers matter.
* `IsSquare n` means n = m * m for some natural m.
* Proving `Claim`: the Ramsey statement holds for all r. Proving `¬Claim`: some finite colouring
  of the positive integers has no monochromatic square-sum triangle.
* Reported (unverified) SAT evidence: r = 2 holds with threshold in (8000, 10000].
-/
namespace OpenProblems.N438

def Claim : Prop :=
  ∀ r : ℕ, 1 ≤ r → ∀ χ : ℕ → Fin r,
    ∃ a b c : ℕ, 0 < a ∧ 0 < b ∧ 0 < c ∧ a ≠ b ∧ a ≠ c ∧ b ≠ c ∧
      χ a = χ b ∧ χ a = χ c ∧
      IsSquare (a + b) ∧ IsSquare (a + c) ∧ IsSquare (b + c)

end OpenProblems.N438
