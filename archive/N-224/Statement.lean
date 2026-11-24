import Mathlib
/-! N-224: Prime Nim game graph
Prime Nim has losing positions with a hidden mod-structure. Show the losing positions are equidistributed in residue classes mod 3.
Informal statement: Prove $\#\{n\le x:G(n)=0,\ n\equiv a\ (3)\}\sim\frac13\#\{n\le x:G(n)=0\}$ for each $a$.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N224
def Claim : Prop := sorry
end OpenProblems.N224
