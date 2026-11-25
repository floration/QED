import Mathlib
/-! QED-E046: Rigorously refute Palásti's parking conjecture in the plane
Drop unit squares (all axis-parallel) one at a time at uniformly random positions in a huge box, keeping each one only if it does not overlap those already placed, until no more fit. In one dimension the covered fraction tends to Rényi's constant, about 0.7476. Palásti guessed the planar answer is Rényi's constant squared, about 0.5589. Simulations give about 0.5620, so the guess seems wrong, but nobody has proved it. Prove that the planar jamming density is not Rényi's constant squared.
Informal statement: Let $\rho_2$ be the jamming limit of random sequential adsorption of aligned unit squares in $[0,L]^2$ as $L\to\infty$; it exists, with $L^1$ and a.s. convergence, by Penrose (2001). Let $c_R=\int_0^\infty\exp\!\left(-2\int_0^t\frac{1-e^{-u}}{u}\,du\right)dt\approx0.747598$ be Rényi's constant. Prove $\rho_2\ne c_R^2$, for instance by proving a rigorous lower bound $\rho_2>c_R^2\approx0.55890$. More generally, give any rigorous non-trivial two-sided bound on $\rho_2$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E046`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE046
def Claim : Prop := sorry
end OpenProblems.QEDE046
