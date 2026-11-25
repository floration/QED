import Mathlib
/-! QED-E133: Beat (3+√2)/2 for diamond-free families
A family of subsets of {1,...,n} is diamond-free if it contains no four distinct sets A, B, C, D with A ⊂ B ⊂ D and A ⊂ C ⊂ D. For years it was believed that the two middle layers, about 2·binom(n, n/2) sets, are optimal; in July 2026 a random linear-algebra construction beat that with about 2.1479·binom(n, n/2) sets. The best general upper bound, (3+√2)/2 ≈ 2.2071 times binom(n, n/2), dates from 2016–2018. Lower it by any fixed amount.
Informal statement: Let $La(n,Q_2)$ be the maximum size of $\mathcal F\subseteq 2^{[n]}$ containing no four distinct $A,B,C,D\in\mathcal F$ with $A\subsetneq B\subsetneq D$ and $A\subsetneq C\subsetneq D$. Prove that $\limsup_{n\to\infty} La(n,Q_2)/\binom{n}{\lfloor n/2\rfloor} < \frac{3+\sqrt2}{2}$. (Known: $\liminf \ge 2+\frac{29}{135}\prod_{i\ge1}(1-4^{-i})\approx 2.1479$; for families inside three consecutive middle layers the density is at most $2.15121$. Stretch goal: determine the limit, whose existence is itself unknown.)
Formalization notes:
* A family is a `Finset (Finset (Fin n))` (ground set [n] = Fin n). `DiamondFree F` forbids A, B, C, D ∈ F with
  A ⊂ B ⊂ D, A ⊂ C ⊂ D (strict inclusions) and B ≠ C. Strictness makes A, B, D and A, C, D pairwise distinct, and
  B ≠ C completes distinctness, so this is exactly the non-induced (weak) Q₂-free condition used for La(n, Q₂)
  (B, C may be comparable).
* `La n` is the maximum of `F.card` over diamond-free families (a `Finset.sup` over the finite type of all families;
  the empty family is diamond-free, so the max is genuine).
* For a real sequence a, limsup a < L ⇔ ∃ c < L with a n ≤ c eventually. `Claim` states the right-hand side with
  a n = La n / C(n, ⌊n/2⌋) and L = (3+√2)/2, avoiding a junk-valued limsup. Proving `Claim` = lowering the
  (3+√2)/2 upper bound by a fixed amount; ¬Claim = limsup La(n,Q₂)/C(n,⌊n/2⌋) ≥ (3+√2)/2 (given the known upper
  bound, equal to it).
-/
namespace OpenProblems.QEDE133
noncomputable section
open scoped Classical

/-- No A ⊂ B ⊂ D, A ⊂ C ⊂ D in `F` with B ≠ C (a weak copy of the diamond poset Q₂). -/
def DiamondFree {n : ℕ} (F : Finset (Finset (Fin n))) : Prop :=
  ¬ ∃ A ∈ F, ∃ B ∈ F, ∃ C ∈ F, ∃ D ∈ F, A ⊂ B ∧ B ⊂ D ∧ A ⊂ C ∧ C ⊂ D ∧ B ≠ C

/-- La(n, Q₂): the largest size of a diamond-free family of subsets of [n]. -/
def La (n : ℕ) : ℕ :=
  ((Finset.univ : Finset (Finset (Finset (Fin n)))).filter
    (fun F : Finset (Finset (Fin n)) => DiamondFree F)).sup Finset.card

def Claim : Prop :=
  ∃ c : ℝ, c < (3 + Real.sqrt 2) / 2 ∧
    ∀ᶠ n : ℕ in Filter.atTop, (La n : ℝ) ≤ c * (Nat.choose n (n / 2) : ℝ)

end
end OpenProblems.QEDE133
