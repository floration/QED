theorem solution : OpenProblems.QEDQ3.Claim := by
  intro n
  induction n with
  | zero => simp
  | succ k ih => rw [Finset.sum_range_succ, ih]; ring
