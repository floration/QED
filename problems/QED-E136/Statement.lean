import Mathlib
/-! QED-E136: Does a perfect cuboid exist?
Is there a box whose three edges, three face diagonals and space diagonal all have whole-number lengths? Boxes with whole-number edges and face diagonals (Euler bricks, such as 44 × 117 × 240) come in infinite families, but in every known one the space diagonal is irrational. Nobody has found a perfect box or proved that none exists.
Informal statement: Decide whether there exist positive integers $a,b,c$ such that $a^2+b^2$, $b^2+c^2$, $c^2+a^2$ and $a^2+b^2+c^2$ are all perfect squares.
Formalization notes: Claim asserts that a perfect cuboid exists: positive natural numbers a, b, c
such that the four sums are squares in ℕ (`IsSquare m ↔ ∃ r, m = r * r`). Positivity excludes
degenerate boxes such as (a, 0, 0). Proving Claim = exhibiting a perfect cuboid; proving ¬Claim
= showing none exists. Rational boxes reduce to integer ones by scaling, so this is the full question.
-/
namespace OpenProblems.QEDE136

def Claim : Prop :=
  ∃ a b c : ℕ, 0 < a ∧ 0 < b ∧ 0 < c ∧
    IsSquare (a ^ 2 + b ^ 2) ∧ IsSquare (b ^ 2 + c ^ 2) ∧ IsSquare (c ^ 2 + a ^ 2) ∧
    IsSquare (a ^ 2 + b ^ 2 + c ^ 2)

end OpenProblems.QEDE136
