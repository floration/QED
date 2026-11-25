import Mathlib
/-! QED-E014: Minimal-mass blow-up with reflection
Consider the 2D Schrödinger equation in which the self-interaction at each point uses the density at the mirror point -x. Below the ground-state mass, solutions exist forever. Show that the only solutions that blow up with exactly the ground-state mass are the explicit pseudo-conformal ground-state solutions centred at the origin.
Informal statement: Let $Q>0$ be the radial solution of $\Delta Q-Q+Q^3=0$ on $\mathbb R^2$. Consider $iu_t+\Delta u+|u(-x,t)|^2u=0$ with $u_0\in H^1(\mathbb R^2)$ and $\|u_0\|_{L^2}=\|Q\|_{L^2}$. Prove that if $u$ blows up at a finite time $T$, then there are $\theta\in\mathbb R$ and $\lambda>0$ with $u(t,x)=e^{i\theta}\frac{\lambda}{T-t}\,Q\!\Big(\frac{\lambda x}{T-t}\Big)\exp\!\Big(i\frac{\lambda^2}{T-t}-i\frac{|x|^2}{4(T-t)}\Big)$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E014`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE014
def Claim : Prop := sorry
end OpenProblems.QEDE014
