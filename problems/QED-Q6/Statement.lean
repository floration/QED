import Mathlib
/-! QED-Q6: Party of six (R(3,3) ≤ 6)
Among any six people, some three all know each other or some three are all strangers.
Informal statement: Every simple graph on 6 vertices contains a triangle or an independent set of size 3.
Formalization notes: `G` ranges over all simple graphs on `Fin 6`; the three vertices must be distinct.
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ6
def Claim : Prop :=
  ∀ G : SimpleGraph (Fin 6), ∃ a b c : Fin 6, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧
    ((G.Adj a b ∧ G.Adj b c ∧ G.Adj a c) ∨ (¬ G.Adj a b ∧ ¬ G.Adj b c ∧ ¬ G.Adj a c))

end OpenProblems.QEDQ6
