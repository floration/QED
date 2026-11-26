/-!
# Resolution refutations under restriction + renaming

A map `τ : V → W ⊕ Bool` sends each variable either to a variable of `W` (renaming, positive
polarity) or to a constant (restriction). If every clause of `F` becomes, under `τ`, either
"trivially true" (a literal sent to `true`, or a complementary pair) or a superset of a clause of
`H`, then every resolution refutation of `F` yields one of `H` that is no longer.
-/

namespace QEDRes


variable {V W : Type*} [DecidableEq V] [DecidableEq W]

/-- Resolution refutation (same shape as the QED-E223 statement). -/
def IsRef (F : Set (Finset (V × Bool))) (L : List (Finset (V × Bool))) : Prop :=
  (∅ : Finset (V × Bool)) ∈ L ∧
  ∀ i : Fin L.length, L.get i ∈ F ∨
    ∃ j k : Fin L.length, j < i ∧ k < i ∧ ∃ x : V,
      (x, true) ∈ L.get j ∧ (x, false) ∈ L.get k ∧
      L.get i = (L.get j).erase (x, true) ∪ (L.get k).erase (x, false)

/-- Every line is an input clause or a resolvent of two earlier lines (no requirement on `∅`). -/
def Sound (F : Set (Finset (V × Bool))) (L : List (Finset (V × Bool))) : Prop :=
  ∀ i : ℕ, ∀ hi : i < L.length, L[i] ∈ F ∨
    ∃ j, ∃ _ : j < i, ∃ k, ∃ _ : k < i, ∃ x : V,
      (x, true) ∈ L[j]'(by omega) ∧ (x, false) ∈ L[k]'(by omega) ∧
      L[i] = (L[j]'(by omega)).erase (x, true) ∪ (L[k]'(by omega)).erase (x, false)

variable (τ : V → W ⊕ Bool)

/-- Literal image. -/
def litImg (l : V × Bool) : Finset (W × Bool) :=
  match τ l.1 with
  | .inl w => {(w, l.2)}
  | .inr _ => ∅

/-- Clause image: renamed literals; constants dropped. -/
def img (C : Finset (V × Bool)) : Finset (W × Bool) := C.biUnion (litImg τ)

/-- Trivially true under `τ`: a literal sent to the constant making it true, or a
complementary pair in the image. -/
def Triv (C : Finset (V × Bool)) : Prop :=
  (∃ l ∈ C, τ l.1 = .inr l.2) ∨ ∃ w, (w, true) ∈ img τ C ∧ (w, false) ∈ img τ C

omit [DecidableEq V] [DecidableEq W] in
lemma mem_litImg {l : V × Bool} {m : W × Bool} :
    m ∈ litImg τ l ↔ τ l.1 = .inl m.1 ∧ l.2 = m.2 := by
  rcases l with ⟨v, b⟩; rcases m with ⟨w, c⟩
  unfold litImg; simp only
  cases h : τ v with
  | inl w' => simp [Prod.ext_iff, eq_comm]
  | inr b' => simp

lemma mem_img {C : Finset (V × Bool)} {m : W × Bool} :
    m ∈ img τ C ↔ ∃ l ∈ C, τ l.1 = .inl m.1 ∧ l.2 = m.2 := by
  simp [img, mem_litImg]

lemma img_mono {C D : Finset (V × Bool)} (h : C ⊆ D) : img τ C ⊆ img τ D :=
  Finset.biUnion_subset_biUnion_of_subset_left _ h

lemma img_empty : img τ (∅ : Finset (V × Bool)) = ∅ := by simp [img]

/-- Key step: the image of a resolvent. -/
lemma img_erase_sub (C : Finset (V × Bool)) (x : V) (b : Bool) (w : W) (hx : τ x = .inl w) :
    img τ C \ {(w, b)} ⊆ img τ (C.erase (x, b)) := by
  intro m hm
  rw [Finset.mem_sdiff, Finset.mem_singleton] at hm
  obtain ⟨hm1, hne⟩ := hm
  obtain ⟨l, hl, h1, h2⟩ := (mem_img τ).1 hm1
  refine (mem_img τ).2 ⟨l, Finset.mem_erase.2 ⟨?_, hl⟩, h1, h2⟩
  rintro rfl
  apply hne
  rw [hx] at h1
  cases h1
  exact Prod.ext rfl h2.symm

lemma img_erase_const (C : Finset (V × Bool)) (x : V) (b c : Bool) (hx : τ x = .inr c) :
    img τ C ⊆ img τ (C.erase (x, b)) := by
  intro m hm
  obtain ⟨l, hl, h1, h2⟩ := (mem_img τ).1 hm
  refine (mem_img τ).2 ⟨l, Finset.mem_erase.2 ⟨?_, hl⟩, h1, h2⟩
  rintro rfl
  rw [hx] at h1
  cases h1

/-- Resolvent of two clauses of `W`. -/
def res (A B : Finset (W × Bool)) (w : W) : Finset (W × Bool) :=
  A.erase (w, true) ∪ B.erase (w, false)

