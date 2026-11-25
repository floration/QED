/-! Helper lemmas for the multi-file fixture (split from the merged QED-Q4 solution). -/
namespace Q4Lemmas

theorem two_mul_sum (m : ℕ) : 2 * ∑ i ∈ Finset.range (m + 1), i = m * (m + 1) := by
  induction m with
  | zero => simp
  | succ k ih => rw [Finset.sum_range_succ, mul_add, ih]; ring

theorem four_mul_sum_cubes (m : ℕ) : 4 * ∑ i ∈ Finset.range (m + 1), i ^ 3 = (m * (m + 1)) ^ 2 := by
  induction m with
  | zero => simp
  | succ k ih => rw [Finset.sum_range_succ, mul_add, ih]; ring

end Q4Lemmas
