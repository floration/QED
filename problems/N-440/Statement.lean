import Mathlib
/-! N-440: Hat tiling heat kernel constant
For a random walk on a hat tiling, find the exact constant in the return probability.
Informal statement: Prove $p_{2n}(o,o)\sim\frac{c(o)}{n}$ on the hat graph and show $\frac1{|B_R|}\sum_{o\in B_R}c(o)\to c$ with $c=\frac{\bar d}{2\pi\sqrt{\det\Sigma}}$, computing $\Sigma$ in closed form.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N440
def Claim : Prop := sorry
end OpenProblems.N440
