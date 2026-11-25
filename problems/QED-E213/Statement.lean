import Mathlib
/-! QED-E213: Half of the binary digits of Champernowne's constant are 1
Champernowne's constant C = 0.123456789101112... (write the positive integers one after another in decimal) was proved normal in base 10 in 1933: every block of decimal digits appears with the expected frequency. Nothing is known about its expansion in bases that are not powers of 10. Prove the first instance: in the binary expansion of C, the proportion of 1s among the first N digits tends to 1/2.
Informal statement: Let $C=\sum_{k\ge1}d_k10^{-k}$ where $d_1d_2d_3\ldots=123456789101112\ldots$ is the concatenation of the decimal representations of $1,2,3,\ldots$, and let $b_n=\lfloor 2^nC\rfloor\bmod 2$ for $n\ge1$. Prove that $\lim_{N\to\infty}\frac1N\#\{1\le n\le N:\ b_n=1\}=\frac12$.
Formalization notes:
* `champList N` is the concatenation of the decimal digit strings of 1, …, N (most significant
  digit first: `Nat.digits 10` lists digits least significant first, so it is reversed).
* `champDigit k` (k ≥ 0) is the (k+1)-st digit d_{k+1} of the concatenation, read off from
  `champList (k+1)`; this list has length ≥ k+1 since every positive integer has ≥ 1 digit,
  and longer lists only extend it, so the default value of `getD` is never used.
* C = Σ_{k≥0} champDigit k · 10^{-(k+1)} as a real `tsum` (summable, terms ≤ 9·10^{-(k+1)}).
* b_n = ⌊2ⁿ C⌋ mod 2 is the n-th binary digit after the point (C is irrational, Mahler, so the
  binary expansion is unique). Claim: (1/N)·#{1 ≤ n ≤ N : b_n = 1} → 1/2 (simple normality of
  the digit 1 in base 2). ¬Claim: the frequency of 1s does not converge to 1/2.
-/
namespace OpenProblems.QEDE213
noncomputable section
open Filter Topology

/-- Concatenation of the decimal representations of `1, …, N`. -/
def champList : ℕ → List ℕ
  | 0 => []
  | N + 1 => champList N ++ (Nat.digits 10 (N + 1)).reverse

/-- `champDigit k = d_{k+1}`, the `(k+1)`-st decimal digit of Champernowne's constant. -/
def champDigit (k : ℕ) : ℕ := (champList (k + 1)).getD k 0

/-- Champernowne's constant `0.123456789101112…`. -/
def champernowne : ℝ := ∑' k : ℕ, (champDigit k : ℝ) / (10 : ℝ) ^ (k + 1)

/-- Half of the binary digits of Champernowne's constant are `1`. -/
def Claim : Prop :=
  Tendsto (fun N : ℕ =>
      ((((Finset.Icc 1 N).filter (fun n : ℕ => ⌊(2 : ℝ) ^ n * champernowne⌋ % 2 = 1)).card : ℕ) : ℝ) / (N : ℝ))
    atTop (𝓝 ((1 : ℝ) / 2))

end
end OpenProblems.QEDE213
