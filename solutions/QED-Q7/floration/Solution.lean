-- Adapted from Mathlib Archive (Erdős–Szekeres, B. Mehta).
open Function Finset

namespace Q7Aux

variable {α β : Type*} [Fintype α] [LinearOrder α] [LinearOrder β] {f : α → β} {i : α}

private noncomputable def incSequencesTo (f : α → β) (i : α) : Finset ℕ :=
  open scoped Classical in
  image card {t : Finset α | IsGreatest t i ∧ StrictMonoOn f t}

private noncomputable def decSequencesTo (f : α → β) (i : α) : Finset ℕ :=
  open scoped Classical in
  image card {t : Finset α | IsGreatest t i ∧ StrictAntiOn f t}

private lemma one_mem_incSequencesTo : 1 ∈ incSequencesTo f i := mem_image.2 ⟨{i}, by simp⟩
private lemma one_mem_decSequencesTo : 1 ∈ decSequencesTo f i := one_mem_incSequencesTo (β := βᵒᵈ)

private lemma incSequencesTo_nonempty : (incSequencesTo f i).Nonempty := ⟨1, one_mem_incSequencesTo⟩
private lemma decSequencesTo_nonempty : (decSequencesTo f i).Nonempty := ⟨1, one_mem_decSequencesTo⟩

private noncomputable def maxIncSequencesTo (f : α → β) (i : α) : ℕ :=
  max' (incSequencesTo f i) incSequencesTo_nonempty

private noncomputable def maxDecSequencesTo (f : α → β) (i : α) : ℕ :=
  max' (decSequencesTo f i) decSequencesTo_nonempty

private lemma one_le_maxIncSequencesTo : 1 ≤ maxIncSequencesTo f i :=
  le_max' _ _ one_mem_incSequencesTo
private lemma one_le_maxDecSequencesTo : 1 ≤ maxDecSequencesTo f i :=
  le_max' _ _ one_mem_decSequencesTo

private lemma maxIncSequencesTo_mem : maxIncSequencesTo f i ∈ incSequencesTo f i :=
  max'_mem _ incSequencesTo_nonempty
private lemma maxDecSequencesTo_mem : maxDecSequencesTo f i ∈ decSequencesTo f i :=
  max'_mem _ decSequencesTo_nonempty

private lemma maxIncSequencesTo_lt {i j : α} (hij : i < j) (hfij : f i < f j) :
    maxIncSequencesTo f i < maxIncSequencesTo f j := by
  rw [Nat.lt_iff_add_one_le]
  refine le_max' _ _ ?_
  have : maxIncSequencesTo f i ∈ incSequencesTo f i := max'_mem _ incSequencesTo_nonempty
  simp only [incSequencesTo, mem_image, mem_filter, mem_univ, true_and, and_assoc] at this
  obtain ⟨t, hti, ht₁, ht₂⟩ := this
  simp only [incSequencesTo, mem_image, mem_filter, mem_univ, true_and, and_assoc]
  have : ∀ x ∈ t, x < j := by
    intro x hx
    exact (hti.2 hx).trans_lt hij
  refine ⟨insert j t, ?_, ?_, ?_⟩
  next =>
    convert hti.insert j
    next => simp
    next => rw [max_eq_left hij.le]
  next =>
    simp only [coe_insert]
    rw [strictMonoOn_insert_iff_of_forall_le]
    · refine ⟨?_, ht₁⟩
      intro x hx hxj
      exact (ht₁.monotoneOn hx hti.1 (hti.2 hx)).trans_lt hfij
    · exact fun x hx ↦ (this x hx).le
  have : j ∉ t := fun hj ↦ lt_irrefl _ (this _ hj)
  simp [this, ht₂]

private lemma maxDecSequencesTo_gt {i j : α} (hij : i < j) (hfij : f j < f i) :
    maxDecSequencesTo f i < maxDecSequencesTo f j :=
  maxIncSequencesTo_lt (β := βᵒᵈ) hij hfij

private noncomputable def paired (f : α → β) (i : α) : ℕ × ℕ :=
  (maxIncSequencesTo f i, maxDecSequencesTo f i)

private lemma paired_injective (hf : Injective f) : Injective (paired f) := by
  apply Injective.of_lt_imp_ne
  intro i j hij q
  cases lt_or_gt_of_ne (hf.ne hij.ne)
  case inl h => exact (maxIncSequencesTo_lt hij h).ne congr($q.1)
  case inr h => exact (maxDecSequencesTo_gt hij h).ne congr($q.2)

theorem erdos_szekeres {r s : ℕ} {f : α → β} (hn : r * s < Fintype.card α) (hf : Injective f) :
    (∃ t : Finset α, r < #t ∧ StrictMonoOn f t) ∨
      ∃ t : Finset α, s < #t ∧ StrictAntiOn f t := by
  classical
  rsuffices ⟨i, hi⟩ : ∃ i, r < maxIncSequencesTo f i ∨ s < maxDecSequencesTo f i
  · refine Or.imp ?_ ?_ hi
    on_goal 1 =>
      have : maxIncSequencesTo f i ∈ image card _ := maxIncSequencesTo_mem
    on_goal 2 =>
      have : maxDecSequencesTo f i ∈ image card _ := maxDecSequencesTo_mem
    all_goals
      intro hi
      obtain ⟨t, ht₁, ht₂⟩ := mem_image.1 this
      refine ⟨t, by rwa [ht₂], ?_⟩
      rw [mem_filter] at ht₁
      exact ht₁.2.2
  by_contra! q
  have : Set.MapsTo (paired f) (univ : Finset α) (Icc 1 r ×ˢ Icc 1 s : Finset _) := by
    simp [paired, one_le_maxIncSequencesTo, one_le_maxDecSequencesTo, Set.MapsTo, *]
  refine hn.not_ge ?_
  simpa using card_le_card_of_injOn (paired f) this (paired_injective hf).injOn

end Q7Aux

theorem solution : OpenProblems.QEDQ7.Claim := by
  intro r s f hf
  have hn : r * s < Fintype.card (Fin (r * s + 1)) := by rw [Fintype.card_fin]; omega
  rcases Q7Aux.erdos_szekeres hn hf with ⟨t, ht, hmono⟩ | ⟨t, ht, hanti⟩
  · left
    obtain ⟨u, hut, hu⟩ := Finset.exists_subset_card_eq (show r + 1 ≤ t.card by omega)
    exact ⟨u, hu, hmono.mono (Finset.coe_subset.mpr hut)⟩
  · right
    obtain ⟨u, hut, hu⟩ := Finset.exists_subset_card_eq (show s + 1 ≤ t.card by omega)
    exact ⟨u, hu, hanti.mono (Finset.coe_subset.mpr hut)⟩
