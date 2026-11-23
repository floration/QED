import Mathlib
/-! N-307: Ising with prime couplings
On the integer line, couple spins i and j with strength 1 if i − j is prime. Decide whether there is a phase transition.
Informal statement: For the 1D Ising model with $J_{ij}=\mathbf 1[|i-j|\in\mathbb{P}]\,|i-j|^{-2}$, prove a phase transition at finite $\beta_c$ and determine whether the magnetization jumps.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N307
def Claim : Prop := sorry
end OpenProblems.N307
