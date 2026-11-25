/-! Dilworth's theorem, following Galvin's inductive proof (remove a maximal element). -/
namespace Q8Aux

variable {α : Type} [PartialOrder α]

/-- An antichain `A ⊆ s` and a chain colouring `c` of `s`: `c` is injective on `A`, values `< k`. -/
theorem cover_inj {s A : Finset α} {k : ℕ} {c : α → ℕ}
    (hc : ∀ x ∈ s, c x < k) (hch : ∀ x ∈ s, ∀ y ∈ s, c x = c y → x ≤ y ∨ y ≤ x)
    (hAs : A ⊆ s) (hA : IsAntichain (· ≤ ·) (A : Set α)) :
    Set.InjOn c (A : Set α) ∧ A.image c ⊆ Finset.range k := by
  classical
  constructor
  · intro x hx y hy hxy
    have hx' : x ∈ A := Finset.mem_coe.mp hx
    have hy' : y ∈ A := Finset.mem_coe.mp hy
    rcases hch x (hAs hx') y (hAs hy') hxy with h | h
    · exact hA.eq hx hy h
    · exact (hA.eq hy hx h).symm
  · intro i hi
    obtain ⟨x, hx, rfl⟩ := Finset.mem_image.mp hi
    exact Finset.mem_range.mpr (hc x (hAs hx))

theorem card_le {s A : Finset α} {k : ℕ} {c : α → ℕ}
    (hc : ∀ x ∈ s, c x < k) (hch : ∀ x ∈ s, ∀ y ∈ s, c x = c y → x ≤ y ∨ y ≤ x)
    (hAs : A ⊆ s) (hA : IsAntichain (· ≤ ·) (A : Set α)) : A.card ≤ k := by
  classical
  obtain ⟨hinj, hsub⟩ := cover_inj hc hch hAs hA
  calc A.card = (A.image c).card := (Finset.card_image_of_injOn hinj).symm
    _ ≤ (Finset.range k).card := Finset.card_le_card hsub
    _ = k := Finset.card_range k

theorem meets {s A : Finset α} {k : ℕ} {c : α → ℕ}
    (hc : ∀ x ∈ s, c x < k) (hch : ∀ x ∈ s, ∀ y ∈ s, c x = c y → x ≤ y ∨ y ≤ x)
    (hAs : A ⊆ s) (hA : IsAntichain (· ≤ ·) (A : Set α)) (hk : A.card = k) :
    ∀ i < k, ∃ x ∈ A, c x = i := by
  classical
  obtain ⟨hinj, hsub⟩ := cover_inj hc hch hAs hA
  have heq : A.image c = Finset.range k := by
    apply Finset.eq_of_subset_of_card_le hsub
    rw [Finset.card_range, Finset.card_image_of_injOn hinj, hk]
  intro i hi
  have hmem : i ∈ A.image c := by rw [heq]; exact Finset.mem_range.mpr hi
  obtain ⟨x, hx, hxi⟩ := Finset.mem_image.mp hmem
  exact ⟨x, hx, hxi⟩

/-- `y` lies in some antichain of size `k` inside `t`. -/
abbrev Good (t : Finset α) (k : ℕ) (y : α) : Prop :=
  ∃ B : Finset α, B ⊆ t ∧ IsAntichain (· ≤ ·) (B : Set α) ∧ B.card = k ∧ y ∈ B

