import Mathlib
/-! QED-E020: Thue–Morse Lorenz knots
Turn the first 2^n letters of the Thue–Morse word into a periodic orbit of the Lorenz flow, and so into a knot K_n. For n >= 4 these knots appear to be hyperbolic. Their volume grows only in proportion to n, the logarithm of the word length, not in proportion to the length itself. Prove that, and find the constant.
Informal statement: Let $K_n$ be the Lorenz knot with Lorenz word $t_0t_1\cdots t_{2^n-1}$ (the length-$2^n$ Thue–Morse prefix, $0\mapsto x$, $1\mapsto y$; this word is primitive, since Thue–Morse is overlap-free and $t_{[0,2^n)}=w\bar w$). Prove that $S^3\setminus K_n$ is hyperbolic for all $n\ge4$ and that $\lim_{n\to\infty}\mathrm{vol}(S^3\setminus K_n)/n$ exists and is positive. Determine the limit.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E020`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE020
def Claim : Prop := sorry
end OpenProblems.QEDE020
