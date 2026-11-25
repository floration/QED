import Mathlib
/-! QED-M090: Does an oscillating source lower the Strauss exponent?
STATUS: NOT YET FORMALIZED
For the 3D wave equation u_tt - Δu = g(t)|u|^p with g smooth, 2π-periodic and of mean zero (e.g. cos t), small smooth compactly supported data give global solutions for p > 1+√2. Is the critical exponent p_c(g) strictly below the Strauss exponent 1+√2?
Informal statement: Let $g$ be smooth, $2\pi$-periodic, $\int_0^{2\pi}g=0$, $g\not\equiv0$ (model $g=\cos t$). For $u_{tt}-\Delta u=g(t)|u|^p$ on $\mathbb R^{1+3}$ with data $\varepsilon(f,h)$, $f,h\in C_c^\infty$ (solutions in the usual weak/mild sense, e.g. $C([0,T);H^1)$ with John-type weighted bounds), let $p_c(g)=\inf\{p>1:\forall f,h\ \exists\varepsilon_0>0$ such that the solution is global for all $0<\varepsilon<\varepsilon_0\}$. Since John/Zhou/Glassey global existence uses only $|g|u|^p|\lesssim|u|^p$ and the matching Lipschitz bound, $p_c(g)\le1+\sqrt2$. Is $p_c(g)<1+\sqrt2$? Determine $p_c(g)$ and whether it depends on $g$ (a heuristic predicts 2). For $1<p<p_c(g)$, determine the lifespan $T_\varepsilon$ as $\varepsilon\to0$ for suitable data.
Formalization notes: Not formalized. Missing pieces: a well-posedness/solution theory for the semilinear wave equation in Mathlib (Sobolev spaces H^1(R^3), mild/Duhamel solutions via the wave propagator or the Kirchhoff formula, maximal existence time, and the notion of global solution). One could hand-roll classical C^2 solutions via Kirchhoff's formula, but for 1 < p the nonlinearity |u|^p is not smooth and the intended solution class (C([0,T);H^1) with John-type weights) requires Sobolev/Fourier machinery Mathlib lacks. The intended Claim is p_c(g) < 1+√2 for g = cos t (or for every admissible g); proving ¬Claim means the Strauss exponent is robust under mean-zero oscillation.
-/
namespace OpenProblems.QEDM090

def Claim : Prop := sorry

end OpenProblems.QEDM090
