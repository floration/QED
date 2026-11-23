import Mathlib
/-! N-256: Seven-free square-sum chains
Take only the numbers up to N with no digit 7. Show they can be lined up so neighbours always sum to perfect squares, for large N.
Informal statement: Let $A_N=\{n\le N: 7\notin n\}$. Prove $S_N[A_N]$ has a Hamiltonian path for all sufficiently large $N$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N256
def Claim : Prop := sorry
end OpenProblems.N256
