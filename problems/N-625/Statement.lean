import Mathlib
/-! N-625: Outer billiards around a superellipse
Outer billiards around a smooth convex shape with positive curvature has only bounded orbits. Decide whether this survives for x⁴+y⁴ ≤ 1, whose curvature vanishes at four points.
Informal statement: Let $K=\{x^4+y^4\le1\}$ and let $T:\mathbb R^2\setminus K\to\mathbb R^2\setminus K$ be the outer billiard map ($T(p)$ is the reflection of $p$ in the point where the right-hand tangent line from $p$ touches $\partial K$). Decide whether every $T$-orbit is bounded.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N625
def Claim : Prop := sorry
end OpenProblems.N625
