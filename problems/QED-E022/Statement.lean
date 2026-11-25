import Mathlib
/-! QED-E022: Four-colour triangle Ramsey number R(3,3,3,3)
Colour every edge of a complete graph with one of four colours. How many vertices force a single-coloured triangle? The answer is known to lie between 51 and 60 (the 60 coming from a 2026 computer-assisted preprint). Narrow or close this gap.
Informal statement: Let $R_4(3)=R(3,3,3,3)$ be the least $n$ such that every 4-edge-colouring of $K_n$ contains a monochromatic triangle. Known: $51\le R_4(3)\le 62$ (refereed), and $\le 60$ in a 2026 computer-assisted preprint. Improve either bound, i.e. exhibit a 4-colouring of $K_{51}$ with no monochromatic triangle, or lower the upper bound (below 60, or confirm 60 rigorously). Ultimately determine $R_4(3)$; it is conjectured to be $51$.
Formalization notes: Claim is the conjecture R_4(3)=51: every symmetric 4-colouring c of the pairs of Fin 51 has a monochromatic triangle on three distinct vertices (diagonal values c i i are irrelevant). Given the known lower bound 51, Claim true means R_4(3)=51, and ¬Claim (a triangle-free 4-colouring of K_51 exists) means R_4(3) >= 52.
-/
namespace OpenProblems.QEDE022
def Claim : Prop :=
  ∀ c : Fin 51 → Fin 51 → Fin 4, (∀ i j : Fin 51, c i j = c j i) →
    ∃ i j k : Fin 51, i ≠ j ∧ j ≠ k ∧ i ≠ k ∧ c i j = c j k ∧ c i j = c i k
end OpenProblems.QEDE022
