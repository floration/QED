import Mathlib
/-! N-064: FLT, compressed
Fermat's Last Theorem has a huge computer formalization effort. Do it in far fewer lines.
Informal statement: Give a Lean 4 proof of $x^n+y^n=z^n\Rightarrow xyz=0$ for $n\ge3$ using at most $10^5$ lines beyond current Mathlib.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N064
def Claim : Prop := sorry
end OpenProblems.N064
