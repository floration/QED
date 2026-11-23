import Mathlib
/-! N-595: Sudoku count asymptotics
Count n²×n² Sudoku grids exactly, to leading order.
Informal statement: Prove $\#\text{Sudoku}(n)=\left(\frac{(n^2)!^{2}}{n^{2n^2}e^{\dots}}\right)\!(1+o(1))$ with an explicit leading term.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N595
def Claim : Prop := sorry
end OpenProblems.N595
