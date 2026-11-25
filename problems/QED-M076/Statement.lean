import Mathlib
/-! QED-M076: Close the gap in the density of integers that are sums of two rational cubes
BSD plus rank heuristics predict that half of all integers are sums of two rational cubes. Proven: at least 2/21 are (Alpöge-Bhargava-Shnidman) and at least 31.95% are not (Koymans-Smith). This file asks to improve the 2/21.
Informal statement: Let $\mathcal S=\{n\in\mathbb Z: n=x^3+y^3,\ x,y\in\mathbb Q\}$ and $d_\pm$ the lower densities of $\mathcal S$ and of its complement (ordered by $|n|$). Known: $\underline d(\mathcal S)\ge 2/21$, $\underline d(\mathcal S^c)\ge 0.3195$. Conjecture: both densities equal $1/2$. Improve either constant.
Formalization notes: Works with positive integers: n ↦ -n (with (x,y) ↦ (-x,-y)) is a bijection of the set, and 0 is negligible, so densities ordered by |n| over ℤ equal densities over ℕ_{≥1}. Lower density > 2/21 is encoded as an explicit c > 2/21 with count ≥ cN for all large N (equivalent to liminf > 2/21). Only the 'sums of cubes' side is formalized; the other target (lower density of the complement > 0.3195) is the alternative improvement and is not part of this Claim (a disjunction of the two would be the problem verbatim, but one side is cleaner and avoids dependence on the 2026 preprint). Proving ¬Claim means the lower density is ≤ 2/21, which would refute the 1/2 conjecture.
-/
namespace OpenProblems.QEDM076

/-- `n` is a sum of two rational cubes. -/
def IsSumTwoRatCubes (n : ℕ) : Prop := ∃ x y : ℚ, (n : ℚ) = x ^ 3 + y ^ 3

/-- The number of `n ∈ [1, N]` that are sums of two rational cubes. -/
noncomputable def countS (N : ℕ) : ℕ :=
  Nat.card {n : ℕ // 1 ≤ n ∧ n ≤ N ∧ IsSumTwoRatCubes n}

/-- The lower density of positive integers that are sums of two rational cubes exceeds `2/21`. -/
def Claim : Prop :=
  ∃ c : ℝ, (2 : ℝ) / 21 < c ∧ ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → c * (N : ℝ) ≤ (countS N : ℝ)

end OpenProblems.QEDM076
