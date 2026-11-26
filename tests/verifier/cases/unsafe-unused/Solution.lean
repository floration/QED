unsafe def helper (n : ℕ) : ℕ := n
theorem solution : OpenProblems.QEDQ1.Claim :=
  fun _ _ ha hb => ha.add_odd hb
