import Mathlib
/-! QED-E171: Beat the trivial x^{1/4} gap between sums of two squares
Let R(x) be the largest gap between consecutive integers of the form a²+b² up to x. A greedy argument (take the largest square below n, then fix the remainder with a second square) gives R(x) <= C·x^{1/4}, and this exponent has never been improved, although gaps are believed to be only about log x in size. Prove that R(x) is eventually smaller than any constant multiple of x^{1/4}.
Informal statement: Let $S=\{a^2+b^2: a,b\in\mathbb Z_{\ge0}\}$. Prove that for every $\varepsilon>0$ there is $X_0$ such that for all real $x\ge X_0$ the interval $(x,\,x+\varepsilon x^{1/4}]$ meets $S$; equivalently, the maximal gap between consecutive elements of $S\cap[1,x]$ is $o(x^{1/4})$.
Formalization notes:
* `SumTwoSq n` : `n = a^2 + b^2` for some natural numbers `a, b` (signs are irrelevant).
* Claim: for every real ε > 0 there is a real X₀ such that every real x ≥ X₀ has some
  n ∈ S with x < n ≤ x + ε·x^{1/4}. Here `x ^ ((1:ℝ)/4)` is `Real.rpow`; only large x matter
  (the prover chooses X₀, and the refuter may pick x as large as wanted), so the junk values of
  `rpow` at negative x play no role.
* This is equivalent to R(x) = o(x^{1/4}) for the maximal gap R(x) (the gap containing a large
  x has length ≤ ε·x^{1/4}, and conversely), and it does not follow from any improvement of the
  constant 2√2 alone.
* Proving `Claim` = R(x) = o(x^{1/4}). Proving `¬Claim` = for some ε > 0 there are arbitrarily
  large gaps of length ≥ ε·x^{1/4}.
-/
namespace OpenProblems.QEDE171
noncomputable section

/-- `n` is a sum of two squares. -/
def SumTwoSq (n : ℕ) : Prop := ∃ a b : ℕ, n = a ^ 2 + b ^ 2

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ X₀ : ℝ, ∀ x : ℝ, X₀ ≤ x →
    ∃ n : ℕ, SumTwoSq n ∧ x < (n : ℝ) ∧ (n : ℝ) ≤ x + ε * x ^ ((1 : ℝ) / 4)

end
end OpenProblems.QEDE171
