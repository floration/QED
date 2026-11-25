import Mathlib
/-! QED-E009: Non-flat free-boundary minimal disks in the superball
In a round ball the only free-boundary minimal disks are flat slices through the centre (Nitsche). The superball x^4+y^4+z^4 <= 1 has nine flat ones, cut by its mirror planes. Is there also one that is not flat? A natural candidate has threefold symmetry about the diagonal (1,1,1).
Informal statement: For $p>2$ let $B_p=\{|x|^p+|y|^p+|z|^p\le1\}$. Decide whether $B_4$ (more generally $B_p$) contains an embedded minimal disk $\Sigma$ with $\partial\Sigma\subset\partial B_p$, meeting $\partial B_p$ orthogonally, that is not contained in a plane. Specifically, show that there is one invariant under the rotation by $2\pi/3$ about the axis $\mathbb R(1,1,1)$ and under $v\mapsto-v$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E009`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE009
def Claim : Prop := sorry
end OpenProblems.QEDE009
