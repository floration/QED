import Mathlib
/-! QED-M088: Critical NLS blow-up threshold on the cube surface
STATUS: NOT YET FORMALIZED
For the focusing cubic NLS on the flat surface of the unit cube, each vertex is a cone of angle 3π/2, which should lower the mass threshold for blow-up from ‖Q‖² to (3/4)‖Q‖². Prove global existence below m_* = (3/4)‖Q‖²_{L²(R²)} and blow-up for masses arbitrarily close above.
Informal statement: Let $S$ be the surface of the unit cube with its flat metric, and let $\Delta$ be the Friedrichs extension of the Laplace–Beltrami operator on $C_c^\infty(S\setminus\{\text{vertices}\})$. Let $Q$ be the ground state of $\Delta Q-Q+Q^3=0$ on $\mathbb R^2$, and put $m_*=\tfrac34\|Q\|_{L^2(\mathbb R^2)}^2$. For $iu_t+\Delta u+|u|^2u=0$ on $S$, prove: (i) every $u_0\in H^1(S)$ with $\|u_0\|_2^2<m_*$ gives a global $H^1$ solution; (ii) for every $\varepsilon>0$ there is $u_0\in H^1(S)$ with $m_*<\|u_0\|_2^2<m_*+\varepsilon$ whose solution blows up in finite time. (Stronger, optional: blow-up data exist for every mass $m>m_*$; also decide whether there is blow-up at mass exactly $m_*$.)
Formalization notes: Not formalized. Missing pieces: the flat cone-manifold structure of the cube surface with its Laplace-Beltrami operator, its Friedrichs extension (Mathlib has unbounded self-adjoint operators only in rudimentary form and no Friedrichs extension), H^1(S) on a singular surface, a local well-posedness/maximal-solution notion for NLS (Strichartz theory), the planar ground state Q (existence/uniqueness of the positive radial solution) and finite-time blow-up. Each is hundreds of lines. The intended Claim is (i) ∧ (ii) of M; ¬Claim means either a sub-threshold blow-up or no near-threshold blow-up.
-/
namespace OpenProblems.QEDM088

def Claim : Prop := sorry

end OpenProblems.QEDM088
