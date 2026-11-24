import Mathlib
/-! N-619: Thue–Morse Lorenz knots
Turn the first 2^n letters of the Thue–Morse word into a periodic orbit of the Lorenz template. Show these knots are eventually hyperbolic and their volume grows proportionally to the word length.
Informal statement: Let $K_n$ be the Lorenz knot whose Lorenz word is the length-$2^n$ Thue–Morse prefix $t_0\cdots t_{2^n-1}$ with $0\mapsto x$, $1\mapsto y$ (this word is primitive). Prove that $S^3\setminus K_n$ is hyperbolic for all sufficiently large $n$ and that $\lim_{n\to\infty}\mathrm{vol}(S^3\setminus K_n)/2^n$ exists and is positive.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N619
def Claim : Prop := sorry
end OpenProblems.N619
