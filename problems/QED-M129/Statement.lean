import Mathlib
/-! QED-M129: Modular isomorphism problem for odd primes
For a finite p-group G, the group algebra F_p G remembers G only through linear combinations of its
elements. Can two non-isomorphic p-groups have isomorphic group algebras over F_p? For p = 2 the
answer is yes (groups of order 512, found in 2021). For every odd prime p the question is open:
find such a pair, or prove the group algebra determines the group.
Informal statement: Let p be an odd prime. Decide whether there exist finite p-groups G ≇ H with
F_pG ≅ F_pH as F_p-algebras. Board claim (either direction accepted): exhibit such p, G, H, or
prove that for every odd prime p and all finite p-groups G, H, F_pG ≅ F_pH ⇒ G ≅ H.
Formalization notes:
* F_p is `ZMod p`; the group algebra F_pG is Mathlib's `MonoidAlgebra (ZMod p) G`, an
  `ZMod p`-algebra; isomorphism of F_p-algebras is `≃ₐ[ZMod p]`.
* Finite p-groups: `[Group G] [Finite G]` with `IsPGroup p G` (every element has p-power order,
  equivalently |G| is a power of p for finite G).
* Groups range over `Type` (no loss: every finite group has an isomorphic copy in `Type`).
* Claim is the positive answer for all odd primes simultaneously. Proving `Claim` = the modular
  isomorphism problem has a positive answer for every odd p; `¬Claim` = an explicit odd prime p
  and non-isomorphic finite p-groups with isomorphic F_p group algebras. Both are accepted.
-/
namespace OpenProblems.QEDM129
noncomputable section

def Claim : Prop :=
  ∀ p : ℕ, p.Prime → p ≠ 2 →
    ∀ (G H : Type) [Group G] [Group H] [Finite G] [Finite H],
      IsPGroup p G → IsPGroup p H →
        Nonempty (MonoidAlgebra (ZMod p) G ≃ₐ[ZMod p] MonoidAlgebra (ZMod p) H) →
          Nonempty (G ≃* H)

end
end OpenProblems.QEDM129
