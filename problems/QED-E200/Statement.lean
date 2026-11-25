import Mathlib
/-! QED-E200: Beat √2−1: the zero-rate threshold for adversarial bit deletions
A binary code of length n can correct pn adversarial deletions if no two codewords share a common subsequence of length (1−p)n. Let p* be the largest fraction for which there are codes of exponential size (positive rate). Simple pigeonhole shows p* ≤ 1/2. The best known constructions (Bukh-Guruswami-Håstad, 2015) give p* ≥ √2−1 ≈ 0.414, and the best upper bound is 1/2 − δ for a tiny unspecified δ. Decide whether p* > √2−1, i.e. whether there are positive-rate binary codes that correct more than a √2−1 fraction of deletions.
Informal statement: For $x,y\in\{0,1\}^n$ let $\mathrm{LCS}(x,y)$ be the length of a longest common subsequence. Let $p^*$ be the supremum of $p\in[0,1]$ for which there is $R>0$ and, for infinitely many $n$, a code $C\subseteq\{0,1\}^n$ with $|C|\ge 2^{Rn}$ and $\mathrm{LCS}(x,y)<(1-p)n$ for all distinct $x,y\in C$. It is known that $\sqrt2-1\le p^*<1/2$. Determine whether $p^*>\sqrt2-1$.
Formalization notes: Words are `Fin n → Bool`, read as lists via `List.ofFn`; a common subsequence is a list z
with `z <+ x` and `z <+ y` (`List.Sublist`, i.e. subsequence, not necessarily contiguous). "LCS(x,y) < (1-p)n"
is "every common subsequence has length < (1-p)n". The set of achievable p is downward closed, so
p* > √2−1 ⇔ some achievable p exceeds √2−1; Claim states exactly this: there are p > √2−1 and R > 0 such that
for infinitely many n (∀ N ∃ n ≥ N) a code of size ≥ 2^{Rn} has all pairwise LCS < (1−p)n. No loophole for
p > 1: then (1−p)n < 0 would forbid even the empty common subsequence, which is impossible once |C| ≥ 2 (forced
by |C| ≥ 2^{Rn} > 1 for n ≥ 1). Claim true ⇔ p* > √2−1; ¬Claim ⇔ p* = √2−1 (given the known p* ≥ √2−1).
-/
namespace OpenProblems.QEDE200
noncomputable section

/-- `C` is a code of length `n` in which every common subsequence of two distinct codewords has length
`< (1 - p) * n`, i.e. it corrects a `p` fraction of adversarial deletions. -/
def DeletionCode (n : ℕ) (p : ℝ) (C : Finset (Fin n → Bool)) : Prop :=
  ∀ x ∈ C, ∀ y ∈ C, x ≠ y → ∀ z : List Bool,
    z.Sublist (List.ofFn x) → z.Sublist (List.ofFn y) → (z.length : ℝ) < (1 - p) * (n : ℝ)

def Claim : Prop :=
  ∃ p : ℝ, Real.sqrt 2 - 1 < p ∧ ∃ R : ℝ, 0 < R ∧
    ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ ∃ C : Finset (Fin n → Bool),
      (2 : ℝ) ^ (R * (n : ℝ)) ≤ (C.card : ℝ) ∧ DeletionCode n p C

end
end OpenProblems.QEDE200
