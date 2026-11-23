import Mathlib
/-! N-294: Square-sum orderings avoiding progressions
Line up 1 to N with neighbours summing to squares, and with no three equally spaced positions holding an arithmetic progression.
Informal statement: Prove for all large $N$ there is a Hamiltonian path $v_1\dots v_N$ of $S_N$ with no $i<j<k$, $j-i=k-j$, such that $v_i,v_j,v_k$ form an AP.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N294
def Claim : Prop := sorry
end OpenProblems.N294
