import Mathlib
/-! N-622: Integrability of the egg-crate torus
Take the surface z = ε sin x sin y over a flat square torus. Show its geodesic flow is never integrable, however small the bumps are.
Informal statement: For $\varepsilon>0$ let $g_\varepsilon$ be the metric on $\mathbb R^2/(2\pi\mathbb Z)^2$ induced by the graph $z=\varepsilon\sin x\sin y$ in $\mathbb R^3$. Prove that for every $\varepsilon>0$ the geodesic flow of $g_\varepsilon$ has no real-analytic first integral on $T^*\mathbb T^2\setminus 0$ that is functionally independent of the Hamiltonian.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N622
def Claim : Prop := sorry
end OpenProblems.N622
