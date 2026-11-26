/-! End-to-end test of the partial-work pipeline: a lemma about QED-Q1. -/
theorem qedq1_odd_add_odd (a b : ℕ) (ha : Odd a) (hb : Odd b) : Even (a + b) := ha.add_odd hb