/-- One resolution step transfers. `A ∋ x`, `B ∋ ¬x`, `R` the resolvent. -/
lemma step (A B : Finset (V × Bool)) (x : V) (hA : (x, true) ∈ A) (hB : (x, false) ∈ B)
    (EA EB : Finset (W × Bool))
    (hEA : Triv τ A ∨ EA ⊆ img τ A) (hEB : Triv τ B ∨ EB ⊆ img τ B)
    (hA' : ¬ Triv τ A → EA ⊆ img τ A) (hB' : ¬ Triv τ B → EB ⊆ img τ B) :
    let R := A.erase (x, true) ∪ B.erase (x, false)
    Triv τ R ∨
      (¬ Triv τ A ∧ EA ⊆ img τ R) ∨ (¬ Triv τ B ∧ EB ⊆ img τ R) ∨
      (¬ Triv τ A ∧ ¬ Triv τ B ∧ ∃ w, τ x = .inl w ∧ res EA EB w ⊆ img τ R) := by
  intro R
  have hRA : A.erase (x, true) ⊆ R := Finset.subset_union_left
  have hRB : B.erase (x, false) ⊆ R := Finset.subset_union_right
  by_cases hR : Triv τ R
  · exact Or.inl hR
  right
  -- facts about `Triv` of the premises in terms of `R`
  have trivA : Triv τ A → (τ x = .inr true) ∨ ∃ w, τ x = .inl w ∧ (w, false) ∈ img τ R := by
    rintro (⟨l, hl, hc⟩ | ⟨w, h1, h2⟩)
    · by_cases hlx : l = (x, true)
      · subst hlx; exact Or.inl hc
      · exact absurd (Or.inl ⟨l, hRA (Finset.mem_erase.2 ⟨hlx, hl⟩), hc⟩) hR
    · obtain ⟨l1, hl1, e1, f1⟩ := (mem_img τ).1 h1
      obtain ⟨l2, hl2, e2, f2⟩ := (mem_img τ).1 h2
      by_cases hl1x : l1 = (x, true)
      · subst hl1x
        refine Or.inr ⟨w, e1, ?_⟩
        refine (mem_img τ).2 ⟨l2, hRA (Finset.mem_erase.2 ⟨?_, hl2⟩), e2, f2⟩
        rintro rfl; simp at f2
      · by_cases hl2x : l2 = (x, true)
        · subst hl2x; simp at f2
        · exact absurd (Or.inr ⟨w, (mem_img τ).2 ⟨l1, hRA (Finset.mem_erase.2 ⟨hl1x, hl1⟩), e1, f1⟩,
            (mem_img τ).2 ⟨l2, hRA (Finset.mem_erase.2 ⟨hl2x, hl2⟩), e2, f2⟩⟩) hR
  have trivB : Triv τ B → (τ x = .inr false) ∨ ∃ w, τ x = .inl w ∧ (w, true) ∈ img τ R := by
    rintro (⟨l, hl, hc⟩ | ⟨w, h1, h2⟩)
    · by_cases hlx : l = (x, false)
      · subst hlx; exact Or.inl hc
      · exact absurd (Or.inl ⟨l, hRB (Finset.mem_erase.2 ⟨hlx, hl⟩), hc⟩) hR
    · obtain ⟨l1, hl1, e1, f1⟩ := (mem_img τ).1 h1
      obtain ⟨l2, hl2, e2, f2⟩ := (mem_img τ).1 h2
      by_cases hl2x : l2 = (x, false)
      · subst hl2x
        refine Or.inr ⟨w, e2, ?_⟩
        refine (mem_img τ).2 ⟨l1, hRB (Finset.mem_erase.2 ⟨?_, hl1⟩), e1, f1⟩
        rintro rfl; simp at f1
      · by_cases hl1x : l1 = (x, false)
        · subst hl1x; simp at f1
        · exact absurd (Or.inr ⟨w, (mem_img τ).2 ⟨l1, hRB (Finset.mem_erase.2 ⟨hl1x, hl1⟩), e1, f1⟩,
            (mem_img τ).2 ⟨l2, hRB (Finset.mem_erase.2 ⟨hl2x, hl2⟩), e2, f2⟩⟩) hR
  -- image of R contains the images of the erased premises
  have subA : ∀ w, τ x = .inl w → img τ A \ {(w, true)} ⊆ img τ R := fun w hw =>
    (img_erase_sub τ A x true w hw).trans (img_mono τ hRA)
  have subB : ∀ w, τ x = .inl w → img τ B \ {(w, false)} ⊆ img τ R := fun w hw =>
    (img_erase_sub τ B x false w hw).trans (img_mono τ hRB)
  -- helper: a clause `E ⊆ img C` avoiding the pivot literal lands in `img R`
  have avoid : ∀ (E C : Finset (W × Bool)) (p : W × Bool), E ⊆ C → p ∉ E → E ⊆ C \ {p} :=
    fun E C p h hp m hm => Finset.mem_sdiff.2 ⟨h hm, by
      rw [Finset.mem_singleton]; rintro rfl; exact hp hm⟩
  cases hx : τ x with
  | inr c =>
    cases c with
    | true =>
      -- A is trivial (x ↦ true), so B is not; B's image survives.
      have hBn : ¬ Triv τ B := by
        intro hb
        rcases trivB hb with h | ⟨w, h, _⟩ <;> rw [hx] at h <;> cases h
      refine Or.inr (Or.inl ⟨hBn, (hB' hBn).trans ?_⟩)
      exact (img_erase_const τ B x false true hx).trans (img_mono τ hRB)
    | false =>
      have hAn : ¬ Triv τ A := by
        intro ha
        rcases trivA ha with h | ⟨w, h, _⟩ <;> rw [hx] at h <;> cases h
      refine Or.inl ⟨hAn, (hA' hAn).trans ?_⟩
      exact (img_erase_const τ A x true false hx).trans (img_mono τ hRA)
  | inl w =>
    by_cases ha : Triv τ A
    · -- then (w,false) ∈ img R; B is not trivial.
      obtain ⟨w', hw', hmem⟩ : ∃ w', τ x = .inl w' ∧ (w', false) ∈ img τ R := by
        rcases trivA ha with h | h
        · rw [hx] at h; cases h
        · exact h
      rw [hx] at hw'; cases hw'
      have hBn : ¬ Triv τ B := by
        intro hb
        rcases trivB hb with h | ⟨w'', h, hmem'⟩
        · rw [hx] at h; cases h
        · rw [hx] at h; cases h; exact hR (Or.inr ⟨w, hmem', hmem⟩)
      refine Or.inr (Or.inl ⟨hBn, ?_⟩)
      intro m hm
      by_cases hmw : m = (w, false)
      · subst hmw; exact hmem
      · exact subB w hx (Finset.mem_sdiff.2 ⟨hB' hBn hm, by simpa using hmw⟩)
    · by_cases hb : Triv τ B
      · obtain ⟨w', hw', hmem⟩ : ∃ w', τ x = .inl w' ∧ (w', true) ∈ img τ R := by
          rcases trivB hb with h | h
          · rw [hx] at h; cases h
          · exact h
        rw [hx] at hw'; cases hw'
        refine Or.inl ⟨ha, ?_⟩
        intro m hm
        by_cases hmw : m = (w, true)
        · subst hmw; exact hmem
        · exact subA w hx (Finset.mem_sdiff.2 ⟨hA' ha hm, by simpa using hmw⟩)
      · -- neither trivial: resolve the images on `w`
        refine Or.inr (Or.inr ⟨ha, hb, w, rfl, ?_⟩)
        intro m hm
        rcases Finset.mem_union.1 hm with h | h
        · obtain ⟨hne, hmA⟩ := Finset.mem_erase.1 h
          exact subA w hx (Finset.mem_sdiff.2 ⟨hA' ha hmA, by simpa using hne⟩)
        · obtain ⟨hne, hmB⟩ := Finset.mem_erase.1 h
          exact subB w hx (Finset.mem_sdiff.2 ⟨hB' hb hmB, by simpa using hne⟩)

omit [DecidableEq W] in
lemma isRef_iff (F : Set (Finset (V × Bool))) (L : List (Finset (V × Bool))) :
    IsRef F L ↔ (∅ : Finset (V × Bool)) ∈ L ∧ Sound F L := by
  unfold IsRef Sound
  constructor
  · rintro ⟨h0, h⟩
    refine ⟨h0, fun i hi => ?_⟩
    rcases h ⟨i, hi⟩ with h | ⟨j, k, hj, hk, x, h1, h2, h3⟩
    · exact Or.inl h
    · exact Or.inr ⟨j, hj, k, hk, x, h1, h2, h3⟩
  · rintro ⟨h0, h⟩
    refine ⟨h0, fun ⟨i, hi⟩ => ?_⟩
    rcases h i hi with h | ⟨j, hj, k, hk, x, h1, h2, h3⟩
    · exact Or.inl h
    · exact Or.inr ⟨⟨j, by omega⟩, ⟨k, by omega⟩, hj, hk, x, h1, h2, h3⟩

omit [DecidableEq W] in
lemma sound_append (F : Set (Finset (V × Bool))) (M : List (Finset (V × Bool)))
    (hM : Sound F M) (E : Finset (V × Bool))
    (hE : E ∈ F ∨ ∃ A ∈ M, ∃ B ∈ M, ∃ x, (x, true) ∈ A ∧ (x, false) ∈ B ∧
      E = A.erase (x, true) ∪ B.erase (x, false)) :
    Sound F (M ++ [E]) := by
  intro i hi
  rw [List.length_append, List.length_singleton] at hi
  rcases Nat.lt_succ_iff_lt_or_eq.1 hi with hi | rfl
  · rcases hM i hi with h | ⟨j, hj, k, hk, x, h1, h2, h3⟩
    · left; rwa [List.getElem_append_left hi]
    · right
      refine ⟨j, hj, k, hk, x, ?_, ?_, ?_⟩
      · rwa [List.getElem_append_left (by omega)]
      · rwa [List.getElem_append_left (by omega)]
      · rw [List.getElem_append_left hi, List.getElem_append_left (by omega),
          List.getElem_append_left (by omega)]; exact h3
  · rw [List.getElem_append_right (by omega)]
    simp only [Nat.sub_self, List.getElem_singleton]
    rcases hE with h | ⟨A, hA, B, hB, x, h1, h2, h3⟩
    · exact Or.inl h
    · right
      obtain ⟨j, hj, rfl⟩ := List.mem_iff_getElem.1 hA
      obtain ⟨k, hk, rfl⟩ := List.mem_iff_getElem.1 hB
      refine ⟨j, hj, k, hk, x, ?_, ?_, ?_⟩
      · rwa [List.getElem_append_left hj]
      · rwa [List.getElem_append_left hk]
      · rw [List.getElem_append_left hj, List.getElem_append_left hk]; exact h3

omit [DecidableEq V] [DecidableEq W] in
lemma forall₂_snoc {α β : Type*} {R : α → β → Prop} {l : List α} {l' : List β} {a : α} {b : β}
    (h : List.Forall₂ R l l') (hab : R a b) : List.Forall₂ R (l ++ [a]) (l' ++ [b]) := by
  induction h with
  | nil => exact List.Forall₂.cons hab List.Forall₂.nil
  | cons h _ ih => exact List.Forall₂.cons h ih

/-- The transfer theorem: restriction + renaming does not lengthen refutations. -/
theorem transfer' (F : Set (Finset (V × Bool))) (H : Set (Finset (W × Bool)))
    (hax : ∀ C ∈ F, Triv τ C ∨ ∃ D ∈ H, D ⊆ img τ C)
    (L : List (Finset (V × Bool))) (hL : IsRef F L) :
    ∃ M : List (Finset (W × Bool)), IsRef H M ∧ ∃ L' : List (Finset (V × Bool)), L'.Sublist L ∧
      List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) M L' := by
  rw [isRef_iff] at hL
  obtain ⟨h0, hS⟩ := hL
  -- invariant over prefixes
  have key : ∀ n (hn : n ≤ L.length), ∃ M : List (Finset (W × Bool)), Sound H M ∧ M.length ≤ n ∧
      (∀ i (hi : i < n), Triv τ (L[i]'(by omega)) ∨ ∃ m ∈ M, m ⊆ img τ (L[i]'(by omega))) ∧
      ∃ L' : List (Finset (V × Bool)), L'.Sublist (L.take n) ∧
        List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) M L' := by
    intro n
    induction n with
    | zero => intro hn; exact ⟨[], fun i hi => by simp at hi, le_refl _, fun i hi => by omega,
        [], List.Sublist.slnil, List.Forall₂.nil⟩
    | succ n ih =>
      intro hn
      obtain ⟨M, hMS, hMl, hMi, L', hL's, hL'f⟩ := ih (by omega)
      have htake : L.take (n + 1) = L.take n ++ [L[n]'(by omega)] := by
        rw [List.take_add_one, List.getElem?_eq_getElem (by omega)]; rfl
      -- lines `< n` are handled by `M` or any extension of it
      have extend : ∀ M' : List (Finset (W × Bool)), M ⊆ M' → ∀ i (hi : i < n),
          Triv τ (L[i]'(by omega)) ∨ ∃ m ∈ M', m ⊆ img τ (L[i]'(by omega)) := by
        intro M' hsub i hi
        rcases hMi i hi with h | ⟨m, hm, hsm⟩
        · exact Or.inl h
        · exact Or.inr ⟨m, hsub hm, hsm⟩
      -- the new line `n`
      have finish : ∀ M' : List (Finset (W × Bool)), Sound H M' → M ⊆ M' → M'.length ≤ n + 1 →
          (Triv τ (L[n]'(by omega)) ∨ ∃ m ∈ M', m ⊆ img τ (L[n]'(by omega))) →
          (∃ L'' : List (Finset (V × Bool)), L''.Sublist (L.take (n + 1)) ∧
            List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) M' L'') →
          ∃ M : List (Finset (W × Bool)), Sound H M ∧ M.length ≤ n + 1 ∧
            (∀ i (hi : i < n + 1), Triv τ (L[i]'(by omega)) ∨
              ∃ m ∈ M, m ⊆ img τ (L[i]'(by omega))) ∧
            ∃ L' : List (Finset (V × Bool)), L'.Sublist (L.take (n + 1)) ∧
              List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) M L' := by
        intro M' hS' hsub hl hn' hL''
        refine ⟨M', hS', hl, fun i hi => ?_, hL''⟩
        rcases Nat.lt_succ_iff_lt_or_eq.1 hi with hi | rfl
        · exact extend M' hsub i hi
        · exact hn'
      have keepL : ∃ L'' : List (Finset (V × Bool)), L''.Sublist (L.take (n + 1)) ∧
          List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) M L'' :=
        ⟨L', htake ▸ hL's.trans (List.sublist_append_left _ _), hL'f⟩
      have appL : ∀ E, E ⊆ img τ (L[n]'(by omega)) → ¬ Triv τ (L[n]'(by omega)) →
          ∃ L'' : List (Finset (V × Bool)), L''.Sublist (L.take (n + 1)) ∧
            List.Forall₂ (fun E C => E ⊆ img τ C ∧ ¬ Triv τ C) (M ++ [E]) L'' := fun E h1 h2 =>
        ⟨L' ++ [L[n]'(by omega)], htake ▸ hL's.append (List.Sublist.refl _),
          forall₂_snoc hL'f ⟨h1, h2⟩⟩
      have hsubapp : ∀ E, M ⊆ M ++ [E] := fun E => List.subset_append_left _ _
      rcases hS n (by omega) with hF | ⟨j, hj, k, hk, x, h1, h2, h3⟩
      · by_cases htr : Triv τ (L[n]'(by omega))
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inl htr) keepL
        · obtain ⟨D, hD, hDs⟩ := (hax _ hF).resolve_left htr
          exact finish (M ++ [D]) (sound_append H M hMS D (Or.inl hD)) (hsubapp D)
            (by simp; omega) (Or.inr ⟨D, by simp, hDs⟩) (appL D hDs htr)
      · -- resolution step
        set A := L[j]'(by omega)
        set B := L[k]'(by omega)
        have hEA : Triv τ A ∨ ∃ m ∈ M, m ⊆ img τ A := hMi j hj
        have hEB : Triv τ B ∨ ∃ m ∈ M, m ⊆ img τ B := hMi k hk
        -- choose witnesses (dummy `∅` if trivial)
        classical
        let EA : Finset (W × Bool) := if h : ∃ m ∈ M, m ⊆ img τ A then h.choose else ∅
        let EB : Finset (W × Bool) := if h : ∃ m ∈ M, m ⊆ img τ B then h.choose else ∅
        have hA' : ¬ Triv τ A → EA ∈ M ∧ EA ⊆ img τ A := by
          intro hn
          have h : ∃ m ∈ M, m ⊆ img τ A := hEA.resolve_left hn
          simp only [EA, dif_pos h]; exact h.choose_spec
        have hB' : ¬ Triv τ B → EB ∈ M ∧ EB ⊆ img τ B := by
          intro hn
          have h : ∃ m ∈ M, m ⊆ img τ B := hEB.resolve_left hn
          simp only [EB, dif_pos h]; exact h.choose_spec
        have hEA2 : Triv τ A ∨ EA ⊆ img τ A := by
          by_cases ht : Triv τ A
          · exact Or.inl ht
          · exact Or.inr (hA' ht).2
        have hEB2 : Triv τ B ∨ EB ⊆ img τ B := by
          by_cases ht : Triv τ B
          · exact Or.inl ht
          · exact Or.inr (hB' ht).2
        have hres := step τ A B x h1 h2 EA EB hEA2 hEB2
          (fun h => (hA' h).2) (fun h => (hB' h).2)
        have hLn : L[n]'(by omega) = A.erase (x, true) ∪ B.erase (x, false) := h3
        simp only at hres
        rw [← hLn] at hres
        by_cases hRt : Triv τ (L[n]'(by omega))
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inl hRt) keepL
        rcases hres with htr | ⟨hn, hs⟩ | ⟨hn, hs⟩ | ⟨hna, hnb, w, hw, hs⟩
        · exact absurd htr hRt
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EA, (hA' hn).1, hs⟩) keepL
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EB, (hB' hn).1, hs⟩) keepL
        · by_cases pa : (w, true) ∈ EA
          · by_cases pb : (w, false) ∈ EB
            · refine finish (M ++ [res EA EB w])
                (sound_append H M hMS _ (Or.inr ⟨EA, (hA' hna).1, EB, (hB' hnb).1, w, pa, pb, rfl⟩))
                (hsubapp _) (by simp; omega) (Or.inr ⟨res EA EB w, by simp, hs⟩)
                (appL _ hs hRt)
            · refine finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EB, (hB' hnb).1, ?_⟩) keepL
              refine fun m hm => hs (Finset.mem_union_right _ (Finset.mem_erase.2 ⟨?_, hm⟩))
              rintro rfl; exact pb hm
          · refine finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EA, (hA' hna).1, ?_⟩) keepL
            refine fun m hm => hs (Finset.mem_union_left _ (Finset.mem_erase.2 ⟨?_, hm⟩))
            rintro rfl; exact pa hm
  obtain ⟨M, hMS, hMl, hMi, L', hL's, hL'f⟩ := key L.length le_rfl
  obtain ⟨i, hi, hi0⟩ := List.mem_iff_getElem.1 h0
  refine ⟨M, (isRef_iff H M).2 ⟨?_, hMS⟩, L', by simpa using hL's, hL'f⟩
  rcases hMi i hi with htr | ⟨m, hm, hsm⟩
  · exfalso
    rw [hi0] at htr
    rcases htr with ⟨l, hl, _⟩ | ⟨w, h1, _⟩
    · simp at hl
    · simp [img_empty] at h1
  · rw [hi0, img_empty, Finset.subset_empty] at hsm
    exact hsm ▸ hm

/-- The transfer theorem: restriction + renaming does not lengthen refutations. -/
theorem transfer (F : Set (Finset (V × Bool))) (H : Set (Finset (W × Bool)))
    (hax : ∀ C ∈ F, Triv τ C ∨ ∃ D ∈ H, D ⊆ img τ C)
    (L : List (Finset (V × Bool))) (hL : IsRef F L) :
    ∃ M : List (Finset (W × Bool)), IsRef H M ∧ M.length ≤ L.length := by
  rw [isRef_iff] at hL
  obtain ⟨h0, hS⟩ := hL
  -- invariant over prefixes
  have key : ∀ n (hn : n ≤ L.length), ∃ M : List (Finset (W × Bool)), Sound H M ∧ M.length ≤ n ∧
      ∀ i (hi : i < n), Triv τ (L[i]'(by omega)) ∨ ∃ m ∈ M, m ⊆ img τ (L[i]'(by omega)) := by
    intro n
    induction n with
    | zero => intro hn; exact ⟨[], fun i hi => by simp at hi, le_refl _, fun i hi => by omega⟩
    | succ n ih =>
      intro hn
      obtain ⟨M, hMS, hMl, hMi⟩ := ih (by omega)
      -- lines `< n` are handled by `M` or any extension of it
      have extend : ∀ M' : List (Finset (W × Bool)), M ⊆ M' → ∀ i (hi : i < n),
          Triv τ (L[i]'(by omega)) ∨ ∃ m ∈ M', m ⊆ img τ (L[i]'(by omega)) := by
        intro M' hsub i hi
        rcases hMi i hi with h | ⟨m, hm, hsm⟩
        · exact Or.inl h
        · exact Or.inr ⟨m, hsub hm, hsm⟩
      -- the new line `n`
      have finish : ∀ M' : List (Finset (W × Bool)), Sound H M' → M ⊆ M' → M'.length ≤ n + 1 →
          (Triv τ (L[n]'(by omega)) ∨ ∃ m ∈ M', m ⊆ img τ (L[n]'(by omega))) →
          ∃ M : List (Finset (W × Bool)), Sound H M ∧ M.length ≤ n + 1 ∧
            ∀ i (hi : i < n + 1), Triv τ (L[i]'(by omega)) ∨
              ∃ m ∈ M, m ⊆ img τ (L[i]'(by omega)) := by
        intro M' hS' hsub hl hn'
        refine ⟨M', hS', hl, fun i hi => ?_⟩
        rcases Nat.lt_succ_iff_lt_or_eq.1 hi with hi | rfl
        · exact extend M' hsub i hi
        · exact hn'
      have hsubapp : ∀ E, M ⊆ M ++ [E] := fun E => List.subset_append_left _ _
      rcases hS n (by omega) with hF | ⟨j, hj, k, hk, x, h1, h2, h3⟩
      · rcases hax _ hF with htr | ⟨D, hD, hDs⟩
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inl htr)
        · exact finish (M ++ [D]) (sound_append H M hMS D (Or.inl hD)) (hsubapp D)
            (by simp; omega) (Or.inr ⟨D, by simp, hDs⟩)
      · -- resolution step
        set A := L[j]'(by omega)
        set B := L[k]'(by omega)
        have hEA : Triv τ A ∨ ∃ m ∈ M, m ⊆ img τ A := hMi j hj
        have hEB : Triv τ B ∨ ∃ m ∈ M, m ⊆ img τ B := hMi k hk
        -- choose witnesses (dummy `∅` if trivial)
        classical
        let EA : Finset (W × Bool) := if h : ∃ m ∈ M, m ⊆ img τ A then h.choose else ∅
        let EB : Finset (W × Bool) := if h : ∃ m ∈ M, m ⊆ img τ B then h.choose else ∅
        have hA' : ¬ Triv τ A → EA ∈ M ∧ EA ⊆ img τ A := by
          intro hn
          have h : ∃ m ∈ M, m ⊆ img τ A := hEA.resolve_left hn
          simp only [EA, dif_pos h]; exact h.choose_spec
        have hB' : ¬ Triv τ B → EB ∈ M ∧ EB ⊆ img τ B := by
          intro hn
          have h : ∃ m ∈ M, m ⊆ img τ B := hEB.resolve_left hn
          simp only [EB, dif_pos h]; exact h.choose_spec
        have hEA2 : Triv τ A ∨ EA ⊆ img τ A := by
          by_cases ht : Triv τ A
          · exact Or.inl ht
          · exact Or.inr (hA' ht).2
        have hEB2 : Triv τ B ∨ EB ⊆ img τ B := by
          by_cases ht : Triv τ B
          · exact Or.inl ht
          · exact Or.inr (hB' ht).2
        have hres := step τ A B x h1 h2 EA EB hEA2 hEB2
          (fun h => (hA' h).2) (fun h => (hB' h).2)
        have hLn : L[n]'(by omega) = A.erase (x, true) ∪ B.erase (x, false) := h3
        simp only at hres
        rw [← hLn] at hres
        rcases hres with htr | ⟨hn, hs⟩ | ⟨hn, hs⟩ | ⟨hna, hnb, w, hw, hs⟩
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inl htr)
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EA, (hA' hn).1, hs⟩)
        · exact finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EB, (hB' hn).1, hs⟩)
        · by_cases pa : (w, true) ∈ EA
          · by_cases pb : (w, false) ∈ EB
            · refine finish (M ++ [res EA EB w])
                (sound_append H M hMS _ (Or.inr ⟨EA, (hA' hna).1, EB, (hB' hnb).1, w, pa, pb, rfl⟩))
                (hsubapp _) (by simp; omega) (Or.inr ⟨res EA EB w, by simp, hs⟩)
            · refine finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EB, (hB' hnb).1, ?_⟩)
              refine fun m hm => hs (Finset.mem_union_right _ (Finset.mem_erase.2 ⟨?_, hm⟩))
              rintro rfl; exact pb hm
          · refine finish M hMS (fun _ h => h) (by omega) (Or.inr ⟨EA, (hA' hna).1, ?_⟩)
            refine fun m hm => hs (Finset.mem_union_left _ (Finset.mem_erase.2 ⟨?_, hm⟩))
            rintro rfl; exact pa hm
  obtain ⟨M, hMS, hMl, hMi⟩ := key L.length le_rfl
  obtain ⟨i, hi, hi0⟩ := List.mem_iff_getElem.1 h0
  refine ⟨M, (isRef_iff H M).2 ⟨?_, hMS⟩, hMl⟩
  rcases hMi i hi with htr | ⟨m, hm, hsm⟩
  · exfalso
    rw [hi0] at htr
    rcases htr with ⟨l, hl, _⟩ | ⟨w, h1, _⟩
    · simp at hl
    · simp [img_empty] at h1
  · rw [hi0, img_empty, Finset.subset_empty] at hsm
    exact hsm ▸ hm

end QEDRes


/-!
# Onto-functional pigeonhole principle: critical assignments and the width lemma
`N + 1` pigeons, `N` holes.
-/

namespace QEDRes

open Finset

/-- Variables `(pigeon, hole)`. -/
abbrev PV (N : ℕ) : Type := Fin (N + 1) × Fin N

/-- Onto-functional `PHP(N+1, N)`. -/
def php (N : ℕ) : Set (Finset (PV N × Bool)) :=
  {C | ∃ i, C = univ.image (fun j : Fin N => ((i, j), true))} ∪
  {C | ∃ i j j', j ≠ j' ∧ C = {((i, j), false), ((i, j'), false)}} ∪
  {C | ∃ i i' j, i ≠ i' ∧ C = {((i, j), false), ((i', j), false)}} ∪
  {C | ∃ j, C = univ.image (fun i : Fin (N + 1) => ((i, j), true))}

/-- Truth value of a clause under an assignment. -/
def Sat {V : Type*} (α : V → Bool) (C : Finset (V × Bool)) : Prop := ∃ l ∈ C, α l.1 = l.2

/-- The critical assignment of an injective `g : holes → pigeons` (hole `j` holds pigeon `g j`). -/
def cta {N : ℕ} (g : Fin N → Fin (N + 1)) : PV N → Bool := fun p => decide (g p.2 = p.1)

/-- `i0` is the pigeon left out by `g`. -/
def Misses {N : ℕ} (g : Fin N → Fin (N + 1)) (i0 : Fin (N + 1)) : Prop :=
  Function.Injective g ∧ ∀ j, g j ≠ i0

open Classical in
/-- Pigeons `i0` such that some critical assignment missing `i0` falsifies `C`. -/
noncomputable def bad {N : ℕ} (C : Finset (PV N × Bool)) : Finset (Fin (N + 1)) :=
  univ.filter (fun i0 => ∃ g, Misses g i0 ∧ ¬ Sat (cta g) C)

open Classical in
/-- Monotone width set of a clause. -/
noncomputable def mono {N : ℕ} (C : Finset (PV N × Bool)) : Finset (PV N) :=
  univ.filter (fun p => (p, true) ∈ C ∨ ∃ i', i' ≠ p.1 ∧ ((i', p.2), false) ∈ C)

lemma misses_unique {N : ℕ} {g : Fin N → Fin (N + 1)} {a b : Fin (N + 1)}
    (ha : Misses g a) (hb : Misses g b) : a = b := by
  classical
  by_contra hab
  have hsub : univ.image g ⊆ (univ.erase a).erase b := by
    intro x hx
    obtain ⟨j, -, rfl⟩ := mem_image.1 hx
    exact mem_erase.2 ⟨hb.2 j, mem_erase.2 ⟨ha.2 j, mem_univ _⟩⟩
  have h1 := card_le_card hsub
  rw [card_image_of_injective _ ha.1, card_erase_of_mem (mem_erase.2 ⟨Ne.symm hab, mem_univ _⟩),
    card_erase_of_mem (mem_univ _)] at h1
  have : N ≠ 0 := by
    rintro rfl; exact hab (Fin.ext (by have := a.2; have := b.2; omega))
  simp at h1; omega

lemma exists_misses {N : ℕ} (i0 : Fin (N + 1)) : ∃ g : Fin N → Fin (N + 1), Misses g i0 :=
  ⟨i0.succAbove, Fin.succAbove_right_injective, fun j => Fin.succAbove_ne i0 j⟩

lemma misses_surj {N : ℕ} {g : Fin N → Fin (N + 1)} {i0 i : Fin (N + 1)} (hg : Misses g i0)
    (hi : i ≠ i0) : ∃ j, g j = i := by
  classical
  by_contra h
  push_neg at h
  exact hi (misses_unique ⟨hg.1, h⟩ hg)

lemma bad_empty {N : ℕ} : bad (∅ : Finset (PV N × Bool)) = univ := by
  classical
  ext i0
  simp only [bad, mem_filter, mem_univ, true_and, iff_true]
  obtain ⟨g, hg⟩ := exists_misses (N := N) i0
  exact ⟨g, hg, fun ⟨l, hl, _⟩ => by simp at hl⟩

lemma sat_res {V : Type*} [DecidableEq V] (α : V → Bool) (A B : Finset (V × Bool)) (x : V)
    (hA : Sat α A) (hB : Sat α B) : Sat α (A.erase (x, true) ∪ B.erase (x, false)) := by
  obtain ⟨a, ha, hav⟩ := hA
  obtain ⟨b, hb, hbv⟩ := hB
  by_cases hax : a = (x, true)
  · subst hax
    have hbx : b ≠ (x, false) := by rintro rfl; simp_all
    exact ⟨b, mem_union_right _ (mem_erase.2 ⟨hbx, hb⟩), hbv⟩
  · exact ⟨a, mem_union_left _ (mem_erase.2 ⟨hax, ha⟩), hav⟩

lemma bad_res {N : ℕ} (A B : Finset (PV N × Bool)) (x : PV N) :
    bad (A.erase (x, true) ∪ B.erase (x, false)) ⊆ bad A ∪ bad B := by
  classical
  intro i0 hi
  simp only [bad, mem_filter, mem_univ, true_and, mem_union] at hi ⊢
  obtain ⟨g, hg, hn⟩ := hi
  by_contra h
  push_neg at h
  exact hn (sat_res _ A B x (h.1 g hg) (h.2 g hg))

lemma bad_axiom {N : ℕ} (C : Finset (PV N × Bool)) (hC : C ∈ php N) : (bad C).card ≤ 1 := by
  classical
  rw [card_le_one]
  intro a ha b hb
  simp only [bad, mem_filter, mem_univ, true_and] at ha hb
  obtain ⟨g, hg, hga⟩ := ha
  obtain ⟨g', hg', hgb⟩ := hb
  simp only [php, Set.mem_union, Set.mem_setOf_eq] at hC
  rcases hC with ((⟨i, rfl⟩ | ⟨i, j, j', hjj, rfl⟩) | ⟨i, i', j, hii, rfl⟩) | ⟨j, rfl⟩
  · -- pigeon clause of `i`: falsified iff `g` misses `i`
    have e1 : Misses g i := ⟨hg.1, fun j hj => hga ⟨((i, j), true), by simp, by simp [cta, hj]⟩⟩
    have e2 : Misses g' i := ⟨hg'.1, fun j hj => hgb ⟨((i, j), true), by simp, by simp [cta, hj]⟩⟩
    exact (misses_unique e1 hg).symm.trans (misses_unique e2 hg')
  · exfalso; apply hga
    by_cases h : g j = i
    · exact ⟨((i, j'), false), by simp, by
        simp only [cta, decide_eq_false_iff_not]; intro h'; exact hjj (hg.1 (h.trans h'.symm))⟩
    · exact ⟨((i, j), false), by simp, by simp [cta, h]⟩
  · exfalso; apply hga
    by_cases h : g j = i
    · exact ⟨((i', j), false), by simp, by simp [cta]; intro h'; exact hii (h.symm.trans h')⟩
    · exact ⟨((i, j), false), by simp, by simp [cta, h]⟩
  · exfalso; exact hga ⟨((g j, j), true), by simp, by simp [cta]⟩

/-- Swap argument: every pigeon pair `i ∈ bad C`, `i' ∉ bad C` yields a monotone variable. -/
lemma mono_card {N : ℕ} (C : Finset (PV N × Bool)) :
    (bad C).card * (N + 1 - (bad C).card) ≤ (mono C).card := by
  classical
  rcases Nat.eq_zero_or_pos N with hN | hN
  · subst hN
    have : (bad C).card ≤ 1 := by simpa using card_le_univ (bad C)
    rcases Nat.le_one_iff_eq_zero_or_eq_one.1 this with h | h <;> simp [h]
  haveI : Nonempty (Fin N) := ⟨⟨0, hN⟩⟩
  set S := bad C
  -- for each `i ∈ S` a critical assignment missing `i` falsifying `C`
  have hS : ∀ i ∈ S, ∃ g, Misses g i ∧ ¬ Sat (cta g) C := by
    intro i hi; simpa [S, bad] using hi
  choose! G hGm hGf using hS
  -- the hole of `i'` under `G i`
  have hJ : ∀ i ∈ S, ∀ i' ∈ Sᶜ, ∃ j, G i j = i' := by
    intro i hi i' hi'
    refine misses_surj (hGm i hi) ?_
    rintro rfl; exact (mem_compl.1 hi') hi
  choose! J hJ using hJ
  have key : ∀ i ∈ S, ∀ i' ∈ Sᶜ, (i, J i i') ∈ mono C := by
    intro i hi i' hi'
    have hne : i ≠ i' := by rintro rfl; exact (mem_compl.1 hi') hi
    set j := J i i'
    have hj : G i j = i' := hJ i hi i' hi'
    set g' := Function.update (G i) j i
    have hg'm : Misses g' i' := by
      refine ⟨?_, ?_⟩
      · intro a b hab
        simp only [g', Function.update_apply] at hab
        by_cases ha : a = j <;> by_cases hb : b = j
        · rw [ha, hb]
        · rw [if_pos ha, if_neg hb] at hab; exact absurd hab.symm ((hGm i hi).2 b)
        · rw [if_neg ha, if_pos hb] at hab; exact absurd hab ((hGm i hi).2 a)
        · rw [if_neg ha, if_neg hb] at hab; exact (hGm i hi).1 hab
      · intro a
        simp only [g', Function.update_apply]
        split_ifs with ha
        · exact hne
        · intro h; exact ha ((hGm i hi).1 (h.trans hj.symm))
    have hsat : Sat (cta g') C := by
      by_contra h
      have : i' ∈ S := by simp only [S, bad, mem_filter, mem_univ, true_and]; exact ⟨g', hg'm, h⟩
      exact (mem_compl.1 hi') this
    obtain ⟨l, hl, hlv⟩ := hsat
    have hfal := hGf i hi
    -- the two assignments agree away from `(i,j)` and `(i',j)`
    have agree : ∀ p : PV N, p ≠ (i, j) → p ≠ (i', j) → cta g' p = cta (G i) p := by
      rintro ⟨a, b⟩ h1 h2
      simp only [cta, g', Function.update_apply]
      by_cases hb : b = j
      · subst hb; simp only [if_pos rfl]
        have ha1 : a ≠ i := fun h => h1 (by rw [h])
        have ha2 : a ≠ i' := fun h => h2 (by rw [h])
        rw [hj]; simp [Ne.symm ha1, Ne.symm ha2]
      · simp [hb]
    simp only [mono, mem_filter, mem_univ, true_and]
    by_cases h1 : l.1 = (i, j)
    · left
      have : l.2 = true := by
        rw [← hlv, h1]; simp [cta, g']
      rcases l with ⟨p, b⟩; simp only at h1 this; subst h1; subst this; exact hl
    · by_cases h2 : l.1 = (i', j)
      · right
        refine ⟨i', Ne.symm hne, ?_⟩
        have : l.2 = false := by
          rw [← hlv, h2]; simp [cta, g', Function.update_apply, hne]
        rcases l with ⟨p, b⟩; simp only at h2 this; subst h2; subst this; exact hl
      · exact absurd ⟨l, hl, (agree _ h1 h2) ▸ hlv⟩ hfal
  -- counting
  have hsub : S.biUnion (fun i => Sᶜ.image (fun i' => (i, J i i'))) ⊆ mono C := by
    intro p hp
    obtain ⟨i, hi, hp⟩ := mem_biUnion.1 hp
    obtain ⟨i', hi', rfl⟩ := mem_image.1 hp
    exact key i hi i' hi'
  have hcard : (S.biUnion (fun i => Sᶜ.image (fun i' => (i, J i i')))).card = S.card * Sᶜ.card := by
    rw [card_biUnion]
    · rw [sum_const_nat]
      intro i hi
      rw [card_image_of_injOn]
      intro a ha b hb hab
      simp only [Prod.mk.injEq, true_and] at hab
      have := congrArg (G i) hab
      rwa [hJ i hi a ha, hJ i hi b hb] at this
    · intro a _ b _ hab
      simp only [Function.onFun]
      rw [disjoint_left]
      intro p hpa hpb
      obtain ⟨_, _, rfl⟩ := mem_image.1 hpa
      obtain ⟨_, _, h⟩ := mem_image.1 hpb
      exact hab (Prod.mk.inj h).1.symm
  have hc : Sᶜ.card = N + 1 - S.card := by rw [card_compl, Fintype.card_fin]
  rw [← hc, ← hcard]
  exact card_le_card hsub

/-- Width lemma: every refutation of `PHP(N+1,N)` (`N ≥ 3`) has a line with monotone width
at least `2(N+1)²/9`. -/
theorem wide_line {N : ℕ} (hN : 3 ≤ N) (L : List (Finset (PV N × Bool))) (hL : IsRef (php N) L) :
    ∃ C ∈ L, 2 * (N + 1) ^ 2 ≤ 9 * (mono C).card := by
  classical
  rw [isRef_iff] at hL
  obtain ⟨h0, hS⟩ := hL
  obtain ⟨e, he, he0⟩ := List.mem_iff_getElem.1 h0
  have hex : ∃ c, c < L.length ∧ N + 1 ≤ 3 * (bad (L[c]!)).card := by
    refine ⟨e, he, ?_⟩
    rw [getElem!_pos L e he, he0, bad_empty, card_univ, Fintype.card_fin]; omega
  let c := Nat.find hex
  obtain ⟨hc, hcq⟩ : c < L.length ∧ N + 1 ≤ 3 * (bad (L[c]!)).card := Nat.find_spec hex
  have hmin : ∀ m < c, m < L.length → 3 * (bad (L[m]!)).card < N + 1 := by
    intro m hm hmL
    have := Nat.find_min hex hm
    push_neg at this
    exact this hmL
  rw [getElem!_pos L c hc] at hcq
  have hup : 3 * (bad (L[c])).card ≤ 2 * N := by
    rcases hS c hc with hF | ⟨j, hj, k, hk, x, -, -, hres⟩
    · have := bad_axiom _ hF; omega
    · have h1 := hmin j hj (by omega)
      have h2 := hmin k hk (by omega)
      rw [getElem!_pos L j (by omega)] at h1
      rw [getElem!_pos L k (by omega)] at h2
      have hsub := bad_res (L[j]'(by omega)) (L[k]'(by omega)) x
      rw [← hres] at hsub
      have := (card_le_card hsub).trans (card_union_le _ _)
      omega
  refine ⟨L[c], List.getElem_mem hc, ?_⟩
  have hm := mono_card (L[c])
  set q := (bad (L[c])).card
  have hq : q ≤ N + 1 := by
    have := card_le_univ (bad (L[c])); simpa using this
  have hup' : 3 * q ≤ 2 * N := hup
  have : 2 * (N + 1) ^ 2 ≤ 9 * (q * (N + 1 - q)) := by
    obtain ⟨r, hr⟩ : ∃ r, N + 1 = q + r := ⟨N + 1 - q, by omega⟩
    rw [hr, Nat.add_sub_cancel_left]
    have h1 : r ≤ 2 * q := by omega
    have h2 : q ≤ 2 * r := by omega
    have h1' : (r : ℤ) ≤ 2 * q := by exact_mod_cast h1
    have h2' : (q : ℤ) ≤ 2 * r := by exact_mod_cast h2
    have : (2 * (q + r) ^ 2 : ℤ) ≤ 9 * (q * r) := by
      nlinarith [mul_nonneg (sub_nonneg.2 h1') (sub_nonneg.2 h2')]
    exact_mod_cast this
  omega

/-! ### One restriction step: put pigeon `i0` into hole `j0`. -/

section Restrict

variable {M : ℕ} (i0 : Fin (M + 2)) (j0 : Fin (M + 1))

open Classical in
/-- The restriction `p_{i0 j0} := 1`, renaming the rest to `PHP(M+1, M)`. -/
noncomputable def rτ (x : PV (M + 1)) : PV M ⊕ Bool :=
  if hi : x.1 = i0 then .inr (decide (x.2 = j0))
  else if hj : x.2 = j0 then .inr false
  else .inl ((Fin.exists_succAbove_eq hi).choose, (Fin.exists_succAbove_eq hj).choose)

lemma rτ_succAbove (a : Fin (M + 1)) (b : Fin M) :
    rτ i0 j0 (i0.succAbove a, j0.succAbove b) = .inl (a, b) := by
  have hi : i0.succAbove a ≠ i0 := Fin.succAbove_ne i0 a
  have hj : j0.succAbove b ≠ j0 := Fin.succAbove_ne j0 b
  unfold rτ
  simp only [dif_neg hi, dif_neg hj, Sum.inl.injEq, Prod.mk.injEq]
  exact ⟨Fin.succAbove_right_injective (Fin.exists_succAbove_eq hi).choose_spec,
    Fin.succAbove_right_injective (Fin.exists_succAbove_eq hj).choose_spec⟩

lemma rτ_inl {x : PV (M + 1)} {a : Fin (M + 1)} {b : Fin M} (h : rτ i0 j0 x = .inl (a, b)) :
    x = (i0.succAbove a, j0.succAbove b) := by
  rcases x with ⟨i, j⟩
  unfold rτ at h
  split_ifs at h with hi hj
  simp only [Sum.inl.injEq, Prod.mk.injEq] at h
  obtain ⟨rfl, rfl⟩ := h
  simp only at hi hj
  rw [(Fin.exists_succAbove_eq hi).choose_spec, (Fin.exists_succAbove_eq hj).choose_spec]

lemma rτ_i0 (j : Fin (M + 1)) : rτ i0 j0 (i0, j) = .inr (decide (j = j0)) := by
  unfold rτ; simp

lemma rτ_j0 {i : Fin (M + 2)} (hi : i ≠ i0) : rτ i0 j0 (i, j0) = .inr false := by
  unfold rτ; simp [hi]

lemma rτ_i0_ne {j : Fin (M + 1)} (hj : j ≠ j0) : rτ i0 j0 (i0, j) = .inr false := by
  unfold rτ; simp [hj]

lemma mem_img_rτ {C : Finset (PV (M + 1) × Bool)} {a : Fin (M + 1)} {b : Fin M} {s : Bool}
    (h : ((i0.succAbove a, j0.succAbove b), s) ∈ C) : ((a, b), s) ∈ img (rτ i0 j0) C :=
  (mem_img _).2 ⟨_, h, rτ_succAbove i0 j0 a b, rfl⟩

lemma restrict_ax (C : Finset (PV (M + 1) × Bool)) (hC : C ∈ php (M + 1)) :
    Triv (rτ i0 j0) C ∨ ∃ D ∈ php M, D ⊆ img (rτ i0 j0) C := by
  classical
  have trivF : ∀ x, rτ i0 j0 x = .inr false → (x, false) ∈ C →
      Triv (rτ i0 j0) C ∨ ∃ D ∈ php M, D ⊆ img (rτ i0 j0) C :=
    fun x hx hm => Or.inl (Or.inl ⟨(x, false), hm, hx⟩)
  simp only [php, Set.mem_union, Set.mem_setOf_eq] at hC
  rcases hC with ((⟨i, rfl⟩ | ⟨i, j, j', hjj, rfl⟩) | ⟨i, i', j, hii, rfl⟩) | ⟨j, rfl⟩
  · by_cases hi : i = i0
    · subst i; exact Or.inl (Or.inl ⟨((i0, j0), true), by simp, by simp [rτ_i0]⟩)
    · obtain ⟨a, rfl⟩ := Fin.exists_succAbove_eq hi
      refine Or.inr ⟨univ.image (fun b : Fin M => ((a, b), true)), ?_, ?_⟩
      · simp only [php, Set.mem_union, Set.mem_setOf_eq]; exact Or.inl (Or.inl (Or.inl ⟨a, rfl⟩))
      · intro m hm
        obtain ⟨b, -, rfl⟩ := mem_image.1 hm
        exact mem_img_rτ i0 j0 (by simp)
  · by_cases hi : i = i0
    · subst i
      by_cases hj : j = j0
      · subst j; exact trivF _ (rτ_i0_ne i0 j0 (Ne.symm hjj)) (by simp)
      · exact trivF _ (rτ_i0_ne i0 j0 hj) (by simp)
    · by_cases hj : j = j0
      · subst j; exact trivF _ (rτ_j0 i0 j0 hi) (by simp)
      by_cases hj' : j' = j0
      · subst j'; exact trivF _ (rτ_j0 i0 j0 hi) (by simp)
      obtain ⟨a, rfl⟩ := Fin.exists_succAbove_eq hi
      obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      obtain ⟨b', rfl⟩ := Fin.exists_succAbove_eq hj'
      refine Or.inr ⟨{((a, b), false), ((a, b'), false)}, ?_, ?_⟩
      · simp only [php, Set.mem_union, Set.mem_setOf_eq]
        exact Or.inl (Or.inl (Or.inr ⟨a, b, b', fun h => hjj (by rw [h]), rfl⟩))
      · intro m hm
        rcases mem_insert.1 hm with rfl | hm
        · exact mem_img_rτ i0 j0 (by simp)
        · rw [mem_singleton.1 hm]; exact mem_img_rτ i0 j0 (by simp)
  · by_cases hj : j = j0
    · subst j
      by_cases hi : i = i0
      · subst i; exact trivF _ (rτ_j0 i0 j0 (Ne.symm hii)) (by simp)
      · exact trivF _ (rτ_j0 i0 j0 hi) (by simp)
    · by_cases hi : i = i0
      · subst i; exact trivF _ (rτ_i0_ne i0 j0 hj) (by simp)
      by_cases hi' : i' = i0
      · subst i'; exact trivF _ (rτ_i0_ne i0 j0 hj) (by simp)
      obtain ⟨a, rfl⟩ := Fin.exists_succAbove_eq hi
      obtain ⟨a', rfl⟩ := Fin.exists_succAbove_eq hi'
      obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      refine Or.inr ⟨{((a, b), false), ((a', b), false)}, ?_, ?_⟩
      · simp only [php, Set.mem_union, Set.mem_setOf_eq]
        exact Or.inl (Or.inr ⟨a, a', b, fun h => hii (by rw [h]), rfl⟩)
      · intro m hm
        rcases mem_insert.1 hm with rfl | hm
        · exact mem_img_rτ i0 j0 (by simp)
        · rw [mem_singleton.1 hm]; exact mem_img_rτ i0 j0 (by simp)
  · by_cases hj : j = j0
    · subst j; exact Or.inl (Or.inl ⟨((i0, j0), true), by simp, by simp [rτ_i0]⟩)
    · obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      refine Or.inr ⟨univ.image (fun a : Fin (M + 1) => ((a, b), true)), ?_, ?_⟩
      · simp only [php, Set.mem_union, Set.mem_setOf_eq]; exact Or.inr ⟨b, rfl⟩
      · intro m hm
        obtain ⟨a, -, rfl⟩ := mem_image.1 hm
        exact mem_img_rτ i0 j0 (by simp)

lemma restrict_kill (C : Finset (PV (M + 1) × Bool)) (h : (i0, j0) ∈ mono C) :
    Triv (rτ i0 j0) C := by
  classical
  simp only [mono, mem_filter, mem_univ, true_and] at h
  rcases h with h | ⟨i', hi', h⟩
  · exact Or.inl ⟨_, h, by simp [rτ_i0]⟩
  · exact Or.inl ⟨_, h, by simp [rτ_j0 i0 j0 hi']⟩

lemma restrict_mono (E : Finset (PV M × Bool)) (C : Finset (PV (M + 1) × Bool))
    (h : E ⊆ img (rτ i0 j0) C) : (mono E).card ≤ (mono C).card := by
  classical
  refine card_le_card_of_injOn (fun p => (i0.succAbove p.1, j0.succAbove p.2)) ?_ ?_
  · intro p hp
    simp only [mono, coe_filter, mem_univ, true_and, Set.mem_setOf_eq, mem_coe] at hp ⊢
    rcases hp with hp | ⟨a', ha', hp⟩
    · left
      obtain ⟨⟨x, sg⟩, hl, h1, h2⟩ := (mem_img _).1 (h hp)
      simp only at h1 h2
      rw [rτ_inl i0 j0 h1, h2] at hl; exact hl
    · right
      obtain ⟨⟨x, sg⟩, hl, h1, h2⟩ := (mem_img _).1 (h hp)
      simp only at h1 h2
      refine ⟨i0.succAbove a', fun he => ha' (Fin.succAbove_right_injective he), ?_⟩
      rw [rτ_inl i0 j0 h1, h2] at hl; exact hl
  · rintro ⟨a, b⟩ - ⟨a', b'⟩ - he
    simp only [Prod.mk.injEq] at he
    rw [Fin.succAbove_right_injective he.1, Fin.succAbove_right_injective he.2]

end Restrict

end QEDRes


/-! # Exponential lower bound for onto-functional PHP via greedy restrictions -/

namespace QEDRes

open Finset

open Classical in
/-- A line is wide if its monotone width is at least `w`. -/
noncomputable def wide {N : ℕ} (w : ℕ) (C : Finset (PV N × Bool)) : Bool :=
  decide (w ≤ (mono C).card)

open Classical in
lemma sum_kill {N : ℕ} (w : ℕ) (L : List (Finset (PV N × Bool))) :
    ∑ p : PV N, L.countP (fun C => wide w C && decide (p ∈ mono C)) =
      (L.map (fun C => if wide w C then (mono C).card else 0)).sum := by
  induction L with
  | nil => simp
  | cons C L ih =>
    simp only [List.countP_cons, sum_add_distrib, ih, List.map_cons, List.sum_cons]
    rw [add_comm]
    congr 1
    by_cases hw : wide w C = true
    · simp only [hw, Bool.true_and, if_true, decide_eq_true_eq]
      rw [sum_boole]; simp
    · simp [hw]

lemma map_sum_ge {N : ℕ} (w : ℕ) (L : List (Finset (PV N × Bool))) :
    w * L.countP (wide w) ≤ (L.map (fun C => if wide w C then (mono C).card else 0)).sum := by
  induction L with
  | nil => simp
  | cons C L ih =>
    simp only [List.countP_cons, List.map_cons, List.sum_cons]
    by_cases hw : wide w C = true
    · have : w ≤ (mono C).card := by simpa [wide] using hw
      simp only [hw, if_true]; rw [Nat.mul_add, Nat.mul_one]; omega
    · simp only [hw, Bool.false_eq_true, if_false, Nat.add_zero]; omega

lemma countP_split {α : Type*} (p q : α → Bool) (L : List α) :
    L.countP (fun a => p a && !q a) + L.countP (fun a => p a && q a) = L.countP p := by
  induction L with
  | nil => simp
  | cons a L ih =>
    simp only [List.countP_cons]
    cases p a <;> cases q a <;> simp <;> omega

lemma countP_forall₂ {α β : Type*} {R : α → β → Prop} (p : α → Bool) (q : β → Bool)
    (hpq : ∀ a b, R a b → p a → q b) {l : List α} {l' : List β} (h : List.Forall₂ R l l') :
    l.countP p ≤ l'.countP q := by
  induction h with
  | nil => simp
  | cons hab _ ih =>
    simp only [List.countP_cons]
    have := hpq _ _ hab
    split_ifs <;> simp_all <;> omega

/-- One greedy step. -/
theorem greedy_step (M w : ℕ) (L : List (Finset (PV (M + 1) × Bool)))
    (hL : IsRef (php (M + 1)) L) :
    ∃ L' : List (Finset (PV M × Bool)), IsRef (php M) L' ∧
      L'.countP (wide w) ≤ L.countP (wide w) ∧
      L'.countP (wide w) * ((M + 2) * (M + 1)) + L.countP (wide w) * w ≤
        L.countP (wide w) * ((M + 2) * (M + 1)) := by
  classical
  set c := L.countP (wide w)
  set P := (M + 2) * (M + 1)
  have hP : Fintype.card (PV (M + 1)) = P := by simp [P, Fintype.card_prod]
  let kill : PV (M + 1) → ℕ := fun p => L.countP (fun C => wide w C && decide (p ∈ mono C))
  have hsum : c * w ≤ ∑ p, kill p := by
    rw [sum_kill]; rw [Nat.mul_comm]; exact map_sum_ge w L
  obtain ⟨p, hp⟩ : ∃ p, c * w ≤ kill p * P := by
    by_contra h
    push_neg at h
    have : ∑ p : PV (M + 1), kill p * P < ∑ _p : PV (M + 1), c * w :=
      sum_lt_sum_of_nonempty univ_nonempty fun p _ => h p
    rw [← sum_mul, sum_const, card_univ, hP, nsmul_eq_mul, Nat.cast_id] at this
    rw [Nat.mul_comm (∑ i, kill i)] at this
    have := Nat.lt_of_mul_lt_mul_left this
    omega
  obtain ⟨i0, j0⟩ := p
  obtain ⟨L', hL', L'', hsub, hf⟩ :=
    transfer' (rτ i0 j0) (php (M + 1)) (php M) (restrict_ax i0 j0) L hL
  refine ⟨L', hL', ?_⟩
  have h1 : L'.countP (wide w) ≤
      L''.countP (fun C => wide w C && !decide ((i0, j0) ∈ mono C)) := by
    refine countP_forall₂ _ _ (fun E C hEC hw => ?_) hf
    have hm := restrict_mono i0 j0 E C hEC.1
    have hk : (i0, j0) ∉ mono C := fun h => hEC.2 (restrict_kill i0 j0 C h)
    simp only [wide, decide_eq_true_eq] at hw ⊢
    simp [hk, wide]; omega
  have h2 := hsub.countP_le (p := fun C => wide w C && !decide ((i0, j0) ∈ mono C))
  have h3 := countP_split (wide w) (fun C => decide ((i0, j0) ∈ mono C)) L
  have hk : kill (i0, j0) = L.countP (fun C => wide w C && decide ((i0, j0) ∈ mono C)) := rfl
  refine ⟨by omega, ?_⟩
  have hc' : L'.countP (wide w) + kill (i0, j0) ≤ c := by omega
  calc L'.countP (wide w) * P + c * w ≤ L'.countP (wide w) * P + kill (i0, j0) * P := by omega
    _ = (L'.countP (wide w) + kill (i0, j0)) * P := by ring
    _ ≤ c * P := Nat.mul_le_mul_right _ hc'

/-- Iterating `t` greedy steps. -/
theorem greedy_iter (w P0 : ℕ) :
    ∀ t M (L : List (Finset (PV (M + t) × Bool))), IsRef (php (M + t)) L →
      (M + t + 1) * (M + t) ≤ P0 →
      ∃ L' : List (Finset (PV M × Bool)), IsRef (php M) L' ∧
        L'.countP (wide w) * P0 ^ t ≤ L.countP (wide w) * (P0 - w) ^ t := by
  intro t
  induction t with
  | zero => intro M L hL _; exact ⟨L, hL, by simp⟩
  | succ t ih =>
    intro M L hL hP0
    obtain ⟨L1, hL1, hle, hstep⟩ := greedy_step (M + t) w L hL
    obtain ⟨L', hL', hb⟩ := ih M L1 hL1 (le_trans (by nlinarith) hP0)
    refine ⟨L', hL', ?_⟩
    set c := L.countP (wide w)
    set c1 := L1.countP (wide w)
    have hPk : (M + t + 2) * (M + t + 1) ≤ P0 := by
      have : M + (t + 1) = M + t + 1 := by omega
      rw [this] at hP0; exact hP0
    -- c1 * P0 ≤ c * (P0 - w)
    have hmain : c1 * P0 + c * w ≤ c * P0 := by
      obtain ⟨d, hd⟩ : ∃ d, P0 = (M + t + 2) * (M + t + 1) + d := ⟨_, (Nat.add_sub_cancel' hPk).symm⟩
      have h4 := Nat.mul_le_mul_right d hle
      calc c1 * P0 + c * w = (c1 * ((M + t + 2) * (M + t + 1)) + c * w) + c1 * d := by rw [hd]; ring
        _ ≤ c * ((M + t + 2) * (M + t + 1)) + c * d := Nat.add_le_add hstep h4
        _ = c * P0 := by rw [hd]; ring
    have hw : c * w ≤ c * P0 := by omega
    have h1 : c1 * P0 ≤ c * (P0 - w) := by rw [Nat.mul_sub]; omega
    calc L'.countP (wide w) * P0 ^ (t + 1) = (L'.countP (wide w) * P0 ^ t) * P0 := by ring
      _ ≤ (c1 * (P0 - w) ^ t) * P0 := Nat.mul_le_mul_right _ hb
      _ = (c1 * P0) * (P0 - w) ^ t := by ring
      _ ≤ (c * (P0 - w)) * (P0 - w) ^ t := Nat.mul_le_mul_right _ h1
      _ = c * (P0 - w) ^ (t + 1) := by ring

theorem php_lower_aux (M t : ℕ) (hM3 : 3 ≤ M) (ht : t ≤ M) (htM : M ≤ t + 1)
    (L : List (Finset (PV (M + t) × Bool))) (hL : IsRef (php (M + t)) L) :
    18 ^ t ≤ L.length * 17 ^ t := by
  classical
  set P0 := (M + t + 1) * (M + t)
  set w := 2 * (M + 1) ^ 2 / 9
  obtain ⟨L', hL', hb⟩ := greedy_iter w P0 t M L hL le_rfl
  obtain ⟨C, hC, hCw⟩ := wide_line hM3 L' hL'
  have hwC : w ≤ (mono C).card := by
    have := Nat.div_mul_le_self (2 * (M + 1) ^ 2) 9; simp only [w]; omega
  have hpos : 1 ≤ L'.countP (wide w) := by
    rw [Nat.one_le_iff_ne_zero, Ne, List.countP_eq_zero]; push_neg
    exact ⟨C, hC, by simpa [wide] using hwC⟩
  have hlen : L.countP (wide w) ≤ L.length := List.countP_le_length
  have hkey : P0 ^ t ≤ L.length * (P0 - w) ^ t :=
    calc P0 ^ t ≤ L'.countP (wide w) * P0 ^ t := by nlinarith [Nat.zero_le (P0 ^ t)]
      _ ≤ L.countP (wide w) * (P0 - w) ^ t := hb
      _ ≤ L.length * (P0 - w) ^ t := Nat.mul_le_mul_right _ hlen
  have hw18 : P0 ≤ 18 * w := by
    have h9 : 2 * (M + 1) ^ 2 < 9 * (w + 1) := by
      have := Nat.lt_mul_div_succ (2 * (M + 1) ^ 2) (show 0 < 9 by norm_num)
      simp only [w]; linarith
    have h2M : M + t + 2 ≤ 2 * (M + 1) := by omega
    have : (M + t + 2) ^ 2 ≤ (2 * (M + 1)) ^ 2 := Nat.pow_le_pow_left h2M 2
    simp only [P0]; nlinarith
  have h17 : 18 * (P0 - w) ≤ 17 * P0 := by omega
  have hP0pos : 0 < P0 := by simp only [P0]; positivity
  have : P0 ^ t * 18 ^ t ≤ P0 ^ t * (L.length * 17 ^ t) :=
    calc P0 ^ t * 18 ^ t ≤ L.length * (P0 - w) ^ t * 18 ^ t := Nat.mul_le_mul_right _ hkey
      _ = L.length * (18 * (P0 - w)) ^ t := by rw [mul_pow]; ring
      _ ≤ L.length * (17 * P0) ^ t := Nat.mul_le_mul_left _ (Nat.pow_le_pow_left h17 t)
      _ = P0 ^ t * (L.length * 17 ^ t) := by rw [mul_pow]; ring
  exact Nat.le_of_mul_le_mul_left this (by positivity)

/-- **Exponential lower bound for onto-functional PHP(N+1, N).** -/
theorem php_lower (N : ℕ) (hN : 8 ≤ N) (L : List (Finset (PV N × Bool))) (hL : IsRef (php N) L) :
    18 ^ (N / 2) ≤ L.length * 17 ^ (N / 2) := by
  obtain ⟨M, hM⟩ : ∃ M, N = M + N / 2 := ⟨N - N / 2, by omega⟩
  have h3 : 3 ≤ M := by omega
  have h4 : N / 2 ≤ M := by omega
  have h5 : M ≤ N / 2 + 1 := by omega
  generalize N / 2 = t at hM h4 h5 ⊢
  subst hM
  exact php_lower_aux M t h3 h4 h5 L hL

end QEDRes


/-!
# Onto-functional PHP with `δ + N` pigeons and `N` holes: hitting-set measure and width lemma
-/

namespace QEDRes

open Finset

variable {δ : ℕ}

/-- Variables `(pigeon, hole)`. -/
abbrev GV (δ N : ℕ) : Type := Fin (δ + N) × Fin N

/-- Onto-functional `PHP(δ+N, N)`. -/
def gphp (δ N : ℕ) : Set (Finset (GV δ N × Bool)) :=
  {C | ∃ i, C = univ.image (fun j : Fin N => ((i, j), true))} ∪
  {C | ∃ i j j', j ≠ j' ∧ C = {((i, j), false), ((i, j'), false)}} ∪
  {C | ∃ i i' j, i ≠ i' ∧ C = {((i, j), false), ((i', j), false)}} ∪
  {C | ∃ j, C = univ.image (fun i : Fin (δ + N) => ((i, j), true))}

/-- Critical assignment of an injective `g : holes → pigeons`. -/
def gcta {N : ℕ} (g : Fin N → Fin (δ + N)) : GV δ N → Bool := fun p => decide (g p.2 = p.1)

/-- `S` hits every critical assignment falsifying `C` (some pigeon of `S` is left out). -/
def Hits {N : ℕ} (S : Finset (Fin (δ + N))) (C : Finset (GV δ N × Bool)) : Prop :=
  ∀ g : Fin N → Fin (δ + N), Function.Injective g → ¬ Sat (gcta g) C → ∃ i ∈ S, ∀ j, g j ≠ i

lemma hits_univ {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) : Hits (univ : Finset (Fin (δ + N))) C := by
  classical
  intro g hg _
  by_contra h
  push_neg at h
  have hsub : (univ : Finset (Fin (δ + N))) ⊆ univ.image g := fun i _ => by
    obtain ⟨j, hj⟩ := h i (mem_univ _); exact mem_image.2 ⟨j, mem_univ _, hj⟩
  have := card_le_card hsub
  rw [card_univ, card_image_of_injective _ hg, Fintype.card_fin, card_univ, Fintype.card_fin] at this
  omega

open Classical in
/-- The hitting-set measure. -/
noncomputable def mu {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) : ℕ :=
  Nat.find (⟨_, univ, rfl, hits_univ hδ C⟩ : ∃ k, ∃ S : Finset (Fin (δ + N)), S.card = k ∧ Hits S C)

lemma mu_spec {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) :
    ∃ S : Finset (Fin (δ + N)), S.card = mu hδ C ∧ Hits S C := by
  classical
  exact Nat.find_spec (⟨_, univ, rfl, hits_univ hδ C⟩ : ∃ k, ∃ S : Finset (Fin (δ + N)), S.card = k ∧ Hits S C)

lemma mu_le {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) (S : Finset (Fin (δ + N))) (h : Hits S C) :
    mu hδ C ≤ S.card := by
  classical
  exact Nat.find_min' _ ⟨S, rfl, h⟩

lemma gsat_res {N : ℕ} (α : GV δ N → Bool) (A B : Finset (GV δ N × Bool)) (x : GV δ N)
    (hA : Sat α A) (hB : Sat α B) : Sat α (A.erase (x, true) ∪ B.erase (x, false)) := by
  obtain ⟨a, ha, hav⟩ := hA
  obtain ⟨b, hb, hbv⟩ := hB
  by_cases hax : a = (x, true)
  · subst hax
    have hbx : b ≠ (x, false) := by rintro rfl; simp_all
    exact ⟨b, mem_union_right _ (mem_erase.2 ⟨hbx, hb⟩), hbv⟩
  · exact ⟨a, mem_union_left _ (mem_erase.2 ⟨hax, ha⟩), hav⟩

lemma mu_res {N : ℕ} (hδ : 1 ≤ δ) (A B : Finset (GV δ N × Bool)) (x : GV δ N) :
    mu hδ (A.erase (x, true) ∪ B.erase (x, false)) ≤ mu hδ A + mu hδ B := by
  classical
  obtain ⟨SA, hSA, hA⟩ := mu_spec hδ A
  obtain ⟨SB, hSB, hB⟩ := mu_spec hδ B
  have : Hits (SA ∪ SB) (A.erase (x, true) ∪ B.erase (x, false)) := by
    intro g hg hn
    by_cases ha : Sat (gcta g) A
    · by_cases hb : Sat (gcta g) B
      · exact absurd (gsat_res _ A B x ha hb) hn
      · obtain ⟨i, hi, h⟩ := hB g hg hb; exact ⟨i, mem_union_right _ hi, h⟩
    · obtain ⟨i, hi, h⟩ := hA g hg ha; exact ⟨i, mem_union_left _ hi, h⟩
  calc mu hδ _ ≤ (SA ∪ SB).card := mu_le hδ _ _ this
    _ ≤ SA.card + SB.card := card_union_le _ _
    _ = _ := by rw [hSA, hSB]

lemma mu_axiom {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) (hC : C ∈ gphp δ N) : mu hδ C ≤ 1 := by
  classical
  simp only [gphp, Set.mem_union, Set.mem_setOf_eq] at hC
  rcases hC with ((⟨i, rfl⟩ | ⟨i, j, j', hjj, rfl⟩) | ⟨i, i', j, hii, rfl⟩) | ⟨j, rfl⟩
  · refine (mu_le hδ _ {i} ?_).trans (by simp)
    intro g hg hn
    refine ⟨i, mem_singleton_self _, fun j hj => hn ⟨((i, j), true), by simp, by simp [gcta, hj]⟩⟩
  · refine (mu_le hδ _ ∅ ?_).trans (by simp)
    intro g hg hn; exfalso; apply hn
    by_cases h : g j = i
    · exact ⟨((i, j'), false), by simp, by
        simp only [gcta, decide_eq_false_iff_not]; intro h'; exact hjj (hg (h.trans h'.symm))⟩
    · exact ⟨((i, j), false), by simp, by simp [gcta, h]⟩
  · refine (mu_le hδ _ ∅ ?_).trans (by simp)
    intro g hg hn; exfalso; apply hn
    by_cases h : g j = i
    · exact ⟨((i', j), false), by simp, by simp [gcta]; intro h'; exact hii (h.symm.trans h')⟩
    · exact ⟨((i, j), false), by simp, by simp [gcta, h]⟩
  · refine (mu_le hδ _ ∅ ?_).trans (by simp)
    intro g hg hn; exfalso; exact hn ⟨((g j, j), true), by simp, by simp [gcta]⟩

lemma mu_empty {N : ℕ} (hδ : 1 ≤ δ) : N + 1 ≤ mu hδ (∅ : Finset (GV δ N × Bool)) := by
  classical
  obtain ⟨S, hS, hhit⟩ := mu_spec hδ (∅ : Finset (GV δ N × Bool))
  by_contra hlt
  push_neg at hlt
  -- a set `T ⊇ S` of size `N`, enumerated by an injective `g`
  obtain ⟨T, hST, hT⟩ := exists_superset_card_eq (s := S) (n := N) (by omega)
    (by simp)
  let g : Fin N → Fin (δ + N) := fun j => T.orderEmbOfFin hT j
  have hg : Function.Injective g := (T.orderEmbOfFin hT).injective
  obtain ⟨i, hi, hmiss⟩ := hhit g hg (fun ⟨l, hl, _⟩ => by simp at hl)
  have : i ∈ T := hST hi
  have h2 : (i : Fin (δ + N)) ∈ (T : Set (Fin (δ + N))) := this
  rw [← Finset.range_orderEmbOfFin T hT] at h2
  obtain ⟨j, hj⟩ := h2
  exact hmiss j hj

open Classical in
/-- Monotone width set. -/
noncomputable def gmono {N : ℕ} (C : Finset (GV δ N × Bool)) : Finset (GV δ N) :=
  univ.filter (fun p => (p, true) ∈ C ∨ ∃ i', i' ≠ p.1 ∧ ((i', p.2), false) ∈ C)

/-- Swap argument with a minimal hitting set. -/
lemma gmono_card {N : ℕ} (hδ : 1 ≤ δ) (C : Finset (GV δ N × Bool)) :
    mu hδ C * (N + 1 - mu hδ C) ≤ (gmono C).card := by
  classical
  obtain ⟨S, hS, hhit⟩ := mu_spec hδ C
  rw [← hS]
  set q := S.card
  -- for each `i ∈ S`, `S.erase i` does not hit
  have hmin : ∀ i ∈ S, ∃ g : Fin N → Fin (δ + N), Function.Injective g ∧ ¬ Sat (gcta g) C ∧
      (∀ j, g j ≠ i) ∧ ∀ i' ∈ S, i' ≠ i → ∃ j, g j = i' := by
    intro i hi
    have hnot : ¬ Hits (S.erase i) C := by
      intro h; have := mu_le hδ C _ h
      rw [card_erase_of_mem hi] at this
      have hq : 1 ≤ q := card_pos.2 ⟨i, hi⟩
      omega
    simp only [Hits, not_forall, not_exists, not_and, not_not, exists_prop] at hnot
    obtain ⟨g, hg, hn, hall⟩ := hnot
    refine ⟨g, hg, hn, ?_, ?_⟩
    · obtain ⟨i'', hi'', hm⟩ := hhit g hg hn
      by_cases h : i'' = i
      · subst h; exact hm
      · obtain ⟨j, hj⟩ := hall i'' (mem_erase.2 ⟨h, hi''⟩); exact absurd hj (hm j)
    · intro i' hi' hne
      by_contra hc; push_neg at hc
      obtain ⟨j, hj⟩ := hall i' (mem_erase.2 ⟨hne, hi'⟩)
      exact hc j hj
  choose! G hGi hGf hGm hGr using hmin
  -- the pigeons in the range of `G i` outside `S`, and their holes
  have key : ∀ i ∈ S, ∀ j : Fin N, G i j ∉ S → (i, j) ∈ gmono C := by
    intro i hi j hjS
    have hne : G i j ≠ i := hGm i hi j
    set g' := Function.update (G i) j i
    have hg'inj : Function.Injective g' := by
      intro a b hab
      simp only [g', Function.update_apply] at hab
      split_ifs at hab with ha hb hb
      · rw [ha, hb]
      · exact absurd hab.symm (hGm i hi b)
      · exact absurd hab (hGm i hi a)
      · exact hGi i hi hab
    have hsat : Sat (gcta g') C := by
      by_contra h
      obtain ⟨i'', hi'', hm⟩ := hhit g' hg'inj h
      by_cases h1 : i'' = i
      · subst h1; exact hm j (by simp [g'])
      · obtain ⟨j', hj'⟩ := hGr i hi i'' hi'' h1
        apply hm j'
        simp only [g', Function.update_apply]
        split_ifs with h2
        · subst h2; exact absurd (hj'.symm ▸ hi'') hjS
        · exact hj'
    obtain ⟨l, hl, hlv⟩ := hsat
    have agree : ∀ p : GV δ N, p ≠ (i, j) → p ≠ (G i j, j) → gcta g' p = gcta (G i) p := by
      rintro ⟨a, b⟩ h1 h2
      simp only [gcta, g', Function.update_apply]
      by_cases hb : b = j
      · subst hb
        simp only [if_true]
        have ha1 : a ≠ i := fun h => h1 (by rw [h])
        have ha2 : a ≠ G i b := fun h => h2 (by rw [h])
        simp [Ne.symm ha1, Ne.symm ha2]
      · simp [hb]
    simp only [gmono, mem_filter, mem_univ, true_and]
    by_cases h1 : l.1 = (i, j)
    · left
      have : l.2 = true := by rw [← hlv, h1]; simp [gcta, g']
      rcases l with ⟨p, b⟩; simp only at h1 this; subst h1; subst this; exact hl
    · by_cases h2 : l.1 = (G i j, j)
      · right
        refine ⟨G i j, hne, ?_⟩
        have : l.2 = false := by rw [← hlv, h2]; simp [gcta, g', Ne.symm hne]
        rcases l with ⟨p, b⟩; simp only at h2 this; subst h2; subst this; exact hl
      · exact absurd ⟨l, hl, (agree _ h1 h2) ▸ hlv⟩ (hGf i hi)
  -- count: for each `i ∈ S`, the holes `j` with `G i j ∉ S`
  let H : Fin (δ + N) → Finset (Fin N) := fun i => univ.filter (fun j => G i j ∉ S)
  have hH : ∀ i ∈ S, N + 1 - q ≤ (H i).card := by
    intro i hi
    -- holes mapped into `S` are at most `q - 1`
    have hin : (univ.filter (fun j => G i j ∈ S)).card ≤ q - 1 := by
      have : (univ.filter (fun j => G i j ∈ S)).image (G i) ⊆ S.erase i := by
        intro x hx
        obtain ⟨j, hj, rfl⟩ := mem_image.1 hx
        exact mem_erase.2 ⟨hGm i hi j, (mem_filter.1 hj).2⟩
      have h1 := card_le_card this
      rw [card_image_of_injective _ (hGi i hi), card_erase_of_mem hi] at h1
      exact h1
    have hsplit := card_filter_add_card_filter_not (s := (univ : Finset (Fin N))) (fun j => G i j ∈ S)
    rw [card_univ, Fintype.card_fin] at hsplit
    have hq : 1 ≤ q := card_pos.2 ⟨i, hi⟩
    simp only [H]
    omega
  have hsub : S.biUnion (fun i => (H i).image (fun j => (i, j))) ⊆ gmono C := by
    intro p hp
    obtain ⟨i, hi, hp⟩ := mem_biUnion.1 hp
    obtain ⟨j, hj, rfl⟩ := mem_image.1 hp
    exact key i hi j (mem_filter.1 hj).2
  have hcard : (S.biUnion (fun i => (H i).image (fun j => (i, j)))).card = ∑ i ∈ S, (H i).card := by
    rw [card_biUnion]
    · refine sum_congr rfl fun i _ => card_image_of_injective _ (fun a b h => (Prod.mk.inj h).2)
    · intro a _ b _ hab
      simp only [Function.onFun]
      rw [disjoint_left]
      intro p hpa hpb
      obtain ⟨_, _, rfl⟩ := mem_image.1 hpa
      obtain ⟨_, _, h⟩ := mem_image.1 hpb
      exact hab (Prod.mk.inj h).1.symm
  calc q * (N + 1 - q) = ∑ _i ∈ S, (N + 1 - q) := by rw [sum_const]; rfl
    _ ≤ ∑ i ∈ S, (H i).card := sum_le_sum hH
    _ = _ := hcard.symm
    _ ≤ _ := card_le_card hsub

/-- Width lemma for `PHP(δ+N, N)`. -/
theorem gwide_line {N : ℕ} (hδ : 1 ≤ δ) (hN : 3 ≤ N) (L : List (Finset (GV δ N × Bool)))
    (hL : IsRef (gphp δ N) L) : ∃ C ∈ L, 2 * (N + 1) ^ 2 ≤ 9 * (gmono C).card := by
  classical
  rw [isRef_iff] at hL
  obtain ⟨h0, hS⟩ := hL
  obtain ⟨e, he, he0⟩ := List.mem_iff_getElem.1 h0
  have hex : ∃ c, c < L.length ∧ N + 1 ≤ 3 * mu hδ (L[c]!) := by
    refine ⟨e, he, ?_⟩
    rw [getElem!_pos L e he, he0]; have := mu_empty (δ := δ) (N := N) hδ; omega
  let c := Nat.find hex
  obtain ⟨hc, hcq⟩ : c < L.length ∧ N + 1 ≤ 3 * mu hδ (L[c]!) := Nat.find_spec hex
  have hmin : ∀ m < c, m < L.length → 3 * mu hδ (L[m]!) < N + 1 := by
    intro m hm hmL
    have := Nat.find_min hex hm
    push_neg at this
    exact this hmL
  rw [getElem!_pos L c hc] at hcq
  have hup : 3 * mu hδ (L[c]) ≤ 2 * N := by
    rcases hS c hc with hF | ⟨j, hj, k, hk, x, -, -, hres⟩
    · have := mu_axiom hδ _ hF; omega
    · have h1 := hmin j hj (by omega)
      have h2 := hmin k hk (by omega)
      rw [getElem!_pos L j (by omega)] at h1
      rw [getElem!_pos L k (by omega)] at h2
      have := mu_res hδ (L[j]'(by omega)) (L[k]'(by omega)) x
      rw [← hres] at this
      omega
  refine ⟨L[c], List.getElem_mem hc, ?_⟩
  have hm := gmono_card hδ (L[c])
  set q := mu hδ (L[c])
  have : 2 * (N + 1) ^ 2 ≤ 9 * (q * (N + 1 - q)) := by
    obtain ⟨r, hr⟩ : ∃ r, N + 1 = q + r := ⟨N + 1 - q, by omega⟩
    rw [hr, Nat.add_sub_cancel_left]
    have h1 : r ≤ 2 * q := by omega
    have h2 : q ≤ 2 * r := by omega
    have h1' : (r : ℤ) ≤ 2 * q := by exact_mod_cast h1
    have h2' : (q : ℤ) ≤ 2 * r := by exact_mod_cast h2
    have : (2 * (q + r) ^ 2 : ℤ) ≤ 9 * (q * r) := by
      nlinarith [mul_nonneg (sub_nonneg.2 h1') (sub_nonneg.2 h2')]
    exact_mod_cast this
  omega

end QEDRes


/-! # Exponential lower bound for onto-functional PHP(δ+N, N), `1 ≤ δ ≤ 2` -/

namespace QEDRes

open Finset

section Restrict

variable {δ M : ℕ} (i0 : Fin (δ + M + 1)) (j0 : Fin (M + 1))

open Classical in
noncomputable def gτ (x : GV δ (M + 1)) : GV δ M ⊕ Bool :=
  if hi : (x.1 : Fin (δ + M + 1)) = i0 then .inr (decide (x.2 = j0))
  else if hj : x.2 = j0 then .inr false
  else .inl ((Fin.exists_succAbove_eq hi).choose, (Fin.exists_succAbove_eq hj).choose)

lemma gτ_succAbove (a : Fin (δ + M)) (b : Fin M) :
    gτ i0 j0 ((i0.succAbove a : Fin (δ + M + 1)), j0.succAbove b) = .inl (a, b) := by
  have hi : i0.succAbove a ≠ i0 := Fin.succAbove_ne i0 a
  have hj : j0.succAbove b ≠ j0 := Fin.succAbove_ne j0 b
  unfold gτ
  simp only [dif_neg hi, dif_neg hj, Sum.inl.injEq, Prod.mk.injEq]
  exact ⟨Fin.succAbove_right_injective (Fin.exists_succAbove_eq hi).choose_spec,
    Fin.succAbove_right_injective (Fin.exists_succAbove_eq hj).choose_spec⟩

lemma gτ_inl {x : GV δ (M + 1)} {a : Fin (δ + M)} {b : Fin M} (h : gτ i0 j0 x = .inl (a, b)) :
    x = ((i0.succAbove a : Fin (δ + M + 1)), j0.succAbove b) := by
  rcases x with ⟨i, j⟩
  unfold gτ at h
  split_ifs at h with hi hj
  simp only [Sum.inl.injEq, Prod.mk.injEq] at h
  obtain ⟨rfl, rfl⟩ := h
  simp only at hi hj
  rw [(Fin.exists_succAbove_eq hi).choose_spec, (Fin.exists_succAbove_eq hj).choose_spec]

lemma gτ_i0 (j : Fin (M + 1)) : gτ (δ := δ) i0 j0 ((i0 : Fin (δ + (M + 1))), j) = .inr (decide (j = j0)) := by
  unfold gτ; simp

lemma gτ_j0 {i : Fin (δ + (M + 1))} (hi : (i : Fin (δ + M + 1)) ≠ i0) : gτ i0 j0 (i, j0) = .inr false := by
  unfold gτ; simp [hi]

lemma gτ_i0_ne {j : Fin (M + 1)} (hj : j ≠ j0) : gτ (δ := δ) i0 j0 ((i0 : Fin (δ + (M + 1))), j) = .inr false := by
  unfold gτ; simp [hj]

lemma mem_img_gτ {C : Finset (GV δ (M + 1) × Bool)} {a : Fin (δ + M)} {b : Fin M} {s : Bool}
    (h : (((i0.succAbove a : Fin (δ + M + 1)), j0.succAbove b), s) ∈ C) : ((a, b), s) ∈ img (gτ i0 j0) C :=
  (mem_img _).2 ⟨_, h, gτ_succAbove i0 j0 a b, rfl⟩

lemma grestrict_ax (C : Finset (GV δ (M + 1) × Bool)) (hC : C ∈ gphp δ (M + 1)) :
    Triv (gτ i0 j0) C ∨ ∃ D ∈ gphp δ M, D ⊆ img (gτ i0 j0) C := by
  classical
  have trivF : ∀ x, gτ i0 j0 x = .inr false → (x, false) ∈ C →
      Triv (gτ i0 j0) C ∨ ∃ D ∈ gphp δ M, D ⊆ img (gτ i0 j0) C :=
    fun x hx hm => Or.inl (Or.inl ⟨(x, false), hm, hx⟩)
  simp only [gphp, Set.mem_union, Set.mem_setOf_eq] at hC
  rcases hC with ((⟨i, rfl⟩ | ⟨i, j, j', hjj, rfl⟩) | ⟨i, i', j, hii, rfl⟩) | ⟨j, rfl⟩
  · by_cases hi : (i : Fin (δ + M + 1)) = i0
    · subst hi; exact Or.inl (Or.inl ⟨((i, j0), true), by simp, by simp [gτ_i0]⟩)
    · obtain ⟨a, ha⟩ := Fin.exists_succAbove_eq hi
      refine Or.inr ⟨univ.image (fun b : Fin M => ((a, b), true)), ?_, ?_⟩
      · simp only [gphp, Set.mem_union, Set.mem_setOf_eq]; exact Or.inl (Or.inl (Or.inl ⟨a, rfl⟩))
      · intro m hm
        obtain ⟨b, -, rfl⟩ := mem_image.1 hm
        exact mem_img_gτ i0 j0 (by rw [ha]; simp)
  · by_cases hi : (i : Fin (δ + M + 1)) = i0
    · subst hi
      by_cases hj : j = j0
      · subst j; exact trivF _ (gτ_i0_ne _ j0 (Ne.symm hjj)) (by simp)
      · exact trivF _ (gτ_i0_ne _ j0 hj) (by simp)
    · by_cases hj : j = j0
      · subst j; exact trivF _ (gτ_j0 i0 j0 hi) (by simp)
      by_cases hj' : j' = j0
      · subst j'; exact trivF _ (gτ_j0 i0 j0 hi) (by simp)
      obtain ⟨a, ha⟩ := Fin.exists_succAbove_eq hi
      obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      obtain ⟨b', rfl⟩ := Fin.exists_succAbove_eq hj'
      refine Or.inr ⟨{((a, b), false), ((a, b'), false)}, ?_, ?_⟩
      · simp only [gphp, Set.mem_union, Set.mem_setOf_eq]
        exact Or.inl (Or.inl (Or.inr ⟨a, b, b', fun h => hjj (by rw [h]), rfl⟩))
      · intro m hm
        rcases mem_insert.1 hm with rfl | hm
        · exact mem_img_gτ i0 j0 (by rw [ha]; simp)
        · rw [mem_singleton.1 hm]; exact mem_img_gτ i0 j0 (by rw [ha]; simp)
  · by_cases hj : j = j0
    · subst j
      by_cases hi : (i : Fin (δ + M + 1)) = i0
      · subst hi; exact trivF _ (gτ_j0 _ j0 (fun h => hii h.symm)) (by simp)
      · exact trivF _ (gτ_j0 i0 j0 hi) (by simp)
    · by_cases hi : (i : Fin (δ + M + 1)) = i0
      · subst hi; exact trivF _ (gτ_i0_ne _ j0 hj) (by simp)
      by_cases hi' : (i' : Fin (δ + M + 1)) = i0
      · subst hi'; exact trivF _ (gτ_i0_ne _ j0 hj) (by simp)
      obtain ⟨a, ha⟩ := Fin.exists_succAbove_eq hi
      obtain ⟨a', ha'⟩ := Fin.exists_succAbove_eq hi'
      obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      refine Or.inr ⟨{((a, b), false), ((a', b), false)}, ?_, ?_⟩
      · simp only [gphp, Set.mem_union, Set.mem_setOf_eq]
        refine Or.inl (Or.inr ⟨a, a', b, fun h => hii ?_, rfl⟩)
        rw [← ha, ← ha', h]
      · intro m hm
        rcases mem_insert.1 hm with rfl | hm
        · exact mem_img_gτ i0 j0 (by rw [ha]; simp)
        · rw [mem_singleton.1 hm]; exact mem_img_gτ i0 j0 (by rw [ha']; simp)
  · by_cases hj : j = j0
    · subst j; exact Or.inl (Or.inl ⟨(((i0 : Fin (δ + (M + 1))), j0), true), by simp, by simp [gτ_i0]⟩)
    · obtain ⟨b, rfl⟩ := Fin.exists_succAbove_eq hj
      refine Or.inr ⟨univ.image (fun a : Fin (δ + M) => ((a, b), true)), ?_, ?_⟩
      · simp only [gphp, Set.mem_union, Set.mem_setOf_eq]; exact Or.inr ⟨b, rfl⟩
      · intro m hm
        obtain ⟨a, -, rfl⟩ := mem_image.1 hm
        exact mem_img_gτ i0 j0 (by simp)

lemma grestrict_kill (C : Finset (GV δ (M + 1) × Bool))
    (h : (((i0 : Fin (δ + (M + 1)))), j0) ∈ gmono C) : Triv (gτ i0 j0) C := by
  classical
  simp only [gmono, mem_filter, mem_univ, true_and] at h
  rcases h with h | ⟨i', hi', h⟩
  · exact Or.inl ⟨_, h, by simp [gτ_i0]⟩
  · exact Or.inl ⟨_, h, by simp [gτ_j0 i0 j0 hi']⟩

lemma grestrict_mono (E : Finset (GV δ M × Bool)) (C : Finset (GV δ (M + 1) × Bool))
    (h : E ⊆ img (gτ i0 j0) C) : (gmono E).card ≤ (gmono C).card := by
  classical
  refine card_le_card_of_injOn
    (fun p => (((i0.succAbove p.1 : Fin (δ + M + 1)) : Fin (δ + (M + 1))), j0.succAbove p.2)) ?_ ?_
  · intro p hp
    simp only [gmono, coe_filter, mem_univ, true_and, Set.mem_setOf_eq, mem_coe] at hp ⊢
    rcases hp with hp | ⟨a', ha', hp⟩
    · left
      obtain ⟨⟨x, sg⟩, hl, h1, h2⟩ := (mem_img _).1 (h hp)
      simp only at h1 h2
      rw [gτ_inl i0 j0 h1, h2] at hl; exact hl
    · right
      obtain ⟨⟨x, sg⟩, hl, h1, h2⟩ := (mem_img _).1 (h hp)
      simp only at h1 h2
      refine ⟨(i0.succAbove a' : Fin (δ + M + 1)), fun he => ha' (Fin.succAbove_right_injective he), ?_⟩
      rw [gτ_inl i0 j0 h1, h2] at hl; exact hl
  · rintro ⟨a, b⟩ - ⟨a', b'⟩ - he
    simp only [Prod.mk.injEq] at he
    rw [Fin.succAbove_right_injective he.1, Fin.succAbove_right_injective he.2]

end Restrict

open Classical in
noncomputable def gwide {δ N : ℕ} (w : ℕ) (C : Finset (GV δ N × Bool)) : Bool :=
  decide (w ≤ (gmono C).card)

open Classical in
lemma gsum_kill {δ N : ℕ} (w : ℕ) (L : List (Finset (GV δ N × Bool))) :
    ∑ p : GV δ N, L.countP (fun C => gwide w C && decide (p ∈ gmono C)) =
      (L.map (fun C => if gwide w C then (gmono C).card else 0)).sum := by
  induction L with
  | nil => simp
  | cons C L ih =>
    simp only [List.countP_cons, sum_add_distrib, ih, List.map_cons, List.sum_cons]
    rw [add_comm]
    congr 1
    by_cases hw : gwide w C = true
    · simp only [hw, Bool.true_and, if_true, decide_eq_true_eq]
      rw [sum_boole]; simp
    · simp [hw]

lemma gmap_sum_ge {δ N : ℕ} (w : ℕ) (L : List (Finset (GV δ N × Bool))) :
    w * L.countP (gwide w) ≤ (L.map (fun C => if gwide w C then (gmono C).card else 0)).sum := by
  induction L with
  | nil => simp
  | cons C L ih =>
    simp only [List.countP_cons, List.map_cons, List.sum_cons]
    by_cases hw : gwide w C = true
    · have : w ≤ (gmono C).card := by simpa [gwide] using hw
      simp only [hw, if_true]; rw [Nat.mul_add, Nat.mul_one]; omega
    · simp only [hw, Bool.false_eq_true, if_false, Nat.add_zero]; omega

theorem ggreedy_step (δ M w : ℕ) (L : List (Finset (GV δ (M + 1) × Bool)))
    (hL : IsRef (gphp δ (M + 1)) L) :
    ∃ L' : List (Finset (GV δ M × Bool)), IsRef (gphp δ M) L' ∧
      L'.countP (gwide w) ≤ L.countP (gwide w) ∧
      L'.countP (gwide w) * ((δ + M + 1) * (M + 1)) + L.countP (gwide w) * w ≤
        L.countP (gwide w) * ((δ + M + 1) * (M + 1)) := by
  classical
  set c := L.countP (gwide w)
  set P := (δ + M + 1) * (M + 1)
  have hP : Fintype.card (GV δ (M + 1)) = P := by simp [P, Fintype.card_prod]; ring
  let kill : GV δ (M + 1) → ℕ := fun p => L.countP (fun C => gwide w C && decide (p ∈ gmono C))
  have hsum : c * w ≤ ∑ p, kill p := by
    rw [gsum_kill]; rw [Nat.mul_comm]; exact gmap_sum_ge w L
  obtain ⟨p, hp⟩ : ∃ p, c * w ≤ kill p * P := by
    by_contra h
    push_neg at h
    have : ∑ p : GV δ (M + 1), kill p * P < ∑ _p : GV δ (M + 1), c * w :=
      sum_lt_sum_of_nonempty univ_nonempty fun p _ => h p
    rw [← sum_mul, sum_const, card_univ, hP, nsmul_eq_mul, Nat.cast_id] at this
    rw [Nat.mul_comm (∑ i, kill i)] at this
    have := Nat.lt_of_mul_lt_mul_left this
    omega
  obtain ⟨i0, j0⟩ := p
  obtain ⟨L', hL', L'', hsub, hf⟩ :=
    transfer' (gτ (i0 : Fin (δ + M + 1)) j0) (gphp δ (M + 1)) (gphp δ M)
      (grestrict_ax (i0 : Fin (δ + M + 1)) j0) L hL
  refine ⟨L', hL', ?_⟩
  have h1 : L'.countP (gwide w) ≤
      L''.countP (fun C => gwide w C && !decide ((i0, j0) ∈ gmono C)) := by
    refine List.countP_mono_left (l := L') (fun _ _ h => h) |>.trans ?_
    refine countP_forall₂ _ _ (fun E C hEC hw => ?_) hf
    have hm := grestrict_mono (i0 : Fin (δ + M + 1)) j0 E C hEC.1
    have hk : (i0, j0) ∉ gmono C := fun h => hEC.2 (grestrict_kill (i0 : Fin (δ + M + 1)) j0 C h)
    simp only [gwide, decide_eq_true_eq] at hw ⊢
    simp [hk, gwide]; omega
  have h2 := hsub.countP_le (p := fun C => gwide w C && !decide ((i0, j0) ∈ gmono C))
  have h3 := countP_split (gwide w) (fun C => decide ((i0, j0) ∈ gmono C)) L
  have hk : kill (i0, j0) = L.countP (fun C => gwide w C && decide ((i0, j0) ∈ gmono C)) := rfl
  refine ⟨by omega, ?_⟩
  have hc' : L'.countP (gwide w) + kill (i0, j0) ≤ c := by omega
  calc L'.countP (gwide w) * P + c * w ≤ L'.countP (gwide w) * P + kill (i0, j0) * P := by omega
    _ = (L'.countP (gwide w) + kill (i0, j0)) * P := by ring
    _ ≤ c * P := Nat.mul_le_mul_right _ hc'

theorem ggreedy_iter (δ w P0 : ℕ) :
    ∀ t M (L : List (Finset (GV δ (M + t) × Bool))), IsRef (gphp δ (M + t)) L →
      (δ + M + t) * (M + t) ≤ P0 →
      ∃ L' : List (Finset (GV δ M × Bool)), IsRef (gphp δ M) L' ∧
        L'.countP (gwide w) * P0 ^ t ≤ L.countP (gwide w) * (P0 - w) ^ t := by
  intro t
  induction t with
  | zero => intro M L hL _; exact ⟨L, hL, by simp⟩
  | succ t ih =>
    intro M L hL hP0
    obtain ⟨L1, hL1, hle, hstep⟩ := ggreedy_step δ (M + t) w L hL
    obtain ⟨L', hL', hb⟩ := ih M L1 hL1 (le_trans (by nlinarith) hP0)
    refine ⟨L', hL', ?_⟩
    set c := L.countP (gwide w)
    set c1 := L1.countP (gwide w)
    have hPk : (δ + (M + t) + 1) * (M + t + 1) ≤ P0 := by
      have e1 : δ + M + (t + 1) = δ + (M + t) + 1 := by omega
      have e2 : M + (t + 1) = M + t + 1 := by omega
      rw [e1, e2] at hP0; exact hP0
    have hmain : c1 * P0 + c * w ≤ c * P0 := by
      obtain ⟨d, hd⟩ : ∃ d, P0 = (δ + (M + t) + 1) * (M + t + 1) + d :=
        ⟨_, (Nat.add_sub_cancel' hPk).symm⟩
      have h4 := Nat.mul_le_mul_right d hle
      calc c1 * P0 + c * w = (c1 * ((δ + (M + t) + 1) * (M + t + 1)) + c * w) + c1 * d := by
            rw [hd]; ring
        _ ≤ c * ((δ + (M + t) + 1) * (M + t + 1)) + c * d := Nat.add_le_add hstep h4
        _ = c * P0 := by rw [hd]; ring
    have h1 : c1 * P0 ≤ c * (P0 - w) := by rw [Nat.mul_sub]; omega
    calc L'.countP (gwide w) * P0 ^ (t + 1) = (L'.countP (gwide w) * P0 ^ t) * P0 := by ring
      _ ≤ (c1 * (P0 - w) ^ t) * P0 := Nat.mul_le_mul_right _ hb
      _ = (c1 * P0) * (P0 - w) ^ t := by ring
      _ ≤ (c * (P0 - w)) * (P0 - w) ^ t := Nat.mul_le_mul_right _ h1
      _ = c * (P0 - w) ^ (t + 1) := by ring

theorem gphp_lower_aux (δ M t : ℕ) (hδ1 : 1 ≤ δ) (hδ2 : δ ≤ 2) (hM : 5 ≤ M) (ht : t ≤ M)
    (L : List (Finset (GV δ (M + t) × Bool))) (hL : IsRef (gphp δ (M + t)) L) :
    18 ^ t ≤ L.length * 17 ^ t := by
  classical
  set P0 := (δ + M + t) * (M + t)
  set w := 2 * (M + 1) ^ 2 / 9
  obtain ⟨L', hL', hb⟩ := ggreedy_iter δ w P0 t M L hL le_rfl
  obtain ⟨C, hC, hCw⟩ := gwide_line hδ1 (by omega) L' hL'
  have hwC : w ≤ (gmono C).card := by
    have := Nat.div_mul_le_self (2 * (M + 1) ^ 2) 9; simp only [w]; omega
  have hpos : 1 ≤ L'.countP (gwide w) := by
    rw [Nat.one_le_iff_ne_zero, Ne, List.countP_eq_zero]; push_neg
    exact ⟨C, hC, by simpa [gwide] using hwC⟩
  have hlen : L.countP (gwide w) ≤ L.length := List.countP_le_length
  have hkey : P0 ^ t ≤ L.length * (P0 - w) ^ t :=
    calc P0 ^ t ≤ L'.countP (gwide w) * P0 ^ t := by nlinarith [Nat.zero_le (P0 ^ t)]
      _ ≤ L.countP (gwide w) * (P0 - w) ^ t := hb
      _ ≤ L.length * (P0 - w) ^ t := Nat.mul_le_mul_right _ hlen
  have hw18 : P0 ≤ 18 * w := by
    have h9 : 2 * (M + 1) ^ 2 < 9 * (w + 1) := by
      have := Nat.lt_mul_div_succ (2 * (M + 1) ^ 2) (show 0 < 9 by norm_num)
      simp only [w]; linarith
    have hA : δ + M + t ≤ 2 * M + 2 := by omega
    have hB : M + t ≤ 2 * M := by omega
    have : P0 ≤ (2 * M + 2) * (2 * M) := Nat.mul_le_mul hA hB
    nlinarith
  have h17 : 18 * (P0 - w) ≤ 17 * P0 := by omega
  have hP0pos : 0 < P0 := by simp only [P0]; positivity
  have : P0 ^ t * 18 ^ t ≤ P0 ^ t * (L.length * 17 ^ t) :=
    calc P0 ^ t * 18 ^ t ≤ L.length * (P0 - w) ^ t * 18 ^ t := Nat.mul_le_mul_right _ hkey
      _ = L.length * (18 * (P0 - w)) ^ t := by rw [mul_pow]; ring
      _ ≤ L.length * (17 * P0) ^ t := Nat.mul_le_mul_left _ (Nat.pow_le_pow_left h17 t)
      _ = P0 ^ t * (L.length * 17 ^ t) := by rw [mul_pow]; ring
  exact Nat.le_of_mul_le_mul_left this (by positivity)

/-- **Exponential lower bound for onto-functional PHP(δ+N, N)**, `δ ∈ {1, 2}`. -/
theorem gphp_lower (δ N : ℕ) (hδ1 : 1 ≤ δ) (hδ2 : δ ≤ 2) (hN : 10 ≤ N)
    (L : List (Finset (GV δ N × Bool))) (hL : IsRef (gphp δ N) L) :
    18 ^ (N / 2) ≤ L.length * 17 ^ (N / 2) := by
  obtain ⟨M, hM⟩ : ∃ M, N = M + N / 2 := ⟨N - N / 2, by omega⟩
  have h3 : 5 ≤ M := by omega
  have h4 : N / 2 ≤ M := by omega
  generalize N / 2 = t at hM h4 ⊢
  subst hM
  exact gphp_lower_aux δ M t hδ1 hδ2 h3 h4 L hL

end QEDRes
