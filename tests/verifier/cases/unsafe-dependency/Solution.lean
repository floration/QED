unsafe def unsafeOdd (n : ℕ) : Prop := Odd n
theorem solution : OpenProblems.QEDQ1.Claim := by
  have : unsafeOdd 1 = Odd 1 := rfl
  exact fun _ _ ha hb => ha.add_odd hb
