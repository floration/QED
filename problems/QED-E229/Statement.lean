import Mathlib
/-! QED-E229: Squares with no digit 7
Count the numbers n up to x whose square, written in base 10, has no digit 7. Show that the count has the size the random-digit model predicts.
Informal statement: Let $\mathcal A=\{m\ge1:\ \text{the decimal expansion of }m\text{ contains no digit }7\}$. Prove that $\#\{n\le x:\ n^2\in\mathcal A\}=x^{\,1+2\log_{10}(9/10)+o(1)}$ as $x\to\infty$ (exponent $\approx0.9085$). The lower bound $\ge x^{1+2\log_{10}(9/10)-o(1)}$ is the main difficulty.
Formalization notes:
* `count N = #{1 ≤ n ≤ N : 7 is not a decimal digit of n²}`, using `Nat.digits 10`
  (no leading zeros, so "contains no digit 7" is exactly `7 ∉ Nat.digits 10 (n^2)`).
* `x^{α+o(1)}` is stated as: for every `ε > 0`, for all sufficiently large integers `N`,
  `N^{α-ε} ≤ count N ≤ N^{α+ε}`. Restricting `x` to integers is harmless: the count at real `x`
  equals the count at `⌊x⌋`, and `x^{α±ε}` and `⌊x⌋^{α±ε}` differ by a bounded factor, absorbed by
  changing `ε`.
* `α = expo = 1 + 2 log₁₀(9/10)` via `Real.logb`. Proving `Claim` gives both bounds; proving `¬Claim`
  means one of them fails along a subsequence.
-/
namespace OpenProblems.QEDE229
noncomputable section

/-- Number of `1 ≤ n ≤ N` such that `n²` has no decimal digit `7`. -/
def count (N : ℕ) : ℕ :=
  ((Finset.Icc 1 N).filter (fun n : ℕ => 7 ∉ Nat.digits 10 (n ^ 2))).card

/-- The predicted exponent `1 + 2 log₁₀ (9/10) ≈ 0.9085`. -/
def expo : ℝ := 1 + 2 * Real.logb 10 (9 / 10)

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∀ᶠ N : ℕ in Filter.atTop,
    (N : ℝ) ^ (expo - ε) ≤ (count N : ℝ) ∧ (count N : ℝ) ≤ (N : ℝ) ^ (expo + ε)

end
end OpenProblems.QEDE229
