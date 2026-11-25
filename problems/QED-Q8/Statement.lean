import Mathlib
/-! QED-Q8: Dilworth's theorem
In any finite partially ordered set, the largest number of pairwise incomparable elements equals the smallest number of chains needed to cover everything.
Informal statement: For every finite poset $P$ there are $k$, an antichain of size $k$, and a partition of $P$ into $k$ chains.
Formalization notes: Stated as: some antichain `A` of size `k` and a colouring `c : α → Fin k` whose colour classes are chains. (Any antichain meets each chain at most once, so this is exactly Dilworth.)
This is a submission-system test problem with a known solution; prove `Claim`.
-/
namespace OpenProblems.QEDQ8
def Claim : Prop :=
  ∀ (α : Type) [Fintype α] [PartialOrder α], ∃ (k : ℕ) (A : Finset α) (c : α → Fin k),
    IsAntichain (· ≤ ·) (A : Set α) ∧ A.card = k ∧ ∀ x y : α, c x = c y → (x ≤ y ∨ y ≤ x)

end OpenProblems.QEDQ8
