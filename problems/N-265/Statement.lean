import Mathlib
/-! N-265: Prime Nim on Gaussian integers
Play Prime Nim with Gaussian integers: subtract a Gaussian prime staying in the first quadrant. Show losing positions have density zero.
Informal statement: For positions $a+bi$ with $a,b\ge0$ and moves $z\mapsto z-\pi$ with $\pi$ a Gaussian prime and the result in the closed first quadrant, prove the P-positions have density 0.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N265
def Claim : Prop := sorry
end OpenProblems.N265