theorem main (n : ℕ) : ∀ s : Finset α, s.card ≤ n → ∃ k : ℕ, ∃ A : Finset α, A ⊆ s ∧
    IsAntichain (· ≤ ·) (A : Set α) ∧ A.card = k ∧ ∃ c : α → ℕ,
    (∀ x ∈ s, c x < k) ∧ ∀ x ∈ s, ∀ y ∈ s, c x = c y → x ≤ y ∨ y ≤ x := by
  classical
  induction n with
  | zero =>
    intro s hs
    have hs0 : s = ∅ := Finset.card_eq_zero.mp (Nat.le_zero.mp hs)
    subst hs0
    refine ⟨0, ∅, Finset.empty_subset _, ?_, rfl, fun _ => 0, ?_, ?_⟩
    · rw [Finset.coe_empty]; exact IsAntichain.empty
    · intro x hx; exact absurd hx (Finset.notMem_empty x)
    · intro x hx; exact absurd hx (Finset.notMem_empty x)
  | succ n ih =>
  intro s hs
  rcases s.eq_empty_or_nonempty with hs0 | hne
  · exact ih s (by rw [hs0, Finset.card_empty]; exact Nat.zero_le _)
  obtain ⟨a, has, hmax⟩ := s.exists_maximal hne
  -- hmax : ∀ y ∈ s, a ≤ y → y ≤ a
  have hmax' : ∀ y ∈ s, a ≤ y → y = a := fun y hy hay => le_antisymm (hmax hy hay) hay
  have hs' : (s.erase a).card ≤ n := by rw [Finset.card_erase_of_mem has]; omega
  obtain ⟨k, A0, hA0s, hA0, hA0k, c, hc, hch⟩ := ih (s.erase a) hs'
  obtain ⟨X, hX⟩ : ∃ X : Finset α, X = (s.erase a).filter (fun x => Good (s.erase a) k x ∧
      ∀ y ∈ s.erase a, Good (s.erase a) k y → c y = c x → y ≤ x) := ⟨_, rfl⟩
  have memX : ∀ x, x ∈ X ↔ x ∈ s.erase a ∧ (Good (s.erase a) k x ∧
      ∀ y ∈ s.erase a, Good (s.erase a) k y → c y = c x → y ≤ x) := by
    intro x; rw [hX, Finset.mem_filter]
  have hXs : X ⊆ s.erase a := fun x hx => ((memX x).mp hx).1
  -- every colour class contains an element of `X`
  have hG1 : ∀ i < k, ∃ x ∈ X, c x = i := by
    intro i hi
    obtain ⟨x, hx, hxi⟩ := meets hc hch hA0s hA0 hA0k i hi
    have hS : ((s.erase a).filter (fun y => Good (s.erase a) k y ∧ c y = i)).Nonempty :=
      ⟨x, Finset.mem_filter.mpr ⟨hA0s hx, ⟨A0, hA0s, hA0, hA0k, hx⟩, hxi⟩⟩
    obtain ⟨m, hmS, hmm⟩ := Finset.exists_maximal hS
    obtain ⟨hm1, hm2, hm3⟩ := Finset.mem_filter.mp hmS
    refine ⟨m, (memX m).mpr ⟨hm1, hm2, ?_⟩, hm3⟩
    intro y hy hgy hcy
    have hyS : y ∈ (s.erase a).filter (fun y => Good (s.erase a) k y ∧ c y = i) :=
      Finset.mem_filter.mpr ⟨hy, hgy, hcy.trans hm3⟩
    rcases hch y hy m hm1 hcy with h | h
    · exact h
    · exact hmm hyS h
  -- `X` is an antichain
  have hXanti : IsAntichain (· ≤ ·) (X : Set α) := by
    intro x hx x' hx' hne hle
    obtain ⟨hx1, -, hx3⟩ := (memX x).mp (Finset.mem_coe.mp hx)
    obtain ⟨-, ⟨B, hBs, hB, hBk, hx'B⟩, -⟩ := (memX x').mp (Finset.mem_coe.mp hx')
    obtain ⟨y, hyB, hyc⟩ := meets hc hch hBs hB hBk (c x) (hc x hx1)
    have hyx : y ≤ x := hx3 y (hBs hyB) ⟨B, hBs, hB, hBk, hyB⟩ hyc
    have hyx' : y = x' := hB.eq (Finset.mem_coe.mpr hyB) (Finset.mem_coe.mpr hx'B) (hyx.trans hle)
    rw [hyx'] at hyx
    exact hne (le_antisymm hle hyx)
  have hXcard : X.card = k := by
    apply le_antisymm (card_le hc hch hXs hXanti)
    have hsub : Finset.range k ⊆ X.image c := by
      intro i hi
      obtain ⟨x, hx, hxi⟩ := hG1 i (Finset.mem_range.mp hi)
      exact Finset.mem_image.mpr ⟨x, hx, hxi⟩
    calc k = (Finset.range k).card := (Finset.card_range k).symm
      _ ≤ (X.image c).card := Finset.card_le_card hsub
      _ ≤ X.card := Finset.card_image_le
  have hmemE : ∀ x ∈ s, x ≠ a → x ∈ s.erase a := fun x hx hxa => Finset.mem_erase.mpr ⟨hxa, hx⟩
  by_cases hcase : ∃ x0 ∈ X, x0 ≤ a
  · -- remove the chain `K` of elements of colour `c x0` below `x0`, together with `a`
    obtain ⟨x0, hx0X, hx0a⟩ := hcase
    obtain ⟨hx0s, -, hx0max⟩ := (memX x0).mp hx0X
    obtain ⟨K, hK⟩ : ∃ K : Finset α,
        K = insert a ((s.erase a).filter (fun z => c z = c x0 ∧ z ≤ x0)) := ⟨_, rfl⟩
    have memK : ∀ z, z ∈ K ↔ z = a ∨ (z ∈ s.erase a ∧ (c z = c x0 ∧ z ≤ x0)) := by
      intro z; rw [hK, Finset.mem_insert, Finset.mem_filter]
    have hKchain : ∀ x ∈ K, ∀ y ∈ K, x ≤ y ∨ y ≤ x := by
      intro x hx y hy
      rcases (memK x).mp hx with rfl | ⟨hx1, hx2, hx3⟩ <;>
        rcases (memK y).mp hy with rfl | ⟨hy1, hy2, hy3⟩
      · exact Or.inl le_rfl
      · exact Or.inr (hy3.trans hx0a)
      · exact Or.inl (hx3.trans hx0a)
      · exact hch x hx1 y hy1 (hx2.trans hy2.symm)
    have hsub2 : s \ K ⊆ s.erase a := by
      intro x hx
      obtain ⟨hxs, hxK⟩ := Finset.mem_sdiff.mp hx
      exact hmemE x hxs (fun h => hxK ((memK x).mpr (Or.inl h)))
    obtain ⟨k2, A2, hA2s, hA2, hA2k, c2, hc2, hch2⟩ :=
      ih (s \ K) ((Finset.card_le_card hsub2).trans hs')
    have hk2le : k2 ≤ k := by
      have := card_le hc hch (hA2s.trans hsub2) hA2
      omega
    have hk2lt : k2 < k := by
      refine lt_of_le_of_ne hk2le ?_
      intro hk2
      obtain ⟨y, hyA2, hyc⟩ := meets hc hch (hA2s.trans hsub2) hA2 (hA2k.trans hk2) (c x0)
        (hc x0 hx0s)
      have hyE : y ∈ s.erase a := hsub2 (hA2s hyA2)
      have hyx0 : y ≤ x0 := hx0max y hyE ⟨A2, hA2s.trans hsub2, hA2, hA2k.trans hk2, hyA2⟩ hyc
      have hyK : y ∈ K := (memK y).mpr (Or.inr ⟨hyE, hyc, hyx0⟩)
      exact (Finset.mem_sdiff.mp (hA2s hyA2)).2 hyK
    refine ⟨k, A0, hA0s.trans (Finset.erase_subset a s), hA0, hA0k,
      fun x => if x ∈ K then k2 else c2 x, ?_, ?_⟩
    · intro x hx
      by_cases hxK : x ∈ K
      · simp only [if_pos hxK]; exact hk2lt
      · simp only [if_neg hxK]
        exact (hc2 x (Finset.mem_sdiff.mpr ⟨hx, hxK⟩)).trans hk2lt
    · intro x hx y hy hxy
      by_cases hxK : x ∈ K <;> by_cases hyK : y ∈ K
      · exact hKchain x hxK y hyK
      · simp only [if_pos hxK, if_neg hyK] at hxy
        have := hc2 y (Finset.mem_sdiff.mpr ⟨hy, hyK⟩)
        omega
      · simp only [if_neg hxK, if_pos hyK] at hxy
        have := hc2 x (Finset.mem_sdiff.mpr ⟨hx, hxK⟩)
        omega
      · simp only [if_neg hxK, if_neg hyK] at hxy
        exact hch2 x (Finset.mem_sdiff.mpr ⟨hx, hxK⟩) y (Finset.mem_sdiff.mpr ⟨hy, hyK⟩) hxy
  · -- `X ∪ {a}` is an antichain of size `k + 1`; `a` gets a new colour
    have haX : a ∉ X := fun h => (Finset.mem_erase.mp (hXs h)).1 rfl
    refine ⟨k + 1, insert a X, ?_, ?_, ?_, fun x => if x = a then k else c x, ?_, ?_⟩
    · intro x hx
      rcases Finset.mem_insert.mp hx with rfl | hx
      · exact has
      · exact Finset.mem_of_mem_erase (hXs hx)
    · rw [Finset.coe_insert]
      refine IsAntichain.insert hXanti ?_ ?_
      · intro b hb _ hba
        exact hcase ⟨b, Finset.mem_coe.mp hb, hba⟩
      · intro b hb hab hab'
        exact hab (hmax' b (Finset.mem_of_mem_erase (hXs (Finset.mem_coe.mp hb))) hab').symm
    · rw [Finset.card_insert_of_notMem haX, hXcard]
    · intro x hx
      by_cases hxa : x = a
      · simp only [if_pos hxa]; omega
      · simp only [if_neg hxa]; have := hc x (hmemE x hx hxa); omega
    · intro x hx y hy hxy
      by_cases hxa : x = a <;> by_cases hya : y = a
      · exact Or.inl (le_of_eq (hxa.trans hya.symm))
      · simp only [if_pos hxa, if_neg hya] at hxy
        have := hc y (hmemE y hy hya); omega
      · simp only [if_neg hxa, if_pos hya] at hxy
        have := hc x (hmemE x hx hxa); omega
      · simp only [if_neg hxa, if_neg hya] at hxy
        exact hch x (hmemE x hx hxa) y (hmemE y hy hya) hxy

end Q8Aux

theorem solution : OpenProblems.QEDQ8.Claim := by
  intro α _ _
  classical
  obtain ⟨k, A, -, hA, hAk, c, hc, hch⟩ :=
    Q8Aux.main (Fintype.card α) (Finset.univ : Finset α) (Finset.card_le_univ _)
  refine ⟨k, A, fun x => ⟨c x, hc x (Finset.mem_univ x)⟩, hA, hAk, ?_⟩
  intro x y hxy
  exact hch x (Finset.mem_univ x) y (Finset.mem_univ y) (congrArg Fin.val hxy)
