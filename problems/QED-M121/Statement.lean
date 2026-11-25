import Mathlib
/-! QED-M121: Additive basis conjecture: a constant number of bases suffices
Take several bases of the vector space (Z/p)^n and pool all their vectors into one list. Can every vector of the space be written as the sum of some sub-list, using each pooled vector at most once? The conjecture says a fixed number c(p) of bases always suffices, independent of the dimension n. The best proven bound grows like log n.
Informal statement: For a prime $p$, a finite multiset $B$ of vectors in $\mathbb{F}_p^n$ is an additive basis if $\{\sum_{b\in B}\varepsilon_b b : \varepsilon\in\{0,1\}^B\}=\mathbb{F}_p^n$. Prove that for every prime $p$ there is $c(p)$ such that for every $n\ge1$ and all bases $B_1,\dots,B_{c(p)}$ of $\mathbb{F}_p^n$, the multiset union $B_1\uplus\cdots\uplus B_{c(p)}$ is an additive basis.
Formalization notes:
* 𝔽_p^n is `Fin n → ZMod p`. A basis is an indexed family `B a : Fin n → (Fin n → ZMod p)` that
  is linearly independent over `ZMod p`; since the space has dimension n, n linearly independent
  vectors are exactly a basis (we avoid the `Basis` structure, whose namespace has moved).
* The multiset union of c bases is the family indexed by `Fin c × Fin n`; repeated vectors across
  bases are separate members, as in a multiset. A 0/1 choice is `ε : Fin c → Fin n → Bool`, and
  the subset sum is `∑ a, ∑ i, if ε a i then B a i else 0`.
* Claim: for every prime p there is c such that for every n ≥ 1, every c-tuple of bases, and
  every target vector v, some subset sum equals v. n ≥ 1 rules out the trivial n = 0 case (it
  is harmless anyway); c = 0 never works for n ≥ 1, so the existential is not vacuous.
  ¬Claim: for some prime p, for every c there is a dimension and c bases whose union is not an
  additive basis.
-/
namespace OpenProblems.QEDM121

def Claim : Prop :=
  ∀ p : ℕ, p.Prime → ∃ c : ℕ, ∀ n : ℕ, 1 ≤ n →
    ∀ B : Fin c → Fin n → (Fin n → ZMod p),
      (∀ a : Fin c, LinearIndependent (ZMod p) (B a)) →
      ∀ v : Fin n → ZMod p, ∃ ε : Fin c → Fin n → Bool,
        v = ∑ a : Fin c, ∑ i : Fin n, (if ε a i then B a i else 0)

end OpenProblems.QEDM121
