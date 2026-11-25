import Mathlib
/-! QED-E024: Ramsey multiplicity constant of K_4
In any red/blue colouring of the edges of a huge complete graph, some fraction of all 4-vertex sets must be single-coloured (all 6 edges the same colour). The minimum possible fraction is known only to lie between about 0.0296 and 0.03015. Pin it down further, or find its exact value.
Informal statement: Let $c_4=\lim_{n\to\infty}\min_{G,|V(G)|=n}\big(k_4(G)+k_4(\bar G)\big)/\binom n4$. Known: $0.0296<c_4\le 4551721\cdot 2^{-24}\cdot 3^{-2}<0.030145$. Improve either bound, or determine $c_4$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, from a branch named `statement-QED-E024`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.QEDE024
def Claim : Prop := sorry
end OpenProblems.QEDE024
