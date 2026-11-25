import Mathlib
/-! QED-E140: A point at rational distance from all four corners of a square
Is there a point in the plane whose distances to all four corners of the unit square are rational numbers? Points at rational distance from three of the corners are dense in the plane, but no point has been found that also works for the fourth corner, and no one has shown that none exists.
Informal statement: Decide whether there exist $x,y\in\mathbb R$ such that $\sqrt{x^2+y^2}$, $\sqrt{(x-1)^2+y^2}$, $\sqrt{x^2+(y-1)^2}$ and $\sqrt{(x-1)^2+(y-1)^2}$ are all rational.
Formalization notes: Claim asserts existence of real x, y such that each of the four Euclidean
distances (written with `Real.sqrt` of a nonnegative quantity, so no junk values arise) equals the
image of some rational number. The point is allowed anywhere in the plane (inside, on, or outside
the square), matching the standard problem. Proving ¬Claim = no such point exists.
-/
namespace OpenProblems.QEDE140
noncomputable section

def Claim : Prop :=
  ∃ x y : ℝ,
    (∃ q : ℚ, Real.sqrt (x ^ 2 + y ^ 2) = (q : ℝ)) ∧
    (∃ q : ℚ, Real.sqrt ((x - 1) ^ 2 + y ^ 2) = (q : ℝ)) ∧
    (∃ q : ℚ, Real.sqrt (x ^ 2 + (y - 1) ^ 2) = (q : ℝ)) ∧
    (∃ q : ℚ, Real.sqrt ((x - 1) ^ 2 + (y - 1) ^ 2) = (q : ℝ))

end
end OpenProblems.QEDE140
