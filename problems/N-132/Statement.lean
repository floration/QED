import Mathlib
/-! N-132: Optimal square-sum circle gaps
Among all arrangements of 1 to N in a circle where neighbours sum to squares, minimise the largest difference between neighbours. Find the order of the minimum.
Informal statement: Determine the order of $\min_{C}\max_{i}|v_{i+1}-v_i|$ over Hamiltonian cycles $C$ of $S_N$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N132
def Claim : Prop := sorry
end OpenProblems.N132
