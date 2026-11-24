import Mathlib
/-! N-652: Chaos in the double pendulum at every energy
The planar double pendulum with equal masses and arms is chaotic at moderate energies. Prove it is chaotic at every energy above the rest state, however small.
Informal statement: Let $H$ be the Hamiltonian of the planar double pendulum with $m_1=m_2=\ell_1=\ell_2=g=1$, with minimum $E_0$. Prove that for every $E>E_0$ the flow on $\{H=E\}$ has positive topological entropy.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N652
def Claim : Prop := sorry
end OpenProblems.N652
