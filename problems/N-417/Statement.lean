import Mathlib
/-! N-417: Prime-sum labelling of balanced trees
Label a tree with 1 to n so every edge sums to a prime. Parity forces the two sides of the tree to be balanced. Show balance is enough, for large n.
Informal statement: Prove every tree on $n\ge n_0$ vertices whose bipartition classes have sizes $\lceil n/2\rceil,\lfloor n/2\rfloor$ admits a bijection $V\to[n]$ with all edge sums prime.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N417
def Claim : Prop := sorry
end OpenProblems.N417
