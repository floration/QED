import Mathlib
/-! QED-E037: How many groups of order 2048?
Determine the number of groups of order 2048, or at least show it is below 1.78 × 10^15.
Informal statement: Let $g(n)$ be the number of isomorphism classes of groups of order $n$. Known $g(2^{11})\ge 1774274116992170$. Prove $g(2^{11})<1.78\times10^{15}$.
Formalization notes: Every group of order n is isomorphic to a group structure on `Fin n`, so g(n) is the number of `Group (Fin n)` structures up to isomorphism. The multiplication of a given structure `g` is extracted explicitly (`mulOf`) to avoid clashing with the ring multiplication on `Fin n`. `Nat.card` of the (finite) quotient is the count. Claim = g(2048) < 1780000000000000; ¬Claim = g(2048) ≥ 1780000000000000. Determining g(2048) exactly is stronger than either.
-/
namespace OpenProblems.QEDE037

def mulOf {n : ℕ} (g : Group (Fin n)) (a b : Fin n) : Fin n :=
  @Mul.mul (Fin n)
    (@Semigroup.toMul (Fin n) (@Monoid.toSemigroup (Fin n)
      (@DivInvMonoid.toMonoid (Fin n) (@Group.toDivInvMonoid (Fin n) g)))) a b

def IsoRel (n : ℕ) (g h : Group (Fin n)) : Prop :=
  ∃ e : Fin n ≃ Fin n, ∀ a b : Fin n, e (mulOf g a b) = mulOf h (e a) (e b)

noncomputable def numGroups (n : ℕ) : ℕ := Nat.card (Quot (IsoRel n))

def Claim : Prop := numGroups 2048 < 1780000000000000

end OpenProblems.QEDE037
