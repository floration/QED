import Mathlib
/-! N-443: The spectre is not spectral
Show the spectre, a curved tile that cannot tile by translations, has no orthogonal basis of exponentials, as Fuglede's conjecture predicts.
Informal statement: Prove there is no $\Lambda\subset\mathbb{R}^2$ such that $\{e^{2\pi i\lambda\cdot x}\}_{\lambda\in\Lambda}$ is an orthogonal basis of $L^2$ of the spectre domain.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N443
def Claim : Prop := sorry
end OpenProblems.N443
