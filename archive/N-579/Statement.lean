import Mathlib
/-! N-579: Undecidability of Prime Nim variants
Show there is no algorithm that takes a polynomial f and decides whether the subtraction game with moves {f(p) : p prime} has eventually periodic Grundy values.
Informal statement: Prove $\{f\in\mathbb{Z}[x]:\text{Grundy sequence of the game with move set }f(\mathbb{P})\cap\mathbb{N}\text{ is eventually periodic}\}$ is undecidable, or decidable.
STATUS: NOT YET FORMALIZED. Replace `sorry` in `Claim` with a faithful Lean statement
(open a PR touching only this file, labelled `statement`). Solutions are accepted only
after the statement PR is merged. -/
namespace OpenProblems.N579
def Claim : Prop := sorry
end OpenProblems.N579
