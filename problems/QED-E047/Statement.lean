import Mathlib
/-! QED-E047: Does the trefoil have a symbiont?
The unknotting number of a knot is the fewest crossing changes needed to turn it into an unknotted loop. In 2025 it was shown that tying two knots together end to end can need fewer changes than the two knots need separately, and in 2026 that every torus knot except possibly the trefoil has a partner like this. Does the trefoil, the simplest knot, also have such a partner? The most likely candidate is the 10-crossing knot 10_6, whose own unknotting number is still unknown (it is 2 or 3).
Informal statement: Write $u(K)$ for the unknotting number and $\#$ for connected sum. Knots $K,K'$ are symbionts if $u(K\#K')<u(K)+u(K')$. Is there a knot $K$, with some choice of mirror image, such that $u(3_1\#K)<1+u(K)$? By Scharlemann's theorem any such $K$ has $u(K)\ge2$. Concrete subquestion: is $u(10_6)=3$? Brittenham–Hermiller prove $u(3_1\#10_6)\le3$ for the mirror choice with $|\sigma(3_1\#10_6)|=2$, so $u(10_6)=3$ would give a positive answer.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E047`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE047
def Claim : Prop := sorry
end OpenProblems.QEDE047
