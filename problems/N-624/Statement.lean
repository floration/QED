import Mathlib
/-! N-624: How nearly can tetrahedra close up
A chain of regular tetrahedra glued face to face can never close exactly. Find the exact exponential rate at which the best near-closure improves with chain length.
Informal statement: For a regular tetrahedron $T_0$, a chain of length $n$ is $T_0,\dots,T_n$ with $T_{k+1}$ the reflection of $T_k$ in a face not shared with $T_{k-1}$. Let $g(n)$ be the minimum over chains of the Hausdorff distance between $T_n$ and $T_0$ (always positive). Prove that $\lim_{n\to\infty}\frac1n\log g(n)=-\frac{\log 3}{6}$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N624
def Claim : Prop := sorry
end OpenProblems.N624
