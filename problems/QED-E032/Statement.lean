import Mathlib
/-! QED-E032: Covering systems with a large minimum modulus
A covering system is a finite list of arithmetic progressions a_i mod m_i, all with different moduli, such that every integer lies in at least one of them. Erdős asked whether the smallest modulus can be made as large as you like; Hough proved it cannot. The largest smallest modulus anyone has actually achieved is 42, while the best proof only shows it is at most 14,000. Find a covering with smallest modulus at least 43, or prove a much smaller upper bound.
Informal statement: Let $M^*$ be the largest integer $M$ for which there exist $k\ge1$, distinct integers $M\le m_1<\dots<m_k$ and residues $a_i$ with $\bigcup_i (a_i+m_i\mathbb Z)=\mathbb Z$. Known: $42\le M^*<14000$ (and $\le 13278$ by a further computer-assisted calculation, same preprint). Decide whether $M^*\ge 43$, and more generally narrow the gap (e.g. prove $M^*\le 1000$).
Formalization notes: A covering is a finite set S of pairs (m, a) with distinct moduli m (Prod.fst injective on S), all m >= 43, such that every integer x satisfies m ∣ x - a for some pair. Claim: such a covering exists, i.e. M* >= 43. ¬Claim means M* = 42. Nonemptiness of S is forced by the covering condition, and m >= 43 excludes the trivial modulus 1.
-/
namespace OpenProblems.QEDE032
def Claim : Prop :=
  ∃ S : Finset (ℕ × ℤ), (∀ p ∈ S, 43 ≤ p.1) ∧ Set.InjOn Prod.fst (S : Set (ℕ × ℤ)) ∧
    ∀ x : ℤ, ∃ p ∈ S, ((p.1 : ℤ) ∣ x - p.2)
end OpenProblems.QEDE032
