import Mathlib
/-! QED-E144: Every non-abelian p-group has a non-inner automorphism of order p
Every group acts on itself by conjugation, and these 'inner' automorphisms are its obvious symmetries. Does every finite non-abelian group whose order is a power of a prime p have an automorphism that is not inner and that gives the identity when applied p times? Gaschütz proved in 1966 that a non-inner automorphism of p-power order always exists, but getting order exactly p has resisted proof for decades.
Informal statement: For every prime $p$ and every finite non-abelian $p$-group $G$, prove that there exists $\varphi\in\mathrm{Aut}(G)\setminus\mathrm{Inn}(G)$ with $\varphi^p=\mathrm{id}$ (such a $\varphi$ has order exactly $p$), or find a counterexample.
Formalization notes:
* `MulAut G` is Aut(G) (a group under composition); Inn(G) is the range of the
  conjugation hom `MulAut.conj : G →* MulAut G`.
* `IsPGroup p G` with `Finite G` means |G| is a power of p. Non-abelian is stated as
  `∃ a b, a * b ≠ b * a`.
* φ ^ p = 1 together with φ ∉ Inn(G) (so φ ≠ 1) and p prime gives order exactly p.
* Groups are taken in `Type` (universe 0); every finite group is isomorphic to one in `Type`,
  so this loses no generality.
* `Claim` is the conjecture; `¬Claim` is a counterexample.
-/
namespace OpenProblems.QEDE144
noncomputable section

def Claim : Prop :=
  ∀ (p : ℕ), p.Prime → ∀ (G : Type) [Group G] [Finite G], IsPGroup p G →
    (∃ a b : G, a * b ≠ b * a) →
    ∃ φ : MulAut G, φ ^ p = 1 ∧ φ ∉ (MulAut.conj : G →* MulAut G).range

end
end OpenProblems.QEDE144
