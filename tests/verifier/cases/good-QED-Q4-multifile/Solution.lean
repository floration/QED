theorem solution : OpenProblems.QEDQ4.Claim := by
  intro n
  have h : 4 * ∑ i ∈ Finset.range (n + 1), i ^ 3 = 4 * (∑ i ∈ Finset.range (n + 1), i) ^ 2 := by
    rw [Q4Lemmas.four_mul_sum_cubes, ← Q4Lemmas.two_mul_sum]; ring
  exact Nat.eq_of_mul_eq_mul_left (by norm_num) h
