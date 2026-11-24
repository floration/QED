import Mathlib
/-! N-637: Strauss exponent for an oscillating source
The wave equation with source |u|^p in 3D has small-data global existence exactly above the Strauss exponent 1+√2. Find the threshold when the source is multiplied by cos t.
Informal statement: For $u_{tt}-\Delta u=\cos(t)\,|u|^p$ on $\mathbb R^{1+3}$ with data $\varepsilon(f,g)$, $f,g\in C_c^\infty$, determine $p_c$ such that for $p>p_c$ solutions are global for all small $\varepsilon$, and for $1<p<p_c$ some data blow up for all small $\varepsilon$; decide whether $p_c=1+\sqrt2$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N637
def Claim : Prop := sorry
end OpenProblems.N637
