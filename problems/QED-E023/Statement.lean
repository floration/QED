import Mathlib
/-! QED-E023: Does the Steiner system S(2,6,51) exist?
Can you choose 6-element groups from 51 objects so that every pair of objects lies together in exactly one group (that would take 85 groups)? The arithmetic allows it, but no one has built one or proved it impossible. This is the smallest such undecided case for groups of size 6.
Informal statement: Decide whether there is a family $\mathcal B$ of $6$-subsets of a $51$-set $V$ such that every $2$-subset of $V$ lies in exactly one member of $\mathcal B$ (a $2$-$(51,6,1)$ design; necessarily $|\mathcal B|=85$ and each point is in $10$ blocks).
Formalization notes: Claim asserts that a 2-(51,6,1) design exists: a finite family B of 6-subsets of Fin 51 such that every pair of distinct points lies in exactly one block. ¬Claim means no S(2,6,51) exists. The block count 85 follows from the definition and is not stated.
-/
namespace OpenProblems.QEDE023
def Claim : Prop :=
  ∃ B : Finset (Finset (Fin 51)), (∀ b ∈ B, b.card = 6) ∧
    ∀ x y : Fin 51, x ≠ y → ∃! b : Finset (Fin 51), b ∈ B ∧ x ∈ b ∧ y ∈ b
end OpenProblems.QEDE023
