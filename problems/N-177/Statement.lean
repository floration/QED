import Mathlib
/-! N-177: Lonely runners in 3D
Runners move in three dimensions on a cube that wraps around. Find the guaranteed loneliness.
Informal statement: For $n$ pairwise independent $v_i\in\mathbb{Z}^3$, find the optimal $\delta_n$ with $\sup_t\min_i\|tv_i\|_{\mathbb{T}^3,\infty}\ge\delta_n$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N177
def Claim : Prop := sorry
end OpenProblems.N177
