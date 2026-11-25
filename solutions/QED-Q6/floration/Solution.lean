theorem solution : OpenProblems.QEDQ6.Claim := by
  classical
  intro G
  have h5 : (Finset.univ.erase (0 : Fin 6)).card = 5 := by simp
  have hcard := Finset.card_filter_add_card_filter_not (s := Finset.univ.erase (0 : Fin 6)) (G.Adj 0)
  rw [h5] at hcard
  rcases Nat.lt_or_ge 2 (Finset.filter (G.Adj 0) (Finset.univ.erase (0 : Fin 6))).card with h | h
  · have ex : ∀ v ∈ Finset.filter (G.Adj 0) (Finset.univ.erase (0 : Fin 6)),
        (0 : Fin 6) ≠ v ∧ G.Adj 0 v := fun v hv =>
      ⟨(Finset.mem_erase.mp (Finset.mem_filter.mp hv).1).1.symm, (Finset.mem_filter.mp hv).2⟩
    obtain ⟨x, hx, y, hy, z, hz, hxy, hxz, hyz⟩ := Finset.two_lt_card.mp h
    obtain ⟨hx0, hxa⟩ := ex x hx
    obtain ⟨hy0, hya⟩ := ex y hy
    obtain ⟨hz0, hza⟩ := ex z hz
    by_cases h1 : G.Adj x y
    · exact ⟨0, x, y, hx0, hxy, hy0, Or.inl ⟨hxa, h1, hya⟩⟩
    by_cases h2 : G.Adj y z
    · exact ⟨0, y, z, hy0, hyz, hz0, Or.inl ⟨hya, h2, hza⟩⟩
    by_cases h3 : G.Adj x z
    · exact ⟨0, x, z, hx0, hxz, hz0, Or.inl ⟨hxa, h3, hza⟩⟩
    exact ⟨x, y, z, hxy, hyz, hxz, Or.inr ⟨h1, h2, h3⟩⟩
  · have h' : 2 < (Finset.filter (fun v => ¬ G.Adj 0 v) (Finset.univ.erase (0 : Fin 6))).card := by
      omega
    have ex : ∀ v ∈ Finset.filter (fun v => ¬ G.Adj 0 v) (Finset.univ.erase (0 : Fin 6)),
        (0 : Fin 6) ≠ v ∧ ¬ G.Adj 0 v := fun v hv =>
      ⟨(Finset.mem_erase.mp (Finset.mem_filter.mp hv).1).1.symm, (Finset.mem_filter.mp hv).2⟩
    obtain ⟨x, hx, y, hy, z, hz, hxy, hxz, hyz⟩ := Finset.two_lt_card.mp h'
    obtain ⟨hx0, hxa⟩ := ex x hx
    obtain ⟨hy0, hya⟩ := ex y hy
    obtain ⟨hz0, hza⟩ := ex z hz
    by_cases h1 : G.Adj x y
    · by_cases h2 : G.Adj y z
      · by_cases h3 : G.Adj x z
        · exact ⟨x, y, z, hxy, hyz, hxz, Or.inl ⟨h1, h2, h3⟩⟩
        · exact ⟨0, x, z, hx0, hxz, hz0, Or.inr ⟨hxa, h3, hza⟩⟩
      · exact ⟨0, y, z, hy0, hyz, hz0, Or.inr ⟨hya, h2, hza⟩⟩
    · exact ⟨0, x, y, hx0, hxy, hy0, Or.inr ⟨hxa, h1, hya⟩⟩
