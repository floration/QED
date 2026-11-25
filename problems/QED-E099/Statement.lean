import Mathlib
/-! QED-E099: Close the gap in the density of integers that are sums of two rational cubes
BSD plus the minimalist rank heuristic predict that exactly half of all integers are sums of two
rational cubes. Known: at least 5/12 are (Alpöge–Bhargava–Shnidman's conditional bound, made
unconditional by the Selmer-group p-converse for all primes), and at least 31.95% are not
(Koymans–Smith 2026). Improve either bound.

Informal statement: Let S = {n ∈ ℤ : n = x³ + y³, x, y ∈ ℚ}, densities ordered by |n|.
Prove that the lower density of S exceeds 5/12, or that the lower density of ℤ \ S exceeds 0.3195.

Formalization notes:
* Works with positive integers: n ↦ -n (with (x,y) ↦ (-x,-y)) preserves S, and 0 is negligible,
  so lower densities ordered by |n| over ℤ equal those over {1, 2, ...}.
* "Lower density > a" is encoded as: ∃ c > a with count ≥ c·N for all large N (equivalent to
  liminf count/N > a); no division, no junk values.
* Claim is the disjunction of the two improvements. Premise risk: the 5/12 baseline rests on the
  2026 p-converse result (if it failed, 2/21 would be the proven bound and the S-side target would
  be harder than "improve the record"); the 0.3195 baseline is from arXiv:2606.06024.
  ¬Claim would mean both lower densities equal the current bounds, refuting the 1/2 conjecture.
-/
namespace OpenProblems.QEDE099

/-- `n` is a sum of two rational cubes. -/
def IsSumTwoRatCubes (n : ℕ) : Prop := ∃ x y : ℚ, (n : ℚ) = x ^ 3 + y ^ 3

/-- The number of `n ∈ [1, N]` that are sums of two rational cubes. -/
noncomputable def countS (N : ℕ) : ℕ :=
  Nat.card {n : ℕ // 1 ≤ n ∧ n ≤ N ∧ IsSumTwoRatCubes n}

/-- The number of `n ∈ [1, N]` that are not sums of two rational cubes. -/
noncomputable def countNotS (N : ℕ) : ℕ :=
  Nat.card {n : ℕ // 1 ≤ n ∧ n ≤ N ∧ ¬ IsSumTwoRatCubes n}

/-- Lower density of the cube sums exceeds `5/12`, or lower density of the non-sums
exceeds `0.3195`. -/
def Claim : Prop :=
  (∃ c : ℝ, (5 : ℝ) / 12 < c ∧ ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → c * (N : ℝ) ≤ (countS N : ℝ)) ∨
  (∃ c : ℝ, (3195 : ℝ) / 10000 < c ∧ ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N →
    c * (N : ℝ) ≤ (countNotS N : ℝ))

end OpenProblems.QEDE099
