import Mathlib
/-! QED-M119: The 3k−4 conjecture modulo a prime
Over the integers, Freiman's 3k−4 theorem says that if a finite set A has a sumset A+A with at most 3|A|−4 elements, then A lies in an arithmetic progression with only |A+A|−|A|+1 terms. Modulo a prime p the same should hold as long as A+A does not come too close to filling Z/pZ. It is known for tiny sets (|A| below roughly p/10^215) and, for larger sets, only when |A+A| is well below 3|A|. Prove the full statement.
Informal statement: Let $p$ be prime and $A\subseteq\mathbb Z/p\mathbb Z$ with $A+A\neq\mathbb Z/p\mathbb Z$. Write $|A+A|=2|A|+r$. Prove that if $|A+A|\le\min\{3|A|-4,\;p-r-4\}$, then $A$ is contained in an arithmetic progression $\{a,a+d,\dots,a+(L-1)d\}$ with $L\le |A|+r+1=|A+A|-|A|+1$.
Formalization notes:
* `A + A` is the pointwise Finset sumset in `ZMod p` (`open Pointwise`).
* All size arithmetic is done in `ℤ` (k = |A|, s = |A+A|, r = s − 2k, which may be −1), so
  there is no truncated natural subtraction. For A = ∅ or |A| ≤ 1 the hypothesis s ≤ 3k − 4
  fails, so no junk cases arise.
* The hypothesis A + A ≠ Z/pZ is stated as `∃ x, x ∉ A + A` (avoids needing a Fintype
  instance on `ZMod p` for variable p) and is kept literally, although it follows from s ≤ p − r − 4.
* An arithmetic progression with L terms is the image of `Finset.range L` under
  i ↦ a + i·d. The common difference d = 0 is allowed (degenerate progression); this only
  weakens the conclusion for singletons, which the hypotheses exclude anyway, and any set
  contained in such an AP with L terms is contained in a genuine one with ≤ L terms.
* `Claim` is the full 3k−4 conjecture mod p (as stated e.g. in Candela–Serra–Spiegel 2020).
  Proving `¬Claim` means exhibiting p and A satisfying the hypotheses not covered by any short AP.
-/
namespace OpenProblems.QEDM119
noncomputable section
open Pointwise

def Claim : Prop :=
  ∀ (p : ℕ), p.Prime → ∀ (A : Finset (ZMod p)),
    (∃ x : ZMod p, x ∉ A + A) →
    ((A + A).card : ℤ) ≤ 3 * (A.card : ℤ) - 4 →
    ((A + A).card : ℤ) ≤ (p : ℤ) - (((A + A).card : ℤ) - 2 * (A.card : ℤ)) - 4 →
    ∃ (a d : ZMod p) (L : ℕ),
      (L : ℤ) ≤ ((A + A).card : ℤ) - (A.card : ℤ) + 1 ∧
      A ⊆ (Finset.range L).image (fun i : ℕ => a + (i : ZMod p) * d)

end
end OpenProblems.QEDM119
