import Mathlib
/-! QED-M124: The 1/3–2/3 conjecture for width-three posets
Take a finite partial order and pick one of its linear extensions (total orders compatible with it) uniformly at random. The 1/3–2/3 conjecture says that, unless the order is already total, some pair x, y has probability between 1/3 and 2/3 that x comes before y. It is known for width 2 (no three pairwise incomparable elements) and, since 2026, for all posets of width above some unspecified constant. Prove it for every poset of width 3.
Informal statement: For a finite poset $P$, let $e(P)$ be its number of linear extensions and, for $x\ne y$, let $p(x\prec y)$ be the fraction of linear extensions in which $x$ precedes $y$. Prove that every finite poset of width exactly $3$ contains $x,y$ with $\tfrac13\le p(x\prec y)\le\tfrac23$.
Formalization notes:
* A finite poset is a type `α : Type` with `[Fintype α] [PartialOrder α]` (every finite poset is
  isomorphic to one, and the statement is isomorphism invariant).
* A linear extension is a bijection `f : α ≃ Fin (Fintype.card α)` that is strictly order
  preserving: `x < y → f x < f y`. These correspond bijectively to linear extensions.
* `numLinExt α` = number of linear extensions; `numBefore x y` = number in which `f x < f y`.
  Both are `Nat.card` of finite subtypes (finite since `α ≃ Fin _` is finite), so no junk value.
* Width exactly 3: some 3-element antichain exists, and every antichain (as a Finset) has at most
  3 elements. Antichains use `IsAntichain (· ≤ ·)`.
* Claim: every such poset has x ≠ y with 1/3 ≤ numBefore x y / numLinExt ≤ 2/3, written without
  division as 3·numBefore ≥ numLinExt and 3·numBefore ≤ 2·numLinExt (numLinExt ≥ 1 since
  linear extensions exist). ¬Claim: some width-3 poset has no balanced pair.
-/
namespace OpenProblems.QEDM124
noncomputable section

/-- Number of linear extensions of a finite poset. -/
def numLinExt (α : Type) [Fintype α] [PartialOrder α] : ℕ :=
  Nat.card {f : α ≃ Fin (Fintype.card α) // ∀ x y : α, x < y → f x < f y}

/-- Number of linear extensions in which `x` comes before `y`. -/
def numBefore {α : Type} [Fintype α] [PartialOrder α] (x y : α) : ℕ :=
  Nat.card {f : α ≃ Fin (Fintype.card α) // (∀ a b : α, a < b → f a < f b) ∧ f x < f y}

/-- The poset has width exactly 3. -/
def WidthThree (α : Type) [Fintype α] [PartialOrder α] : Prop :=
  (∃ s : Finset α, s.card = 3 ∧ IsAntichain (· ≤ ·) (s : Set α)) ∧
    ∀ s : Finset α, IsAntichain (· ≤ ·) (s : Set α) → s.card ≤ 3

def Claim : Prop :=
  ∀ (α : Type) [Fintype α] [PartialOrder α], WidthThree α →
    ∃ x y : α, x ≠ y ∧ numLinExt α ≤ 3 * numBefore x y ∧ 3 * numBefore x y ≤ 2 * numLinExt α

end
end OpenProblems.QEDM124
