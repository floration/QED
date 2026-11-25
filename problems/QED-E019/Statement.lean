import Mathlib
/-! QED-E019: Period-doubling torus bundles
Build a once-punctured torus bundle by reading the period-doubling word as a product of the two basic shear matrices. Show its hyperbolic volume per letter settles to a limit as the word grows.
Informal statement: Let $W_n\in\{a,b\}^{2^n}$ be the length-$2^n$ prefix of the fixed point of $a\mapsto ab,\ b\mapsto aa$ ($n\ge1$). Let $\phi_n\in SL_2(\mathbb{Z})$ be the product obtained from $W_n$ via $a\mapsto R=\begin{pmatrix}1&1\\0&1\end{pmatrix}$, $b\mapsto L=\begin{pmatrix}1&0\\1&1\end{pmatrix}$, and let $M_n$ be the once-punctured torus bundle with monodromy $\phi_n$ (hyperbolic since $W_n$ contains both letters). Prove that $\lim_{n\to\infty}\mathrm{vol}(M_n)/2^n$ exists.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E019`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE019
def Claim : Prop := sorry
end OpenProblems.QEDE019
