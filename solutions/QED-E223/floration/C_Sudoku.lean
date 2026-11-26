/-! # Abstract reduction: Sudoku CNF ↦ PHP(δ+N, N) under a restriction, and an unsat criterion -/

namespace QEDSud

open OpenProblems.QEDE223 QEDRes Finset

variable {n δ N : ℕ}

/-- `D` is a PHP line (as a set of variables). -/
def IsLine (D : Finset (GV δ N)) : Prop :=
  (∃ i, D = univ.image (fun j : Fin N => (i, j))) ∨ (∃ j, D = univ.image (fun i : Fin (δ + N) => (i, j)))

/-- The live variables of `S` are labelled bijectively onto a PHP line. -/
def Good (lv : SVar n → Option (GV δ N)) (S : Finset (SVar n)) : Prop :=
  ∃ D : Finset (GV δ N), IsLine D ∧ (∀ ℓ ∈ D, ∃ x ∈ S, lv x = some ℓ) ∧
    (∀ x ∈ S, ∀ y ∈ S, ∀ ℓ, lv x = some ℓ → lv y = some ℓ → x = y) ∧
    (∀ x ∈ S, ∀ ℓ, lv x = some ℓ → ℓ ∈ D)

/-- Hypotheses of the reduction. -/
structure Hyp (A : Set (Cell n × Fin (n ^ 2))) (lv : SVar n → Option (GV δ N)) : Prop where
  pa : IsPartialAssignment A
  val : ∀ U ∈ units n, ∀ c ∈ U, ∀ c' ∈ U, c ≠ c' → ∀ v, (c, v) ∈ A → (c', v) ∉ A
  live_blank : ∀ x ℓ, lv x = some ℓ → ∀ w, (x.1, w) ∉ A
  live_allowed : ∀ x ℓ, lv x = some ℓ → ∀ U ∈ units n, x.1 ∈ U → ∀ c' ∈ U, (c', x.2) ∉ A
  cell : ∀ c, (∀ w, (c, w) ∉ A) → Good lv (univ.image (fun v => (c, v)))
  unit : ∀ U ∈ units n, ∀ v, (∀ c ∈ U, (c, v) ∉ A) → Good lv (U.image (fun c => (c, v)))

open Classical in
/-- The restriction. -/
noncomputable def tau (A : Set (Cell n × Fin (n ^ 2))) (lv : SVar n → Option (GV δ N)) (x : SVar n) :
    GV δ N ⊕ Bool :=
  if x ∈ A then .inr true else
    match lv x with
    | some ℓ => .inl ℓ
    | none => .inr false

lemma tau_A {A : Set (Cell n × Fin (n ^ 2))} {lv : SVar n → Option (GV δ N)} {x : SVar n} (h : x ∈ A) :
    tau A lv x = .inr true := by simp [tau, h]

lemma tau_some {A : Set (Cell n × Fin (n ^ 2))} {lv : SVar n → Option (GV δ N)} {x : SVar n} {ℓ}
    (h : x ∉ A) (h' : lv x = some ℓ) : tau A lv x = .inl ℓ := by simp [tau, h, h']

lemma tau_none {A : Set (Cell n × Fin (n ^ 2))} {lv : SVar n → Option (GV δ N)} {x : SVar n}
    (h : x ∉ A) (h' : lv x = none) : tau A lv x = .inr false := by simp [tau, h, h']

lemma line_clause {D : Finset (GV δ N)} (hD : IsLine D) : D.image (fun ℓ => (ℓ, true)) ∈ gphp δ N := by
  simp only [gphp, Set.mem_union, Set.mem_setOf_eq]
  rcases hD with ⟨i, rfl⟩ | ⟨j, rfl⟩
  · exact Or.inl (Or.inl (Or.inl ⟨i, by rw [image_image]; rfl⟩))
  · exact Or.inr ⟨j, by rw [image_image]; rfl⟩

