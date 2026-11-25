theorem solution : OpenProblems.QEDQ4.Claim := by
  intro n
  have h1 : ∀ m : ℕ, 2 * ∑ i ∈ Finset.range (m + 1), i = m * (m + 1) := by
    intro m
    induction m with
    | zero => simp
    | succ k ih => rw [Finset.sum_range_succ, mul_add, ih]; ring
  have h3 : ∀ m : ℕ, 4 * ∑ i ∈ Finset.range (m + 1), i ^ 3 = (m * (m + 1)) ^ 2 := by
    intro m
    induction m with
    | zero => simp
    | succ k ih => rw [Finset.sum_range_succ, mul_add, ih]; ring
  have h : 4 * ∑ i ∈ Finset.range (n + 1), i ^ 3 = 4 * (∑ i ∈ Finset.range (n + 1), i) ^ 2 := by
    rw [h3, ← h1]; ring
  exact Nat.eq_of_mul_eq_mul_left (by norm_num) h
