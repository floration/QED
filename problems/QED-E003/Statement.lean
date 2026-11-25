import Mathlib
/-! QED-E003: Keller monodromy is everything
Since 2026 there are polynomial maps of 3-space with constant nonzero Jacobian that are not invertible (counterexamples to the Jacobian conjecture), and every number n >= 3 of points in a generic fibre occurs. Show that for every n the fibre points can be permuted in every possible way by going around loops, i.e. the monodromy group can be the full symmetric group S_n.
Informal statement: Prove that for every $n\ge3$ there is a polynomial map $F:\mathbb C^3\to\mathbb C^3$ with $\det JF\in\mathbb C^{\times}$, of geometric degree $[\mathbb C(x):\mathbb C(F)]=n$, whose geometric monodromy group (the Galois group of the Galois closure of $\mathbb C(x_1,x_2,x_3)/\mathbb C(F_1,F_2,F_3)$, acting on the $n$ generic fibre points) is $S_n$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E003`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE003
def Claim : Prop := sorry
end OpenProblems.QEDE003
