import Mathlib
/-! QED-M136: The MDS conjecture over fields of odd characteristic
An arc in F_q^k is a set of vectors in which every k of them are linearly independent. Arcs are the same thing as linear MDS codes, the codes that meet the Singleton bound, and Reed-Solomon codes give arcs of size q+1. Show that q+1 is always the maximum when q is odd and 2 ≤ k ≤ q. This is known when q is prime (Ball 2012). A 2026 preprint claims it for all k outside a middle window of roughly q/(2p−3) dimensions, where p is the characteristic; the smallest open case would then be q=27 with 12 ≤ k ≤ 17.
Informal statement: Let $q$ be an odd prime power and $2\le k\le q$. Prove that if $S\subseteq\mathbb{F}_q^k$ is a set of vectors such that every $k$ distinct elements of $S$ are linearly independent, then $|S|\le q+1$.
Formalization notes: F ranges over all finite fields (`Field F`, `Fintype F`) of odd cardinality
q (odd q is the same as odd characteristic; every odd prime power is realized). Vectors in F_q^k
are `Fin k → F`; S is a `Finset`. "Every k distinct elements are linearly independent" is: for
every sub-finset T ⊆ S with |T| = k, the family of elements of T (indexed by the subtype of T)
is `LinearIndependent F`. This is the standard notion of an arc (equivalently, the columns of a
generator matrix of a linear [|S|, k] MDS code; duplicate columns cannot occur since S is a set,
and a repeated vector would make some k-subset dependent anyway). Claim: every such arc has at
most q+1 elements whenever 2 ≤ k ≤ q. ¬Claim means an arc of size q+2 in some F_q^k with q odd
and 2 ≤ k ≤ q.
-/
namespace OpenProblems.QEDM136
noncomputable section

/-- `S ⊆ F^k` is an arc: every `k` distinct elements are linearly independent. -/
def IsArc {F : Type} [Field F] (k : ℕ) (S : Finset (Fin k → F)) : Prop :=
  ∀ T : Finset (Fin k → F), T ⊆ S → T.card = k →
    LinearIndependent F (fun v : {x // x ∈ T} => (v.1 : Fin k → F))

def Claim : Prop :=
  ∀ (F : Type) [Field F] [Fintype F], Odd (Fintype.card F) →
    ∀ k : ℕ, 2 ≤ k → k ≤ Fintype.card F →
      ∀ S : Finset (Fin k → F), IsArc k S → S.card ≤ Fintype.card F + 1

end
end OpenProblems.QEDM136