lemma line_pair {D : Finset (GV δ N)} (hD : IsLine D) {a b : GV δ N} (ha : a ∈ D) (hb : b ∈ D)
    (hab : a ≠ b) : ({(a, false), (b, false)} : Finset (GV δ N × Bool)) ∈ gphp δ N := by
  simp only [gphp, Set.mem_union, Set.mem_setOf_eq]
  rcases hD with ⟨i, rfl⟩ | ⟨j, rfl⟩
  · obtain ⟨j, -, rfl⟩ := mem_image.1 ha
    obtain ⟨j', -, rfl⟩ := mem_image.1 hb
    exact Or.inl (Or.inl (Or.inr ⟨i, j, j', fun h => hab (by rw [h]), rfl⟩))
  · obtain ⟨i, -, rfl⟩ := mem_image.1 ha
    obtain ⟨i', -, rfl⟩ := mem_image.1 hb
    exact Or.inl (Or.inr ⟨i, i', j, fun h => hab (by rw [h]), rfl⟩)

variable {A : Set (Cell n × Fin (n ^ 2))} {lv : SVar n → Option (GV δ N)}

lemma pos_clause (S : Finset (SVar n)) (hS : (∃ x ∈ S, x ∈ A) ∨ Good lv S) :
    Triv (tau A lv) (S.image (fun x => (x, true))) ∨
      ∃ D ∈ gphp δ N, D ⊆ img (tau A lv) (S.image (fun x => (x, true))) := by
  classical
  rcases hS with ⟨x, hx, hA⟩ | ⟨D, hD, hcov, -, -⟩
  · exact Or.inl (Or.inl ⟨(x, true), mem_image_of_mem _ hx, by simp [tau_A hA]⟩)
  · by_cases hA : ∃ x ∈ S, x ∈ A
    · obtain ⟨x, hx, hA⟩ := hA
      exact Or.inl (Or.inl ⟨(x, true), mem_image_of_mem _ hx, by simp [tau_A hA]⟩)
    push_neg at hA
    refine Or.inr ⟨_, line_clause hD, ?_⟩
    intro m hm
    obtain ⟨ℓ, hℓ, rfl⟩ := mem_image.1 hm
    obtain ⟨x, hx, hlx⟩ := hcov ℓ hℓ
    exact (mem_img _).2 ⟨(x, true), mem_image_of_mem _ hx, tau_some (hA x hx) hlx, rfl⟩

/-- Binary clause `¬x ∨ ¬y`. -/
lemma neg_pair (x y : SVar n)
    (hconf : x ∈ A → y ∉ A ∧ lv y = none) (hconf' : y ∈ A → x ∉ A ∧ lv x = none)
    (hboth : ∀ ℓ ℓ', x ∉ A → y ∉ A → lv x = some ℓ → lv y = some ℓ' →
      ∃ S, Good lv S ∧ x ∈ S ∧ y ∈ S) (hxy : x ≠ y) :
    Triv (tau A lv) {(x, false), (y, false)} ∨
      ∃ D ∈ gphp δ N, D ⊆ img (tau A lv) {(x, false), (y, false)} := by
  classical
  have trivx : tau A lv x = .inr false → Triv (tau A lv) {(x, false), (y, false)} :=
    fun h => Or.inl ⟨(x, false), by simp, h⟩
  have trivy : tau A lv y = .inr false → Triv (tau A lv) {(x, false), (y, false)} :=
    fun h => Or.inl ⟨(y, false), by simp, h⟩
  by_cases hxA : x ∈ A
  · obtain ⟨h1, h2⟩ := hconf hxA; exact Or.inl (trivy (tau_none h1 h2))
  by_cases hyA : y ∈ A
  · obtain ⟨h1, h2⟩ := hconf' hyA; exact Or.inl (trivx (tau_none h1 h2))
  cases hlx : lv x with
  | none => exact Or.inl (trivx (tau_none hxA hlx))
  | some ℓ =>
    cases hly : lv y with
    | none => exact Or.inl (trivy (tau_none hyA hly))
    | some ℓ' =>
      obtain ⟨S, ⟨D, hD, -, hinj, hmem⟩, hxS, hyS⟩ := hboth ℓ ℓ' hxA hyA hlx hly
      have hne : ℓ ≠ ℓ' := by
        rintro rfl; exact hxy (hinj x hxS y hyS ℓ hlx hly)
      refine Or.inr ⟨_, line_pair hD (hmem x hxS ℓ hlx) (hmem y hyS ℓ' hly) hne, ?_⟩
      intro m hm
      rcases mem_insert.1 hm with rfl | hm
      · exact (mem_img _).2 ⟨(x, false), by simp, tau_some hxA hlx, rfl⟩
      · rw [mem_singleton.1 hm]
        exact (mem_img _).2 ⟨(y, false), by simp, tau_some hyA hly, rfl⟩

theorem hax (H : Hyp A lv) : ∀ C ∈ sud n A,
    Triv (tau A lv) C ∨ ∃ D ∈ gphp δ N, D ⊆ img (tau A lv) C := by
  classical
  intro C hC
  simp only [sud, Set.mem_union, Set.mem_setOf_eq] at hC
  rcases hC with (((⟨g, hg, rfl⟩ | ⟨c, rfl⟩) | ⟨c, v, w, hvw, rfl⟩) | ⟨U, hU, c, hc, c', hc', hcc, v, rfl⟩) |
    ⟨U, hU, v, rfl⟩
  · exact Or.inl (Or.inl ⟨(g, true), by simp, by simp [tau_A hg]⟩)
  · have := pos_clause (A := A) (lv := lv) (univ.image (fun v => (c, v))) (by
      by_cases h : ∃ w, (c, w) ∈ A
      · obtain ⟨w, hw⟩ := h; exact Or.inl ⟨(c, w), by simp, hw⟩
      · push_neg at h; exact Or.inr (H.cell c h))
    rwa [image_image] at this
  · refine neg_pair (c, v) (c, w) (fun h => ⟨fun h' => hvw (H.pa c v w h h'), ?_⟩)
      (fun h => ⟨fun h' => hvw (H.pa c v w h' h), ?_⟩) ?_ (fun h => hvw (Prod.mk.inj h).2)
    · cases hl : lv (c, w) with
      | none => rfl
      | some ℓ => exact absurd h (H.live_blank _ ℓ hl v)
    · cases hl : lv (c, v) with
      | none => rfl
      | some ℓ => exact absurd h (H.live_blank _ ℓ hl w)
    · intro ℓ ℓ' _ _ hl _
      have hb := H.live_blank _ ℓ hl
      exact ⟨univ.image (fun v => (c, v)), H.cell c hb, by simp, by simp⟩
  · refine neg_pair (c, v) (c', v) (fun h => ⟨H.val U hU c hc c' hc' hcc v h, ?_⟩)
      (fun h => ⟨H.val U hU c' hc' c hc (Ne.symm hcc) v h, ?_⟩) ?_ (fun h => hcc (Prod.mk.inj h).1)
    · cases hl : lv (c', v) with
      | none => rfl
      | some ℓ => exact absurd h (H.live_allowed _ ℓ hl U hU hc' c hc)
    · cases hl : lv (c, v) with
      | none => rfl
      | some ℓ => exact absurd h (H.live_allowed _ ℓ hl U hU hc c' hc')
    · intro ℓ ℓ' _ _ hl _
      exact ⟨U.image (fun c => (c, v)), H.unit U hU v (fun c'' hc'' => H.live_allowed _ ℓ hl U hU hc c'' hc''),
        mem_image_of_mem _ hc, mem_image_of_mem _ hc'⟩
  · have := pos_clause (A := A) (lv := lv) (U.image (fun c => (c, v))) (by
      by_cases h : ∃ c ∈ U, (c, v) ∈ A
      · obtain ⟨c, hc, hcv⟩ := h; exact Or.inl ⟨(c, v), mem_image_of_mem _ hc, hcv⟩
      · push_neg at h; exact Or.inr (H.unit U hU v h))
    rwa [image_image] at this

/-- **Lower bound transfer.** -/
theorem sud_lower {N : ℕ} {lv : SVar n → Option (GV 2 N)} (H : Hyp A lv) (hN : 10 ≤ N)
    (L : List (Clause n)) (hL : IsRefutation (sud n A) L) :
    18 ^ (N / 2) ≤ L.length * 17 ^ (N / 2) := by
  classical
  have hL' : IsRef (sud n A) L := hL
  obtain ⟨M, hM, L', hsub, hf⟩ := transfer' (tau A lv) (sud n A) (gphp 2 N) (hax H) L hL'
  have h1 := gphp_lower 2 N (by norm_num) le_rfl hN M hM
  have h2 : M.length ≤ L.length := hf.length_eq.trans_le hsub.length_le
  exact h1.trans (Nat.mul_le_mul_right _ h2)

/-- **Unsatisfiability criterion**: more blank cells in a unit than the symbols they can take. -/
theorem unsat_of (U : Finset (Cell n)) (hU : U ∈ units n) (cells : Finset (Cell n)) (hcU : cells ⊆ U)
    (X : Finset (Fin (n ^ 2))) (hX : X.card < cells.card)
    (hblank : ∀ c ∈ cells, ∀ w, (c, w) ∉ A)
    (hforce : ∀ c ∈ cells, ∀ v ∉ X, ∃ U' ∈ units n, c ∈ U' ∧ ∃ c' ∈ U', (c', v) ∈ A) :
    ¬ Satisfiable (sud n A) := by
  classical
  rintro ⟨α, hα⟩
  have hgiven : ∀ g ∈ A, α g = true := by
    intro g hg
    obtain ⟨l, hl, hv⟩ := hα {(g, true)} (Or.inl (Or.inl (Or.inl (Or.inl ⟨g, hg, rfl⟩))))
    rw [mem_singleton.1 hl] at hv; exact hv
  have hunitneg : ∀ U' ∈ units n, ∀ c ∈ U', ∀ c' ∈ U', c ≠ c' → ∀ v, α (c, v) = true → α (c', v) = true →
      False := by
    intro U' hU' c hc c' hc' hcc v h1 h2
    obtain ⟨l, hl, hv⟩ := hα {((c, v), false), ((c', v), false)}
      (Or.inl (Or.inr ⟨U', hU', c, hc, c', hc', hcc, v, rfl⟩))
    rcases mem_insert.1 hl with rfl | hl
    · simp_all
    · rw [mem_singleton.1 hl] at hv; simp_all
  have hsym : ∀ c ∈ cells, ∃ v ∈ X, α (c, v) = true := by
    intro c hc
    obtain ⟨l, hl, hv⟩ := hα (univ.image (fun v => ((c, v), true)))
      (Or.inl (Or.inl (Or.inl (Or.inr ⟨c, rfl⟩))))
    obtain ⟨v, -, rfl⟩ := mem_image.1 hl
    refine ⟨v, ?_, hv⟩
    by_contra hvX
    obtain ⟨U', hU', hcU', c', hc', hA⟩ := hforce c hc v hvX
    have hne : c ≠ c' := by rintro rfl; exact hblank c hc v hA
    exact hunitneg U' hU' c hcU' c' hc' hne v hv (hgiven _ hA)
  obtain ⟨c0, hc0⟩ : cells.Nonempty := card_pos.1 (by omega)
  obtain ⟨v0, -, -⟩ := hsym c0 hc0
  haveI : Inhabited (Fin (n ^ 2)) := ⟨v0⟩
  choose! f hfX hf using hsym
  have hinj : Set.InjOn f (cells : Set (Cell n)) := by
    intro c hc c' hc' h
    by_contra hne
    exact hunitneg U hU c (hcU hc) c' (hcU hc') hne (f c) (hf c hc) (h ▸ hf c' hc')
  have := card_le_card_of_injOn f (fun c hc => hfX c hc) hinj
  omega

end QEDSud


/-! # From an `n × n` core design to the Sudoku hypotheses

The Sudoku solution is the base pattern `((o+t) % n, (b+q) % n)` for row `b n + o`, column `t n + q`;
the core cells (`o = 0`, `t = 0`) form an `n × n` Latin square on the symbols `< n` which we replace by
an incomplete design. -/

namespace QEDSud

open OpenProblems.QEDE223 QEDRes Finset

/-- A core design (all data on `ℕ`). -/
structure Core where
  blank : ℕ → ℕ → Bool
  gv : ℕ → ℕ → ℕ
  rf : ℕ → ℕ → ℕ
  cf : ℕ → ℕ → ℕ
  live : ℕ → ℕ → ℕ → Bool
  lab : ℕ → ℕ → ℕ → ℕ × ℕ

/-- `P`-positions `< n` labelled by `f` bijectively onto a line of `PHP(P0, H)`. -/
def LineN (n P0 H : ℕ) (P : ℕ → Bool) (f : ℕ → ℕ × ℕ) : Prop :=
  (∀ x < n, ∀ y < n, P x → P y → f x = f y → x = y) ∧
  ((∃ i < P0, (∀ x < n, P x → (f x).1 = i ∧ (f x).2 < H) ∧ (∀ j < H, ∃ x < n, P x ∧ f x = (i, j))) ∨
   (∃ j < H, (∀ x < n, P x → (f x).2 = j ∧ (f x).1 < P0) ∧ (∀ i < P0, ∃ x < n, P x ∧ f x = (i, j))))

/-- Correctness conditions of a core design with `PHP(H+2, H)` labels. -/
structure CoreOK (K : Core) (n H : ℕ) : Prop where
  rf_lt : ∀ r < n, ∀ c < n, K.rf r c < n
  cf_lt : ∀ r < n, ∀ c < n, K.cf r c < n
  rf_gv : ∀ r < n, ∀ c < n, K.blank r c = false → K.rf r c = K.gv r c
  cf_gv : ∀ r < n, ∀ c < n, K.blank r c = false → K.cf r c = K.gv r c
  rf_inj : ∀ r < n, ∀ c < n, ∀ c' < n, K.rf r c = K.rf r c' → c = c'
  cf_inj : ∀ c < n, ∀ r < n, ∀ r' < n, K.cf r c = K.cf r' c → r = r'
  live_ok : ∀ r c v, K.live r c v = true → r < n ∧ c < n ∧ v < n ∧ K.blank r c = true ∧
    (∀ c' < n, K.rf r c' = v → K.blank r c' = true) ∧ (∀ r' < n, K.cf r' c = v → K.blank r' c = true)
  cell : ∀ r < n, ∀ c < n, K.blank r c = true → LineN n (2 + H) H (K.live r c) (K.lab r c)
  row : ∀ r < n, ∀ c < n, K.blank r c = true →
    LineN n (2 + H) H (fun c' => K.live r c' (K.rf r c)) (fun c' => K.lab r c' (K.rf r c))
  col : ∀ r < n, ∀ c < n, K.blank r c = true →
    LineN n (2 + H) H (fun r' => K.live r' c (K.cf r c)) (fun r' => K.lab r' c (K.cf r c))
  unsat : ∃ c0 < n, ∃ Rs : Finset ℕ, H < Rs.card ∧ ∀ r ∈ Rs, r < n ∧ K.blank r c0 = true ∧
    ∀ c' < n, K.blank r c' = true → K.rf r c' < H

variable {n : ℕ}

def baseV (n R C : ℕ) : ℕ := ((R % n + C / n) % n) * n + (R / n + C % n) % n

/-- The givens, on values. -/
def givenP (K : Core) (n R C v : ℕ) : Prop :=
  if R % n = 0 ∧ C / n = 0 then K.blank (R / n) (C % n) = false ∧ v = K.gv (R / n) (C % n)
  else v = baseV n R C

def givensOf (K : Core) (n : ℕ) : Set (Cell n × Fin (n ^ 2)) :=
  {g | givenP K n g.1.1.val g.1.2.val g.2.val}

def toL (H : ℕ) (hH : 0 < H) (ℓ : ℕ × ℕ) : GV 2 H :=
  (⟨ℓ.1 % (2 + H), Nat.mod_lt _ (by omega)⟩, ⟨ℓ.2 % H, Nat.mod_lt _ hH⟩)

open Classical in
noncomputable def lvOf (K : Core) (n H : ℕ) (hH : 0 < H) (x : SVar n) : Option (GV 2 H) :=
  if x.1.1.val % n = 0 ∧ x.1.2.val / n = 0 ∧ K.live (x.1.1.val / n) (x.1.2.val % n) x.2.val = true then
    some (toL H hH (K.lab (x.1.1.val / n) (x.1.2.val % n) x.2.val))
  else none

/-! ### Arithmetic helpers -/

lemma sq_eq (n : ℕ) : n ^ 2 = n * n := by ring

lemma bn_lt {b o : ℕ} (hb : b < n) (ho : o < n) : b * n + o < n ^ 2 := by
  rw [sq_eq]; nlinarith

lemma div_lt' (R : Fin (n ^ 2)) : R.val / n < n := by
  have h : R.val < n * n := lt_of_lt_of_eq R.2 (sq_eq n)
  exact Nat.div_lt_of_lt_mul h

lemma mod_lt' (R : Fin (n ^ 2)) : R.val % n < n := by
  have := R.2
  rcases Nat.eq_zero_or_pos n with h | h
  · subst h; simp at this
  · exact Nat.mod_lt _ h

lemma npos (R : Fin (n ^ 2)) : 0 < n := by
  rcases Nat.eq_zero_or_pos n with h | h
  · subst h; exact absurd R.2 (by simp)
  · exact h

lemma bn_div {b o : ℕ} (ho : o < n) : (b * n + o) / n = b := by
  have hn : 0 < n := by omega
  rw [Nat.add_comm, Nat.add_mul_div_right _ _ hn, Nat.div_eq_of_lt ho, Nat.zero_add]

lemma bn_mod {b o : ℕ} (ho : o < n) : (b * n + o) % n = o := by
  rw [Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt ho]

lemma eq_of_div_mod {x y : ℕ} (h1 : x / n = y / n) (h2 : x % n = y % n) : x = y := by
  rw [← Nat.div_add_mod x n, ← Nat.div_add_mod y n, h1, h2]

lemma add_mod_cancel {a x y : ℕ} (hx : x < n) (hy : y < n) (h : (a + x) % n = (a + y) % n) : x = y := by
  have := Nat.ModEq.add_left_cancel' a h
  unfold Nat.ModEq at this
  rwa [Nat.mod_eq_of_lt hx, Nat.mod_eq_of_lt hy] at this

/-- Solve `(a + x) % n = β`. -/
lemma solve_mod {a β : ℕ} (ha : a < n) (hβ : β < n) : (a + (β + n - a) % n) % n = β := by
  rw [Nat.add_mod_mod]
  have : a + (β + n - a) = β + n := by omega
  rw [this, Nat.add_mod_right, Nat.mod_eq_of_lt hβ]

lemma solve_ex {a β : ℕ} (ha : a < n) (hβ : β < n) : ∃ x < n, (a + x) % n = β :=
  ⟨_, Nat.mod_lt _ (by omega), solve_mod ha hβ⟩

lemma solve_ex' {a β : ℕ} (ha : a < n) (hβ : β < n) : ∃ x < n, (x + a) % n = β := by
  obtain ⟨x, hx, h⟩ := solve_ex ha hβ; exact ⟨x, hx, by rw [Nat.add_comm]; exact h⟩

lemma baseV_lt {R C : ℕ} (hn : 0 < n) : baseV n R C < n ^ 2 := by
  unfold baseV
  exact bn_lt (Nat.mod_lt _ hn) (Nat.mod_lt _ hn)

lemma baseV_div {R C : ℕ} (hn : 0 < n) : baseV n R C / n = (R % n + C / n) % n := by
  unfold baseV; exact bn_div (Nat.mod_lt _ hn)

lemma baseV_mod {R C : ℕ} (hn : 0 < n) : baseV n R C % n = (R / n + C % n) % n := by
  unfold baseV; exact bn_mod (Nat.mod_lt _ hn)

/-! ### Witnesses that a symbol is given -/

variable {K : Core} {H : ℕ}

/-- A non-core cell with prescribed base value. -/
lemma given_base (R C : Fin (n ^ 2)) (v : Fin (n ^ 2)) (hnc : ¬ (R.val % n = 0 ∧ C.val / n = 0))
    (h1 : (R.val % n + C.val / n) % n = v.val / n) (h2 : (R.val / n + C.val % n) % n = v.val % n) :
    ((R, C), v) ∈ givensOf K n := by
  show givenP K n R.val C.val v.val
  unfold givenP
  rw [if_neg hnc]
  unfold baseV
  rw [h1, h2]; exact (Nat.div_add_mod' _ _).symm

def mkF {b o : ℕ} (hb : b < n) (ho : o < n) : Fin (n ^ 2) := ⟨b * n + o, bn_lt hb ho⟩

lemma one_le_div {v : ℕ} (hn : 0 < n) (hv : n ≤ v) : 1 ≤ v / n := (Nat.le_div_iff_mul_le hn).2 (by omega)

/-- In row `R`, every symbol of value `≥ n` (or every symbol if `R` is not a core row) is given. -/
lemma row_witness (R v : Fin (n ^ 2)) (hv : R.val % n ≠ 0 ∨ n ≤ v.val) :
    ∃ C : Fin (n ^ 2), ((R, C), v) ∈ givensOf K n := by
  have hn := npos R
  obtain ⟨t, ht, htv⟩ := solve_ex (mod_lt' R) (div_lt' v)
  obtain ⟨q, hq, hqv⟩ := solve_ex (div_lt' R) (mod_lt' v)
  refine ⟨⟨t * n + q, bn_lt ht hq⟩, given_base _ _ _ ?_ ?_ ?_⟩
  · simp only [bn_div hq]
    rintro ⟨h1, h2⟩
    rcases hv with hv | hv
    · exact hv h1
    · rw [h1, h2] at htv; have := one_le_div hn hv; simp at htv; omega
  · simp only [bn_div hq]; exact htv
  · simp only [bn_mod hq]; exact hqv

lemma col_witness (C v : Fin (n ^ 2)) (hv : C.val / n ≠ 0 ∨ n ≤ v.val) :
    ∃ R : Fin (n ^ 2), ((R, C), v) ∈ givensOf K n := by
  have hn := npos C
  obtain ⟨o, ho, hov⟩ := solve_ex' (div_lt' C) (div_lt' v)
  obtain ⟨b, hb, hbv⟩ := solve_ex' (mod_lt' C) (mod_lt' v)
  refine ⟨⟨b * n + o, bn_lt hb ho⟩, given_base _ _ _ ?_ ?_ ?_⟩
  · simp only [bn_mod ho]
    rintro ⟨h1, h2⟩
    rcases hv with hv | hv
    · exact hv h2
    · rw [h1, h2] at hov; have := one_le_div hn hv; simp at hov; omega
  · simp only [bn_mod ho]; exact hov
  · simp only [bn_div ho]; exact hbv

lemma box_witness (i j : Fin n) (v : Fin (n ^ 2)) (hv : j.val ≠ 0 ∨ n ≤ v.val) :
    ∃ R C : Fin (n ^ 2), R.val / n = i.val ∧ C.val / n = j.val ∧ ((R, C), v) ∈ givensOf K n := by
  have hn : 0 < n := by have := i.2; omega
  obtain ⟨o, ho, hov⟩ := solve_ex' j.2 (div_lt' v)
  obtain ⟨q, hq, hqv⟩ := solve_ex i.2 (mod_lt' v)
  refine ⟨⟨i.val * n + o, bn_lt i.2 ho⟩, ⟨j.val * n + q, bn_lt j.2 hq⟩,
    bn_div ho, bn_div hq, given_base _ _ _ ?_ ?_ ?_⟩
  · simp only [bn_mod ho, bn_div hq]
    rintro ⟨h1, h2⟩
    rcases hv with hv | hv
    · exact hv h2
    · rw [h1, h2] at hov; have := one_le_div hn hv; simp at hov; omega
  · simp only [bn_mod ho, bn_div hq]; exact hov
  · simp only [bn_div ho, bn_mod hq]; exact hqv

/-! ### Lines to `Good` -/

lemma toL_inj {H : ℕ} (hH : 0 < H) {a b : ℕ × ℕ} (ha1 : a.1 < 2 + H) (ha2 : a.2 < H) (hb1 : b.1 < 2 + H)
    (hb2 : b.2 < H) (h : toL H hH a = toL H hH b) : a = b := by
  simp only [toL, Prod.mk.injEq, Fin.mk.injEq] at h
  rw [Nat.mod_eq_of_lt ha1, Nat.mod_eq_of_lt hb1, Nat.mod_eq_of_lt ha2, Nat.mod_eq_of_lt hb2] at h
  exact Prod.ext h.1 h.2

lemma good_of_line (hH : 0 < H) (S : Finset (SVar n)) (e : ℕ → SVar n) (P : ℕ → Bool) (f : ℕ → ℕ × ℕ)
    (hl : LineN n (2 + H) H P f)
    (he : ∀ x < n, P x = true → e x ∈ S ∧ lvOf K n H hH (e x) = some (toL H hH (f x)))
    (hS : ∀ y ∈ S, ∀ ℓ, lvOf K n H hH y = some ℓ → ∃ x < n, P x = true ∧ y = e x) :
    Good (lvOf K n H hH) S := by
  classical
  obtain ⟨hinj, hl⟩ := hl
  have bnd : ∀ x < n, P x = true → (f x).1 < 2 + H ∧ (f x).2 < H := by
    intro x hx hP
    rcases hl with ⟨i, hi, h1, -⟩ | ⟨j, hj, h1, -⟩
    · obtain ⟨a, b⟩ := h1 x hx hP; exact ⟨a ▸ hi, b⟩
    · obtain ⟨a, b⟩ := h1 x hx hP; exact ⟨b, a ▸ hj⟩
  have inj' : ∀ y ∈ S, ∀ y' ∈ S, ∀ ℓ, lvOf K n H hH y = some ℓ → lvOf K n H hH y' = some ℓ → y = y' := by
    intro y hy y' hy' ℓ h1 h2
    obtain ⟨x, hx, hP, rfl⟩ := hS y hy ℓ h1
    obtain ⟨x', hx', hP', rfl⟩ := hS y' hy' ℓ h2
    rw [(he x hx hP).2] at h1; rw [(he x' hx' hP').2] at h2
    have := Option.some.inj (h1.trans h2.symm)
    have hb := bnd x hx hP; have hb' := bnd x' hx' hP'
    rw [hinj x hx x' hx' hP hP' (toL_inj hH hb.1 hb.2 hb'.1 hb'.2 this)]
  rcases hl with ⟨i, hi, h1, h2⟩ | ⟨j, hj, h1, h2⟩
  · refine ⟨univ.image (fun b : Fin H => ((⟨i, hi⟩ : Fin (2 + H)), b)), Or.inl ⟨_, rfl⟩, ?_, inj', ?_⟩
    · intro ℓ hℓ
      obtain ⟨b, -, rfl⟩ := mem_image.1 hℓ
      obtain ⟨x, hx, hP, hf⟩ := h2 b.val b.2
      refine ⟨e x, (he x hx hP).1, ?_⟩
      rw [(he x hx hP).2, hf]
      simp [toL, Nat.mod_eq_of_lt hi, Nat.mod_eq_of_lt b.2]
    · intro y hy ℓ hℓ
      obtain ⟨x, hx, hP, rfl⟩ := hS y hy ℓ hℓ
      rw [(he x hx hP).2] at hℓ
      cases hℓ
      obtain ⟨ha, hb⟩ := h1 x hx hP
      refine mem_image.2 ⟨⟨(f x).2, hb⟩, mem_univ _, ?_⟩
      simp [toL, ha, Nat.mod_eq_of_lt hi, Nat.mod_eq_of_lt hb]
  · refine ⟨univ.image (fun a : Fin (2 + H) => (a, (⟨j, hj⟩ : Fin H))), Or.inr ⟨_, rfl⟩, ?_, inj', ?_⟩
    · intro ℓ hℓ
      obtain ⟨a, -, rfl⟩ := mem_image.1 hℓ
      obtain ⟨x, hx, hP, hf⟩ := h2 a.val a.2
      refine ⟨e x, (he x hx hP).1, ?_⟩
      rw [(he x hx hP).2, hf]
      simp [toL, Nat.mod_eq_of_lt hj, Nat.mod_eq_of_lt a.2]
    · intro y hy ℓ hℓ
      obtain ⟨x, hx, hP, rfl⟩ := hS y hy ℓ hℓ
      rw [(he x hx hP).2] at hℓ
      cases hℓ
      obtain ⟨hb, ha⟩ := h1 x hx hP
      refine mem_image.2 ⟨⟨(f x).1, ha⟩, mem_univ _, ?_⟩
      simp [toL, hb, Nat.mod_eq_of_lt hj, Nat.mod_eq_of_lt ha]

/-! ### Core facts -/

lemma mem_givens {R C v : Fin (n ^ 2)} : ((R, C), v) ∈ givensOf K n ↔ givenP K n R.val C.val v.val := Iff.rfl

lemma lvOf_some {hH : 0 < H} {x : SVar n} {ℓ} (h : lvOf K n H hH x = some ℓ) :
    x.1.1.val % n = 0 ∧ x.1.2.val / n = 0 ∧ K.live (x.1.1.val / n) (x.1.2.val % n) x.2.val = true := by
  unfold lvOf at h; split_ifs at h with h1; exact h1

lemma lvOf_eq {hH : 0 < H} {x : SVar n} (h1 : x.1.1.val % n = 0) (h2 : x.1.2.val / n = 0)
    (h3 : K.live (x.1.1.val / n) (x.1.2.val % n) x.2.val = true) :
    lvOf K n H hH x = some (toL H hH (K.lab (x.1.1.val / n) (x.1.2.val % n) x.2.val)) := by
  unfold lvOf; rw [if_pos ⟨h1, h2, h3⟩]

/-- Rows are `R = (R/n) n + R % n`. -/
lemma val_eq (R : ℕ) : R = R / n * n + R % n := (Nat.div_add_mod' R n).symm

/-- In a unit through a core cell, a given symbol `< n` sits at a core cell. -/
lemma core_of_small {R C : ℕ} {v : ℕ} (hn : 0 < n) (hR : R / n < n) (hC : C / n < n)
    (hv : v < n) (hg : givenP K n R C v) (hcore : R % n = 0 ∨ C / n = 0) : R % n = 0 ∧ C / n = 0 := by
  unfold givenP at hg
  split_ifs at hg with h
  · exact h
  · exfalso
    have h1 : v / n = (R % n + C / n) % n := by rw [hg]; exact baseV_div hn
    rw [Nat.div_eq_of_lt hv] at h1
    have hRm := Nat.mod_lt R hn
    rcases hcore with h0 | h0
    · rw [h0, Nat.zero_add, Nat.mod_eq_of_lt hC] at h1; exact h ⟨h0, h1.symm⟩
    · rw [h0, Nat.add_zero, Nat.mod_mod] at h1; exact h ⟨h1.symm, h0⟩

variable (hok : CoreOK K n H)
include hok

lemma rf_surj {b v : ℕ} (hb : b < n) (hv : v < n) : ∃ q < n, K.rf b q = v := by
  classical
  have hmaps : ∀ q ∈ range n, K.rf b q ∈ range n := fun q hq => mem_range.2 (hok.rf_lt b hb q (mem_range.1 hq))
  have hinj : Set.InjOn (K.rf b) (range n : Set ℕ) := fun q hq q' hq' h =>
    hok.rf_inj b hb q (mem_range.1 hq) q' (mem_range.1 hq') h
  have himg : (range n).image (K.rf b) = range n :=
    eq_of_subset_of_card_le (fun x hx => by obtain ⟨q, hq, rfl⟩ := mem_image.1 hx; exact hmaps q hq)
      (by rw [card_image_of_injOn hinj])
  have : v ∈ (range n).image (K.rf b) := by rw [himg]; exact mem_range.2 hv
  obtain ⟨q, hq, h⟩ := mem_image.1 this
  exact ⟨q, mem_range.1 hq, h⟩

lemma cf_surj {c v : ℕ} (hc : c < n) (hv : v < n) : ∃ r < n, K.cf r c = v := by
  classical
  have hmaps : ∀ r ∈ range n, K.cf r c ∈ range n := fun r hr => mem_range.2 (hok.cf_lt r (mem_range.1 hr) c hc)
  have hinj : Set.InjOn (fun r => K.cf r c) (range n : Set ℕ) := fun r hr r' hr' h =>
    hok.cf_inj c hc r (mem_range.1 hr) r' (mem_range.1 hr') h
  have himg : (range n).image (fun r => K.cf r c) = range n :=
    eq_of_subset_of_card_le (fun x hx => by obtain ⟨r, hr, rfl⟩ := mem_image.1 hx; exact hmaps r hr)
      (by rw [card_image_of_injOn hinj])
  have : v ∈ (range n).image (fun r => K.cf r c) := by rw [himg]; exact mem_range.2 hv
  obtain ⟨r, hr, h⟩ := mem_image.1 this
  exact ⟨r, mem_range.1 hr, h⟩

end QEDSud


namespace QEDSud

open OpenProblems.QEDE223 QEDRes Finset

variable {n H : ℕ} {K : Core}

lemma core_given {R C v : ℕ} (hok : CoreOK K n H) (hR : R / n < n) (hC : C % n < n)
    (hcore : R % n = 0 ∧ C / n = 0) (hg : givenP K n R C v) :
    K.blank (R / n) (C % n) = false ∧ v = K.rf (R / n) (C % n) ∧ v < n := by
  unfold givenP at hg; rw [if_pos hcore] at hg
  refine ⟨hg.1, ?_, ?_⟩
  · rw [hok.rf_gv _ hR _ hC hg.1]; exact hg.2
  · rw [hg.2, ← hok.rf_gv _ hR _ hC hg.1]; exact hok.rf_lt _ hR _ hC

lemma core_given' {R C v : ℕ} (hok : CoreOK K n H) (hR : R / n < n) (hC : C % n < n)
    (hcore : R % n = 0 ∧ C / n = 0) (hg : givenP K n R C v) : v = K.cf (R / n) (C % n) := by
  unfold givenP at hg; rw [if_pos hcore] at hg
  rw [hok.cf_gv _ hR _ hC hg.1]; exact hg.2

lemma base_given {R C v : ℕ} (hcore : ¬ (R % n = 0 ∧ C / n = 0)) (hg : givenP K n R C v) : v = baseV n R C := by
  unfold givenP at hg; rwa [if_neg hcore] at hg

lemma baseV_eq {R C R' C' : ℕ} (hn : 0 < n) (h : baseV n R C = baseV n R' C') :
    (R % n + C / n) % n = (R' % n + C' / n) % n ∧ (R / n + C % n) % n = (R' / n + C' % n) % n := by
  constructor
  · rw [← baseV_div hn, ← baseV_div hn, h]
  · rw [← baseV_mod hn, ← baseV_mod hn, h]

lemma cell_ext {c c' : Cell n} (h1 : c.1.val / n = c'.1.val / n) (h2 : c.1.val % n = c'.1.val % n)
    (h3 : c.2.val / n = c'.2.val / n) (h4 : c.2.val % n = c'.2.val % n) : c = c' :=
  Prod.ext (Fin.ext (eq_of_div_mod h1 h2)) (Fin.ext (eq_of_div_mod h3 h4))

lemma A_row (hok : CoreOK K n H) {c c' : Cell n} {v : Fin (n ^ 2)} (h : (c, v) ∈ givensOf K n)
    (h' : (c', v) ∈ givensOf K n) (hr : c.1 = c'.1) : c = c' := by
  have hn := npos c.1
  have hR := div_lt' c.1; have hC := mod_lt' c.2; have hC' := mod_lt' c'.2
  have hCd := div_lt' c.2; have hCd' := div_lt' c'.2
  rw [mem_givens] at h h'
  rw [← hr] at h'
  refine cell_ext (by rw [hr]) (by rw [hr]) ?_ ?_
  · by_cases hc : c.1.val % n = 0 ∧ c.2.val / n = 0
    · obtain ⟨-, h1, hv⟩ := core_given hok hR hC hc h
      have hc' := core_of_small hn hR hCd' hv h' (Or.inl hc.1)
      rw [hc.2, hc'.2]
    · by_cases hc' : c.1.val % n = 0 ∧ c'.2.val / n = 0
      · obtain ⟨-, h1, hv⟩ := core_given hok hR hC' hc' h'
        exact absurd (core_of_small hn hR hCd hv h (Or.inl hc'.1)) hc
      · have := (baseV_eq hn ((base_given hc h).symm.trans (base_given hc' h'))).1
        exact add_mod_cancel hCd hCd' this
  · by_cases hc : c.1.val % n = 0 ∧ c.2.val / n = 0
    · obtain ⟨hb, h1, hv⟩ := core_given hok hR hC hc h
      have hc' := core_of_small hn hR hCd' hv h' (Or.inl hc.1)
      obtain ⟨hb', h1', -⟩ := core_given hok hR hC' hc' h'
      exact hok.rf_inj _ hR _ hC _ hC' (h1.symm.trans h1')
    · by_cases hc' : c.1.val % n = 0 ∧ c'.2.val / n = 0
      · obtain ⟨-, h1, hv⟩ := core_given hok hR hC' hc' h'
        exact absurd (core_of_small hn hR hCd hv h (Or.inl hc'.1)) hc
      · have := (baseV_eq hn ((base_given hc h).symm.trans (base_given hc' h'))).2
        exact add_mod_cancel hC hC' this

lemma A_col (hok : CoreOK K n H) {c c' : Cell n} {v : Fin (n ^ 2)} (h : (c, v) ∈ givensOf K n)
    (h' : (c', v) ∈ givensOf K n) (hk : c.2 = c'.2) : c = c' := by
  have hn := npos c.1
  have hR := div_lt' c.1; have hR' := div_lt' c'.1; have hC := mod_lt' c.2
  have hCd := div_lt' c.2
  have hRm := mod_lt' c.1; have hRm' := mod_lt' c'.1
  rw [mem_givens] at h h'
  rw [← hk] at h'
  refine cell_ext ?_ ?_ (by rw [hk]) (by rw [hk])
  · by_cases hc : c.1.val % n = 0 ∧ c.2.val / n = 0
    · obtain ⟨-, -, hv⟩ := core_given hok hR hC hc h
      have hc' := core_of_small hn hR' hCd hv h' (Or.inr hc.2)
      have e1 := core_given' hok hR hC hc h
      have e2 := core_given' hok hR' hC hc' h'
      exact hok.cf_inj _ hC _ hR _ hR' (e1.symm.trans e2)
    · by_cases hc' : c'.1.val % n = 0 ∧ c.2.val / n = 0
      · obtain ⟨-, -, hv⟩ := core_given hok hR' hC hc' h'
        exact absurd (core_of_small hn hR hCd hv h (Or.inr hc'.2)) hc
      · have := (baseV_eq hn ((base_given hc h).symm.trans (base_given hc' h'))).2
        rw [Nat.add_comm (c.1.val / n), Nat.add_comm (c'.1.val / n)] at this
        exact add_mod_cancel hR hR' this
  · by_cases hc : c.1.val % n = 0 ∧ c.2.val / n = 0
    · obtain ⟨-, -, hv⟩ := core_given hok hR hC hc h
      have hc' := core_of_small hn hR' hCd hv h' (Or.inr hc.2)
      rw [hc.1, hc'.1]
    · by_cases hc' : c'.1.val % n = 0 ∧ c.2.val / n = 0
      · obtain ⟨-, -, hv⟩ := core_given hok hR' hC hc' h'
        exact absurd (core_of_small hn hR hCd hv h (Or.inr hc'.2)) hc
      · have := (baseV_eq hn ((base_given hc h).symm.trans (base_given hc' h'))).1
        rw [Nat.add_comm (c.1.val % n), Nat.add_comm (c'.1.val % n)] at this
        exact add_mod_cancel hRm hRm' this

lemma A_box (hok : CoreOK K n H) {c c' : Cell n} {v : Fin (n ^ 2)} (h : (c, v) ∈ givensOf K n)
    (h' : (c', v) ∈ givensOf K n) (hi : c.1.val / n = c'.1.val / n) (hj : c.2.val / n = c'.2.val / n) :
    c = c' := by
  have hn := npos c.1
  have hR := div_lt' c.1; have hR' := div_lt' c'.1; have hC := mod_lt' c.2; have hC' := mod_lt' c'.2
  have hCd := div_lt' c.2; have hCd' := div_lt' c'.2
  have hRm := mod_lt' c.1; have hRm' := mod_lt' c'.1
  rw [mem_givens] at h h'
  by_cases hc : c.1.val % n = 0 ∧ c.2.val / n = 0
  · obtain ⟨-, e1, hv⟩ := core_given hok hR hC hc h
    have hc' := core_of_small hn hR' hCd' hv h' (Or.inr (hj ▸ hc.2))
    obtain ⟨-, e2, -⟩ := core_given hok hR' hC' hc' h'
    rw [← hi] at e2
    exact cell_ext hi (by rw [hc.1, hc'.1]) hj (hok.rf_inj _ hR _ hC _ hC' (e1.symm.trans e2))
  · by_cases hc' : c'.1.val % n = 0 ∧ c'.2.val / n = 0
    · obtain ⟨-, -, hv⟩ := core_given hok hR' hC' hc' h'
      exact absurd (core_of_small hn hR hCd hv h (Or.inr (hj.symm ▸ hc'.2))) hc
    · have := baseV_eq hn ((base_given hc h).symm.trans (base_given hc' h'))
      rw [hj, hi] at this
      rw [Nat.add_comm (c.1.val % n), Nat.add_comm (c'.1.val % n)] at this
      exact cell_ext hi (add_mod_cancel hRm hRm' this.1) hj (add_mod_cancel hC hC' this.2)

lemma unit_cases {U : Finset (Cell n)} (hU : U ∈ units n) :
    (∃ r, ∀ c, c ∈ U ↔ c.1 = r) ∨ (∃ k, ∀ c, c ∈ U ↔ c.2 = k) ∨
    (∃ i j : Fin n, ∀ c, c ∈ U ↔ c.1.val / n = i.val ∧ c.2.val / n = j.val) := by
  simp only [units, Set.mem_union, Set.mem_setOf_eq] at hU
  rcases hU with (⟨r, rfl⟩ | ⟨k, rfl⟩) | ⟨i, j, rfl⟩
  · exact Or.inl ⟨r, fun c => by simp⟩
  · exact Or.inr (Or.inl ⟨k, fun c => by simp⟩)
  · exact Or.inr (Or.inr ⟨i, j, fun c => by simp⟩)

theorem hyp_val (hok : CoreOK K n H) : ∀ U ∈ units n, ∀ c ∈ U, ∀ c' ∈ U, c ≠ c' → ∀ v,
    (c, v) ∈ givensOf K n → (c', v) ∉ givensOf K n := by
  intro U hU c hc c' hc' hne v h h'
  rcases unit_cases hU with ⟨r, hr⟩ | ⟨k, hk⟩ | ⟨i, j, hij⟩
  · exact hne (A_row hok h h' (((hr c).1 hc).trans ((hr c').1 hc').symm))
  · exact hne (A_col hok h h' (((hk c).1 hc).trans ((hk c').1 hc').symm))
  · obtain ⟨a1, a2⟩ := (hij c).1 hc
    obtain ⟨b1, b2⟩ := (hij c').1 hc'
    exact hne (A_box hok h h' (a1.trans b1.symm) (a2.trans b2.symm))

end QEDSud


namespace QEDSud

open OpenProblems.QEDE223 QEDRes Finset

variable {n H : ℕ} {K : Core}

lemma core_pos {x : SVar n} (h1 : x.1.1.val % n = 0) (h2 : x.1.2.val / n = 0) :
    x.1.1.val = x.1.1.val / n * n ∧ x.1.2.val = x.1.2.val % n := by
  constructor
  · conv_lhs => rw [val_eq (n := n) x.1.1.val, h1]
    simp
  · conv_lhs => rw [val_eq (n := n) x.1.2.val, h2]; simp

theorem hyp_live_blank (hok : CoreOK K n H) (hH : 0 < H) :
    ∀ x ℓ, lvOf K n H hH x = some ℓ → ∀ w, (x.1, w) ∉ givensOf K n := by
  intro x ℓ hx w hw
  obtain ⟨h1, h2, h3⟩ := lvOf_some hx
  have hb := (hok.live_ok _ _ _ h3).2.2.2.1
  rw [mem_givens] at hw
  unfold givenP at hw; rw [if_pos ⟨h1, h2⟩] at hw
  rw [hb] at hw; exact Bool.noConfusion hw.1

theorem hyp_live_allowed (hok : CoreOK K n H) (hH : 0 < H) :
    ∀ x ℓ, lvOf K n H hH x = some ℓ → ∀ U ∈ units n, x.1 ∈ U → ∀ c' ∈ U, (c', x.2) ∉ givensOf K n := by
  intro x ℓ hx U hU hxU c' hc' hg
  obtain ⟨h1, h2, h3⟩ := lvOf_some hx
  have hn := npos x.1.1
  obtain ⟨-, -, hv, -, hrow, hcol⟩ := hok.live_ok _ _ _ h3
  rw [mem_givens] at hg
  have hR' := div_lt' c'.1; have hC' := mod_lt' c'.2; have hCd' := div_lt' c'.2
  rcases unit_cases hU with ⟨r, hr⟩ | ⟨k, hk⟩ | ⟨i, j, hij⟩
  · have e : c'.1 = x.1.1 := ((hr c').1 hc').trans ((hr x.1).1 hxU).symm
    rw [e] at hg hR'
    have hc := core_of_small hn hR' hCd' hv hg (Or.inl h1)
    obtain ⟨hb, he, -⟩ := core_given hok hR' hC' hc hg
    have := hrow _ hC' he.symm
    rw [hb] at this; exact Bool.noConfusion this
  · have e : c'.2 = x.1.2 := ((hk c').1 hc').trans ((hk x.1).1 hxU).symm
    rw [e] at hg hC' hCd'
    have hc := core_of_small hn hR' hCd' hv hg (Or.inr h2)
    have he := core_given' hok hR' hC' hc hg
    have hb := (core_given hok hR' hC' hc hg).1
    have := hcol _ hR' he.symm
    rw [hb] at this; exact Bool.noConfusion this
  · obtain ⟨a1, a2⟩ := (hij c').1 hc'
    obtain ⟨b1, b2⟩ := (hij x.1).1 hxU
    have hc := core_of_small hn hR' hCd' hv hg (Or.inr (a2.trans (b2.symm.trans h2)))
    obtain ⟨hb, he, -⟩ := core_given hok hR' hC' hc hg
    rw [a1, ← b1] at hb he
    have := hrow _ hC' he.symm
    rw [hb] at this; exact Bool.noConfusion this

theorem hyp_cell (hok : CoreOK K n H) (hH : 0 < H) :
    ∀ c, (∀ w, (c, w) ∉ givensOf K n) → Good (lvOf K n H hH) (univ.image (fun v => (c, v))) := by
  intro c hc
  have hn := npos c.1
  have hR := div_lt' c.1; have hC := mod_lt' c.2
  have hcore : c.1.val % n = 0 ∧ c.2.val / n = 0 := by
    by_contra h
    exact hc ⟨_, baseV_lt hn⟩ (by rw [mem_givens]; unfold givenP; rw [if_neg h])
  have hnn : n ≤ n ^ 2 := by rw [sq_eq]; nlinarith
  have hbl : K.blank (c.1.val / n) (c.2.val % n) = true := by
    by_contra h
    simp only [Bool.not_eq_true] at h
    have hv := hok.rf_lt _ hR _ hC
    have : K.gv (c.1.val / n) (c.2.val % n) < n ^ 2 := by
      rw [← hok.rf_gv _ hR _ hC h]; exact lt_of_lt_of_le hv hnn
    exact hc ⟨_, this⟩ (by rw [mem_givens]; unfold givenP; rw [if_pos hcore]; exact ⟨h, rfl⟩)
  refine good_of_line hH _ (fun x => (c, ⟨x % n ^ 2, Nat.mod_lt _ (by omega)⟩)) _ _
    (hok.cell _ hR _ hC hbl) ?_ ?_
  · intro x hx hP
    refine ⟨mem_image.2 ⟨_, mem_univ _, rfl⟩, ?_⟩
    have : x % n ^ 2 = x := Nat.mod_eq_of_lt (by omega)
    rw [lvOf_eq hcore.1 hcore.2 (by simp only [this]; exact hP)]
    simp only [this]
  · intro y hy ℓ hl
    obtain ⟨v, -, rfl⟩ := mem_image.1 hy
    obtain ⟨-, -, h3⟩ := lvOf_some hl
    have hv := (hok.live_ok _ _ _ h3).2.2.1
    refine ⟨v.val, hv, h3, ?_⟩
    simp [Nat.mod_eq_of_lt v.2]

end QEDSud


namespace QEDSud

open OpenProblems.QEDE223 QEDRes Finset

variable {n H : ℕ} {K : Core}

def mkC (hn : 0 < n) (a : ℕ) : Fin (n ^ 2) := ⟨a % n ^ 2, Nat.mod_lt _ (by positivity)⟩

lemma mkC_val (hn : 0 < n) {a : ℕ} (ha : a < n ^ 2) : (mkC hn a).val = a := Nat.mod_eq_of_lt ha

lemma lt_sq {x : ℕ} (hx : x < n) : x < n ^ 2 := by rw [sq_eq]; nlinarith

lemma xn_lt {x : ℕ} (hx : x < n) : x * n < n ^ 2 := by rw [sq_eq]; nlinarith

theorem hyp_unit (hok : CoreOK K n H) (hH : 0 < H) :
    ∀ U ∈ units n, ∀ v, (∀ c ∈ U, (c, v) ∉ givensOf K n) →
      Good (lvOf K n H hH) (U.image (fun c => (c, v))) := by
  intro U hU v hnot
  have hn := npos v
  rcases unit_cases hU with ⟨r, hr⟩ | ⟨k, hk⟩ | ⟨i, j, hij⟩
  · by_cases hw : r.val % n ≠ 0 ∨ n ≤ v.val
    · obtain ⟨C, hC⟩ := row_witness (K := K) r v hw
      exact absurd hC (hnot _ ((hr _).2 rfl))
    push_neg at hw
    obtain ⟨hr0, hv⟩ := hw
    have hb := div_lt' r
    obtain ⟨q, hq, hqv⟩ := rf_surj hok hb hv
    have hbl : K.blank (r.val / n) q = true := by
      by_contra h; simp only [Bool.not_eq_true] at h
      apply hnot (r, mkC hn q) ((hr _).2 rfl)
      rw [mem_givens]; unfold givenP
      rw [mkC_val hn (lt_sq hq), Nat.div_eq_of_lt hq, Nat.mod_eq_of_lt hq, if_pos ⟨hr0, rfl⟩]
      exact ⟨h, by rw [← hok.rf_gv _ hb _ hq h, hqv]⟩
    have hl := hok.row _ hb _ hq hbl
    rw [hqv] at hl
    refine good_of_line hH _ (fun x => ((r, mkC hn x), v)) _ _ hl ?_ ?_
    · intro x hx hP
      refine ⟨mem_image.2 ⟨_, (hr _).2 rfl, rfl⟩, ?_⟩
      have e1 := mkC_val hn (lt_sq hx)
      rw [lvOf_eq (by exact hr0) (by simp only [e1]; exact Nat.div_eq_of_lt hx)
        (by simp only [e1, Nat.mod_eq_of_lt hx]; exact hP)]
      simp only [e1, Nat.mod_eq_of_lt hx]
    · intro y hy ℓ hl'
      obtain ⟨c, hc, rfl⟩ := mem_image.1 hy
      obtain ⟨h1, h2, h3⟩ := lvOf_some hl'
      have hc1 : c.1 = r := (hr c).1 hc
      have hcv : c.2.val = c.2.val % n := (core_pos (x := (c, v)) h1 h2).2
      refine ⟨c.2.val % n, mod_lt' c.2, by rw [← hc1]; exact h3, ?_⟩
      simp only [Prod.mk.injEq, and_true]
      refine Prod.ext hc1 (Fin.ext ?_)
      rw [mkC_val hn (lt_sq (mod_lt' c.2))]; exact hcv
  · by_cases hw : k.val / n ≠ 0 ∨ n ≤ v.val
    · obtain ⟨R, hR⟩ := col_witness (K := K) k v hw
      exact absurd hR (hnot _ ((hk _).2 rfl))
    push_neg at hw
    obtain ⟨hk0, hv⟩ := hw
    have hq := mod_lt' k
    have hkq : k.val % n = k.val := by rw [Nat.mod_eq_of_lt]; exact (Nat.div_eq_zero_iff_lt hn).1 hk0
    obtain ⟨r0, hr0, hrv⟩ := cf_surj hok hq hv
    have hbl : K.blank r0 (k.val % n) = true := by
      by_contra h; simp only [Bool.not_eq_true] at h
      apply hnot (mkC hn (r0 * n), k) ((hk _).2 rfl)
      rw [mem_givens]; unfold givenP
      rw [mkC_val hn (xn_lt hr0), Nat.mul_div_cancel _ hn, Nat.mul_mod_left, if_pos ⟨rfl, hk0⟩]
      exact ⟨h, by rw [← hok.cf_gv _ hr0 _ hq h, hrv]⟩
    have hl := hok.col _ hr0 _ hq hbl
    rw [hrv] at hl
    refine good_of_line hH _ (fun x => ((mkC hn (x * n), k), v)) _ _ hl ?_ ?_
    · intro x hx hP
      refine ⟨mem_image.2 ⟨_, (hk _).2 rfl, rfl⟩, ?_⟩
      have e1 := mkC_val hn (xn_lt hx)
      rw [lvOf_eq (by simp only [e1]; exact Nat.mul_mod_left _ _) (by exact hk0)
        (by simp only [e1, Nat.mul_div_cancel _ hn]; exact hP)]
      simp only [e1, Nat.mul_div_cancel _ hn]
    · intro y hy ℓ hl'
      obtain ⟨c, hc, rfl⟩ := mem_image.1 hy
      obtain ⟨h1, h2, h3⟩ := lvOf_some hl'
      have hc2 : c.2 = k := (hk c).1 hc
      have hcv : c.1.val = c.1.val / n * n := (core_pos (x := (c, v)) h1 h2).1
      refine ⟨c.1.val / n, div_lt' c.1, by rw [← hc2]; exact h3, ?_⟩
      simp only [Prod.mk.injEq, and_true]
      refine Prod.ext (Fin.ext ?_) hc2
      rw [mkC_val hn (xn_lt (div_lt' c.1))]; exact hcv
  · by_cases hw : j.val ≠ 0 ∨ n ≤ v.val
    · obtain ⟨R, C, h1, h2, hRC⟩ := box_witness (K := K) i j v hw
      exact absurd hRC (hnot _ ((hij _).2 ⟨h1, h2⟩))
    push_neg at hw
    obtain ⟨hj0, hv⟩ := hw
    obtain ⟨q, hq, hqv⟩ := rf_surj hok i.2 hv
    have hin := xn_lt i.2
    have hbl : K.blank i.val q = true := by
      by_contra h; simp only [Bool.not_eq_true] at h
      apply hnot (mkC hn (i.val * n), mkC hn q)
        ((hij _).2 ⟨by rw [mkC_val hn hin, Nat.mul_div_cancel _ hn],
          by rw [mkC_val hn (lt_sq hq), Nat.div_eq_of_lt hq, hj0]⟩)
      rw [mem_givens]; unfold givenP
      rw [mkC_val hn hin, mkC_val hn (lt_sq hq), Nat.mul_div_cancel _ hn, Nat.mul_mod_left,
        Nat.div_eq_of_lt hq, Nat.mod_eq_of_lt hq, if_pos ⟨rfl, rfl⟩]
      exact ⟨h, by rw [← hok.rf_gv _ i.2 _ hq h, hqv]⟩
    have hl := hok.row _ i.2 _ hq hbl
    rw [hqv] at hl
    refine good_of_line hH _ (fun x => ((mkC hn (i.val * n), mkC hn x), v)) _ _ hl ?_ ?_
    · intro x hx hP
      have e1 := mkC_val hn (lt_sq hx)
      refine ⟨mem_image.2 ⟨_, (hij _).2 ⟨by rw [mkC_val hn hin, Nat.mul_div_cancel _ hn],
        by rw [e1, Nat.div_eq_of_lt hx, hj0]⟩, rfl⟩, ?_⟩
      rw [lvOf_eq (by simp only [mkC_val hn hin]; exact Nat.mul_mod_left _ _)
        (by simp only [e1]; exact Nat.div_eq_of_lt hx)
        (by simp only [e1, mkC_val hn hin, Nat.mul_div_cancel _ hn, Nat.mod_eq_of_lt hx]; exact hP)]
      simp only [e1, mkC_val hn hin, Nat.mul_div_cancel _ hn, Nat.mod_eq_of_lt hx]
    · intro y hy ℓ hl'
      obtain ⟨c, hc, rfl⟩ := mem_image.1 hy
      obtain ⟨h1, h2, h3⟩ := lvOf_some hl'
      obtain ⟨a1, a2⟩ := (hij c).1 hc
      obtain ⟨hcv1, hcv2⟩ := core_pos (x := (c, v)) h1 h2
      refine ⟨c.2.val % n, mod_lt' c.2, by rw [← a1]; exact h3, ?_⟩
      simp only [Prod.mk.injEq, and_true]
      refine Prod.ext (Fin.ext ?_) (Fin.ext ?_)
      · rw [mkC_val hn hin, ← a1]; exact hcv1
      · rw [mkC_val hn (lt_sq (mod_lt' c.2))]; exact hcv2

theorem core_hyp (hok : CoreOK K n H) (hH : 0 < H) : Hyp (givensOf K n) (lvOf K n H hH) where
  pa := by
    intro c v w hv hw
    rw [mem_givens] at hv hw
    unfold givenP at hv hw
    split_ifs at hv hw
    · exact Fin.ext (hv.2.trans hw.2.symm)
    · exact Fin.ext (hv.trans hw.symm)
  val := hyp_val hok
  live_blank := hyp_live_blank hok hH
  live_allowed := hyp_live_allowed hok hH
  cell := hyp_cell hok hH
  unit := hyp_unit hok hH

theorem core_unsat (hok : CoreOK K n H) (hHn : H ≤ n) : ¬ Satisfiable (sud n (givensOf K n)) := by
  classical
  obtain ⟨c0, hc0, Rs, hcard, hRs⟩ := hok.unsat
  have hn : 0 < n := by omega
  obtain ⟨col, hcol⟩ : ∃ col : Fin (n ^ 2), col.val = c0 := ⟨mkC hn c0, mkC_val hn (lt_sq hc0)⟩
  let U : Finset (Cell n) := univ.filter (fun c => c.2 = col)
  have hU : U ∈ units n := by
    simp only [units, Set.mem_union, Set.mem_setOf_eq]; exact Or.inl (Or.inr ⟨col, rfl⟩)
  let cells : Finset (Cell n) := Rs.image (fun r => (mkC hn (r * n), col))
  have hinj : Set.InjOn (fun r => (mkC hn (r * n), col)) (Rs : Set ℕ) := by
    intro a ha b hb h
    have := congrArg (fun c : Cell n => c.1.val) h
    simp only [mkC_val hn (xn_lt (hRs a ha).1), mkC_val hn (xn_lt (hRs b hb).1)] at this
    exact Nat.eq_of_mul_eq_mul_right hn this
  let X : Finset (Fin (n ^ 2)) := univ.filter (fun v => v.val < H)
  have hX : X.card = H := by
    have : X = (range H).attachFin (fun m hm => lt_of_lt_of_le (mem_range.1 hm)
        (le_trans hHn (by rw [sq_eq]; nlinarith))) := by
      ext v; simp [X]
    rw [this, card_attachFin, card_range]
  refine unsat_of U hU cells ?_ X ?_ ?_ ?_
  · intro c hc
    obtain ⟨r, -, rfl⟩ := mem_image.1 hc
    simp [U]
  · rw [card_image_of_injOn hinj, hX]; exact hcard
  · intro c hc w hw
    obtain ⟨r, hr, rfl⟩ := mem_image.1 hc
    obtain ⟨hrn, hbl, -⟩ := hRs r hr
    rw [mem_givens] at hw; unfold givenP at hw
    simp only [mkC_val hn (xn_lt hrn), hcol, Nat.mul_mod_left, Nat.div_eq_of_lt hc0,
      Nat.mul_div_cancel _ hn, Nat.mod_eq_of_lt hc0] at hw
    rw [if_pos (by simp), hbl] at hw
    exact Bool.noConfusion hw.1
  · intro c hc v hvX
    obtain ⟨r, hr, rfl⟩ := mem_image.1 hc
    obtain ⟨hrn, hbl, hmiss⟩ := hRs r hr
    have hvH : H ≤ v.val := by
      simp only [X, mem_filter, mem_univ, true_and, not_lt] at hvX; exact hvX
    obtain ⟨R, hR⟩ : ∃ R : Fin (n ^ 2), R.val = r * n := ⟨mkC hn (r * n), mkC_val hn (xn_lt hrn)⟩
    have hReq : mkC hn (r * n) = R := Fin.ext (by rw [mkC_val hn (xn_lt hrn), hR])
    rw [hReq]
    refine ⟨univ.filter (fun c => c.1 = R), by
      simp only [units, Set.mem_union, Set.mem_setOf_eq]; exact Or.inl (Or.inl ⟨R, rfl⟩), by simp, ?_⟩
    have hRn : R.val % n = 0 := by rw [hR]; exact Nat.mul_mod_left _ _
    have hRd : R.val / n = r := by rw [hR]; exact Nat.mul_div_cancel _ hn
    by_cases hv : n ≤ v.val
    · obtain ⟨C, hC⟩ := row_witness (K := K) R v (Or.inr hv)
      exact ⟨(R, C), by simp, hC⟩
    · push_neg at hv
      obtain ⟨q, hq, hqv⟩ := rf_surj hok hrn hv
      have hbq : K.blank r q = false := by
        by_contra h; simp only [Bool.not_eq_false] at h
        have := hmiss q hq h; omega
      refine ⟨(R, mkC hn q), by simp, ?_⟩
      rw [mem_givens]; unfold givenP
      simp only [hRn, hRd, mkC_val hn (lt_sq hq), Nat.div_eq_of_lt hq, Nat.mod_eq_of_lt hq]
      rw [if_pos (by simp)]
      exact ⟨hbq, by rw [← hok.rf_gv _ hrn _ hq hbq, hqv]⟩

end QEDSud


/-! # Prolongation of an `L × L` design by `k` disjoint transversals -/

namespace QEDSud

/-- One-step reduction. -/
def red (m y : ℕ) : ℕ := if y < m then y else y - m

structure PD where
  blank : ℕ → ℕ → Bool
  gv : ℕ → ℕ → ℕ
  rf : ℕ → ℕ → ℕ
  cf : ℕ → ℕ → ℕ
  live : ℕ → ℕ → ℕ → Bool
  lab : ℕ → ℕ → ℕ → ℕ × ℕ
  sg : ℕ → ℕ → ℕ
  si : ℕ → ℕ → ℕ
  trq : ℕ → ℕ → ℕ

structure PDOK (P : PD) (L k H : ℕ) : Prop where
  rf_lt : ∀ r < L, ∀ c < L, P.rf r c < L
  cf_lt : ∀ r < L, ∀ c < L, P.cf r c < L
  rf_gv : ∀ r < L, ∀ c < L, P.blank r c = false → P.rf r c = P.gv r c
  cf_gv : ∀ r < L, ∀ c < L, P.blank r c = false → P.cf r c = P.gv r c
  rf_inj : ∀ r < L, ∀ c < L, ∀ c' < L, P.rf r c = P.rf r c' → c = c'
  cf_inj : ∀ c < L, ∀ r < L, ∀ r' < L, P.cf r c = P.cf r' c → r = r'
  live_ok : ∀ r c v, P.live r c v = true → r < L ∧ c < L ∧ v < L ∧ P.blank r c = true ∧
    (∀ c' < L, P.rf r c' = v → P.blank r c' = true) ∧ (∀ r' < L, P.cf r' c = v → P.blank r' c = true)
  cell : ∀ r < L, ∀ c < L, P.blank r c = true → LineN L (2 + H) H (P.live r c) (P.lab r c)
  row : ∀ r < L, ∀ c < L, P.blank r c = true →
    LineN L (2 + H) H (fun c' => P.live r c' (P.rf r c)) (fun c' => P.lab r c' (P.rf r c))
  col : ∀ r < L, ∀ c < L, P.blank r c = true →
    LineN L (2 + H) H (fun r' => P.live r' c (P.cf r c)) (fun r' => P.lab r' c (P.cf r c))
  unsat : ∃ c0 < L, ∃ Rs : Finset ℕ, H < Rs.card ∧ ∀ r ∈ Rs, r < L ∧ P.blank r c0 = true ∧
    ∀ c' < L, P.blank r c' = true → P.rf r c' < H
  sg_lt : ∀ t < k, ∀ x < L, P.sg t x < L
  si_lt : ∀ t < k, ∀ c < L, P.si t c < L
  si_sg : ∀ t < k, ∀ x < L, P.si t (P.sg t x) = x
  sg_si : ∀ t < k, ∀ c < L, P.sg t (P.si t c) = c
  sg_ne : ∀ t < k, ∀ u < k, t ≠ u → ∀ x < L, P.sg t x ≠ P.sg u x
  sg_nb : ∀ t < k, ∀ x < L, P.blank x (P.sg t x) = false
  trq_sg : ∀ t < k, ∀ x < L, P.trq x (P.sg t x) = t
  trq_lt : ∀ x < L, ∀ c < L, P.trq x c < k → P.sg (P.trq x c) x = c
  tv_inj : ∀ t < k, ∀ c < L, ∀ c' < L, P.gv (P.si t c) c = P.gv (P.si t c') c' → c = c'

variable (P : PD) (L k : ℕ)

def qval (f : ℕ → ℕ → ℕ) (r c : ℕ) : ℕ :=
  if r < L then (if c < L then (if P.trq r c < k then L + P.trq r c else f r c) else P.gv r (P.sg (c - L) r))
  else (if c < L then P.gv (P.si (r - L) c) c else L + red k (r - L + (c - L)))

def qblank (r c : ℕ) : Bool := decide (r < L) && decide (c < L) && P.blank r c

def prolong : Core where
  blank := qblank P L
  gv := qval P L k P.gv
  rf := qval P L k P.rf
  cf := qval P L k P.cf
  live := fun r c v => decide (r < L) && decide (c < L) && P.live r c v
  lab := P.lab

variable {P L k} {H : ℕ}

lemma lineN_mono {n : ℕ} {Q : ℕ → Bool} {f : ℕ → ℕ × ℕ} (hLn : L ≤ n) (hQ : ∀ x, Q x = true → x < L)
    (h : LineN L (2 + H) H Q f) : LineN n (2 + H) H Q f := by
  obtain ⟨hinj, h⟩ := h
  refine ⟨fun x _ y _ hx hy => hinj x (hQ x hx) y (hQ y hy) hx hy, ?_⟩
  rcases h with ⟨i, hi, h1, h2⟩ | ⟨j, hj, h1, h2⟩
  · refine Or.inl ⟨i, hi, fun x _ hx => h1 x (hQ x hx) hx, fun j hj => ?_⟩
    obtain ⟨x, hx, h⟩ := h2 j hj; exact ⟨x, by omega, h⟩
  · refine Or.inr ⟨j, hj, fun x _ hx => h1 x (hQ x hx) hx, fun i hi => ?_⟩
    obtain ⟨x, hx, h⟩ := h2 i hi; exact ⟨x, by omega, h⟩

lemma red_lt {m y : ℕ} (hy : y < 2 * m) : red m y < m := by unfold red; split_ifs <;> omega

lemma blank_nt (hok : PDOK P L k H) {r c : ℕ} (hr : r < L) (hc : c < L) (hb : P.blank r c = true) :
    ¬ P.trq r c < k := by
  intro ht
  have := hok.sg_nb _ ht r hr
  rw [hok.trq_lt r hr c hc ht, hb] at this
  exact Bool.noConfusion this

lemma qval_nt {f : ℕ → ℕ → ℕ} {r c : ℕ} (hr : r < L) (hc : c < L) (ht : ¬ P.trq r c < k) :
    qval P L k f r c = f r c := by
  unfold qval; rw [if_pos hr, if_pos hc, if_neg ht]


variable (hok : PDOK P L k H)
include hok

lemma gv_tr_r {t x : ℕ} (ht : t < k) (hx : x < L) :
    P.gv x (P.sg t x) = P.rf x (P.sg t x) ∧ P.gv x (P.sg t x) = P.cf x (P.sg t x) :=
  ⟨(hok.rf_gv _ hx _ (hok.sg_lt t ht x hx) (hok.sg_nb t ht x hx)).symm,
   (hok.cf_gv _ hx _ (hok.sg_lt t ht x hx) (hok.sg_nb t ht x hx)).symm⟩

lemma nb_si {t c : ℕ} (ht : t < k) (hc : c < L) : P.blank (P.si t c) c = false := by
  have := hok.sg_nb t ht _ (hok.si_lt t ht c hc); rwa [hok.sg_si t ht c hc] at this

lemma gv_tr_c {t c : ℕ} (ht : t < k) (hc : c < L) :
    P.gv (P.si t c) c = P.rf (P.si t c) c ∧ P.gv (P.si t c) c = P.cf (P.si t c) c :=
  ⟨(hok.rf_gv _ (hok.si_lt t ht c hc) _ hc (nb_si hok ht hc)).symm,
   (hok.cf_gv _ (hok.si_lt t ht c hc) _ hc (nb_si hok ht hc)).symm⟩

lemma gv_tr_lt {t c : ℕ} (ht : t < k) (hc : c < L) : P.gv (P.si t c) c < L := by
  rw [(gv_tr_c hok ht hc).1]; exact hok.rf_lt _ (hok.si_lt t ht c hc) _ hc

lemma gv_tr_r_lt {t x : ℕ} (ht : t < k) (hx : x < L) : P.gv x (P.sg t x) < L := by
  rw [(gv_tr_r hok ht hx).1]; exact hok.rf_lt _ hx _ (hok.sg_lt t ht x hx)

/-- The values of row `r` of the prolongation (for `f = rf`) or column (for `f = cf`). -/
lemma qval_lt {f : ℕ → ℕ → ℕ} (hf : ∀ r < L, ∀ c < L, f r c < L) {r c : ℕ} (hr : r < L + k) (hc : c < L + k) :
    qval P L k f r c < L + k := by
  unfold qval
  split_ifs with h1 h2 h3 h4
  · omega
  · have := hf r h1 c h2; omega
  · have := gv_tr_r_lt hok (t := c - L) (by omega) h1; omega
  · have := gv_tr_lt hok (t := r - L) (by omega) h4; omega
  · have := red_lt (m := k) (y := r - L + (c - L)) (by omega); omega

theorem q_rf_inj {r c c' : ℕ} (hr : r < L + k) (hc : c < L + k) (hc' : c' < L + k)
    (h : qval P L k P.rf r c = qval P L k P.rf r c') : c = c' := by
  unfold qval at h
  by_cases h1 : r < L
  · simp only [if_pos h1] at h
    by_cases h2 : c < L <;> by_cases h2' : c' < L
    · simp only [if_pos h2, if_pos h2'] at h
      by_cases h3 : P.trq r c < k <;> by_cases h3' : P.trq r c' < k
      · simp only [if_pos h3, if_pos h3'] at h
        rw [← hok.trq_lt r h1 c h2 h3, ← hok.trq_lt r h1 c' h2' h3']; congr 1; omega
      · simp only [if_pos h3, if_neg h3'] at h; have := hok.rf_lt r h1 c' h2'; omega
      · simp only [if_neg h3, if_pos h3'] at h; have := hok.rf_lt r h1 c h2; omega
      · simp only [if_neg h3, if_neg h3'] at h; exact hok.rf_inj r h1 c h2 c' h2' h
    · simp only [if_pos h2, if_neg h2'] at h
      by_cases h3 : P.trq r c < k
      · simp only [if_pos h3] at h; have := gv_tr_r_lt hok (t := c' - L) (by omega) h1; omega
      · simp only [if_neg h3] at h
        rw [(gv_tr_r hok (t := c' - L) (by omega) h1).1] at h
        have := hok.rf_inj r h1 c h2 _ (hok.sg_lt _ (by omega) r h1) h
        exfalso; apply h3; rw [this, hok.trq_sg (c' - L) (by omega) r h1]; omega
    · simp only [if_neg h2, if_pos h2'] at h
      by_cases h3 : P.trq r c' < k
      · simp only [if_pos h3] at h; have := gv_tr_r_lt hok (t := c - L) (by omega) h1; omega
      · simp only [if_neg h3] at h
        rw [(gv_tr_r hok (t := c - L) (by omega) h1).1] at h
        have := hok.rf_inj r h1 _ (hok.sg_lt _ (by omega) r h1) c' h2' h
        exfalso; apply h3; rw [← this, hok.trq_sg (c - L) (by omega) r h1]; omega
    · simp only [if_neg h2, if_neg h2'] at h
      rw [(gv_tr_r hok (t := c - L) (by omega) h1).1, (gv_tr_r hok (t := c' - L) (by omega) h1).1] at h
      have := hok.rf_inj r h1 _ (hok.sg_lt _ (by omega) r h1) _ (hok.sg_lt _ (by omega) r h1) h
      by_contra hne
      exact hok.sg_ne (c - L) (by omega) (c' - L) (by omega) (by omega) r h1 this
  · simp only [if_neg h1] at h
    by_cases h2 : c < L <;> by_cases h2' : c' < L
    · simp only [if_pos h2, if_pos h2'] at h; exact hok.tv_inj (r - L) (by omega) c h2 c' h2' h
    · simp only [if_pos h2, if_neg h2'] at h; have := gv_tr_lt hok (t := r - L) (by omega) h2; omega
    · simp only [if_neg h2, if_pos h2'] at h; have := gv_tr_lt hok (t := r - L) (by omega) h2'; omega
    · simp only [if_neg h2, if_neg h2'] at h
      unfold red at h; split_ifs at h <;> omega

theorem q_cf_inj {c r r' : ℕ} (hc : c < L + k) (hr : r < L + k) (hr' : r' < L + k)
    (h : qval P L k P.cf r c = qval P L k P.cf r' c) : r = r' := by
  unfold qval at h
  by_cases h2 : c < L
  · by_cases h1 : r < L <;> by_cases h1' : r' < L
    · simp only [if_pos h1, if_pos h1', if_pos h2] at h
      by_cases h3 : P.trq r c < k <;> by_cases h3' : P.trq r' c < k
      · simp only [if_pos h3, if_pos h3'] at h
        have e1 := hok.trq_lt r h1 c h2 h3
        have e2 := hok.trq_lt r' h1' c h2 h3'
        have ht : P.trq r c = P.trq r' c := by omega
        have a1 : P.si (P.trq r c) c = r := by have := hok.si_sg _ h3 r h1; rwa [e1] at this
        have a2 : P.si (P.trq r' c) c = r' := by have := hok.si_sg _ h3' r' h1'; rwa [e2] at this
        rw [← a1, ← a2, ht]
      · simp only [if_pos h3, if_neg h3'] at h; have := hok.cf_lt r' h1' c h2; omega
      · simp only [if_neg h3, if_pos h3'] at h; have := hok.cf_lt r h1 c h2; omega
      · simp only [if_neg h3, if_neg h3'] at h; exact hok.cf_inj c h2 r h1 r' h1' h
    · simp only [if_pos h1, if_neg h1', if_pos h2] at h
      by_cases h3 : P.trq r c < k
      · simp only [if_pos h3] at h; have := gv_tr_lt hok (t := r' - L) (by omega) h2; omega
      · simp only [if_neg h3] at h
        rw [(gv_tr_c hok (t := r' - L) (by omega) h2).2] at h
        have := hok.cf_inj c h2 r h1 _ (hok.si_lt _ (by omega) c h2) h
        exfalso; apply h3
        rw [this]
        have := hok.trq_sg (r' - L) (by omega) _ (hok.si_lt (r' - L) (by omega) c h2)
        rw [hok.sg_si (r' - L) (by omega) c h2] at this
        omega
    · simp only [if_neg h1, if_pos h1', if_pos h2] at h
      by_cases h3 : P.trq r' c < k
      · simp only [if_pos h3] at h; have := gv_tr_lt hok (t := r - L) (by omega) h2; omega
      · simp only [if_neg h3] at h
        rw [(gv_tr_c hok (t := r - L) (by omega) h2).2] at h
        have := hok.cf_inj c h2 _ (hok.si_lt _ (by omega) c h2) r' h1' h
        exfalso; apply h3
        rw [← this]
        have := hok.trq_sg (r - L) (by omega) _ (hok.si_lt (r - L) (by omega) c h2)
        rw [hok.sg_si (r - L) (by omega) c h2] at this
        omega
    · simp only [if_neg h1, if_neg h1', if_pos h2] at h
      rw [(gv_tr_c hok (t := r - L) (by omega) h2).2, (gv_tr_c hok (t := r' - L) (by omega) h2).2] at h
      have hx := hok.cf_inj c h2 _ (hok.si_lt (r - L) (by omega) c h2) _ (hok.si_lt (r' - L) (by omega) c h2) h
      by_contra hne
      apply hok.sg_ne (r - L) (by omega) (r' - L) (by omega) (by omega) _ (hok.si_lt (r - L) (by omega) c h2)
      rw [hok.sg_si (r - L) (by omega) c h2, hx, hok.sg_si (r' - L) (by omega) c h2]
  · by_cases h1 : r < L <;> by_cases h1' : r' < L
    · simp only [if_pos h1, if_pos h1', if_neg h2] at h
      have e : P.gv (P.si (c - L) (P.sg (c - L) r)) (P.sg (c - L) r) =
          P.gv (P.si (c - L) (P.sg (c - L) r')) (P.sg (c - L) r') := by
        rw [hok.si_sg _ (by omega) r h1, hok.si_sg _ (by omega) r' h1']; exact h
      have := hok.tv_inj (c - L) (by omega) _ (hok.sg_lt (c - L) (by omega) r h1) _ (hok.sg_lt (c - L) (by omega) r' h1') e
      rw [← hok.si_sg (c - L) (by omega) r h1, this, hok.si_sg (c - L) (by omega) r' h1']
    · simp only [if_pos h1, if_neg h1', if_neg h2] at h; have := gv_tr_r_lt hok (t := c - L) (by omega) h1; omega
    · simp only [if_neg h1, if_pos h1', if_neg h2] at h; have := gv_tr_r_lt hok (t := c - L) (by omega) h1'; omega
    · simp only [if_neg h1, if_neg h1', if_neg h2] at h
      unfold red at h; split_ifs at h <;> omega

lemma q_rf_blank {r c' v : ℕ} (hr : r < L) (hc' : c' < L + k) (hv : v < L)
    (hrow : ∀ c' < L, P.rf r c' = v → P.blank r c' = true) (h : qval P L k P.rf r c' = v) :
    qblank P L r c' = true := by
  unfold qval at h
  simp only [if_pos hr] at h
  by_cases h2 : c' < L
  · simp only [if_pos h2] at h
    by_cases h3 : P.trq r c' < k
    · simp only [if_pos h3] at h; omega
    · simp only [if_neg h3] at h
      simp [qblank, hr, h2, hrow c' h2 h]
  · simp only [if_neg h2] at h
    rw [(gv_tr_r hok (t := c' - L) (by omega) hr).1] at h
    have := hrow _ (hok.sg_lt (c' - L) (by omega) r hr) h
    rw [hok.sg_nb _ (by omega) r hr] at this; exact Bool.noConfusion this

lemma q_cf_blank {c r' v : ℕ} (hc : c < L) (hr' : r' < L + k) (hv : v < L)
    (hcol : ∀ r' < L, P.cf r' c = v → P.blank r' c = true) (h : qval P L k P.cf r' c = v) :
    qblank P L r' c = true := by
  unfold qval at h
  by_cases h1 : r' < L
  · simp only [if_pos h1, if_pos hc] at h
    by_cases h3 : P.trq r' c < k
    · simp only [if_pos h3] at h; omega
    · simp only [if_neg h3] at h
      simp [qblank, hc, h1, hcol r' h1 h]
  · simp only [if_neg h1, if_pos hc] at h
    rw [(gv_tr_c hok (t := r' - L) (by omega) hc).2] at h
    have := hcol _ (hok.si_lt (r' - L) (by omega) c hc) h
    rw [nb_si hok (by omega) hc] at this; exact Bool.noConfusion this

omit hok in
lemma qblank_true {r c : ℕ} (h : qblank P L r c = true) : r < L ∧ c < L ∧ P.blank r c = true := by
  simp only [qblank, Bool.and_eq_true, decide_eq_true_eq] at h; exact ⟨h.1.1, h.1.2, h.2⟩

theorem prolong_ok : CoreOK (prolong P L k) (L + k) H where
  rf_lt := fun r hr c hc => qval_lt hok hok.rf_lt hr hc
  cf_lt := fun r hr c hc => qval_lt hok hok.cf_lt hr hc
  rf_gv := by
    intro r hr c hc hb
    show qval P L k P.rf r c = qval P L k P.gv r c
    unfold qval
    split_ifs with h1 h2 h3 <;> try rfl
    exact hok.rf_gv r h1 c h2 (by simpa [prolong, qblank, h1, h2] using hb)
  cf_gv := by
    intro r hr c hc hb
    show qval P L k P.cf r c = qval P L k P.gv r c
    unfold qval
    split_ifs with h1 h2 h3 <;> try rfl
    exact hok.cf_gv r h1 c h2 (by simpa [prolong, qblank, h1, h2] using hb)
  rf_inj := fun r hr c hc c' hc' h => q_rf_inj hok hr hc hc' h
  cf_inj := fun c hc r hr r' hr' h => q_cf_inj hok hc hr hr' h
  live_ok := by
    intro r c v hl
    simp only [prolong, Bool.and_eq_true, decide_eq_true_eq] at hl
    obtain ⟨⟨hr, hc⟩, hl⟩ := hl
    obtain ⟨-, -, hv, hb, hrow, hcol⟩ := hok.live_ok r c v hl
    refine ⟨by omega, by omega, by omega, by simp [prolong, qblank, hr, hc, hb], ?_, ?_⟩
    · intro c' hc' h; exact q_rf_blank hok hr hc' hv hrow h
    · intro r' hr' h; exact q_cf_blank hok hc hr' hv hcol h
  cell := by
    intro r hr c hc hb
    obtain ⟨hr, hc, hb⟩ := qblank_true hb
    have hfun : (prolong P L k).live r c = P.live r c := by
      funext v; simp [prolong, hr, hc]
    simp only [hfun]
    exact lineN_mono (by omega) (fun x hx => (hok.live_ok r c x hx).2.2.1) (hok.cell r hr c hc hb)
  row := by
    intro r hr c hc hb
    obtain ⟨hr, hc, hb⟩ := qblank_true hb
    have he : (prolong P L k).rf r c = P.rf r c := qval_nt hr hc (blank_nt hok hr hc hb)
    have hfun : (fun c' => (prolong P L k).live r c' ((prolong P L k).rf r c)) =
        (fun c' => P.live r c' (P.rf r c)) := by
      funext c'; rw [he]; simp only [prolong]
      by_cases h : c' < L
      · simp [hr, h]
      · have : P.live r c' (P.rf r c) = false := by
          by_contra hh; simp only [Bool.not_eq_false] at hh
          exact h (hok.live_ok _ _ _ hh).2.1
        simp [this]
    simp only [hfun]
    show LineN (L + k) (2 + H) H (fun c' => P.live r c' (P.rf r c)) (fun c' => P.lab r c' ((prolong P L k).rf r c))
    rw [he]
    exact lineN_mono (by omega) (fun x hx => (hok.live_ok r x _ hx).2.1) (hok.row r hr c hc hb)
  col := by
    intro r hr c hc hb
    obtain ⟨hr, hc, hb⟩ := qblank_true hb
    have he : (prolong P L k).cf r c = P.cf r c := qval_nt hr hc (blank_nt hok hr hc hb)
    have hfun : (fun r' => (prolong P L k).live r' c ((prolong P L k).cf r c)) =
        (fun r' => P.live r' c (P.cf r c)) := by
      funext r'; rw [he]; simp only [prolong]
      by_cases h : r' < L
      · simp [hc, h]
      · have : P.live r' c (P.cf r c) = false := by
          by_contra hh; simp only [Bool.not_eq_false] at hh
          exact h (hok.live_ok _ _ _ hh).1
        simp [this]
    simp only [hfun]
    show LineN (L + k) (2 + H) H (fun r' => P.live r' c (P.cf r c)) (fun r' => P.lab r' c ((prolong P L k).cf r c))
    rw [he]
    exact lineN_mono (by omega) (fun x hx => (hok.live_ok x c _ hx).1) (hok.col r hr c hc hb)
  unsat := by
    obtain ⟨c0, hc0, Rs, hcard, hRs⟩ := hok.unsat
    refine ⟨c0, by omega, Rs, hcard, fun r hr => ?_⟩
    obtain ⟨hrL, hb, hm⟩ := hRs r hr
    refine ⟨by omega, by simp [prolong, qblank, hrL, hc0, hb], fun c' hc' hb' => ?_⟩
    obtain ⟨-, hc'L, hb'⟩ := qblank_true hb'
    show qval P L k P.rf r c' < H
    rw [qval_nt hrL hc'L (blank_nt hok hrL hc'L hb')]
    exact hm c' hc'L hb'

end QEDSud


/-! # The concrete `8s × 8s` design (`h = 2s-1` holes, `p = 2s+1` pigeons) -/

namespace QEDSud

def ET (t : ℕ) : ℕ := if t = 0 then 0 else t + 1

def half (p m : ℕ) : ℕ := if m % 2 = 0 then m / 2 else (m + p) / 2

def band (p a d S1 S2 : ℕ) : ℕ :=
  if red p (d + p - a) = 1 then S1 + red p (a + p - 1)
  else if red p (d + p - a) = p - 1 then S1 + red p (a + p - 2)
  else S2 + (red p (d + p - a) - 1)

def bandW (s a d : ℕ) : ℕ :=
  if red (2 * s + 1) (d + (2 * s + 1) - a) = 1 then 6 * s - 1 + red (2 * s + 1) (a + (2 * s + 1) - 1)
  else if red (2 * s + 1) (d + (2 * s + 1) - a) = 2 * s then 6 * s - 1 + red (2 * s + 1) (a + (2 * s + 1) - 2)
  else 4 * s - 2 + half (2 * s + 1) (red (2 * s + 1) (red (2 * s + 1) (a + d + (2 * s + 1) - 3)))

def vAD (s x c : ℕ) : ℕ := 6 * s - 1 + red (2 * s + 1) (x + (c - (2 * s - 1)))
def vAC' (s x c : ℕ) : ℕ := 4 * s - 2 + red (2 * s + 1) (x + (c - 4 * s))
def vAD' (s x c : ℕ) : ℕ := band (2 * s + 1) x (c - (6 * s - 1)) (4 * s - 2) (2 * s - 1)
def vBC' (s x c : ℕ) : ℕ := red (2 * s - 1) (x - (2 * s + 1) + (c - 4 * s))
def vBD' (s x c : ℕ) : ℕ := 6 * s - 1 + red (2 * s + 1) (x - (2 * s + 1) + (c - (6 * s - 1)))
def vA'C (s x c : ℕ) : ℕ := 6 * s - 1 + red (2 * s + 1) (x - 4 * s + c)
def vA'D (s x c : ℕ) : ℕ := band (2 * s + 1) (x - 4 * s) (c - (2 * s - 1)) (4 * s - 2) 0
def vA'D' (s x c : ℕ) : ℕ := bandW s (x - 4 * s) (c - (6 * s - 1))
def vB'C (s x c : ℕ) : ℕ := 2 * s - 1 + red (2 * s - 1) (x - (6 * s + 1) + c)
def vB'D (s x c : ℕ) : ℕ := 4 * s - 2 + red (2 * s + 1) (x - (6 * s + 1) + (c - (2 * s - 1)))

def dgv (s x c : ℕ) : ℕ :=
  if x < 2 * s + 1 then
    (if c < 2 * s - 1 then 0 else if c < 4 * s then vAD s x c else if c < 6 * s - 1 then vAC' s x c
      else vAD' s x c)
  else if x < 4 * s then
    (if c < 4 * s then 0 else if c < 6 * s - 1 then vBC' s x c else vBD' s x c)
  else if x < 6 * s + 1 then
    (if c < 2 * s - 1 then vA'C s x c else if c < 4 * s then vA'D s x c else if c < 6 * s - 1 then 0
      else vA'D' s x c)
  else
    (if c < 2 * s - 1 then vB'C s x c else if c < 4 * s then vB'D s x c else 0)

def dblank (s x c : ℕ) : Bool :=
  if x < 2 * s + 1 then decide (c < 2 * s - 1)
  else if x < 4 * s then decide (c < 4 * s)
  else if x < 6 * s + 1 then decide (4 * s ≤ c) && decide (c < 6 * s - 1)
  else decide (4 * s ≤ c)

def drfill (s x c : ℕ) : ℕ :=
  if x < 2 * s + 1 then c
  else if x < 4 * s then (if c < 2 * s - 1 then 2 * s - 1 + c else 4 * s - 2 + (c - (2 * s - 1)))
  else if x < 6 * s + 1 then 2 * s - 1 + (c - 4 * s)
  else (if c < 6 * s - 1 then c - 4 * s else 6 * s - 1 + (c - (6 * s - 1)))

def dcfill (s x c : ℕ) : ℕ :=
  if c < 2 * s - 1 then (if x < 2 * s + 1 then 4 * s - 2 + x else x - (2 * s + 1))
  else if c < 4 * s then 2 * s - 1 + (x - (2 * s + 1))
  else if c < 6 * s - 1 then (if x < 6 * s + 1 then 6 * s - 1 + (x - 4 * s) else 2 * s - 1 + (x - (6 * s + 1)))
  else x - (6 * s + 1)

def drf (s x c : ℕ) : ℕ := if dblank s x c = true then drfill s x c else dgv s x c
def dcf (s x c : ℕ) : ℕ := if dblank s x c = true then dcfill s x c else dgv s x c

/-! ### Arithmetic of one-step reductions -/

lemma R_lt {m u w : ℕ} (hu : u < m) (hw : w < m) : red m (u + w) < m := by unfold red; split_ifs <;> omega

lemma R_lt' {m y : ℕ} (hy : y < 2 * m) : red m y < m := by unfold red; split_ifs <;> omega

lemma R_add_sub {m a y : ℕ} (ha : a < m) (hy : y < m) : red m (a + red m (y + m - a)) = y := by
  unfold red; split_ifs <;> omega

lemma R_sub_add {m a e : ℕ} (ha : a < m) (he : e < m) : red m (red m (a + e) + m - a) = e := by
  unfold red; split_ifs <;> omega

lemma R_add_inj {m u w w' : ℕ} (hu : u < m) (hw : w < m) (hw' : w' < m) (h : red m (u + w) = red m (u + w')) :
    w = w' := by
  unfold red at h; split_ifs at h <;> omega

lemma R_add_inj' {m u w w' : ℕ} (hu : u < m) (hw : w < m) (hw' : w' < m) (h : red m (w + u) = red m (w' + u)) :
    w = w' := by
  unfold red at h; split_ifs at h <;> omega

lemma R_sub_inj {m a d d' : ℕ} (ha : a < m) (hd : d < m) (hd' : d' < m)
    (h : red m (d + m - a) = red m (d' + m - a)) : d = d' := by
  unfold red at h; split_ifs at h <;> omega

lemma R_sub_inj' {m a a' d : ℕ} (ha : a < m) (ha' : a' < m) (hd : d < m)
    (h : red m (d + m - a) = red m (d + m - a')) : a = a' := by
  unfold red at h; split_ifs at h <;> omega

lemma R_ne12 {p a : ℕ} (hp : 3 ≤ p) (ha : a < p) : red p (a + p - 1) ≠ red p (a + p - 2) := by
  unfold red; split_ifs <;> omega

/-- The shift `y ↦ y - a (mod p)` lands below `p - 2` unless `y ≡ a - 1, a - 2`. -/
lemma R_small {p a y : ℕ} (hp : 3 ≤ p) (ha : a < p) (hy : y < p) (h1 : y ≠ red p (a + p - 1))
    (h2 : y ≠ red p (a + p - 2)) : red p (y + p - a) < p - 2 := by
  unfold red at *; split_ifs at * <;> omega

lemma R_big {p a w : ℕ} (hp : 3 ≤ p) (ha : a < p) (hw : w < p - 2) :
    red p (a + w) ≠ red p (a + p - 1) ∧ red p (a + w) ≠ red p (a + p - 2) := by
  unfold red; constructor <;> split_ifs <;> omega

lemma ET_lt {z p : ℕ} (hz : z < p - 2) : ET z < p := by unfold ET; split_ifs <;> omega
lemma ET_ne1 (z : ℕ) : ET z ≠ 1 := by unfold ET; split_ifs <;> omega
lemma ET_ne {z p : ℕ} (hz : z < p - 2) : ET z ≠ p - 1 := by unfold ET; split_ifs <;> omega
lemma ET_sub (z : ℕ) : ET z - 1 = z := by unfold ET; split_ifs <;> omega

/-! ### The band -/

lemma band_e {p a d S1 S2 : ℕ} (e : ℕ) (he : red p (d + p - a) = e) :
    band p a d S1 S2 = if e = 1 then S1 + red p (a + p - 1) else if e = p - 1 then S1 + red p (a + p - 2)
      else S2 + (e - 1) := by
  unfold band; rw [he]

lemma band_Z {p a z S1 S2 : ℕ} (hp : 5 ≤ p) (ha : a < p) (hz : z < p - 2) :
    band p a (red p (a + ET z)) S1 S2 = S2 + z := by
  rw [band_e (ET z) (R_sub_add ha (ET_lt hz)), if_neg (ET_ne1 z), if_neg (ET_ne hz), ET_sub]

lemma band_1 {p a S1 S2 : ℕ} (hp : 5 ≤ p) (ha : a < p) :
    band p a (red p (a + 1)) S1 S2 = S1 + red p (a + p - 1) := by
  rw [band_e 1 (R_sub_add ha (by omega)), if_pos rfl]

lemma band_m1 {p a S1 S2 : ℕ} (hp : 5 ≤ p) (ha : a < p) :
    band p a (red p (a + (p - 1))) S1 S2 = S1 + red p (a + p - 2) := by
  rw [band_e (p - 1) (R_sub_add ha (by omega)), if_neg (by omega), if_pos rfl]

/-- Band values: either `S2 + z` with `z < p-2`, or `S1 + (a-1)`, or `S1 + (a-2)`. -/
lemma band_cases {p a d S1 S2 : ℕ} (hp : 5 ≤ p) (ha : a < p) (hd : d < p) :
    (∃ z < p - 2, band p a d S1 S2 = S2 + z ∧ d = red p (a + ET z)) ∨
    (band p a d S1 S2 = S1 + red p (a + p - 1) ∧ d = red p (a + 1)) ∨
    (band p a d S1 S2 = S1 + red p (a + p - 2) ∧ d = red p (a + (p - 1))) := by
  have he : red p (d + p - a) < p := R_lt' (by omega)
  have hd' : d = red p (a + red p (d + p - a)) := (R_add_sub ha hd).symm
  rw [band_e _ rfl]
  generalize red p (d + p - a) = e at he hd' ⊢
  split_ifs with h1 h2
  · exact Or.inr (Or.inl ⟨rfl, by rw [hd', h1]⟩)
  · exact Or.inr (Or.inr ⟨rfl, by rw [hd', h2]⟩)
  · refine Or.inl ⟨e - 1, by omega, rfl, ?_⟩
    rw [hd']; congr 2; unfold ET; split_ifs <;> omega

/-! ### Halving modulo an odd `p` -/

lemma half_lt {s m : ℕ} (hm : m < 2 * s + 1) : half (2 * s + 1) m < 2 * s + 1 := by
  unfold half; split_ifs <;> omega

lemma half_inj {s m m' : ℕ} (hm : m < 2 * s + 1) (hm' : m' < 2 * s + 1)
    (h : half (2 * s + 1) m = half (2 * s + 1) m') : m = m' := by
  unfold half at h; split_ifs at h <;> omega

lemma half_dbl {s y : ℕ} (hy : y < 2 * s + 1) : half (2 * s + 1) (red (2 * s + 1) (2 * y)) = y := by
  unfold half red; split_ifs <;> omega

lemma bl_AC {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : c < 2 * s - 1) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_AC {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : c < 2 * s - 1) : drf s x c = c := by
  rw [drf, if_pos (bl_AC hs h1 h3)]; unfold drfill; split_ifs <;> omega

lemma cf_AC {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : c < 2 * s - 1) : dcf s x c = 4 * s - 2 + x := by
  rw [dcf, if_pos (bl_AC hs h1 h3)]; unfold dcfill; split_ifs <;> omega

lemma bl_AD {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_AD {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dgv s x c = vAD s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_AD {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : drf s x c = vAD s x c := by
  rw [drf, if_neg (by rw [bl_AD hs h1 h3 h4]; simp), gv_AD hs h1 h3 h4]

lemma cf_AD {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dcf s x c = vAD s x c := by
  rw [dcf, if_neg (by rw [bl_AD hs h1 h3 h4]; simp), gv_AD hs h1 h3 h4]

lemma bl_ACp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_ACp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dgv s x c = vAC' s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_ACp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : drf s x c = vAC' s x c := by
  rw [drf, if_neg (by rw [bl_ACp hs h1 h3 h4]; simp), gv_ACp hs h1 h3 h4]

lemma cf_ACp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dcf s x c = vAC' s x c := by
  rw [dcf, if_neg (by rw [bl_ACp hs h1 h3 h4]; simp), gv_ACp hs h1 h3 h4]

lemma bl_ADp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_ADp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dgv s x c = vAD' s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_ADp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : drf s x c = vAD' s x c := by
  rw [drf, if_neg (by rw [bl_ADp hs h1 h3 h4]; simp), gv_ADp hs h1 h3 h4]

lemma cf_ADp {s x c : ℕ} (hs : 5 ≤ s) (h1 : x < 2 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dcf s x c = vAD' s x c := by
  rw [dcf, if_neg (by rw [bl_ADp hs h1 h3 h4]; simp), gv_ADp hs h1 h3 h4]

lemma bl_BC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : c < 2 * s - 1) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_BC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : c < 2 * s - 1) : drf s x c = 2 * s - 1 + c := by
  rw [drf, if_pos (bl_BC hs h1 h2 h3)]; unfold drfill; split_ifs <;> omega

lemma cf_BC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : c < 2 * s - 1) : dcf s x c = x - (2 * s + 1) := by
  rw [dcf, if_pos (bl_BC hs h1 h2 h3)]; unfold dcfill; split_ifs <;> omega

lemma bl_BD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_BD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : drf s x c = 4 * s - 2 + (c - (2 * s - 1)) := by
  rw [drf, if_pos (bl_BD hs h1 h2 h3 h4)]; unfold drfill; split_ifs <;> omega

lemma cf_BD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dcf s x c = 2 * s - 1 + (x - (2 * s + 1)) := by
  rw [dcf, if_pos (bl_BD hs h1 h2 h3 h4)]; unfold dcfill; split_ifs <;> omega

lemma bl_BCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_BCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dgv s x c = vBC' s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_BCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : drf s x c = vBC' s x c := by
  rw [drf, if_neg (by rw [bl_BCp hs h1 h2 h3 h4]; simp), gv_BCp hs h1 h2 h3 h4]

lemma cf_BCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dcf s x c = vBC' s x c := by
  rw [dcf, if_neg (by rw [bl_BCp hs h1 h2 h3 h4]; simp), gv_BCp hs h1 h2 h3 h4]

lemma bl_BDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_BDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dgv s x c = vBD' s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_BDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : drf s x c = vBD' s x c := by
  rw [drf, if_neg (by rw [bl_BDp hs h1 h2 h3 h4]; simp), gv_BDp hs h1 h2 h3 h4]

lemma cf_BDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 2 * s + 1 ≤ x) (h2 : x < 4 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dcf s x c = vBD' s x c := by
  rw [dcf, if_neg (by rw [bl_BDp hs h1 h2 h3 h4]; simp), gv_BDp hs h1 h2 h3 h4]

lemma bl_ApC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : c < 2 * s - 1) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_ApC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : c < 2 * s - 1) : dgv s x c = vA'C s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_ApC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : c < 2 * s - 1) : drf s x c = vA'C s x c := by
  rw [drf, if_neg (by rw [bl_ApC hs h1 h2 h3]; simp), gv_ApC hs h1 h2 h3]

lemma cf_ApC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : c < 2 * s - 1) : dcf s x c = vA'C s x c := by
  rw [dcf, if_neg (by rw [bl_ApC hs h1 h2 h3]; simp), gv_ApC hs h1 h2 h3]

lemma bl_ApD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_ApD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dgv s x c = vA'D s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_ApD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : drf s x c = vA'D s x c := by
  rw [drf, if_neg (by rw [bl_ApD hs h1 h2 h3 h4]; simp), gv_ApD hs h1 h2 h3 h4]

lemma cf_ApD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dcf s x c = vA'D s x c := by
  rw [dcf, if_neg (by rw [bl_ApD hs h1 h2 h3 h4]; simp), gv_ApD hs h1 h2 h3 h4]

lemma bl_ApCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_ApCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : drf s x c = 2 * s - 1 + (c - 4 * s) := by
  rw [drf, if_pos (bl_ApCp hs h1 h2 h3 h4)]; unfold drfill; split_ifs <;> omega

lemma cf_ApCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dcf s x c = 6 * s - 1 + (x - 4 * s) := by
  rw [dcf, if_pos (bl_ApCp hs h1 h2 h3 h4)]; unfold dcfill; split_ifs <;> omega

lemma bl_ApDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_ApDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dgv s x c = vA'D' s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_ApDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : drf s x c = vA'D' s x c := by
  rw [drf, if_neg (by rw [bl_ApDp hs h1 h2 h3 h4]; simp), gv_ApDp hs h1 h2 h3 h4]

lemma cf_ApDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 4 * s ≤ x) (h2 : x < 6 * s + 1) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dcf s x c = vA'D' s x c := by
  rw [dcf, if_neg (by rw [bl_ApDp hs h1 h2 h3 h4]; simp), gv_ApDp hs h1 h2 h3 h4]

lemma bl_BpC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : c < 2 * s - 1) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_BpC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : c < 2 * s - 1) : dgv s x c = vB'C s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_BpC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : c < 2 * s - 1) : drf s x c = vB'C s x c := by
  rw [drf, if_neg (by rw [bl_BpC hs h1 h2 h3]; simp), gv_BpC hs h1 h2 h3]

lemma cf_BpC {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : c < 2 * s - 1) : dcf s x c = vB'C s x c := by
  rw [dcf, if_neg (by rw [bl_BpC hs h1 h2 h3]; simp), gv_BpC hs h1 h2 h3]

lemma bl_BpD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dblank s x c = false := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma gv_BpD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dgv s x c = vB'D s x c := by
  unfold dgv; split_ifs <;> first | rfl | omega

lemma rf_BpD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : drf s x c = vB'D s x c := by
  rw [drf, if_neg (by rw [bl_BpD hs h1 h2 h3 h4]; simp), gv_BpD hs h1 h2 h3 h4]

lemma cf_BpD {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 2 * s - 1 ≤ c) (h4 : c < 4 * s) : dcf s x c = vB'D s x c := by
  rw [dcf, if_neg (by rw [bl_BpD hs h1 h2 h3 h4]; simp), gv_BpD hs h1 h2 h3 h4]

lemma bl_BpCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_BpCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : drf s x c = c - 4 * s := by
  rw [drf, if_pos (bl_BpCp hs h1 h2 h3 h4)]; unfold drfill; split_ifs <;> omega

lemma cf_BpCp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 4 * s ≤ c) (h4 : c < 6 * s - 1) : dcf s x c = 2 * s - 1 + (x - (6 * s + 1)) := by
  rw [dcf, if_pos (bl_BpCp hs h1 h2 h3 h4)]; unfold dcfill; split_ifs <;> omega

lemma bl_BpDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dblank s x c = true := by
  unfold dblank; split_ifs <;> simp <;> omega

lemma rf_BpDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : drf s x c = 6 * s - 1 + (c - (6 * s - 1)) := by
  rw [drf, if_pos (bl_BpDp hs h1 h2 h3 h4)]; unfold drfill; split_ifs <;> omega

lemma cf_BpDp {s x c : ℕ} (hs : 5 ≤ s) (h1 : 6 * s + 1 ≤ x) (h2 : x < 8 * s) (h3 : 6 * s - 1 ≤ c) (h4 : c < 8 * s) : dcf s x c = x - (6 * s + 1) := by
  rw [dcf, if_pos (bl_BpDp hs h1 h2 h3 h4)]; unfold dcfill; split_ifs <;> omega

end QEDSud

namespace QEDSud

/-! ### Band evaluations for columns -/

lemma R_sub_sub {m d e : ℕ} (hd : d < m) (he : e < m) : red m (d + m - red m (d + m - e)) = e := by
  unfold red; split_ifs <;> omega

lemma band_Zc {p d z S1 S2 : ℕ} (hp : 5 ≤ p) (hd : d < p) (hz : z < p - 2) :
    band p (red p (d + p - ET z)) d S1 S2 = S2 + z := by
  rw [band_e (ET z) (R_sub_sub hd (ET_lt hz)), if_neg (ET_ne1 z), if_neg (ET_ne hz), ET_sub]

lemma band_1c {p d S1 S2 : ℕ} (hp : 5 ≤ p) (hd : d < p) :
    band p (red p (d + p - 1)) d S1 S2 = S1 + red p (red p (d + p - 1) + p - 1) := by
  rw [band_e 1 (R_sub_sub hd (by omega)), if_pos rfl]

lemma band_m1c {p d S1 S2 : ℕ} (hp : 5 ≤ p) (hd : d < p) :
    band p (red p (d + 1)) d S1 S2 = S1 + red p (red p (d + 1) + p - 2) := by
  have : red p (d + p - red p (d + 1)) = p - 1 := by unfold red; split_ifs <;> omega
  rw [band_e (p - 1) this, if_neg (by omega), if_pos rfl]

lemma band_lt {p a d S1 S2 : ℕ} (hp : 5 ≤ p) (ha : a < p) (hd : d < p) :
    (S2 ≤ band p a d S1 S2 ∧ band p a d S1 S2 < S2 + (p - 2)) ∨
      (S1 ≤ band p a d S1 S2 ∧ band p a d S1 S2 < S1 + p) := by
  rcases band_cases (S1 := S1) (S2 := S2) hp ha hd with ⟨z, hz, h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩
  · left; omega
  · right; have := R_lt' (m := p) (y := a + p - 1) (by omega); omega
  · right; have := R_lt' (m := p) (y := a + p - 2) (by omega); omega

/-! ### `bandW` -/

def dW (s a y : ℕ) : ℕ :=
  red (2 * s + 1) (red (2 * s + 1) (red (2 * s + 1) (2 * y) + 3 + (2 * s + 1) - a))

lemma red_le {m y : ℕ} : red m y ≤ y := by unfold red; split_ifs <;> omega

lemma red_ge {m y : ℕ} : y ≤ red m y + m := by unfold red; split_ifs <;> omega

lemma red_small {m y : ℕ} (hy : y < m) : red m y = y := by unfold red; rw [if_pos hy]

lemma red_big {m y : ℕ} (hy : m ≤ y) : red m y = y - m := by unfold red; rw [if_neg (by omega)]

lemma dW_lt {s a y : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hy : y < 2 * s + 1) : dW s a y < 2 * s + 1 := by
  unfold dW
  have h1 : red (2 * s + 1) (2 * y) < 2 * s + 1 := R_lt' (by omega)
  generalize red (2 * s + 1) (2 * y) = m1 at *
  have h2 : red (2 * s + 1) (m1 + 3 + (2 * s + 1) - a) ≤ 2 * s + 3 := by
    unfold red; split_ifs <;> omega
  generalize red (2 * s + 1) (m1 + 3 + (2 * s + 1) - a) = m2 at *
  unfold red; split_ifs <;> omega

lemma dW_m {s a y : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hy : y < 2 * s + 1) :
    red (2 * s + 1) (red (2 * s + 1) (a + dW s a y + (2 * s + 1) - 3)) = red (2 * s + 1) (2 * y) := by
  unfold dW red; split_ifs <;> omega

lemma dW_e1 {s a y : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hy : y < 2 * s + 1)
    (h1 : y ≠ red (2 * s + 1) (a + (2 * s + 1) - 1)) :
    red (2 * s + 1) (dW s a y + (2 * s + 1) - a) ≠ 1 := by
  unfold dW red at *; split_ifs at * <;> omega

lemma dW_e2 {s a y : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hy : y < 2 * s + 1)
    (h2 : y ≠ red (2 * s + 1) (a + (2 * s + 1) - 2)) :
    red (2 * s + 1) (dW s a y + (2 * s + 1) - a) ≠ 2 * s := by
  unfold dW red at *; split_ifs at * <;> omega

lemma bandW_Y {s a y : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hy : y < 2 * s + 1)
    (h1 : y ≠ red (2 * s + 1) (a + (2 * s + 1) - 1)) (h2 : y ≠ red (2 * s + 1) (a + (2 * s + 1) - 2)) :
    bandW s a (dW s a y) = 4 * s - 2 + y := by
  unfold bandW
  rw [if_neg (dW_e1 hs ha hy h1), if_neg (dW_e2 hs ha hy h2), dW_m hs ha hy, half_dbl hy]

lemma bandW_1 {s a : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) :
    bandW s a (red (2 * s + 1) (a + 1)) = 6 * s - 1 + red (2 * s + 1) (a + (2 * s + 1) - 1) := by
  unfold bandW; rw [if_pos (R_sub_add ha (by omega))]

lemma bandW_m1 {s a : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) :
    bandW s a (red (2 * s + 1) (a + 2 * s)) = 6 * s - 1 + red (2 * s + 1) (a + (2 * s + 1) - 2) := by
  unfold bandW; rw [if_neg (by rw [R_sub_add ha (by omega)]; omega), if_pos (R_sub_add ha (by omega))]

lemma bandW_lt {s a d : ℕ} (hs : 5 ≤ s) (ha : a < 2 * s + 1) (hd : d < 2 * s + 1) :
    4 * s - 2 ≤ bandW s a d ∧ bandW s a d < 8 * s := by
  unfold bandW
  have h1 := R_lt' (m := 2 * s + 1) (y := a + (2 * s + 1) - 1) (by omega)
  have h2 := R_lt' (m := 2 * s + 1) (y := a + (2 * s + 1) - 2) (by omega)
  have h3 := half_lt (s := s)
    (m := red (2 * s + 1) (red (2 * s + 1) (a + d + (2 * s + 1) - 3))) (R_lt' (by unfold red; split_ifs <;> omega))
  split_ifs <;> omega

end QEDSud

namespace QEDSud

lemma R_sub_add' {m a y : ℕ} (ha : a < m) (hy : y < m) : red m (red m (y + m - a) + a) = y := by
  unfold red; split_ifs <;> omega

lemma R_small_c {p d y : ℕ} (hp : 5 ≤ p) (hd : d < p) (hy : y < p)
    (h1 : y ≠ red p (red p (d + p - 1) + p - 1)) (h2 : y ≠ red p (red p (d + 1) + p - 2)) :
    red p (y + p - d) < p - 2 := by
  unfold red at *; split_ifs at * <;> omega

/-! ### Rows: values in range and every symbol hit -/

theorem rowA_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 2 * s + 1) (hc : c < 8 * s) : drf s x c < 8 * s := by
  by_cases h1 : c < 2 * s - 1
  · rw [rf_AC hs hx h1]; omega
  by_cases h2 : c < 4 * s
  · rw [rf_AD hs hx (by omega) h2, vAD]; have := R_lt (m := 2 * s + 1) hx (show c - (2 * s - 1) < 2 * s + 1 by omega); omega
  by_cases h3 : c < 6 * s - 1
  · rw [rf_ACp hs hx (by omega) h3, vAC']; have := R_lt (m := 2 * s + 1) hx (show c - 4 * s < 2 * s + 1 by omega); omega
  · rw [rf_ADp hs hx (by omega) hc, vAD']
    rcases band_lt (S1 := 4 * s - 2) (S2 := 2 * s - 1) (show 5 ≤ 2 * s + 1 by omega) hx
      (show c - (6 * s - 1) < 2 * s + 1 by omega) with h | h <;> omega

theorem rowA_surj {s x v : ℕ} (hs : 5 ≤ s) (hx : x < 2 * s + 1) (hv : v < 8 * s) :
    ∃ c < 8 * s, drf s x c = v := by
  have hp : 5 ≤ 2 * s + 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · exact ⟨v, by omega, by rw [rf_AC hs hx h1]⟩
  by_cases h2 : v < 4 * s - 2
  · have hz : v - (2 * s - 1) < 2 * s + 1 - 2 := by omega
    have hr := R_lt (m := 2 * s + 1) hx (ET_lt hz)
    refine ⟨6 * s - 1 + red (2 * s + 1) (x + ET (v - (2 * s - 1))), by omega, ?_⟩
    rw [rf_ADp hs hx (by omega) (by omega), vAD', Nat.add_sub_cancel_left, band_Z hp hx hz]; omega
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    by_cases e1 : v - (4 * s - 2) = red (2 * s + 1) (x + (2 * s + 1) - 1)
    · have hr := R_lt (m := 2 * s + 1) hx (show 1 < 2 * s + 1 by omega)
      refine ⟨6 * s - 1 + red (2 * s + 1) (x + 1), by omega, ?_⟩
      rw [rf_ADp hs hx (by omega) (by omega), vAD', Nat.add_sub_cancel_left, band_1 hp hx]; omega
    by_cases e2 : v - (4 * s - 2) = red (2 * s + 1) (x + (2 * s + 1) - 2)
    · have hr := R_lt (m := 2 * s + 1) hx (show 2 * s + 1 - 1 < 2 * s + 1 by omega)
      refine ⟨6 * s - 1 + red (2 * s + 1) (x + (2 * s + 1 - 1)), by omega, ?_⟩
      rw [rf_ADp hs hx (by omega) (by omega), vAD', Nat.add_sub_cancel_left, band_m1 hp hx]; omega
    · have hr := R_small (by omega) hx hy e1 e2
      refine ⟨4 * s + red (2 * s + 1) (v - (4 * s - 2) + (2 * s + 1) - x), by omega, ?_⟩
      rw [rf_ACp hs hx (by omega) (by omega), vAC', Nat.add_sub_cancel_left, R_add_sub hx hy]; omega
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (6 * s - 1) + (2 * s + 1) - x) (by omega)
    refine ⟨2 * s - 1 + red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - x), by omega, ?_⟩
    rw [rf_AD hs hx (by omega) (by omega), vAD, Nat.add_sub_cancel_left, R_add_sub hx hy]; omega

theorem rowB_lt {s x c : ℕ} (hs : 5 ≤ s) (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) (hc : c < 8 * s) :
    drf s x c < 8 * s := by
  by_cases h1 : c < 2 * s - 1
  · rw [rf_BC hs hx1 hx h1]; omega
  by_cases h2 : c < 4 * s
  · rw [rf_BD hs hx1 hx (by omega) h2]; omega
  by_cases h3 : c < 6 * s - 1
  · rw [rf_BCp hs hx1 hx (by omega) h3, vBC']
    have := R_lt (m := 2 * s - 1) (show x - (2 * s + 1) < 2 * s - 1 by omega) (show c - 4 * s < 2 * s - 1 by omega); omega
  · rw [rf_BDp hs hx1 hx (by omega) hc, vBD']
    have := R_lt (m := 2 * s + 1) (show x - (2 * s + 1) < 2 * s + 1 by omega) (show c - (6 * s - 1) < 2 * s + 1 by omega); omega

theorem rowB_surj {s x v : ℕ} (hs : 5 ≤ s) (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) (hv : v < 8 * s) :
    ∃ c < 8 * s, drf s x c = v := by
  have hk : x - (2 * s + 1) < 2 * s - 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · have hr := R_lt' (m := 2 * s - 1) (y := v + (2 * s - 1) - (x - (2 * s + 1))) (by omega)
    refine ⟨4 * s + red (2 * s - 1) (v + (2 * s - 1) - (x - (2 * s + 1))), by omega, ?_⟩
    rw [rf_BCp hs hx1 hx (by omega) (by omega), vBC', Nat.add_sub_cancel_left, R_add_sub hk h1]
  by_cases h2 : v < 4 * s - 2
  · exact ⟨v - (2 * s - 1), by omega, by rw [rf_BC hs hx1 hx (by omega)]; omega⟩
  by_cases h3 : v < 6 * s - 1
  · exact ⟨2 * s - 1 + (v - (4 * s - 2)), by omega, by rw [rf_BD hs hx1 hx (by omega) (by omega)]; omega⟩
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    have hk' : x - (2 * s + 1) < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (6 * s - 1) + (2 * s + 1) - (x - (2 * s + 1))) (by omega)
    refine ⟨6 * s - 1 + red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - (x - (2 * s + 1))), by omega, ?_⟩
    rw [rf_BDp hs hx1 hx (by omega) (by omega), vBD', Nat.add_sub_cancel_left, R_add_sub hk' hy]; omega

theorem rowA'_lt {s x c : ℕ} (hs : 5 ≤ s) (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) (hc : c < 8 * s) :
    drf s x c < 8 * s := by
  have ha : x - 4 * s < 2 * s + 1 := by omega
  by_cases h1 : c < 2 * s - 1
  · rw [rf_ApC hs hx1 hx h1, vA'C]; have := R_lt (m := 2 * s + 1) ha (show c < 2 * s + 1 by omega); omega
  by_cases h2 : c < 4 * s
  · rw [rf_ApD hs hx1 hx (by omega) h2, vA'D]
    rcases band_lt (S1 := 4 * s - 2) (S2 := 0) (show 5 ≤ 2 * s + 1 by omega) ha
      (show c - (2 * s - 1) < 2 * s + 1 by omega) with h | h <;> omega
  by_cases h3 : c < 6 * s - 1
  · rw [rf_ApCp hs hx1 hx (by omega) h3]; omega
  · rw [rf_ApDp hs hx1 hx (by omega) hc, vA'D']
    exact (bandW_lt hs ha (show c - (6 * s - 1) < 2 * s + 1 by omega)).2

theorem rowA'_surj {s x v : ℕ} (hs : 5 ≤ s) (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) (hv : v < 8 * s) :
    ∃ c < 8 * s, drf s x c = v := by
  have hp : 5 ≤ 2 * s + 1 := by omega
  have ha : x - 4 * s < 2 * s + 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · have hz : v < 2 * s + 1 - 2 := by omega
    have hr := R_lt (m := 2 * s + 1) ha (ET_lt hz)
    refine ⟨2 * s - 1 + red (2 * s + 1) (x - 4 * s + ET v), by omega, ?_⟩
    rw [rf_ApD hs hx1 hx (by omega) (by omega), vA'D, Nat.add_sub_cancel_left, band_Z hp ha hz]; omega
  by_cases h2 : v < 4 * s - 2
  · exact ⟨4 * s + (v - (2 * s - 1)), by omega, by rw [rf_ApCp hs hx1 hx (by omega) (by omega)]; omega⟩
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    by_cases e1 : v - (4 * s - 2) = red (2 * s + 1) (x - 4 * s + (2 * s + 1) - 1)
    · have hr := R_lt (m := 2 * s + 1) ha (show 1 < 2 * s + 1 by omega)
      refine ⟨2 * s - 1 + red (2 * s + 1) (x - 4 * s + 1), by omega, ?_⟩
      rw [rf_ApD hs hx1 hx (by omega) (by omega), vA'D, Nat.add_sub_cancel_left, band_1 hp ha]; omega
    by_cases e2 : v - (4 * s - 2) = red (2 * s + 1) (x - 4 * s + (2 * s + 1) - 2)
    · have hr := R_lt (m := 2 * s + 1) ha (show 2 * s + 1 - 1 < 2 * s + 1 by omega)
      refine ⟨2 * s - 1 + red (2 * s + 1) (x - 4 * s + (2 * s + 1 - 1)), by omega, ?_⟩
      rw [rf_ApD hs hx1 hx (by omega) (by omega), vA'D, Nat.add_sub_cancel_left, band_m1 hp ha]; omega
    · have hr := dW_lt hs ha hy
      refine ⟨6 * s - 1 + dW s (x - 4 * s) (v - (4 * s - 2)), by omega, ?_⟩
      rw [rf_ApDp hs hx1 hx (by omega) (by omega), vA'D', Nat.add_sub_cancel_left, bandW_Y hs ha hy e1 e2]; omega
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    by_cases e1 : v - (6 * s - 1) = red (2 * s + 1) (x - 4 * s + (2 * s + 1) - 1)
    · have hr := R_lt (m := 2 * s + 1) ha (show 1 < 2 * s + 1 by omega)
      refine ⟨6 * s - 1 + red (2 * s + 1) (x - 4 * s + 1), by omega, ?_⟩
      rw [rf_ApDp hs hx1 hx (by omega) (by omega), vA'D', Nat.add_sub_cancel_left, bandW_1 hs ha]; omega
    by_cases e2 : v - (6 * s - 1) = red (2 * s + 1) (x - 4 * s + (2 * s + 1) - 2)
    · have hr := R_lt (m := 2 * s + 1) ha (show 2 * s < 2 * s + 1 by omega)
      refine ⟨6 * s - 1 + red (2 * s + 1) (x - 4 * s + 2 * s), by omega, ?_⟩
      rw [rf_ApDp hs hx1 hx (by omega) (by omega), vA'D', Nat.add_sub_cancel_left, bandW_m1 hs ha]; omega
    · have hr := R_small (by omega) ha hy e1 e2
      refine ⟨red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)), by omega, ?_⟩
      rw [rf_ApC hs hx1 hx (by omega), vA'C, R_add_sub ha hy]; omega

theorem rowB'_lt {s x c : ℕ} (hs : 5 ≤ s) (hx1 : 6 * s + 1 ≤ x) (hx : x < 8 * s) (hc : c < 8 * s) :
    drf s x c < 8 * s := by
  by_cases h1 : c < 2 * s - 1
  · rw [rf_BpC hs hx1 hx h1, vB'C]
    have := R_lt (m := 2 * s - 1) (show x - (6 * s + 1) < 2 * s - 1 by omega) h1; omega
  by_cases h2 : c < 4 * s
  · rw [rf_BpD hs hx1 hx (by omega) h2, vB'D]
    have := R_lt (m := 2 * s + 1) (show x - (6 * s + 1) < 2 * s + 1 by omega) (show c - (2 * s - 1) < 2 * s + 1 by omega); omega
  by_cases h3 : c < 6 * s - 1
  · rw [rf_BpCp hs hx1 hx (by omega) h3]; omega
  · rw [rf_BpDp hs hx1 hx (by omega) hc]; omega

theorem rowB'_surj {s x v : ℕ} (hs : 5 ≤ s) (hx1 : 6 * s + 1 ≤ x) (hx : x < 8 * s) (hv : v < 8 * s) :
    ∃ c < 8 * s, drf s x c = v := by
  have hk : x - (6 * s + 1) < 2 * s - 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · exact ⟨4 * s + v, by omega, by rw [rf_BpCp hs hx1 hx (by omega) (by omega)]; omega⟩
  by_cases h2 : v < 4 * s - 2
  · have hz : v - (2 * s - 1) < 2 * s - 1 := by omega
    have hr := R_lt' (m := 2 * s - 1) (y := v - (2 * s - 1) + (2 * s - 1) - (x - (6 * s + 1))) (by omega)
    refine ⟨red (2 * s - 1) (v - (2 * s - 1) + (2 * s - 1) - (x - (6 * s + 1))), by omega, ?_⟩
    rw [rf_BpC hs hx1 hx hr, vB'C, R_add_sub hk hz]; omega
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    have hk' : x - (6 * s + 1) < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (4 * s - 2) + (2 * s + 1) - (x - (6 * s + 1))) (by omega)
    refine ⟨2 * s - 1 + red (2 * s + 1) (v - (4 * s - 2) + (2 * s + 1) - (x - (6 * s + 1))), by omega, ?_⟩
    rw [rf_BpD hs hx1 hx (by omega) (by omega), vB'D, Nat.add_sub_cancel_left, R_add_sub hk' hy]; omega
  · exact ⟨v, hv, by rw [rf_BpDp hs hx1 hx (by omega) hv]; omega⟩

end QEDSud


namespace QEDSud

/-! ### Columns -/

theorem colC_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 2 * s - 1) : dcf s x c < 8 * s := by
  by_cases h1 : x < 2 * s + 1
  · rw [cf_AC hs h1 hc]; omega
  by_cases h2 : x < 4 * s
  · rw [cf_BC hs (by omega) h2 hc]; omega
  by_cases h3 : x < 6 * s + 1
  · rw [cf_ApC hs (by omega) h3 hc, vA'C]
    have := R_lt (m := 2 * s + 1) (show x - 4 * s < 2 * s + 1 by omega) (show c < 2 * s + 1 by omega); omega
  · rw [cf_BpC hs (by omega) hx hc, vB'C]
    have := R_lt (m := 2 * s - 1) (show x - (6 * s + 1) < 2 * s - 1 by omega) hc; omega

theorem colC_surj {s c v : ℕ} (hs : 5 ≤ s) (hc : c < 2 * s - 1) (hv : v < 8 * s) :
    ∃ x < 8 * s, dcf s x c = v := by
  by_cases h1 : v < 2 * s - 1
  · exact ⟨2 * s + 1 + v, by omega, by rw [cf_BC hs (by omega) (by omega) hc]; omega⟩
  by_cases h2 : v < 4 * s - 2
  · have hz : v - (2 * s - 1) < 2 * s - 1 := by omega
    have hr := R_lt' (m := 2 * s - 1) (y := v - (2 * s - 1) + (2 * s - 1) - c) (by omega)
    refine ⟨6 * s + 1 + red (2 * s - 1) (v - (2 * s - 1) + (2 * s - 1) - c), by omega, ?_⟩
    rw [cf_BpC hs (by omega) (by omega) hc, vB'C, Nat.add_sub_cancel_left, R_sub_add' hc hz]; omega
  by_cases h3 : v < 6 * s - 1
  · exact ⟨v - (4 * s - 2), by omega, by rw [cf_AC hs (by omega) hc]; omega⟩
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    have hc' : c < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (6 * s - 1) + (2 * s + 1) - c) (by omega)
    refine ⟨4 * s + red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - c), by omega, ?_⟩
    rw [cf_ApC hs (by omega) (by omega) hc, vA'C, Nat.add_sub_cancel_left, R_sub_add' hc' hy]; omega

theorem colD_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc1 : 2 * s - 1 ≤ c) (hc : c < 4 * s) :
    dcf s x c < 8 * s := by
  have hd : c - (2 * s - 1) < 2 * s + 1 := by omega
  by_cases h1 : x < 2 * s + 1
  · rw [cf_AD hs h1 hc1 hc, vAD]; have := R_lt (m := 2 * s + 1) h1 hd; omega
  by_cases h2 : x < 4 * s
  · rw [cf_BD hs (by omega) h2 hc1 hc]; omega
  by_cases h3 : x < 6 * s + 1
  · rw [cf_ApD hs (by omega) h3 hc1 hc, vA'D]
    rcases band_lt (S1 := 4 * s - 2) (S2 := 0) (show 5 ≤ 2 * s + 1 by omega)
      (show x - 4 * s < 2 * s + 1 by omega) hd with h | h <;> omega
  · rw [cf_BpD hs (by omega) hx hc1 hc, vB'D]
    have := R_lt (m := 2 * s + 1) (show x - (6 * s + 1) < 2 * s + 1 by omega) hd; omega

theorem colD_surj {s c v : ℕ} (hs : 5 ≤ s) (hc1 : 2 * s - 1 ≤ c) (hc : c < 4 * s) (hv : v < 8 * s) :
    ∃ x < 8 * s, dcf s x c = v := by
  have hp : 5 ≤ 2 * s + 1 := by omega
  have hd : c - (2 * s - 1) < 2 * s + 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · have hz : v < 2 * s + 1 - 2 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + (2 * s + 1) - ET v) (by have := ET_lt hz; omega)
    refine ⟨4 * s + red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - ET v), by omega, ?_⟩
    rw [cf_ApD hs (by omega) (by omega) hc1 hc, vA'D, Nat.add_sub_cancel_left, band_Zc hp hd hz]; omega
  by_cases h2 : v < 4 * s - 2
  · exact ⟨2 * s + 1 + (v - (2 * s - 1)), by omega, by rw [cf_BD hs (by omega) (by omega) hc1 hc]; omega⟩
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    by_cases e1 : v - (4 * s - 2) = red (2 * s + 1) (red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - 1) + (2 * s + 1) - 1)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + (2 * s + 1) - 1) (by omega)
      refine ⟨4 * s + red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - 1), by omega, ?_⟩
      rw [cf_ApD hs (by omega) (by omega) hc1 hc, vA'D, Nat.add_sub_cancel_left, band_1c hp hd]; omega
    by_cases e2 : v - (4 * s - 2) = red (2 * s + 1) (red (2 * s + 1) (c - (2 * s - 1) + 1) + (2 * s + 1) - 2)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + 1) (by omega)
      refine ⟨4 * s + red (2 * s + 1) (c - (2 * s - 1) + 1), by omega, ?_⟩
      rw [cf_ApD hs (by omega) (by omega) hc1 hc, vA'D, Nat.add_sub_cancel_left, band_m1c hp hd]; omega
    · have hr := R_small_c hp hd hy e1 e2
      refine ⟨6 * s + 1 + red (2 * s + 1) (v - (4 * s - 2) + (2 * s + 1) - (c - (2 * s - 1))), by omega, ?_⟩
      rw [cf_BpD hs (by omega) (by omega) hc1 hc, vB'D, Nat.add_sub_cancel_left, R_sub_add' hd hy]; omega
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (6 * s - 1) + (2 * s + 1) - (c - (2 * s - 1))) (by omega)
    refine ⟨red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - (c - (2 * s - 1))), by omega, ?_⟩
    rw [cf_AD hs hr hc1 hc, vAD, R_sub_add' hd hy]; omega

theorem colC'_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc1 : 4 * s ≤ c) (hc : c < 6 * s - 1) :
    dcf s x c < 8 * s := by
  by_cases h1 : x < 2 * s + 1
  · rw [cf_ACp hs h1 hc1 hc, vAC']
    have := R_lt (m := 2 * s + 1) h1 (show c - 4 * s < 2 * s + 1 by omega); omega
  by_cases h2 : x < 4 * s
  · rw [cf_BCp hs (by omega) h2 hc1 hc, vBC']
    have := R_lt (m := 2 * s - 1) (show x - (2 * s + 1) < 2 * s - 1 by omega) (show c - 4 * s < 2 * s - 1 by omega); omega
  by_cases h3 : x < 6 * s + 1
  · rw [cf_ApCp hs (by omega) h3 hc1 hc]; omega
  · rw [cf_BpCp hs (by omega) hx hc1 hc]; omega

theorem colC'_surj {s c v : ℕ} (hs : 5 ≤ s) (hc1 : 4 * s ≤ c) (hc : c < 6 * s - 1) (hv : v < 8 * s) :
    ∃ x < 8 * s, dcf s x c = v := by
  have hj : c - 4 * s < 2 * s - 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · have hr := R_lt' (m := 2 * s - 1) (y := v + (2 * s - 1) - (c - 4 * s)) (by omega)
    refine ⟨2 * s + 1 + red (2 * s - 1) (v + (2 * s - 1) - (c - 4 * s)), by omega, ?_⟩
    rw [cf_BCp hs (by omega) (by omega) hc1 hc, vBC', Nat.add_sub_cancel_left, R_sub_add' hj h1]
  by_cases h2 : v < 4 * s - 2
  · exact ⟨6 * s + 1 + (v - (2 * s - 1)), by omega, by rw [cf_BpCp hs (by omega) (by omega) hc1 hc]; omega⟩
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    have hj' : c - 4 * s < 2 * s + 1 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := v - (4 * s - 2) + (2 * s + 1) - (c - 4 * s)) (by omega)
    refine ⟨red (2 * s + 1) (v - (4 * s - 2) + (2 * s + 1) - (c - 4 * s)), by omega, ?_⟩
    rw [cf_ACp hs hr hc1 hc, vAC', R_sub_add' hj' hy]; omega
  · exact ⟨4 * s + (v - (6 * s - 1)), by omega, by rw [cf_ApCp hs (by omega) (by omega) hc1 hc]; omega⟩

lemma dWc_e1 {s d y : ℕ} (hs : 5 ≤ s) (hd : d < 2 * s + 1) (hy : y < 2 * s + 1)
    (h1 : y ≠ red (2 * s + 1) (red (2 * s + 1) (d + (2 * s + 1) - 1) + (2 * s + 1) - 1)) :
    red (2 * s + 1) (d + (2 * s + 1) - dW s d y) ≠ 1 := by
  unfold dW red at *; split_ifs at * <;> omega

lemma dWc_e2 {s d y : ℕ} (hs : 5 ≤ s) (hd : d < 2 * s + 1) (hy : y < 2 * s + 1)
    (h2 : y ≠ red (2 * s + 1) (red (2 * s + 1) (d + 1) + (2 * s + 1) - 2)) :
    red (2 * s + 1) (d + (2 * s + 1) - dW s d y) ≠ 2 * s := by
  unfold dW red at *; split_ifs at * <;> omega

lemma bandW_Yc {s d y : ℕ} (hs : 5 ≤ s) (hd : d < 2 * s + 1) (hy : y < 2 * s + 1)
    (h1 : y ≠ red (2 * s + 1) (red (2 * s + 1) (d + (2 * s + 1) - 1) + (2 * s + 1) - 1))
    (h2 : y ≠ red (2 * s + 1) (red (2 * s + 1) (d + 1) + (2 * s + 1) - 2)) :
    bandW s (dW s d y) d = 4 * s - 2 + y := by
  unfold bandW
  rw [if_neg (dWc_e1 hs hd hy h1), if_neg (dWc_e2 hs hd hy h2), Nat.add_comm (dW s d y) d, dW_m hs hd hy,
    half_dbl hy]

lemma bandW_1c {s d : ℕ} (hs : 5 ≤ s) (hd : d < 2 * s + 1) :
    bandW s (red (2 * s + 1) (d + (2 * s + 1) - 1)) d =
      6 * s - 1 + red (2 * s + 1) (red (2 * s + 1) (d + (2 * s + 1) - 1) + (2 * s + 1) - 1) := by
  unfold bandW; rw [if_pos (R_sub_sub hd (by omega))]

lemma bandW_m1c {s d : ℕ} (hs : 5 ≤ s) (hd : d < 2 * s + 1) :
    bandW s (red (2 * s + 1) (d + 1)) d =
      6 * s - 1 + red (2 * s + 1) (red (2 * s + 1) (d + 1) + (2 * s + 1) - 2) := by
  have : red (2 * s + 1) (d + (2 * s + 1) - red (2 * s + 1) (d + 1)) = 2 * s := by
    unfold red; split_ifs <;> omega
  unfold bandW; rw [if_neg (by rw [this]; omega), if_pos this]

theorem colD'_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc1 : 6 * s - 1 ≤ c) (hc : c < 8 * s) :
    dcf s x c < 8 * s := by
  have hd : c - (6 * s - 1) < 2 * s + 1 := by omega
  by_cases h1 : x < 2 * s + 1
  · rw [cf_ADp hs h1 hc1 hc, vAD']
    rcases band_lt (S1 := 4 * s - 2) (S2 := 2 * s - 1) (show 5 ≤ 2 * s + 1 by omega) h1 hd with h | h <;> omega
  by_cases h2 : x < 4 * s
  · rw [cf_BDp hs (by omega) h2 hc1 hc, vBD']
    have := R_lt (m := 2 * s + 1) (show x - (2 * s + 1) < 2 * s + 1 by omega) hd; omega
  by_cases h3 : x < 6 * s + 1
  · rw [cf_ApDp hs (by omega) h3 hc1 hc, vA'D']
    exact (bandW_lt hs (show x - 4 * s < 2 * s + 1 by omega) hd).2
  · rw [cf_BpDp hs (by omega) hx hc1 hc]; omega

theorem colD'_surj {s c v : ℕ} (hs : 5 ≤ s) (hc1 : 6 * s - 1 ≤ c) (hc : c < 8 * s) (hv : v < 8 * s) :
    ∃ x < 8 * s, dcf s x c = v := by
  have hp : 5 ≤ 2 * s + 1 := by omega
  have hd : c - (6 * s - 1) < 2 * s + 1 := by omega
  by_cases h1 : v < 2 * s - 1
  · exact ⟨6 * s + 1 + v, by omega, by rw [cf_BpDp hs (by omega) (by omega) hc1 hc]; omega⟩
  by_cases h2 : v < 4 * s - 2
  · have hz : v - (2 * s - 1) < 2 * s + 1 - 2 := by omega
    have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - ET (v - (2 * s - 1)))
      (by have := ET_lt hz; omega)
    refine ⟨red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - ET (v - (2 * s - 1))), hr.trans (by omega), ?_⟩
    rw [cf_ADp hs hr hc1 hc, vAD', band_Zc hp hd hz]; omega
  by_cases h3 : v < 6 * s - 1
  · have hy : v - (4 * s - 2) < 2 * s + 1 := by omega
    by_cases e1 : v - (4 * s - 2) =
        red (2 * s + 1) (red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - 1) + (2 * s + 1) - 1)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - 1) (by omega)
      refine ⟨red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - 1), hr.trans (by omega), ?_⟩
      rw [cf_ADp hs hr hc1 hc, vAD', band_1c hp hd]; omega
    by_cases e2 : v - (4 * s - 2) = red (2 * s + 1) (red (2 * s + 1) (c - (6 * s - 1) + 1) + (2 * s + 1) - 2)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + 1) (by omega)
      refine ⟨red (2 * s + 1) (c - (6 * s - 1) + 1), hr.trans (by omega), ?_⟩
      rw [cf_ADp hs hr hc1 hc, vAD', band_m1c hp hd]; omega
    · have hr := dW_lt hs hd hy
      refine ⟨4 * s + dW s (c - (6 * s - 1)) (v - (4 * s - 2)), by omega, ?_⟩
      rw [cf_ApDp hs (by omega) (by omega) hc1 hc, vA'D', Nat.add_sub_cancel_left, bandW_Yc hs hd hy e1 e2]; omega
  · have hy : v - (6 * s - 1) < 2 * s + 1 := by omega
    by_cases e1 : v - (6 * s - 1) =
        red (2 * s + 1) (red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - 1) + (2 * s + 1) - 1)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - 1) (by omega)
      refine ⟨4 * s + red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - 1), by omega, ?_⟩
      rw [cf_ApDp hs (by omega) (by omega) hc1 hc, vA'D', Nat.add_sub_cancel_left, bandW_1c hs hd]; omega
    by_cases e2 : v - (6 * s - 1) = red (2 * s + 1) (red (2 * s + 1) (c - (6 * s - 1) + 1) + (2 * s + 1) - 2)
    · have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + 1) (by omega)
      refine ⟨4 * s + red (2 * s + 1) (c - (6 * s - 1) + 1), by omega, ?_⟩
      rw [cf_ApDp hs (by omega) (by omega) hc1 hc, vA'D', Nat.add_sub_cancel_left, bandW_m1c hs hd]; omega
    · have hr := R_small_c hp hd hy e1 e2
      refine ⟨2 * s + 1 + red (2 * s + 1) (v - (6 * s - 1) + (2 * s + 1) - (c - (6 * s - 1))), by omega, ?_⟩
      rw [cf_BDp hs (by omega) (by omega) hc1 hc, vBD', Nat.add_sub_cancel_left, R_sub_add' hd hy]; omega

end QEDSud


namespace QEDSud

open Finset

lemma surj_inj (f : ℕ → ℕ) (L : ℕ) (hlt : ∀ c < L, f c < L) (hs : ∀ v < L, ∃ c < L, f c = v) :
    ∀ c < L, ∀ c' < L, f c = f c' → c = c' := by
  classical
  have himg : (range L).image f = range L := by
    have h2 : range L ⊆ (range L).image f := by
      intro v hv; obtain ⟨c, hc, rfl⟩ := hs v (mem_range.1 hv); exact mem_image.2 ⟨c, mem_range.2 hc, rfl⟩
    apply eq_of_subset_of_card_le _ (card_le_card h2)
    intro v hv; obtain ⟨c, hc, rfl⟩ := mem_image.1 hv; exact mem_range.2 (hlt c (mem_range.1 hc))
  have hinj : Set.InjOn f (range L : Set ℕ) := by
    rw [← card_image_iff, himg]
  intro c hc c' hc' h
  exact hinj (mem_range.2 hc) (mem_range.2 hc') h

theorem drf_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) : drf s x c < 8 * s := by
  by_cases h1 : x < 2 * s + 1
  · exact rowA_lt hs h1 hc
  by_cases h2 : x < 4 * s
  · exact rowB_lt hs (by omega) h2 hc
  by_cases h3 : x < 6 * s + 1
  · exact rowA'_lt hs (by omega) h3 hc
  · exact rowB'_lt hs (by omega) hx hc

theorem drf_surj {s x v : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hv : v < 8 * s) : ∃ c < 8 * s, drf s x c = v := by
  by_cases h1 : x < 2 * s + 1
  · exact rowA_surj hs h1 hv
  by_cases h2 : x < 4 * s
  · exact rowB_surj hs (by omega) h2 hv
  by_cases h3 : x < 6 * s + 1
  · exact rowA'_surj hs (by omega) h3 hv
  · exact rowB'_surj hs (by omega) hx hv

theorem dcf_lt {s x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) : dcf s x c < 8 * s := by
  by_cases h1 : c < 2 * s - 1
  · exact colC_lt hs hx h1
  by_cases h2 : c < 4 * s
  · exact colD_lt hs hx (by omega) h2
  by_cases h3 : c < 6 * s - 1
  · exact colC'_lt hs hx (by omega) h3
  · exact colD'_lt hs hx (by omega) hc

theorem dcf_surj {s c v : ℕ} (hs : 5 ≤ s) (hc : c < 8 * s) (hv : v < 8 * s) : ∃ x < 8 * s, dcf s x c = v := by
  by_cases h1 : c < 2 * s - 1
  · exact colC_surj hs h1 hv
  by_cases h2 : c < 4 * s
  · exact colD_surj hs (by omega) h2 hv
  by_cases h3 : c < 6 * s - 1
  · exact colC'_surj hs (by omega) h3 hv
  · exact colD'_surj hs (by omega) hc hv

theorem drf_inj {s x : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) :
    ∀ c < 8 * s, ∀ c' < 8 * s, drf s x c = drf s x c' → c = c' :=
  surj_inj (drf s x) _ (fun _ hc => drf_lt hs hx hc) (fun _ hv => drf_surj hs hx hv)

theorem dcf_inj {s c : ℕ} (hs : 5 ≤ s) (hc : c < 8 * s) :
    ∀ x < 8 * s, ∀ x' < 8 * s, dcf s x c = dcf s x' c → x = x' :=
  surj_inj (fun x => dcf s x c) _ (fun _ hx => dcf_lt hs hx hc) (fun _ hv => dcf_surj hs hc hv)

/-! ### Live symbols and labels -/

def dlive (s x c v : ℕ) : Bool :=
  if x < 2 * s + 1 then decide (c < 2 * s - 1) && decide (v < 2 * s - 1)
  else if x < 4 * s then
    (if c < 2 * s - 1 then decide (4 * s - 2 ≤ v) && decide (v < 6 * s - 1)
     else if c < 4 * s then decide (2 * s - 1 ≤ v) && decide (v < 4 * s - 2) else false)
  else if x < 6 * s + 1 then
    decide (4 * s ≤ c) && decide (c < 6 * s - 1) && decide (2 * s - 1 ≤ v) && decide (v < 4 * s - 2)
  else if x < 8 * s then
    (if c < 4 * s then false else if c < 6 * s - 1 then decide (6 * s - 1 ≤ v) && decide (v < 8 * s)
     else decide (c < 8 * s) && decide (v < 2 * s - 1))
  else false

def dlab (s x c v : ℕ) : ℕ × ℕ :=
  if x < 2 * s + 1 then (x, red (2 * s - 1) (c + v))
  else if x < 4 * s then
    (if c < 2 * s - 1 then (v - (4 * s - 2), red (2 * s - 1) (x - (2 * s + 1) + c))
     else (c - (2 * s - 1), red (2 * s - 1) (x - (2 * s + 1) + (v - (2 * s - 1)))))
  else if x < 6 * s + 1 then (x - 4 * s, red (2 * s - 1) (c - 4 * s + (v - (2 * s - 1))))
  else
    (if c < 6 * s - 1 then (v - (6 * s - 1), red (2 * s - 1) (x - (6 * s + 1) + (c - 4 * s)))
     else (c - (6 * s - 1), red (2 * s - 1) (x - (6 * s + 1) + v)))

/-- Live symbols are the row-fill of some blank cell of the row, and the column-fill of some
blank cell of the column. -/
lemma live_fill {s x c v : ℕ} (hs : 5 ≤ s) (h : dlive s x c v = true) :
    x < 8 * s ∧ c < 8 * s ∧ v < 8 * s ∧ dblank s x c = true ∧
    (∃ c'' < 8 * s, dblank s x c'' = true ∧ drf s x c'' = v) ∧
    (∃ x'' < 8 * s, dblank s x'' c = true ∧ dcf s x'' c = v) := by
  unfold dlive at h
  by_cases h1 : x < 2 * s + 1
  · simp only [if_pos h1, Bool.and_eq_true, decide_eq_true_eq] at h
    exact ⟨by omega, by omega, by omega, bl_AC hs h1 h.1, ⟨v, by omega, bl_AC hs h1 h.2, rf_AC hs h1 h.2⟩,
      ⟨2 * s + 1 + v, by omega, bl_BC hs (by omega) (by omega) h.1,
        by rw [cf_BC hs (by omega) (by omega) h.1]; omega⟩⟩
  by_cases h2 : x < 4 * s
  · simp only [if_neg h1, if_pos h2] at h
    by_cases h3 : c < 2 * s - 1
    · simp only [if_pos h3, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨by omega, by omega, by omega, bl_BC hs (by omega) h2 h3,
        ⟨2 * s - 1 + (v - (4 * s - 2)), by omega, bl_BD hs (by omega) h2 (by omega) (by omega),
          by rw [rf_BD hs (by omega) h2 (by omega) (by omega)]; omega⟩,
        ⟨v - (4 * s - 2), by omega, bl_AC hs (by omega) h3, by rw [cf_AC hs (by omega) h3]; omega⟩⟩
    by_cases h4 : c < 4 * s
    · simp only [if_neg h3, if_pos h4, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨by omega, by omega, by omega, bl_BD hs (by omega) h2 (by omega) h4,
        ⟨v - (2 * s - 1), by omega, bl_BC hs (by omega) h2 (by omega),
          by rw [rf_BC hs (by omega) h2 (by omega)]; omega⟩,
        ⟨2 * s + 1 + (v - (2 * s - 1)), by omega, bl_BD hs (by omega) (by omega) (by omega) h4,
          by rw [cf_BD hs (by omega) (by omega) (by omega) h4]; omega⟩⟩
    · simp [if_neg h3, if_neg h4] at h
  by_cases h3 : x < 6 * s + 1
  · simp only [if_neg h1, if_neg h2, if_pos h3, Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨⟨⟨hc1, hc2⟩, hv1⟩, hv2⟩ := h
    exact ⟨by omega, by omega, by omega, bl_ApCp hs (by omega) h3 hc1 hc2,
      ⟨4 * s + (v - (2 * s - 1)), by omega, bl_ApCp hs (by omega) h3 (by omega) (by omega),
        by rw [rf_ApCp hs (by omega) h3 (by omega) (by omega)]; omega⟩,
      ⟨6 * s + 1 + (v - (2 * s - 1)), by omega, bl_BpCp hs (by omega) (by omega) hc1 hc2,
        by rw [cf_BpCp hs (by omega) (by omega) hc1 hc2]; omega⟩⟩
  by_cases h4 : x < 8 * s
  · simp only [if_neg h1, if_neg h2, if_neg h3, if_pos h4] at h
    by_cases h5 : c < 4 * s
    · simp [if_pos h5] at h
    by_cases h6 : c < 6 * s - 1
    · simp only [if_neg h5, if_pos h6, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨h4, by omega, h.2, bl_BpCp hs (by omega) h4 (by omega) h6,
        ⟨v, h.2, bl_BpDp hs (by omega) h4 h.1 h.2, by rw [rf_BpDp hs (by omega) h4 h.1 h.2]; omega⟩,
        ⟨4 * s + (v - (6 * s - 1)), by omega, bl_ApCp hs (by omega) (by omega) (by omega) h6,
          by rw [cf_ApCp hs (by omega) (by omega) (by omega) h6]; omega⟩⟩
    · simp only [if_neg h5, if_neg h6, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨h4, h.1, by omega, bl_BpDp hs (by omega) h4 (by omega) h.1,
        ⟨4 * s + v, by omega, bl_BpCp hs (by omega) h4 (by omega) (by omega),
          by rw [rf_BpCp hs (by omega) h4 (by omega) (by omega)]; omega⟩,
        ⟨6 * s + 1 + v, by omega, bl_BpDp hs (by omega) (by omega) (by omega) h.1,
          by rw [cf_BpDp hs (by omega) (by omega) (by omega) h.1]; omega⟩⟩
  · rw [if_neg h1, if_neg h2, if_neg h3, if_neg h4] at h; exact absurd h (by decide)

lemma liveA {s x c v : ℕ} (hx : x < 2 * s + 1) : dlive s x c v = true ↔ c < 2 * s - 1 ∧ v < 2 * s - 1 := by
  unfold dlive; rw [if_pos hx]; simp

lemma liveB {s x c v : ℕ} (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) : dlive s x c v = true ↔
    (c < 2 * s - 1 ∧ 4 * s - 2 ≤ v ∧ v < 6 * s - 1) ∨ (2 * s - 1 ≤ c ∧ c < 4 * s ∧ 2 * s - 1 ≤ v ∧ v < 4 * s - 2) := by
  unfold dlive; rw [if_neg (by omega), if_pos hx]
  split_ifs with h1 h2 <;> simp <;> omega

lemma liveA' {s x c v : ℕ} (hs : 5 ≤ s) (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) : dlive s x c v = true ↔
    4 * s ≤ c ∧ c < 6 * s - 1 ∧ 2 * s - 1 ≤ v ∧ v < 4 * s - 2 := by
  unfold dlive; rw [if_neg (by omega), if_neg (by omega), if_pos hx]; simp; omega

lemma liveB' {s x c v : ℕ} (hs : 5 ≤ s) (hx1 : 6 * s + 1 ≤ x) (hx : x < 8 * s) : dlive s x c v = true ↔
    (4 * s ≤ c ∧ c < 6 * s - 1 ∧ 6 * s - 1 ≤ v ∧ v < 8 * s) ∨ (6 * s - 1 ≤ c ∧ c < 8 * s ∧ v < 2 * s - 1) := by
  unfold dlive; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega), if_pos hx]
  split_ifs with h1 h2 <;> simp <;> omega

lemma labA {s x c v : ℕ} (hx : x < 2 * s + 1) : dlab s x c v = (x, red (2 * s - 1) (c + v)) := by
  unfold dlab; rw [if_pos hx]

lemma labBC {s x c v : ℕ} (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) (hc : c < 2 * s - 1) :
    dlab s x c v = (v - (4 * s - 2), red (2 * s - 1) (x - (2 * s + 1) + c)) := by
  unfold dlab; rw [if_neg (by omega), if_pos hx, if_pos hc]

lemma labBD {s x c v : ℕ} (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) (hc : 2 * s - 1 ≤ c) :
    dlab s x c v = (c - (2 * s - 1), red (2 * s - 1) (x - (2 * s + 1) + (v - (2 * s - 1)))) := by
  unfold dlab; rw [if_neg (by omega), if_pos hx, if_neg (by omega)]

lemma labA' {s x c v : ℕ} (hs : 5 ≤ s) (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) :
    dlab s x c v = (x - 4 * s, red (2 * s - 1) (c - 4 * s + (v - (2 * s - 1)))) := by
  unfold dlab; rw [if_neg (by omega), if_neg (by omega), if_pos hx]

lemma labB'C' {s x c v : ℕ} (hs : 5 ≤ s) (hx1 : 6 * s + 1 ≤ x) (hc : c < 6 * s - 1) :
    dlab s x c v = (v - (6 * s - 1), red (2 * s - 1) (x - (6 * s + 1) + (c - 4 * s))) := by
  unfold dlab; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega), if_pos hc]

lemma labB'D' {s x c v : ℕ} (hs : 5 ≤ s) (hx1 : 6 * s + 1 ≤ x) (hc : 6 * s - 1 ≤ c) :
    dlab s x c v = (c - (6 * s - 1), red (2 * s - 1) (x - (6 * s + 1) + v)) := by
  unfold dlab; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega), if_neg (by omega)]

theorem dlive_ok {s r c v : ℕ} (hs : 5 ≤ s) (h : dlive s r c v = true) :
    r < 8 * s ∧ c < 8 * s ∧ v < 8 * s ∧ dblank s r c = true ∧
    (∀ c' < 8 * s, drf s r c' = v → dblank s r c' = true) ∧
    (∀ r' < 8 * s, dcf s r' c = v → dblank s r' c = true) := by
  obtain ⟨hr, hc, hv, hb, ⟨c'', hc'', hb'', he''⟩, ⟨r'', hr'', hbr, her⟩⟩ := live_fill hs h
  refine ⟨hr, hc, hv, hb, fun c' hc' he => ?_, fun r' hr' he => ?_⟩
  · rw [drf_inj hs hr c' hc' c'' hc'' (he.trans he''.symm)]; exact hb''
  · rw [dcf_inj hs hc r' hr' r'' hr'' (he.trans her.symm)]; exact hbr

end QEDSud


namespace QEDSud

lemma line_pig {L P0 H : ℕ} {P : ℕ → Bool} {f : ℕ → ℕ × ℕ} (lo hi i : ℕ) (g w : ℕ → ℕ)
    (hi0 : i < P0) (hP : ∀ x, P x = true ↔ lo ≤ x ∧ x < hi) (hhi : hi ≤ L)
    (hf : ∀ x, lo ≤ x → x < hi → f x = (i, g x)) (hg : ∀ x, lo ≤ x → x < hi → g x < H)
    (hinj : ∀ x y, lo ≤ x → x < hi → lo ≤ y → y < hi → g x = g y → x = y)
    (hw : ∀ j < H, lo ≤ w j ∧ w j < hi ∧ g (w j) = j) : LineN L P0 H P f := by
  refine ⟨fun x _ y _ hx hy h => ?_, Or.inl ⟨i, hi0, fun x _ hx => ?_, fun j hj => ?_⟩⟩
  · rw [hP] at hx hy
    rw [hf x hx.1 hx.2, hf y hy.1 hy.2] at h
    exact hinj x y hx.1 hx.2 hy.1 hy.2 (Prod.mk.inj h).2
  · rw [hP] at hx; rw [hf x hx.1 hx.2]; exact ⟨rfl, hg x hx.1 hx.2⟩
  · obtain ⟨h1, h2, h3⟩ := hw j hj
    exact ⟨w j, by omega, (hP _).2 ⟨h1, h2⟩, by rw [hf _ h1 h2, h3]⟩

lemma line_hole {L P0 H : ℕ} {P : ℕ → Bool} {f : ℕ → ℕ × ℕ} (lo hi j : ℕ) (g w : ℕ → ℕ)
    (hj0 : j < H) (hP : ∀ x, P x = true ↔ lo ≤ x ∧ x < hi) (hhi : hi ≤ L)
    (hf : ∀ x, lo ≤ x → x < hi → f x = (g x, j)) (hg : ∀ x, lo ≤ x → x < hi → g x < P0)
    (hinj : ∀ x y, lo ≤ x → x < hi → lo ≤ y → y < hi → g x = g y → x = y)
    (hw : ∀ i < P0, lo ≤ w i ∧ w i < hi ∧ g (w i) = i) : LineN L P0 H P f := by
  refine ⟨fun x _ y _ hx hy h => ?_, Or.inr ⟨j, hj0, fun x _ hx => ?_, fun i hi => ?_⟩⟩
  · rw [hP] at hx hy
    rw [hf x hx.1 hx.2, hf y hy.1 hy.2] at h
    exact hinj x y hx.1 hx.2 hy.1 hy.2 (Prod.mk.inj h).1
  · rw [hP] at hx; rw [hf x hx.1 hx.2]; exact ⟨rfl, hg x hx.1 hx.2⟩
  · obtain ⟨h1, h2, h3⟩ := hw i hi
    exact ⟨w i, by omega, (hP _).2 ⟨h1, h2⟩, by rw [hf _ h1 h2, h3]⟩

lemma live_big {s x c v : ℕ} (hs : 5 ≤ s) (hx : 8 * s ≤ x) : dlive s x c v = false := by
  unfold dlive; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega), if_neg (by omega)]

/-- Column characterisation of liveness. -/
lemma live_col {s c v : ℕ} (hs : 5 ≤ s) (r : ℕ) : dlive s r c v = true ↔
    (r < 2 * s + 1 ∧ c < 2 * s - 1 ∧ v < 2 * s - 1) ∨
    (2 * s + 1 ≤ r ∧ r < 4 * s ∧ ((c < 2 * s - 1 ∧ 4 * s - 2 ≤ v ∧ v < 6 * s - 1) ∨
      (2 * s - 1 ≤ c ∧ c < 4 * s ∧ 2 * s - 1 ≤ v ∧ v < 4 * s - 2))) ∨
    (4 * s ≤ r ∧ r < 6 * s + 1 ∧ 4 * s ≤ c ∧ c < 6 * s - 1 ∧ 2 * s - 1 ≤ v ∧ v < 4 * s - 2) ∨
    (6 * s + 1 ≤ r ∧ r < 8 * s ∧ ((4 * s ≤ c ∧ c < 6 * s - 1 ∧ 6 * s - 1 ≤ v ∧ v < 8 * s) ∨
      (6 * s - 1 ≤ c ∧ c < 8 * s ∧ v < 2 * s - 1))) := by
  by_cases h1 : r < 2 * s + 1
  · rw [liveA h1]; omega
  by_cases h2 : r < 4 * s
  · rw [liveB (by omega) h2]; omega
  by_cases h3 : r < 6 * s + 1
  · rw [liveA' hs (by omega) h3]; omega
  by_cases h4 : r < 8 * s
  · rw [liveB' hs (by omega) h4]; omega
  · rw [live_big hs (by omega)]; simp; omega

variable {s : ℕ}

/-! ### Cell lines -/

theorem cell_line {x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) (hb : dblank s x c = true) :
    LineN (8 * s) (2 + (2 * s - 1)) (2 * s - 1) (dlive s x c) (dlab s x c) := by
  have hP0 : 2 + (2 * s - 1) = 2 * s + 1 := by omega
  rw [hP0]
  unfold dblank at hb
  by_cases h1 : x < 2 * s + 1
  · simp only [if_pos h1, decide_eq_true_eq] at hb
    refine line_pig 0 (2 * s - 1) x (fun v => red (2 * s - 1) (c + v)) (fun w => red (2 * s - 1) (w + (2 * s - 1) - c))
      h1 (fun v => by rw [liveA h1]; omega) (by omega) (fun v _ _ => labA h1)
      (fun v _ hv => R_lt hb hv) (fun v v' _ hv _ hv' h => R_add_inj hb hv hv' h)
      (fun w hw => ⟨by omega, R_lt' (by omega), R_add_sub hb hw⟩)
  by_cases h2 : x < 4 * s
  · simp only [if_neg h1, if_pos h2, decide_eq_true_eq] at hb
    have hk : x - (2 * s + 1) < 2 * s - 1 := by omega
    by_cases h3 : c < 2 * s - 1
    · refine line_hole (4 * s - 2) (6 * s - 1) (red (2 * s - 1) (x - (2 * s + 1) + c)) (fun v => v - (4 * s - 2))
        (fun i => 4 * s - 2 + i) (R_lt hk h3) (fun v => by rw [liveB (by omega) h2]; omega) (by omega)
        (fun v _ _ => labBC (by omega) h2 h3) (fun v _ _ => by omega) (fun v v' _ _ _ _ h => by omega)
        (fun i hi => ⟨by omega, by omega, by omega⟩)
    · refine line_pig (2 * s - 1) (4 * s - 2) (c - (2 * s - 1))
        (fun v => red (2 * s - 1) (x - (2 * s + 1) + (v - (2 * s - 1))))
        (fun w => 2 * s - 1 + red (2 * s - 1) (w + (2 * s - 1) - (x - (2 * s + 1)))) (by omega)
        (fun v => by rw [liveB (by omega) h2]; omega) (by omega) (fun v _ _ => labBD (by omega) h2 (by omega))
        (fun v _ _ => R_lt hk (by omega)) (fun v v' _ _ _ _ h => by have := R_add_inj hk (by omega) (by omega) h; omega)
        (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (x - (2 * s + 1))) (by omega); omega,
          by simp only [Nat.add_sub_cancel_left]; exact R_add_sub hk hw⟩)
  by_cases h3 : x < 6 * s + 1
  · simp only [if_neg h1, if_neg h2, if_pos h3, Bool.and_eq_true, decide_eq_true_eq] at hb
    have hj : c - 4 * s < 2 * s - 1 := by omega
    refine line_pig (2 * s - 1) (4 * s - 2) (x - 4 * s) (fun v => red (2 * s - 1) (c - 4 * s + (v - (2 * s - 1))))
      (fun w => 2 * s - 1 + red (2 * s - 1) (w + (2 * s - 1) - (c - 4 * s))) (by omega)
      (fun v => by rw [liveA' hs (by omega) h3]; omega) (by omega) (fun v _ _ => labA' hs (by omega) h3)
      (fun v _ _ => R_lt hj (by omega)) (fun v v' _ _ _ _ h => by have := R_add_inj hj (by omega) (by omega) h; omega)
      (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (c - 4 * s)) (by omega); omega,
        by simp only [Nat.add_sub_cancel_left]; exact R_add_sub hj hw⟩)
  · simp only [if_neg h1, if_neg h2, if_neg h3, decide_eq_true_eq] at hb
    have hk : x - (6 * s + 1) < 2 * s - 1 := by omega
    by_cases h4 : c < 6 * s - 1
    · refine line_hole (6 * s - 1) (8 * s) (red (2 * s - 1) (x - (6 * s + 1) + (c - 4 * s))) (fun v => v - (6 * s - 1))
        (fun i => 6 * s - 1 + i) (R_lt hk (by omega)) (fun v => by rw [liveB' hs (by omega) hx]; omega) le_rfl
        (fun v _ _ => labB'C' hs (by omega) h4) (fun v _ _ => by omega) (fun v v' _ _ _ _ h => by omega)
        (fun i hi => ⟨by omega, by omega, by omega⟩)
    · refine line_pig 0 (2 * s - 1) (c - (6 * s - 1)) (fun v => red (2 * s - 1) (x - (6 * s + 1) + v))
        (fun w => red (2 * s - 1) (w + (2 * s - 1) - (x - (6 * s + 1)))) (by omega)
        (fun v => by rw [liveB' hs (by omega) hx]; omega) (by omega) (fun v _ _ => labB'D' hs (by omega) (by omega))
        (fun v _ hv => R_lt hk hv) (fun v v' _ hv _ hv' h => R_add_inj hk hv hv' h)
        (fun w hw => ⟨by omega, R_lt' (by omega), R_add_sub hk hw⟩)

/-! ### Row lines -/

theorem row_line {x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) (hb : dblank s x c = true) :
    LineN (8 * s) (2 + (2 * s - 1)) (2 * s - 1) (fun c' => dlive s x c' (drf s x c))
      (fun c' => dlab s x c' (drf s x c)) := by
  have hP0 : 2 + (2 * s - 1) = 2 * s + 1 := by omega
  rw [hP0]
  have hb' := hb
  unfold dblank at hb
  by_cases h1 : x < 2 * s + 1
  · simp only [if_pos h1, decide_eq_true_eq] at hb
    rw [rf_AC hs h1 hb]
    refine line_pig 0 (2 * s - 1) x (fun c' => red (2 * s - 1) (c' + c)) (fun w => red (2 * s - 1) (w + (2 * s - 1) - c))
      h1 (fun c' => by rw [liveA h1]; omega) (by omega) (fun c' _ _ => labA h1)
      (fun c' _ hc' => R_lt hc' hb) (fun c' c'' _ h' _ h'' h => R_add_inj' hb h' h'' h)
      (fun w hw => ⟨by omega, R_lt' (by omega), R_sub_add' hb hw⟩)
  by_cases h2 : x < 4 * s
  · simp only [if_neg h1, if_pos h2, decide_eq_true_eq] at hb
    have hk : x - (2 * s + 1) < 2 * s - 1 := by omega
    by_cases h3 : c < 2 * s - 1
    · rw [rf_BC hs (by omega) h2 h3]
      refine line_hole (2 * s - 1) (4 * s) (red (2 * s - 1) (x - (2 * s + 1) + c)) (fun c' => c' - (2 * s - 1))
        (fun i => 2 * s - 1 + i) (R_lt hk h3) (fun c' => by rw [liveB (by omega) h2]; omega) (by omega)
        (fun c' _ _ => by rw [labBD (by omega) h2 (by omega)]; congr 3; omega) (fun c' _ _ => by omega)
        (fun c' c'' _ _ _ _ h => by omega) (fun i hi => ⟨by omega, by omega, by omega⟩)
    · rw [rf_BD hs (by omega) h2 (by omega) hb]
      refine line_pig 0 (2 * s - 1) (c - (2 * s - 1)) (fun c' => red (2 * s - 1) (x - (2 * s + 1) + c'))
        (fun w => red (2 * s - 1) (w + (2 * s - 1) - (x - (2 * s + 1)))) (by omega)
        (fun c' => by rw [liveB (by omega) h2]; omega) (by omega)
        (fun c' _ hc' => by rw [labBC (by omega) h2 hc']; congr 1; omega)
        (fun c' _ hc' => R_lt hk hc') (fun c' c'' _ h' _ h'' h => R_add_inj hk h' h'' h)
        (fun w hw => ⟨by omega, R_lt' (by omega), R_add_sub hk hw⟩)
  by_cases h3 : x < 6 * s + 1
  · simp only [if_neg h1, if_neg h2, if_pos h3, Bool.and_eq_true, decide_eq_true_eq] at hb
    have hj : c - 4 * s < 2 * s - 1 := by omega
    rw [rf_ApCp hs (by omega) h3 hb.1 hb.2]
    refine line_pig (4 * s) (6 * s - 1) (x - 4 * s) (fun c' => red (2 * s - 1) (c' - 4 * s + (c - 4 * s)))
      (fun w => 4 * s + red (2 * s - 1) (w + (2 * s - 1) - (c - 4 * s))) (by omega)
      (fun c' => by rw [liveA' hs (by omega) h3]; omega) (by omega)
      (fun c' _ _ => by rw [labA' hs (by omega) h3]; congr 3; omega)
      (fun c' _ _ => R_lt (by omega) hj) (fun c' c'' _ _ _ _ h => by have := R_add_inj' hj (by omega) (by omega) h; omega)
      (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (c - 4 * s)) (by omega); omega,
        by simp only [Nat.add_sub_cancel_left]; exact R_sub_add' hj hw⟩)
  · simp only [if_neg h1, if_neg h2, if_neg h3, decide_eq_true_eq] at hb
    have hk : x - (6 * s + 1) < 2 * s - 1 := by omega
    by_cases h4 : c < 6 * s - 1
    · rw [rf_BpCp hs (by omega) hx hb h4]
      refine line_hole (6 * s - 1) (8 * s) (red (2 * s - 1) (x - (6 * s + 1) + (c - 4 * s))) (fun c' => c' - (6 * s - 1))
        (fun i => 6 * s - 1 + i) (R_lt hk (by omega)) (fun c' => by rw [liveB' hs (by omega) hx]; omega) le_rfl
        (fun c' _ _ => labB'D' hs (by omega) (by omega)) (fun c' _ _ => by omega) (fun c' c'' _ _ _ _ h => by omega)
        (fun i hi => ⟨by omega, by omega, by omega⟩)
    · rw [rf_BpDp hs (by omega) hx (by omega) hc]
      refine line_pig (4 * s) (6 * s - 1) (c - (6 * s - 1)) (fun c' => red (2 * s - 1) (x - (6 * s + 1) + (c' - 4 * s)))
        (fun w => 4 * s + red (2 * s - 1) (w + (2 * s - 1) - (x - (6 * s + 1)))) (by omega)
        (fun c' => by rw [liveB' hs (by omega) hx]; omega) (by omega)
        (fun c' _ hc' => by rw [labB'C' hs (by omega) hc']; congr 1; omega)
        (fun c' _ _ => R_lt hk (by omega)) (fun c' c'' _ _ _ _ h => by have := R_add_inj hk (by omega) (by omega) h; omega)
        (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (x - (6 * s + 1))) (by omega); omega,
          by simp only [Nat.add_sub_cancel_left]; exact R_add_sub hk hw⟩)

/-! ### Column lines -/

theorem col_line {x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) (hb : dblank s x c = true) :
    LineN (8 * s) (2 + (2 * s - 1)) (2 * s - 1) (fun r' => dlive s r' c (dcf s x c))
      (fun r' => dlab s r' c (dcf s x c)) := by
  have hP0 : 2 + (2 * s - 1) = 2 * s + 1 := by omega
  rw [hP0]
  unfold dblank at hb
  by_cases h1 : x < 2 * s + 1
  · simp only [if_pos h1, decide_eq_true_eq] at hb
    rw [cf_AC hs h1 hb]
    refine line_pig (2 * s + 1) (4 * s) x (fun r' => red (2 * s - 1) (r' - (2 * s + 1) + c))
      (fun w => 2 * s + 1 + red (2 * s - 1) (w + (2 * s - 1) - c)) h1
      (fun r' => by rw [live_col hs]; omega) (by omega)
      (fun r' h' h'' => by rw [labBC h' h'' hb]; congr 1; omega)
      (fun r' _ _ => R_lt (by omega) hb) (fun r' r'' _ _ _ _ h => by have := R_add_inj' hb (by omega) (by omega) h; omega)
      (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - c) (by omega); omega,
        by simp only [Nat.add_sub_cancel_left]; exact R_sub_add' hb hw⟩)
  by_cases h2 : x < 4 * s
  · simp only [if_neg h1, if_pos h2, decide_eq_true_eq] at hb
    have hk : x - (2 * s + 1) < 2 * s - 1 := by omega
    by_cases h3 : c < 2 * s - 1
    · rw [cf_BC hs (by omega) h2 h3]
      refine line_hole 0 (2 * s + 1) (red (2 * s - 1) (c + (x - (2 * s + 1)))) (fun r' => r') (fun i => i)
        (R_lt h3 hk) (fun r' => by rw [live_col hs]; omega) (by omega)
        (fun r' _ h' => labA h') (fun r' _ h' => h') (fun r' r'' _ _ _ _ h => h)
        (fun i hi => ⟨by omega, hi, rfl⟩)
    · rw [cf_BD hs (by omega) h2 (by omega) hb]
      refine line_pig (2 * s + 1) (4 * s) (c - (2 * s - 1)) (fun r' => red (2 * s - 1) (r' - (2 * s + 1) + (x - (2 * s + 1))))
        (fun w => 2 * s + 1 + red (2 * s - 1) (w + (2 * s - 1) - (x - (2 * s + 1)))) (by omega)
        (fun r' => by rw [live_col hs]; omega) (by omega)
        (fun r' h' h'' => by rw [labBD h' h'' (by omega)]; congr 3; omega)
        (fun r' _ _ => R_lt (by omega) hk) (fun r' r'' _ _ _ _ h => by have := R_add_inj' hk (by omega) (by omega) h; omega)
        (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (x - (2 * s + 1))) (by omega); omega,
          by simp only [Nat.add_sub_cancel_left]; exact R_sub_add' hk hw⟩)
  by_cases h3 : x < 6 * s + 1
  · simp only [if_neg h1, if_neg h2, if_pos h3, Bool.and_eq_true, decide_eq_true_eq] at hb
    have hj : c - 4 * s < 2 * s - 1 := by omega
    rw [cf_ApCp hs (by omega) h3 hb.1 hb.2]
    refine line_pig (6 * s + 1) (8 * s) (x - 4 * s) (fun r' => red (2 * s - 1) (r' - (6 * s + 1) + (c - 4 * s)))
      (fun w => 6 * s + 1 + red (2 * s - 1) (w + (2 * s - 1) - (c - 4 * s))) (by omega)
      (fun r' => by rw [live_col hs]; omega) le_rfl
      (fun r' h' _ => by rw [labB'C' hs h' hb.2]; congr 1; omega)
      (fun r' _ _ => R_lt (by omega) hj) (fun r' r'' _ _ _ _ h => by have := R_add_inj' hj (by omega) (by omega) h; omega)
      (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (c - 4 * s)) (by omega); omega,
        by simp only [Nat.add_sub_cancel_left]; exact R_sub_add' hj hw⟩)
  · simp only [if_neg h1, if_neg h2, if_neg h3, decide_eq_true_eq] at hb
    have hk : x - (6 * s + 1) < 2 * s - 1 := by omega
    by_cases h4 : c < 6 * s - 1
    · rw [cf_BpCp hs (by omega) hx hb h4]
      refine line_hole (4 * s) (6 * s + 1) (red (2 * s - 1) (c - 4 * s + (x - (6 * s + 1)))) (fun r' => r' - 4 * s)
        (fun i => 4 * s + i) (R_lt (by omega) hk) (fun r' => by rw [live_col hs]; omega) (by omega)
        (fun r' h' h'' => by rw [labA' hs h' h'']; congr 3; omega) (fun r' _ _ => by omega)
        (fun r' r'' _ _ _ _ h => by omega) (fun i hi => ⟨by omega, by omega, by omega⟩)
    · rw [cf_BpDp hs (by omega) hx (by omega) hc]
      refine line_pig (6 * s + 1) (8 * s) (c - (6 * s - 1)) (fun r' => red (2 * s - 1) (r' - (6 * s + 1) + (x - (6 * s + 1))))
        (fun w => 6 * s + 1 + red (2 * s - 1) (w + (2 * s - 1) - (x - (6 * s + 1)))) (by omega)
        (fun r' => by rw [live_col hs]; omega) le_rfl
        (fun r' h' _ => labB'D' hs h' (by omega))
        (fun r' _ _ => R_lt (by omega) hk) (fun r' r'' _ _ _ _ h => by have := R_add_inj' hk (by omega) (by omega) h; omega)
        (fun w hw => ⟨by omega, by have := R_lt' (m := 2 * s - 1) (y := w + (2 * s - 1) - (x - (6 * s + 1))) (by omega); omega,
          by simp only [Nat.add_sub_cancel_left]; exact R_sub_add' hk hw⟩)

end QEDSud


namespace QEDSud

/-! ### Transversals -/

def dsg (s t x : ℕ) : ℕ :=
  if x < 2 * s + 1 then 2 * s - 1 + red (2 * s + 1) (x + t)
  else if x < 4 * s then 4 * s + red (2 * s - 1) (x - (2 * s + 1) + t)
  else if x < 6 * s + 1 then 6 * s - 1 + red (2 * s + 1) (x - 4 * s + ET t)
  else red (2 * s - 1) (x - (6 * s + 1) + t)

def dsi (s t c : ℕ) : ℕ :=
  if c < 2 * s - 1 then 6 * s + 1 + red (2 * s - 1) (c + (2 * s - 1) - t)
  else if c < 4 * s then red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - t)
  else if c < 6 * s - 1 then 2 * s + 1 + red (2 * s - 1) (c - 4 * s + (2 * s - 1) - t)
  else 4 * s + red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - ET t)

def dtrq (s x c : ℕ) : ℕ :=
  if x < 2 * s + 1 then
    (if c < 2 * s - 1 then 8 else if c < 4 * s then red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - x) else 8)
  else if x < 4 * s then
    (if c < 4 * s then 8 else if c < 6 * s - 1 then red (2 * s - 1) (c - 4 * s + (2 * s - 1) - (x - (2 * s + 1)))
      else 8)
  else if x < 6 * s + 1 then
    (if c < 6 * s - 1 then 8
     else if red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = 0 then 0
     else if red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = 1 then 8
     else red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) - 1)
  else (if c < 2 * s - 1 then red (2 * s - 1) (c + (2 * s - 1) - (x - (6 * s + 1))) else 8)

lemma ET_le {t : ℕ} (ht : t < 8) : ET t ≤ 8 := by unfold ET; split_ifs <;> omega

lemma R_back {m x t : ℕ} (hx : x < m) (ht : t < m) : red m (red m (x + t) + m - t) = x := by
  unfold red; split_ifs <;> omega

lemma R_fwd {m c t : ℕ} (hc : c < m) (ht : t < m) : red m (red m (c + m - t) + t) = c := by
  unfold red; split_ifs <;> omega

variable {s t : ℕ}

lemma sg_A {x : ℕ} (hx : x < 2 * s + 1) : dsg s t x = 2 * s - 1 + red (2 * s + 1) (x + t) := by
  unfold dsg; rw [if_pos hx]
lemma sg_B {x : ℕ} (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) :
    dsg s t x = 4 * s + red (2 * s - 1) (x - (2 * s + 1) + t) := by
  unfold dsg; rw [if_neg (by omega), if_pos hx]
lemma sg_A' {x : ℕ} (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) (hs : 5 ≤ s) :
    dsg s t x = 6 * s - 1 + red (2 * s + 1) (x - 4 * s + ET t) := by
  unfold dsg; rw [if_neg (by omega), if_neg (by omega), if_pos hx]
lemma sg_B' {x : ℕ} (hx1 : 6 * s + 1 ≤ x) (hs : 5 ≤ s) : dsg s t x = red (2 * s - 1) (x - (6 * s + 1) + t) := by
  unfold dsg; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega)]

lemma si_C {c : ℕ} (hc : c < 2 * s - 1) : dsi s t c = 6 * s + 1 + red (2 * s - 1) (c + (2 * s - 1) - t) := by
  unfold dsi; rw [if_pos hc]
lemma si_D {c : ℕ} (hc1 : 2 * s - 1 ≤ c) (hc : c < 4 * s) :
    dsi s t c = red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - t) := by
  unfold dsi; rw [if_neg (by omega), if_pos hc]
lemma si_C' {c : ℕ} (hc1 : 4 * s ≤ c) (hc : c < 6 * s - 1) :
    dsi s t c = 2 * s + 1 + red (2 * s - 1) (c - 4 * s + (2 * s - 1) - t) := by
  unfold dsi; rw [if_neg (by omega), if_neg (by omega), if_pos hc]
lemma si_D' {c : ℕ} (hc1 : 6 * s - 1 ≤ c) (hs : 5 ≤ s) :
    dsi s t c = 4 * s + red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - ET t) := by
  unfold dsi; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega)]

theorem dsg_lt {x : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hx : x < 8 * s) : dsg s t x < 8 * s := by
  have := ET_le ht
  by_cases h1 : x < 2 * s + 1
  · rw [sg_A h1]; have := R_lt' (m := 2 * s + 1) (y := x + t) (by omega); omega
  by_cases h2 : x < 4 * s
  · rw [sg_B (by omega) h2]; have := R_lt' (m := 2 * s - 1) (y := x - (2 * s + 1) + t) (by omega); omega
  by_cases h3 : x < 6 * s + 1
  · rw [sg_A' (by omega) h3 hs]; have := R_lt' (m := 2 * s + 1) (y := x - 4 * s + ET t) (by omega); omega
  · rw [sg_B' (by omega) hs]; have := R_lt' (m := 2 * s - 1) (y := x - (6 * s + 1) + t) (by omega); omega

theorem dsi_lt {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc : c < 8 * s) : dsi s t c < 8 * s := by
  have := ET_le ht
  by_cases h1 : c < 2 * s - 1
  · rw [si_C h1]; have := R_lt' (m := 2 * s - 1) (y := c + (2 * s - 1) - t) (by omega); omega
  by_cases h2 : c < 4 * s
  · rw [si_D (by omega) h2]; have := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + (2 * s + 1) - t) (by omega); omega
  by_cases h3 : c < 6 * s - 1
  · rw [si_C' (by omega) h3]; have := R_lt' (m := 2 * s - 1) (y := c - 4 * s + (2 * s - 1) - t) (by omega); omega
  · rw [si_D' (by omega) hs]; have := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - ET t) (by omega); omega

theorem dsi_sg {x : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hx : x < 8 * s) : dsi s t (dsg s t x) = x := by
  have := ET_le ht
  by_cases h1 : x < 2 * s + 1
  · have hr := R_lt' (m := 2 * s + 1) (y := x + t) (by omega)
    rw [sg_A h1, si_D (by omega) (by omega), Nat.add_sub_cancel_left, R_back h1 (by omega)]
  by_cases h2 : x < 4 * s
  · have hr := R_lt' (m := 2 * s - 1) (y := x - (2 * s + 1) + t) (by omega)
    rw [sg_B (by omega) h2, si_C' (by omega) (by omega), Nat.add_sub_cancel_left, R_back (by omega) (by omega)]; omega
  by_cases h3 : x < 6 * s + 1
  · have hr := R_lt' (m := 2 * s + 1) (y := x - 4 * s + ET t) (by omega)
    rw [sg_A' (by omega) h3 hs, si_D' (by omega) hs, Nat.add_sub_cancel_left, R_back (by omega) (by omega)]; omega
  · have hr := R_lt' (m := 2 * s - 1) (y := x - (6 * s + 1) + t) (by omega)
    rw [sg_B' (by omega) hs, si_C hr, R_back (by omega) (by omega)]; omega

theorem dsg_si {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc : c < 8 * s) : dsg s t (dsi s t c) = c := by
  have := ET_le ht
  by_cases h1 : c < 2 * s - 1
  · have hr := R_lt' (m := 2 * s - 1) (y := c + (2 * s - 1) - t) (by omega)
    rw [si_C h1, sg_B' (by omega) hs, Nat.add_sub_cancel_left, R_fwd h1 (by omega)]
  by_cases h2 : c < 4 * s
  · have hr := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + (2 * s + 1) - t) (by omega)
    rw [si_D (by omega) h2, sg_A hr, R_fwd (by omega) (by omega)]; omega
  by_cases h3 : c < 6 * s - 1
  · have hr := R_lt' (m := 2 * s - 1) (y := c - 4 * s + (2 * s - 1) - t) (by omega)
    rw [si_C' (by omega) h3, sg_B (by omega) (by omega), Nat.add_sub_cancel_left, R_fwd (by omega) (by omega)]; omega
  · have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - ET t) (by omega)
    rw [si_D' (by omega) hs, sg_A' (by omega) (by omega) hs, Nat.add_sub_cancel_left, R_fwd (by omega) (by omega)]; omega

theorem dsg_ne {x u : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hu : u < 8) (htu : t ≠ u) (hx : x < 8 * s) :
    dsg s t x ≠ dsg s u x := by
  intro h
  by_cases h1 : x < 2 * s + 1
  · rw [sg_A h1, sg_A h1] at h; have := R_add_inj (m := 2 * s + 1) (u := x) h1 (show t < 2 * s + 1 by omega) (show u < 2 * s + 1 by omega) (by omega); omega
  by_cases h2 : x < 4 * s
  · rw [sg_B (by omega) h2, sg_B (by omega) h2] at h
    have := R_add_inj (m := 2 * s - 1) (u := x - (2 * s + 1)) (by omega) (show t < 2 * s - 1 by omega)
      (show u < 2 * s - 1 by omega) (by omega); omega
  by_cases h3 : x < 6 * s + 1
  · rw [sg_A' (by omega) h3 hs, sg_A' (by omega) h3 hs] at h
    have h4 := ET_le ht; have h5 := ET_le hu
    have := R_add_inj (m := 2 * s + 1) (u := x - 4 * s) (by omega) (show ET t < 2 * s + 1 by omega)
      (show ET u < 2 * s + 1 by omega) (by omega)
    unfold ET at this; split_ifs at this <;> omega
  · rw [sg_B' (by omega) hs, sg_B' (by omega) hs] at h
    have := R_add_inj (m := 2 * s - 1) (u := x - (6 * s + 1)) (by omega) (show t < 2 * s - 1 by omega)
      (show u < 2 * s - 1 by omega) h; omega

theorem dsg_nb {x : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hx : x < 8 * s) : dblank s x (dsg s t x) = false := by
  have := ET_le ht
  by_cases h1 : x < 2 * s + 1
  · rw [sg_A h1]; have := R_lt' (m := 2 * s + 1) (y := x + t) (by omega)
    exact bl_AD hs h1 (by omega) (by omega)
  by_cases h2 : x < 4 * s
  · rw [sg_B (by omega) h2]; have := R_lt' (m := 2 * s - 1) (y := x - (2 * s + 1) + t) (by omega)
    exact bl_BCp hs (by omega) h2 (by omega) (by omega)
  by_cases h3 : x < 6 * s + 1
  · rw [sg_A' (by omega) h3 hs]; have := R_lt' (m := 2 * s + 1) (y := x - 4 * s + ET t) (by omega)
    exact bl_ApDp hs (by omega) h3 (by omega) (by omega)
  · rw [sg_B' (by omega) hs]; have := R_lt' (m := 2 * s - 1) (y := x - (6 * s + 1) + t) (by omega)
    exact bl_BpC hs (by omega) hx (by omega)

lemma trq_A {x c : ℕ} (hx : x < 2 * s + 1) (hc1 : 2 * s - 1 ≤ c) (hc : c < 4 * s) :
    dtrq s x c = red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - x) := by
  unfold dtrq; rw [if_pos hx, if_neg (by omega), if_pos hc]
lemma trq_B {x c : ℕ} (hx1 : 2 * s + 1 ≤ x) (hx : x < 4 * s) (hc1 : 4 * s ≤ c) (hc : c < 6 * s - 1) :
    dtrq s x c = red (2 * s - 1) (c - 4 * s + (2 * s - 1) - (x - (2 * s + 1))) := by
  unfold dtrq; rw [if_neg (by omega), if_pos hx, if_neg (by omega), if_pos hc]
lemma trq_A' {x c : ℕ} (hx1 : 4 * s ≤ x) (hx : x < 6 * s + 1) (hc1 : 6 * s - 1 ≤ c) (hs : 5 ≤ s) :
    dtrq s x c = (if red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = 0 then 0
     else if red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = 1 then 8
     else red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) - 1) := by
  unfold dtrq; rw [if_neg (by omega), if_neg (by omega), if_pos hx, if_neg (by omega)]
lemma trq_B' {x c : ℕ} (hx1 : 6 * s + 1 ≤ x) (hc : c < 2 * s - 1) (hs : 5 ≤ s) :
    dtrq s x c = red (2 * s - 1) (c + (2 * s - 1) - (x - (6 * s + 1))) := by
  unfold dtrq; rw [if_neg (by omega), if_neg (by omega), if_neg (by omega), if_pos hc]

theorem dtrq_sg {x : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hx : x < 8 * s) : dtrq s x (dsg s t x) = t := by
  have := ET_le ht
  by_cases h1 : x < 2 * s + 1
  · have hr := R_lt' (m := 2 * s + 1) (y := x + t) (by omega)
    rw [sg_A h1, trq_A h1 (by omega) (by omega), Nat.add_sub_cancel_left, R_sub_add h1 (by omega)]
  by_cases h2 : x < 4 * s
  · have hr := R_lt' (m := 2 * s - 1) (y := x - (2 * s + 1) + t) (by omega)
    rw [sg_B (by omega) h2, trq_B (by omega) h2 (by omega) (by omega), Nat.add_sub_cancel_left,
      R_sub_add (by omega) (by omega)]
  by_cases h3 : x < 6 * s + 1
  · have hr := R_lt' (m := 2 * s + 1) (y := x - 4 * s + ET t) (by omega)
    have hc : dsg s t x = 6 * s - 1 + red (2 * s + 1) (x - 4 * s + ET t) := sg_A' (by omega) h3 hs
    have he : red (2 * s + 1) (dsg s t x - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = ET t := by
      rw [hc, Nat.add_sub_cancel_left]; exact R_sub_add (by omega) (by omega)
    rw [trq_A' (by omega) h3 (by rw [hc]; omega) hs, he]
    by_cases t0 : t = 0
    · subst t0; rfl
    · have : ET t = t + 1 := by unfold ET; rw [if_neg t0]
      rw [this, if_neg (by omega), if_neg (by omega)]; omega
  · have hr := R_lt' (m := 2 * s - 1) (y := x - (6 * s + 1) + t) (by omega)
    rw [sg_B' (by omega) hs, trq_B' (by omega) hr hs, R_sub_add (by omega) (by omega)]

theorem dtrq_lt {x c : ℕ} (hs : 5 ≤ s) (hx : x < 8 * s) (hc : c < 8 * s) (ht : dtrq s x c < 8) :
    dsg s (dtrq s x c) x = c := by
  unfold dtrq at ht
  by_cases h1 : x < 2 * s + 1
  · simp only [if_pos h1] at ht
    by_cases h2 : c < 2 * s - 1
    · simp only [if_pos h2] at ht; omega
    by_cases h3 : c < 4 * s
    · rw [trq_A h1 (by omega) h3, sg_A h1, R_add_sub h1 (by omega)]; omega
    · simp only [if_neg h2, if_neg h3] at ht; omega
  by_cases h2 : x < 4 * s
  · simp only [if_neg h1, if_pos h2] at ht
    by_cases h3 : c < 4 * s
    · simp only [if_pos h3] at ht; omega
    by_cases h4 : c < 6 * s - 1
    · rw [trq_B (by omega) h2 (by omega) h4, sg_B (by omega) h2, R_add_sub (by omega) (by omega)]; omega
    · simp only [if_neg h3, if_neg h4] at ht; omega
  by_cases h3 : x < 6 * s + 1
  · simp only [if_neg h1, if_neg h2, if_pos h3] at ht
    by_cases h4 : c < 6 * s - 1
    · simp only [if_pos h4] at ht; omega
    simp only [if_neg h4] at ht
    rw [trq_A' (by omega) h3 (by omega) hs]
    have he := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) (by omega)
    have hd := R_add_sub (m := 2 * s + 1) (show x - 4 * s < 2 * s + 1 by omega)
      (show c - (6 * s - 1) < 2 * s + 1 by omega)
    generalize red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - (x - 4 * s)) = e at *
    split_ifs at ht ⊢ with e0 e1
    · rw [sg_A' (by omega) h3 hs]; subst e0; rw [show ET 0 = 0 by rfl]; omega
    · omega
    · rw [sg_A' (by omega) h3 hs]
      have : ET (e - 1) = e := by unfold ET; split_ifs <;> omega
      rw [this]; omega
  · simp only [if_neg h1, if_neg h2, if_neg h3] at ht
    by_cases h4 : c < 2 * s - 1
    · rw [trq_B' (by omega) h4 hs, sg_B' (by omega) hs, R_add_sub (by omega) h4]
    · simp only [if_neg h4] at ht; omega

/-- Values along a transversal, column by column. -/
lemma tv_C {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc : c < 2 * s - 1) :
    dgv s (dsi s t c) c = 2 * s - 1 + red (2 * s - 1) (red (2 * s - 1) (c + (2 * s - 1) - t) + c) := by
  have hr := R_lt' (m := 2 * s - 1) (y := c + (2 * s - 1) - t) (by omega)
  rw [si_C hc, gv_BpC hs (by omega) (by omega) hc, vB'C, Nat.add_sub_cancel_left]

lemma tv_D {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc1 : 2 * s - 1 ≤ c) (hc : c < 4 * s) :
    dgv s (dsi s t c) c = 6 * s - 1 +
      red (2 * s + 1) (red (2 * s + 1) (c - (2 * s - 1) + (2 * s + 1) - t) + (c - (2 * s - 1))) := by
  have hr := R_lt' (m := 2 * s + 1) (y := c - (2 * s - 1) + (2 * s + 1) - t) (by omega)
  rw [si_D hc1 hc, gv_AD hs hr hc1 hc, vAD]

lemma tv_C' {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc1 : 4 * s ≤ c) (hc : c < 6 * s - 1) :
    dgv s (dsi s t c) c = red (2 * s - 1) (red (2 * s - 1) (c - 4 * s + (2 * s - 1) - t) + (c - 4 * s)) := by
  have hr := R_lt' (m := 2 * s - 1) (y := c - 4 * s + (2 * s - 1) - t) (by omega)
  rw [si_C' hc1 hc, gv_BCp hs (by omega) (by omega) hc1 hc, vBC', Nat.add_sub_cancel_left]

lemma tv_D' {c : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc1 : 6 * s - 1 ≤ c) (hc : c < 8 * s) :
    dgv s (dsi s t c) c = 4 * s - 2 + half (2 * s + 1) (red (2 * s + 1) (red (2 * s + 1)
      (red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - ET t) + (c - (6 * s - 1)) + (2 * s + 1) - 3))) := by
  have h8 := ET_le ht
  have hr := R_lt' (m := 2 * s + 1) (y := c - (6 * s - 1) + (2 * s + 1) - ET t) (by omega)
  rw [si_D' hc1 hs, gv_ApDp hs (by omega) (by omega) hc1 hc, vA'D', Nat.add_sub_cancel_left]
  unfold bandW
  have he := R_sub_sub (m := 2 * s + 1) (show c - (6 * s - 1) < 2 * s + 1 by omega) (show ET t < 2 * s + 1 by omega)
  rw [he, if_neg (ET_ne1 t), if_neg (by omega)]

lemma red2_inj {m c c' t : ℕ} (hm : m % 2 = 1) (hc : c < m) (hc' : c' < m) (ht : t < m)
    (h : red m (red m (c + m - t) + c) = red m (red m (c' + m - t) + c')) : c = c' := by
  unfold red at h; split_ifs at h <;> omega

lemma redW_inj {m d d' t : ℕ} (hm : m % 2 = 1) (h5 : 5 ≤ m) (hd : d < m) (hd' : d' < m) (ht : t < m)
    (h : red m (red m (red m (d + m - t) + d + m - 3)) = red m (red m (red m (d' + m - t) + d' + m - 3))) :
    d = d' := by
  unfold red at h; split_ifs at h <;> omega

theorem dtv_inj {c c' : ℕ} (hs : 5 ≤ s) (ht : t < 8) (hc : c < 8 * s) (hc' : c' < 8 * s)
    (h : dgv s (dsi s t c) c = dgv s (dsi s t c') c') : c = c' := by
  have hp : (2 * s + 1) % 2 = 1 := by omega
  have hh : (2 * s - 1) % 2 = 1 := by omega
  have h8 := ET_le ht
  -- classify by block
  have cls : ∀ c < 8 * s, (c < 2 * s - 1 ∧ 2 * s - 1 ≤ dgv s (dsi s t c) c ∧ dgv s (dsi s t c) c < 4 * s - 2) ∨
      (2 * s - 1 ≤ c ∧ c < 4 * s ∧ 6 * s - 1 ≤ dgv s (dsi s t c) c) ∨
      (4 * s ≤ c ∧ c < 6 * s - 1 ∧ dgv s (dsi s t c) c < 2 * s - 1) ∨
      (6 * s - 1 ≤ c ∧ 4 * s - 2 ≤ dgv s (dsi s t c) c ∧ dgv s (dsi s t c) c < 6 * s - 1) := by
    intro c hc
    by_cases h1 : c < 2 * s - 1
    · rw [tv_C hs ht h1]
      have := R_lt' (m := 2 * s - 1) (y := red (2 * s - 1) (c + (2 * s - 1) - t) + c)
        (by have := R_lt' (m := 2 * s - 1) (y := c + (2 * s - 1) - t) (by omega); omega)
      omega
    by_cases h2 : c < 4 * s
    · rw [tv_D hs ht (by omega) h2]; omega
    by_cases h3 : c < 6 * s - 1
    · rw [tv_C' hs ht (by omega) h3]
      have := R_lt' (m := 2 * s - 1) (y := red (2 * s - 1) (c - 4 * s + (2 * s - 1) - t) + (c - 4 * s))
        (by have := R_lt' (m := 2 * s - 1) (y := c - 4 * s + (2 * s - 1) - t) (by omega); omega)
      omega
    · rw [tv_D' hs ht (by omega) hc]
      have := half_lt (s := s) (m := red (2 * s + 1) (red (2 * s + 1)
        (red (2 * s + 1) (c - (6 * s - 1) + (2 * s + 1) - ET t) + (c - (6 * s - 1)) + (2 * s + 1) - 3)))
        (R_lt' (by unfold red; split_ifs <;> omega))
      omega
  rcases cls c hc with ⟨a1, a2, a3⟩ | ⟨a1, a2, a3⟩ | ⟨a1, a2, a3⟩ | ⟨a1, a2, a3⟩ <;>
  rcases cls c' hc' with ⟨b1, b2, b3⟩ | ⟨b1, b2, b3⟩ | ⟨b1, b2, b3⟩ | ⟨b1, b2, b3⟩ <;>
  try omega
  · rw [tv_C hs ht a1, tv_C hs ht b1] at h
    exact red2_inj hh a1 b1 (by omega) (Nat.add_left_cancel h)
  · rw [tv_D hs ht a1 a2, tv_D hs ht b1 b2] at h
    have := red2_inj hp (show c - (2 * s - 1) < 2 * s + 1 by omega) (show c' - (2 * s - 1) < 2 * s + 1 by omega)
      (show t < 2 * s + 1 by omega) (Nat.add_left_cancel h)
    omega
  · rw [tv_C' hs ht a1 a2, tv_C' hs ht b1 b2] at h
    have := red2_inj hh (show c - 4 * s < 2 * s - 1 by omega) (show c' - 4 * s < 2 * s - 1 by omega)
      (show t < 2 * s - 1 by omega) h
    omega
  · rw [tv_D' hs ht a1 hc, tv_D' hs ht b1 hc'] at h
    have hl : ∀ d < 2 * s + 1, red (2 * s + 1) (red (2 * s + 1)
        (red (2 * s + 1) (d + (2 * s + 1) - ET t) + d + (2 * s + 1) - 3)) < 2 * s + 1 := by
      intro d hd
      apply R_lt'
      have := R_lt' (m := 2 * s + 1) (y := d + (2 * s + 1) - ET t) (by omega)
      unfold red; split_ifs <;> omega
    have hm := half_inj (hl _ (show c - (6 * s - 1) < 2 * s + 1 by omega))
      (hl _ (show c' - (6 * s - 1) < 2 * s + 1 by omega)) (Nat.add_left_cancel h)
    have := redW_inj hp (by omega) (show c - (6 * s - 1) < 2 * s + 1 by omega)
      (show c' - (6 * s - 1) < 2 * s + 1 by omega) (show ET t < 2 * s + 1 by omega) hm
    omega

end QEDSud


namespace QEDSud

open Finset

def dPD (s : ℕ) : PD where
  blank := dblank s
  gv := dgv s
  rf := drf s
  cf := dcf s
  live := dlive s
  lab := dlab s
  sg := dsg s
  si := dsi s
  trq := dtrq s

theorem dPD_ok {s k : ℕ} (hs : 5 ≤ s) (hk : k < 8) : PDOK (dPD s) (8 * s) k (2 * s - 1) where
  rf_lt := fun r hr c hc => drf_lt hs hr hc
  cf_lt := fun r hr c hc => dcf_lt hs hr hc
  rf_gv := fun r _ c _ hb => by
    show drf s r c = dgv s r c
    unfold drf; rw [if_neg (by rw [show dblank s r c = false from hb]; simp)]
  cf_gv := fun r _ c _ hb => by
    show dcf s r c = dgv s r c
    unfold dcf; rw [if_neg (by rw [show dblank s r c = false from hb]; simp)]
  rf_inj := fun r hr c hc c' hc' h => drf_inj hs hr c hc c' hc' h
  cf_inj := fun c hc r hr r' hr' h => dcf_inj hs hc r hr r' hr' h
  live_ok := fun r c v h => dlive_ok hs h
  cell := fun r hr c hc hb => cell_line hs hr hc hb
  row := fun r hr c hc hb => row_line hs hr hc hb
  col := fun r hr c hc hb => col_line hs hr hc hb
  unsat := by
    refine ⟨0, by omega, range (2 * s + 1), by rw [card_range]; omega, fun r hr => ?_⟩
    have hr' := mem_range.1 hr
    refine ⟨by omega, bl_AC hs hr' (by omega), fun c' hc' hb => ?_⟩
    have hc'' : c' < 2 * s - 1 := by
      have := hb; unfold dPD at this; simp only at this
      unfold dblank at this; rw [if_pos hr'] at this; simpa using this
    show drf s r c' < 2 * s - 1
    rw [rf_AC hs hr' hc'']; exact hc''
  sg_lt := fun t ht x hx => dsg_lt hs (by omega) hx
  si_lt := fun t ht c hc => dsi_lt hs (by omega) hc
  si_sg := fun t ht x hx => dsi_sg hs (by omega) hx
  sg_si := fun t ht c hc => dsg_si hs (by omega) hc
  sg_ne := fun t ht u hu htu x hx => dsg_ne hs (by omega) (by omega) htu hx
  sg_nb := fun t ht x hx => dsg_nb hs (by omega) hx
  trq_sg := fun t ht x hx => dtrq_sg hs (by omega) hx
  trq_lt := fun x hx c hc ht => dtrq_lt hs hx hc (show dtrq s x c < 8 from by have : (dPD s).trq x c = dtrq s x c := rfl; omega)
  tv_inj := fun t ht c hc c' hc' h => dtv_inj hs (by omega) hc hc' h

/-- The core design of order `n`. -/
def coreN (n : ℕ) : Core := prolong (dPD (n / 8)) (8 * (n / 8)) (n % 8)

theorem coreN_ok {n : ℕ} (hn : 40 ≤ n) : CoreOK (coreN n) n (2 * (n / 8) - 1) := by
  have h := prolong_ok (dPD_ok (s := n / 8) (k := n % 8) (by omega) (Nat.mod_lt _ (by norm_num)))
  have e : 8 * (n / 8) + n % 8 = n := by omega
  rw [e] at h
  exact h

end QEDSud


/-! # The givens as an arithmetic expression -/

namespace QEDSud

open QEDTM

abbrev E7 := Exp 7

namespace X

def v (i : Fin 7) : E7 := .var i
def k (c : ℕ) : E7 := .const c
def lt (a b x y : E7) : E7 := .ite (.sub (.add a (.const 1)) b) x y
def eq (a b x y : E7) : E7 := .ite (.add (.sub a b) (.sub b a)) x y
def rd (m y : E7) : E7 := lt y m y (.sub y m)

variable (env : Fin 7 → ℕ)

@[simp] lemma ev_v (i : Fin 7) : (v i).eval env = env i := rfl
@[simp] lemma ev_k (c : ℕ) : (k c).eval env = c := rfl
@[simp] lemma ev_add (a b : E7) : (Exp.add a b).eval env = a.eval env + b.eval env := rfl
@[simp] lemma ev_sub (a b : E7) : (Exp.sub a b).eval env = a.eval env - b.eval env := rfl
@[simp] lemma ev_mul (a b : E7) : (Exp.mul a b).eval env = a.eval env * b.eval env := rfl
@[simp] lemma ev_div (a b : E7) : (Exp.div a b).eval env = a.eval env / b.eval env := rfl
@[simp] lemma ev_mod (a b : E7) : (Exp.mod a b).eval env = a.eval env % b.eval env := rfl
@[simp] lemma ev_ite (c a b : E7) :
    (Exp.ite c a b).eval env = if c.eval env = 0 then a.eval env else b.eval env := Exp.eval_ite env c a b
@[simp] lemma ev_lt (a b x y : E7) :
    (lt a b x y).eval env = if a.eval env < b.eval env then x.eval env else y.eval env := by
  rw [lt, Exp.eval_ite]
  show (if a.eval env + 1 - b.eval env = 0 then x.eval env else y.eval env) = _
  by_cases h : a.eval env < b.eval env
  · rw [if_pos (by omega), if_pos h]
  · rw [if_neg (by omega), if_neg h]
@[simp] lemma ev_eq (a b x y : E7) :
    (eq a b x y).eval env = if a.eval env = b.eval env then x.eval env else y.eval env := by
  rw [eq, Exp.eval_ite]
  show (if a.eval env - b.eval env + (b.eval env - a.eval env) = 0 then x.eval env else y.eval env) = _
  by_cases h : a.eval env = b.eval env
  · rw [if_pos (by omega), if_pos h]
  · rw [if_neg (by omega), if_neg h]
@[simp] lemma ev_rd (m y : E7) : (rd m y).eval env = QEDSud.red (m.eval env) (y.eval env) := by
  simp only [rd, ev_lt, ev_sub]; rfl

end X

open X

/-! Mirrors of the design functions. Arguments: `s` and the coordinates as expressions. -/

def ET_E (t : E7) : E7 := eq t (k 0) (k 0) (.add t (k 1))
def half_E (p m : E7) : E7 := .ite (.mod m (k 2)) (.div m (k 2)) (.div (.add m p) (k 2))
def band_E (p a d S1 S2 : E7) : E7 :=
  eq (rd p (.sub (.add d p) a)) (k 1) (.add S1 (rd p (.sub (.add a p) (k 1))))
    (eq (rd p (.sub (.add d p) a)) (.sub p (k 1)) (.add S1 (rd p (.sub (.add a p) (k 2))))
      (.add S2 (.sub (rd p (.sub (.add d p) a)) (k 1))))

section
variable (s : E7)
def P_E : E7 := .add (.mul (k 2) s) (k 1)
def H_E : E7 := .sub (.mul (k 2) s) (k 1)
def m_E (a : ℕ) (b : ℕ) : E7 := .sub (.mul (k a) s) (k b)
def p_E (a : ℕ) (b : ℕ) : E7 := .add (.mul (k a) s) (k b)
end

def bandW_E (s a d : E7) : E7 :=
  eq (rd (P_E s) (.sub (.add d (P_E s)) a)) (k 1)
    (.add (m_E s 6 1) (rd (P_E s) (.sub (.add a (P_E s)) (k 1))))
    (eq (rd (P_E s) (.sub (.add d (P_E s)) a)) (.mul (k 2) s)
      (.add (m_E s 6 1) (rd (P_E s) (.sub (.add a (P_E s)) (k 2))))
      (.add (m_E s 4 2) (half_E (P_E s) (rd (P_E s) (rd (P_E s) (.sub (.add (.add a d) (P_E s)) (k 3)))))))

variable (env : Fin 7 → ℕ)

@[simp] lemma ev_P (s : E7) : (P_E s).eval env = 2 * s.eval env + 1 := rfl
@[simp] lemma ev_H (s : E7) : (H_E s).eval env = 2 * s.eval env - 1 := rfl
@[simp] lemma ev_m (s : E7) (a b : ℕ) : (m_E s a b).eval env = a * s.eval env - b := rfl
@[simp] lemma ev_pE (s : E7) (a b : ℕ) : (p_E s a b).eval env = a * s.eval env + b := rfl
@[simp] lemma ev_ET (t : E7) : (ET_E t).eval env = ET (t.eval env) := by
  simp only [ET_E, ev_eq, ev_k, ev_add, ET]
  by_cases h : Exp.eval env t = 0 <;> simp [h]
@[simp] lemma ev_half (p m : E7) : (half_E p m).eval env = half (p.eval env) (m.eval env) := by
  rw [half_E, Exp.eval_ite]
  show (if m.eval env % 2 = 0 then m.eval env / 2 else (m.eval env + p.eval env) / 2) = _
  rfl
@[simp] lemma ev_band (p a d S1 S2 : E7) :
    (band_E p a d S1 S2).eval env = band (p.eval env) (a.eval env) (d.eval env) (S1.eval env) (S2.eval env) := by
  simp [band_E, band]
@[simp] lemma ev_bandW (s a d : E7) : (bandW_E s a d).eval env = bandW (s.eval env) (a.eval env) (d.eval env) := by
  simp [bandW_E, bandW]

section
variable (s x c : E7)
def M4 : E7 := .mul (k 4) s
def vAD_E : E7 := .add (m_E s 6 1) (rd (P_E s) (.add x (.sub c (m_E s 2 1))))
def vAC'_E : E7 := .add (m_E s 4 2) (rd (P_E s) (.add x (.sub c (M4 s))))
def vAD'_E : E7 := band_E (P_E s) x (.sub c (m_E s 6 1)) (m_E s 4 2) (m_E s 2 1)
def vBC'_E : E7 := rd (H_E s) (.add (.sub x (P_E s)) (.sub c (M4 s)))
def vBD'_E : E7 := .add (m_E s 6 1) (rd (P_E s) (.add (.sub x (P_E s)) (.sub c (m_E s 6 1))))
def vA'C_E : E7 := .add (m_E s 6 1) (rd (P_E s) (.add (.sub x (M4 s)) c))
def vA'D_E : E7 := band_E (P_E s) (.sub x (M4 s)) (.sub c (m_E s 2 1)) (m_E s 4 2) (k 0)
def vA'D'_E : E7 := bandW_E s (.sub x (M4 s)) (.sub c (m_E s 6 1))
def vB'C_E : E7 := .add (m_E s 2 1) (rd (H_E s) (.add (.sub x (p_E s 6 1)) c))
def vB'D_E : E7 := .add (m_E s 4 2) (rd (P_E s) (.add (.sub x (p_E s 6 1)) (.sub c (m_E s 2 1))))

def dgv_E : E7 :=
  lt x (P_E s)
    (lt c (H_E s) (k 0) (lt c (M4 s) (vAD_E s x c) (lt c (m_E s 6 1) (vAC'_E s x c) (vAD'_E s x c))))
    (lt x (M4 s)
      (lt c (M4 s) (k 0) (lt c (m_E s 6 1) (vBC'_E s x c) (vBD'_E s x c)))
      (lt x (p_E s 6 1)
        (lt c (H_E s) (vA'C_E s x c) (lt c (M4 s) (vA'D_E s x c) (lt c (m_E s 6 1) (k 0) (vA'D'_E s x c))))
        (lt c (H_E s) (vB'C_E s x c) (lt c (M4 s) (vB'D_E s x c) (k 0)))))

def dblankN_E : E7 :=
  lt x (P_E s) (lt c (H_E s) (k 1) (k 0))
    (lt x (M4 s) (lt c (M4 s) (k 1) (k 0))
      (lt x (p_E s 6 1) (lt c (M4 s) (k 0) (lt c (m_E s 6 1) (k 1) (k 0)))
        (lt c (M4 s) (k 0) (k 1))))
end

section
variable (s t x c : E7)
def dsg_E : E7 :=
  lt x (P_E s) (.add (m_E s 2 1) (rd (P_E s) (.add x t)))
    (lt x (M4 s) (.add (M4 s) (rd (H_E s) (.add (.sub x (P_E s)) t)))
      (lt x (p_E s 6 1) (.add (m_E s 6 1) (rd (P_E s) (.add (.sub x (M4 s)) (ET_E t))))
        (rd (H_E s) (.add (.sub x (p_E s 6 1)) t))))
def dsi_E : E7 :=
  lt c (H_E s) (.add (p_E s 6 1) (rd (H_E s) (.sub (.add c (H_E s)) t)))
    (lt c (M4 s) (rd (P_E s) (.sub (.add (.sub c (m_E s 2 1)) (P_E s)) t))
      (lt c (m_E s 6 1) (.add (P_E s) (rd (H_E s) (.sub (.add (.sub c (M4 s)) (H_E s)) t)))
        (.add (M4 s) (rd (P_E s) (.sub (.add (.sub c (m_E s 6 1)) (P_E s)) (ET_E t))))))
end

section
variable (s x c : E7)
def eA : E7 := rd (P_E s) (.sub (.add (.sub c (m_E s 6 1)) (P_E s)) (.sub x (M4 s)))
def dtrq_E : E7 :=
  lt x (P_E s)
    (lt c (H_E s) (k 8) (lt c (M4 s) (rd (P_E s) (.sub (.add (.sub c (m_E s 2 1)) (P_E s)) x)) (k 8)))
    (lt x (M4 s)
      (lt c (M4 s) (k 8) (lt c (m_E s 6 1) (rd (H_E s) (.sub (.add (.sub c (M4 s)) (H_E s)) (.sub x (P_E s)))) (k 8)))
      (lt x (p_E s 6 1)
        (lt c (m_E s 6 1) (k 8) (eq (eA s x c) (k 0) (k 0) (eq (eA s x c) (k 1) (k 8) (.sub (eA s x c) (k 1)))))
        (lt c (H_E s) (rd (H_E s) (.sub (.add c (H_E s)) (.sub x (p_E s 6 1)))) (k 8))))
end

def dblankNf (s x c : ℕ) : ℕ :=
  if x < 2 * s + 1 then (if c < 2 * s - 1 then 1 else 0)
  else if x < 4 * s then (if c < 4 * s then 1 else 0)
  else if x < 6 * s + 1 then (if c < 4 * s then 0 else if c < 6 * s - 1 then 1 else 0)
  else (if c < 4 * s then 0 else 1)

lemma dblankN_spec (s x c : ℕ) : dblankNf s x c = if dblank s x c = true then 1 else 0 := by
  unfold dblankNf dblank; split_ifs <;> simp_all <;> omega

@[simp] lemma ev_M4 (s : E7) : (M4 s).eval env = 4 * s.eval env := rfl

lemma ev_dgv (s x c : E7) : (dgv_E s x c).eval env = dgv (s.eval env) (x.eval env) (c.eval env) := by
  simp only [dgv_E, dgv, ev_lt, ev_P, ev_H, ev_M4, ev_m, ev_pE, ev_k, vAD_E, vAC'_E, vAD'_E, vBC'_E, vBD'_E,
    vA'C_E, vA'D_E, vA'D'_E, vB'C_E, vB'D_E, vAD, vAC', vAD', vBC', vBD', vA'C, vA'D, vA'D', vB'C, vB'D,
    ev_add, ev_sub, ev_rd, ev_band, ev_bandW]

lemma ev_dblankN (s x c : E7) : (dblankN_E s x c).eval env =
    if dblank (s.eval env) (x.eval env) (c.eval env) = true then 1 else 0 := by
  rw [← dblankN_spec]
  simp only [dblankN_E, dblankNf, ev_lt, ev_P, ev_H, ev_M4, ev_m, ev_pE, ev_k]
  rfl

lemma ev_dsg (s t x : E7) : (dsg_E s t x).eval env = dsg (s.eval env) (t.eval env) (x.eval env) := by
  simp only [dsg_E, dsg, ev_lt, ev_P, ev_H, ev_M4, ev_m, ev_pE, ev_k, ev_add, ev_sub, ev_rd, ev_ET]

lemma ev_dsi (s t c : E7) : (dsi_E s t c).eval env = dsi (s.eval env) (t.eval env) (c.eval env) := by
  simp only [dsi_E, dsi, ev_lt, ev_P, ev_H, ev_M4, ev_m, ev_pE, ev_k, ev_add, ev_sub, ev_rd, ev_ET]

lemma ev_dtrq (s x c : E7) : (dtrq_E s x c).eval env = dtrq (s.eval env) (x.eval env) (c.eval env) := by
  simp only [dtrq_E, dtrq, eA, ev_lt, ev_eq, ev_P, ev_H, ev_M4, ev_m, ev_pE, ev_k, ev_add, ev_sub, ev_rd]

def S_E : E7 := .div (v 0) (k 8)
def L_E : E7 := .mul (k 8) S_E
def K_E : E7 := .mod (v 0) (k 8)

def qgv_E (r c : E7) : E7 :=
  lt r L_E
    (lt c L_E (lt (dtrq_E S_E r c) K_E (.add L_E (dtrq_E S_E r c)) (dgv_E S_E r c))
      (dgv_E S_E r (dsg_E S_E (.sub c L_E) r)))
    (lt c L_E (dgv_E S_E (dsi_E S_E (.sub r L_E) c) c) (.add L_E (rd K_E (.add (.sub r L_E) (.sub c L_E)))))

def qblank_E (r c : E7) : E7 := lt r L_E (lt c L_E (dblankN_E S_E r c) (k 0)) (k 0)

lemma ev_qgv (r c : E7) : (qgv_E r c).eval env = (coreN (env 0)).gv (r.eval env) (c.eval env) := by
  simp only [qgv_E, coreN, prolong, qval, dPD, ev_lt, ev_add, ev_sub, ev_rd, ev_dtrq, ev_dgv, ev_dsg, ev_dsi,
    S_E, L_E, K_E, ev_mul, ev_div, ev_mod, ev_k, ev_v]

lemma ev_qblank (r c : E7) : (qblank_E r c).eval env =
    if (coreN (env 0)).blank (r.eval env) (c.eval env) = true then 1 else 0 := by
  simp only [qblank_E, coreN, prolong, qblank, dPD, ev_lt, ev_dblankN, S_E, L_E, ev_mul, ev_div, ev_k, ev_v]
  split_ifs <;> simp_all <;> omega

def dif_E (a b : E7) : E7 := .add (.sub a b) (.sub b a)

/-- The output bit for row `b n + o`, column `t n + q`, symbol `α n + β`. -/
def givE : E7 :=
  .ite (.add (v 2) (v 3))
    (.ite (qblank_E (v 1) (v 4)) (.ite (.add (v 5) (dif_E (v 6) (qgv_E (v 1) (v 4)))) (k 1) (k 0)) (k 0))
    (.ite (.add (dif_E (v 5) (.mod (.add (v 2) (v 3)) (v 0))) (dif_E (v 6) (.mod (.add (v 1) (v 4)) (v 0))))
      (k 1) (k 0))

lemma ev_dif (a b : E7) : (dif_E a b).eval env = 0 ↔ a.eval env = b.eval env := by
  show a.eval env - b.eval env + (b.eval env - a.eval env) = 0 ↔ _; omega

lemma givE_iff (env : Fin 7 → ℕ) : givE.eval env ≠ 0 ↔
    if env 2 + env 3 = 0 then (coreN (env 0)).blank (env 1) (env 4) = false ∧ env 5 = 0 ∧
      env 6 = (coreN (env 0)).gv (env 1) (env 4)
    else env 5 = (env 2 + env 3) % env 0 ∧ env 6 = (env 1 + env 4) % env 0 := by
  unfold givE
  rw [ev_ite]
  have hc : (Exp.add (v 2) (v 3)).eval env = env 2 + env 3 := rfl
  by_cases h : env 2 + env 3 = 0
  · rw [if_pos (hc.trans h), if_pos h, ev_ite]
    have hq : (qblank_E (v 1) (v 4)).eval env = if (coreN (env 0)).blank (env 1) (env 4) = true then 1 else 0 :=
      ev_qblank env (v 1) (v 4)
    by_cases hb : (coreN (env 0)).blank (env 1) (env 4) = true
    · rw [if_neg (by rw [hq, if_pos hb]; omega)]; simp [hb]
    · rw [if_pos (by rw [hq, if_neg hb]), ev_ite]
      have := ev_dif env (v 6) (qgv_E (v 1) (v 4))
      rw [ev_qgv] at this; simp only [ev_v] at this
      have h5 : (Exp.add (v 5) (dif_E (v 6) (qgv_E (v 1) (v 4)))).eval env =
          env 5 + (dif_E (v 6) (qgv_E (v 1) (v 4))).eval env := rfl
      constructor
      · intro h1
        by_cases h2 : env 5 + (dif_E (v 6) (qgv_E (v 1) (v 4))).eval env = 0
        · exact ⟨by simpa using hb, by omega, this.1 (by omega)⟩
        · rw [if_neg (by rw [h5]; exact h2)] at h1; exact absurd rfl h1
      · rintro ⟨-, h6, h7⟩
        rw [if_pos (by rw [h5, h6, this.2 h7])]; simp
  · rw [if_neg (by rw [hc]; exact h), if_neg h, ev_ite]
    have h1 := ev_dif env (v 5) (.mod (.add (v 2) (v 3)) (v 0))
    have h2 := ev_dif env (v 6) (.mod (.add (v 1) (v 4)) (v 0))
    simp only [ev_mod, ev_add, ev_v] at h1 h2
    have h5 : (Exp.add (dif_E (v 5) ((Exp.add (v 2) (v 3)).mod (v 0))) (dif_E (v 6) ((Exp.add (v 1) (v 4)).mod (v 0)))).eval env
        = (dif_E (v 5) ((Exp.add (v 2) (v 3)).mod (v 0))).eval env +
          (dif_E (v 6) ((Exp.add (v 1) (v 4)).mod (v 0))).eval env := rfl
    constructor
    · intro h3
      by_cases h4 : (dif_E (v 5) ((Exp.add (v 2) (v 3)).mod (v 0))).eval env +
          (dif_E (v 6) ((Exp.add (v 1) (v 4)).mod (v 0))).eval env = 0
      · exact ⟨h1.1 (by omega), h2.1 (by omega)⟩
      · rw [if_neg (by rw [h5]; exact h4)] at h3; exact absurd rfl h3
    · rintro ⟨h6, h7⟩
      have := h1.2 h6; have := h2.2 h7
      rw [if_pos (by rw [h5]; omega)]; simp

end QEDSud
