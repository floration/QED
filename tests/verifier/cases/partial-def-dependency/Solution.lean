partial def spin (n : ℕ) : ℕ := spin (n + 1)
theorem solution : OpenProblems.QEDQ1.Claim := by
  have : spin 0 = spin 0 := rfl
  exact fun _ _ ha hb => ha.add_odd hb
