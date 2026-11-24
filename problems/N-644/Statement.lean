import Mathlib
/-! N-644: Lane–Emden with a shift
Replace u² in the five-dimensional Lane–Emden equation by the square of u at a shifted point. Are there still no positive solutions?
Informal statement: Let $e\in\mathbb R^5$, $e\ne0$. Decide whether there is a positive $u\in C^2(\mathbb R^5)$ with $-\Delta u(x)=u(x+e)^2$ for all $x$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N644
def Claim : Prop := sorry
end OpenProblems.N644
