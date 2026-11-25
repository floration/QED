import Mathlib
/-! QED-E006: Multiplicities on the Fermat quartic
The surface x^4+y^4+z^4 = 1 has exactly the 48 symmetries of a cube. Show its Laplace eigenvalues repeat no more often than those symmetries force (at most 3 times), except possibly for finitely many eigenvalues.
Informal statement: Let $S=\{x^4+y^4+z^4=1\}\subset\mathbb R^3$ with the induced metric (isometry group the hyperoctahedral group of order 48, whose irreducible representations have dimension $\le3$). Prove that all but finitely many eigenvalues of $\Delta_S$ have multiplicity $\le3$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E006`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE006
def Claim : Prop := sorry
end OpenProblems.QEDE006
