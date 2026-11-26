theorem odd_add_odd_even (a b : ℕ) (ha : Odd a) (hb : Odd b) : Even (a + b) := ha.add_odd hb
theorem claim_of_lemma : OpenProblems.QEDQ1.Claim := fun a b => odd_add_odd_even a b
