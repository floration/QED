import Mathlib
/-! QED-E038: Squeezing the square-lattice site percolation threshold
Colour each square of an infinite chessboard black independently with probability p. There is a critical p above which an infinite connected black cluster appears; simulations put it at about 0.5927, but nobody has a formula. The best proved statements only say it lies between 0.556 and 0.6669. Prove a tighter bound on either side.
Informal statement: Let $p_c=p_c^{\mathrm{site}}(\mathbb Z^2)$ be the critical probability for Bernoulli site percolation on the square lattice (nearest-neighbour adjacency). Known rigorously: $0.556 < p_c < 0.666894$. Improve either endpoint rigorously (numerically $p_c\approx0.59274605$).
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E038`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE038
def Claim : Prop := sorry
end OpenProblems.QEDE038
