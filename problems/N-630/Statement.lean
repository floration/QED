import Mathlib
/-! N-630: Charge on a Fermat conductor
Put a unit of electric charge on a perfectly conducting body x⁴+y⁴+z⁴ ≤ 1. Show the surface charge is thinnest at the six flat points and thickest at the eight diagonal points.
Informal statement: Let $\mu$ be the Newtonian equilibrium measure of $K=\{x^4+y^4+z^4\le1\}$, with density $\rho$ with respect to surface area on $\partial K$. Prove that $\rho$ attains its minimum exactly at $(\pm1,0,0),(0,\pm1,0),(0,0,\pm1)$ and its maximum exactly at $3^{-1/4}(\pm1,\pm1,\pm1)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N630
def Claim : Prop := sorry
end OpenProblems.N630
