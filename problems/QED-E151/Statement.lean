import Mathlib
/-! QED-E151: Rational 6-cycles of z^2+c
Iterate the map x ↦ x² + c with c and the starting point x rational. A rational starting point can return to itself after exactly 1, 2 or 3 steps (for example c = −29/16, x = −1/4 gives a 3-cycle), and it is proved that exact periods 4 and 5 are impossible. Show, without assuming unproved conjectures, that exact period 6 is impossible too.
Informal statement: Prove that there are no $c,x\in\mathbb{Q}$ such that $x$ has exact (minimal) period $6$ under $f_c(z)=z^2+c$.
Formalization notes: `Function.minimalPeriod f x` is the least n > 0 with `f^[n] x = x`,
and 0 if x is not periodic; so `= 6` means exactly that x is periodic with exact period 6.
Claim = unconditional nonexistence of rational 6-cycles for z² + c (Stoll's result
without BSD); ¬Claim = an explicit rational c and point x of exact period 6.
-/
namespace OpenProblems.QEDE151
noncomputable section

def Claim : Prop :=
  ¬ ∃ c x : ℚ, Function.minimalPeriod (fun z : ℚ => z ^ 2 + c) x = 6

end
end OpenProblems.QEDE151
