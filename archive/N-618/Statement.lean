import Mathlib
/-! N-618: Period-doubling torus bundles
Build a once-punctured torus bundle by reading the period-doubling word as a product of the two basic shear matrices. Show its hyperbolic volume per letter settles to a limit as the word grows.
Informal statement: Let $W_n\in\{a,b\}^{2^n}$ be the length-$2^n$ prefix of the fixed point of $a\mapsto ab,\ b\mapsto aa$, let $\phi_n$ be $W_n$ with $a\mapsto R=\begin{pmatrix}1&1\\0&1\end{pmatrix}$, $b\mapsto L=\begin{pmatrix}1&0\\1&1\end{pmatrix}$, and let $M_n$ be the (hyperbolic) once-punctured torus bundle with monodromy $\phi_n$. Prove that $\lim_{n\to\infty}\mathrm{vol}(M_n)/2^n$ exists.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N618
def Claim : Prop := sorry
end OpenProblems.N618
