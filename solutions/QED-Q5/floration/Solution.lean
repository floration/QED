theorem solution : OpenProblems.QEDQ5.Claim := by
  intro n hn
  have h := Nat.mod_add_div n 3
  rcases (by omega : n % 3 = 0 ∨ n % 3 = 1 ∨ n % 3 = 2) with h0 | h1 | h2
  · exact ⟨n / 3, 0, by omega⟩
  · exact ⟨n / 3 - 3, 2, by omega⟩
  · exact ⟨n / 3 - 1, 1, by omega⟩
