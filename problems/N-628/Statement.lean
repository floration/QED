import Mathlib
/-! N-628: Capacities of the 4D superball
Viterbo's conjecture that all symplectic capacities agree on convex bodies is false in general. Do they agree on the 4D ball x⁴+y⁴+z⁴+w⁴ ≤ 1?
Informal statement: Let $U=\{x_1^4+y_1^4+x_2^4+y_2^4\le1\}\subset(\mathbb R^4,\omega_0)$. Decide whether the Gromov width of $U$ equals its Ekeland–Hofer–Zehnder capacity (the minimal action of a closed characteristic on $\partial U$).
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N628
def Claim : Prop := sorry
end OpenProblems.N628
