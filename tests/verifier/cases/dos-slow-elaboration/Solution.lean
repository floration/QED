-- selftest.py prepends the generated lines from case.json ("generate") to this file.
theorem solution : OpenProblems.QEDQ1.Claim :=
  fun _ _ ha hb => ha.add_odd hb
