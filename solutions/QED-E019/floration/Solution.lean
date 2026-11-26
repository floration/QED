namespace QEDE019Proof

open OpenProblems.QEDE019

private theorem subst_append (u v : List Bool) :
    subst (u ++ v) = subst u ++ subst v := by
  simp [subst, List.flatMap_append]

private theorem subst_iterate_append (n : ℕ) (u v : List Bool) :
    subst^[n] (u ++ v) = subst^[n] u ++ subst^[n] v := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [Function.iterate_succ_apply', ih, subst_append]

private theorem W_succ_eq_append (n : ℕ) :
    W (n + 1) = W n ++ subst^[n] [false] := by
  unfold W
  rw [Function.iterate_succ_apply]
  change subst^[n] ([true] ++ [false]) = _
  exact subst_iterate_append n [true] [false]

/-- The two substituted words differ exactly in their final letter. -/
theorem W_and_companion (n : ℕ) :
    ∃ (p : List Bool) (b : Bool),
      W n = p ++ [b] ∧ subst^[n] [false] = p ++ [!b] := by
  induction n with
  | zero => exact ⟨[], true, rfl, rfl⟩
  | succ n ih =>
    obtain ⟨p, b, hW, hV⟩ := ih
    have ha := W_succ_eq_append n
    have hb : subst^[n + 1] [false] = W n ++ W n := by
      rw [Function.iterate_succ_apply]
      change subst^[n] ([true] ++ [true]) = _
      exact subst_iterate_append n [true] [true]
    refine ⟨W n ++ p, !b, ?_, ?_⟩
    · rw [ha, hV, List.append_assoc]
    · rw [hb, Bool.not_not, List.append_assoc, ← hW]

/-- A margin of at least 1/4 is available whenever each non-hinge
    has a hinge as an immediate neighbor. -/
theorem uniform_angle_structure (ω : List Bool)
    (h : ∀ i : Fin ω.length, ω.get i = ω.get (nxt ω i) →
      (ω.get (prv ω i) ≠ ω.get (nxt ω (prv ω i)) ∨
        ω.get (nxt ω i) ≠ ω.get (nxt ω (nxt ω i)))) :
    ∃ w : Fin ω.length → ℝ, ∀ i, (1 / 4 : ℝ) ≤ w i ∧
      (1 / 4 : ℝ) ≤ xAng ω w i ∧ (1 / 4 : ℝ) ≤ yAng ω w i ∧
      (1 / 4 : ℝ) ≤ zAng ω w i := by
  classical
  let w : Fin ω.length → ℝ := fun i =>
    if ω.get i = ω.get (nxt ω i) then 3 / 4 else 1 / 2
  refine ⟨w, fun i => ?_⟩
  have hpi := Real.pi_gt_three
  simp only [xAng, yAng, zAng, w]
  split_ifs with hm hp hs <;>
    first
    | exact False.elim ((h i hm).elim (fun h' => h' hp) (fun h' => h' hs))
    | exact ⟨by norm_num, by norm_num, by norm_num, by linarith⟩

private theorem subst_length (u : List Bool) : (subst u).length = 2 * u.length := by
  induction u with
  | nil => rfl
  | cons b u ih =>
    have hpair : (if b then [true, false] else [true, true]).length = 2 := by
      cases b <;> rfl
    change ((if b then [true, false] else [true, true]) ++ subst u).length = _
    rw [List.length_append, hpair, ih, List.length_cons]
    omega

theorem W_length (n : ℕ) : (W n).length = 2 ^ n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [W, Function.iterate_succ_apply', subst_length]
    change 2 * (W n).length = 2 ^ (n + 1)
    rw [ih, Nat.pow_succ, Nat.mul_comm]

open MeasureTheory in
/-- The logarithmic endpoint singularities are interval-integrable. -/
theorem continuous_lob : Continuous lob := by
  have h (a b : ℝ) :
      IntervalIntegrable (fun t : ℝ => Real.log (2 * Real.sin t)) volume a b := by
    have ha : AnalyticOnNhd ℝ (fun t : ℝ => 2 * Real.sin t) (Set.uIcc a b) :=
      analyticOnNhd_const.mul Real.analyticOnNhd_sin
    exact ha.meromorphicOn.intervalIntegrable_log
  unfold lob
  exact (intervalIntegral.continuous_primitive h 0).neg

theorem angle_sum (ω : List Bool) (w : Fin ω.length → ℝ) (i : Fin ω.length) :
    xAng ω w i + yAng ω w i + zAng ω w i = Real.pi := by
  unfold xAng yAng zAng
  split_ifs <;> ring

theorem tetrahedron_volume_bound :
    ∃ M : ℝ, ∀ (ω : List Bool) (w : Fin ω.length → ℝ), IsAngleStructure ω w →
      ∀ i, |lob (xAng ω w i) + lob (yAng ω w i) + lob (zAng ω w i)| ≤ M := by
  have hcompact : IsCompact (Set.Icc (0 : ℝ) Real.pi) := isCompact_Icc
  have habs : Continuous (fun t : ℝ => |lob t|) := continuous_lob.abs
  have hbounded : BddAbove ((fun t : ℝ => |lob t|) '' Set.Icc 0 Real.pi) :=
    hcompact.bddAbove_image habs.continuousOn
  obtain ⟨B, hB⟩ := hbounded
  refine ⟨3 * B, fun ω w hw i => ?_⟩
  obtain ⟨_, hx, hy, hz⟩ := hw i
  have hs := angle_sum ω w i
  have bound (t : ℝ) (ht₀ : 0 ≤ t) (ht₁ : t ≤ Real.pi) : |lob t| ≤ B :=
    hB ⟨t, ⟨ht₀, ht₁⟩, rfl⟩
  let x := lob (xAng ω w i)
  let y := lob (yAng ω w i)
  let z := lob (zAng ω w i)
  have hxb : |x| ≤ B := bound _ hx.le (by linarith only [hy, hz, hs])
  have hyb : |y| ≤ B := bound _ hy.le (by linarith only [hx, hz, hs])
  have hzb : |z| ≤ B := bound _ hz.le (by linarith only [hx, hy, hs])
  change |x + y + z| ≤ 3 * B
  calc
    |x + y + z| ≤ |x + y| + |z| := abs_add_le _ _
    _ ≤ |x| + |y| + |z| := add_le_add (abs_add_le x y) le_rfl
    _ ≤ 3 * B := by linarith only [hxb, hyb, hzb]

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private def cyclicLetter (ω : List Bool) (i : ℕ) : Bool :=
  ω[i % ω.length]?.getD false

private theorem subst_get_even (u : List Bool) (k : ℕ) (hk : k < u.length) :
    (subst u)[2 * k]? = some true := by
  induction u generalizing k with
  | nil => simp at hk
  | cons b u ih =>
    cases k with
    | zero => cases b <;> rfl
    | succ k =>
      have he : 2 * (k + 1) = (2 * k + 1) + 1 := by omega
      change ((if b then [true, false] else [true, true]) ++ subst u)[2 * (k + 1)]? = _
      rw [he]
      cases b <;> exact ih k (by simpa using hk)

private theorem subst_get_odd (u : List Bool) (k : ℕ) (hk : k < u.length) :
    (subst u)[2 * k + 1]? = u[k]?.map (! ·) := by
  induction u generalizing k with
  | nil => simp at hk
  | cons b u ih =>
    cases k with
    | zero => cases b <;> rfl
    | succ k =>
      have he : 2 * (k + 1) + 1 = ((2 * k + 1) + 1) + 1 := by omega
      change ((if b then [true, false] else [true, true]) ++ subst u)[2 * (k + 1) + 1]? = _
      rw [he]
      cases b <;> exact ih k (by simpa using hk)

private theorem twice_mod_succ (k m r : ℕ) (hm : 0 < m) (hr : r < 2) :
    (2 * k + r) % (2 * m) = 2 * (k % m) + r := by
  have hk := Nat.mod_lt k hm
  have hq := Nat.mod_add_div k m
  have he : 2 * k + r = (2 * (k % m) + r) + (2 * m) * (k / m) := by
    rw [Nat.mul_assoc]
    omega
  rw [he, Nat.add_mul_mod_self_left]
  exact Nat.mod_eq_of_lt (by omega)

private theorem cyclic_subst_even (u : List Bool) (hu : 0 < u.length) (k : ℕ) :
    cyclicLetter (subst u) (2 * k) = true := by
  have he := twice_mod_succ k u.length 0 hu (by decide)
  simp only [Nat.add_zero] at he
  simp [cyclicLetter, subst_length, he, subst_get_even _ _ (Nat.mod_lt _ hu)]

private theorem cyclic_subst_odd (u : List Bool) (hu : 0 < u.length) (k : ℕ) :
    cyclicLetter (subst u) (2 * k + 1) = !cyclicLetter u k := by
  have hk := Nat.mod_lt k hu
  simp only [cyclicLetter, subst_length, twice_mod_succ k u.length 1 hu (by decide),
    subst_get_odd u _ hk, List.getElem?_eq_getElem hk, Option.map_some, Option.getD_some]

private theorem W_succ_subst (n : ℕ) : W (n + 1) = subst (W n) :=
  Function.iterate_succ_apply' _ _ _

private theorem W_pos (n : ℕ) : 0 < (W n).length := by
  rw [W_length]
  positivity

private theorem W_no_bb (n : ℕ) (hn : 1 ≤ n) (k : ℕ) :
    cyclicLetter (W n) k = true ∨ cyclicLetter (W n) (k + 1) = true := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
  rw [W_succ_subst]
  by_cases he : k % 2 = 0
  · left
    rw [show k = 2 * (k / 2) by omega]
    exact cyclic_subst_even _ (W_pos _) _
  · right
    rw [show k + 1 = 2 * (k / 2 + 1) by omega]
    exact cyclic_subst_even _ (W_pos _) _

private theorem W_no_four_a (n : ℕ) (hn : 1 ≤ n) (k : ℕ) :
    ¬ (cyclicLetter (W n) k = true ∧ cyclicLetter (W n) (k + 1) = true ∧
      cyclicLetter (W n) (k + 2) = true ∧ cyclicLetter (W n) (k + 3) = true) := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
  rw [W_succ_subst]
  have hparent : cyclicLetter (W n) (k / 2) = true ∨
      cyclicLetter (W n) (k / 2 + 1) = true := by
    by_cases hn0 : n = 0
    · subst n
      left
      simp [W, cyclicLetter, Nat.mod_one]
    · exact W_no_bb n (by omega) _
  have h₀ := cyclic_subst_odd (W n) (W_pos n) (k / 2)
  have h₁ := cyclic_subst_odd (W n) (W_pos n) (k / 2 + 1)
  rintro ⟨ha, hb, hc, hd⟩
  by_cases he : k % 2 = 0
  · rw [show k + 1 = 2 * (k / 2) + 1 by omega, h₀] at hb
    rw [show k + 3 = 2 * (k / 2 + 1) + 1 by omega, h₁] at hd
    rcases hparent with hh | hh
    · simp [hh] at hb
    · simp [hh] at hd
  · rw [show k = 2 * (k / 2) + 1 by omega, h₀] at ha
    rw [show k + 2 = 2 * (k / 2 + 1) + 1 by omega, h₁] at hc
    rcases hparent with hh | hh
    · simp [hh] at ha
    · simp [hh] at hc

private def cyclicIndex (ω : List Bool) (h : 0 < ω.length) (k : ℕ) : Fin ω.length :=
  ⟨k % ω.length, Nat.mod_lt _ h⟩

private theorem cyclicIndex_succ (ω : List Bool) (h : 0 < ω.length) (k : ℕ) :
    cyclicIndex ω h (k + 1) = nxt ω (cyclicIndex ω h k) := by
  letI : NeZero ω.length := ⟨h.ne'⟩
  apply Fin.ext
  rw [nxt, finRotate_apply, Fin.val_add, Fin.val_one']
  exact Nat.add_mod _ _ _

private theorem get_cyclicIndex (ω : List Bool) (h : 0 < ω.length) (k : ℕ) :
    ω.get (cyclicIndex ω h k) = cyclicLetter ω k := by
  simp [cyclicIndex, cyclicLetter, List.getElem?_eq_getElem (Nat.mod_lt _ h)]

private theorem W_hinge_neighbor (n : ℕ) (hn : 1 ≤ n) (i : Fin (W n).length)
    (hi : (W n).get i = (W n).get (nxt (W n) i)) :
    (W n).get (prv (W n) i) ≠ (W n).get (nxt (W n) (prv (W n) i)) ∨
      (W n).get (nxt (W n) i) ≠ (W n).get (nxt (W n) (nxt (W n) i)) := by
  by_contra! h
  let k := (prv (W n) i).val
  have hk : cyclicIndex (W n) (W_pos n) k = prv (W n) i := by
    apply Fin.ext
    exact Nat.mod_eq_of_lt (prv (W n) i).isLt
  have hk1 : cyclicIndex (W n) (W_pos n) (k + 1) = i := by
    rw [cyclicIndex_succ, hk]
    exact (finRotate _).apply_symm_apply i
  have hk2 : cyclicIndex (W n) (W_pos n) (k + 2) = nxt (W n) i := by
    change cyclicIndex (W n) (W_pos n) (k + 1 + 1) = _
    rw [cyclicIndex_succ, hk1]
  have hk3 : cyclicIndex (W n) (W_pos n) (k + 3) = nxt (W n) (nxt (W n) i) := by
    change cyclicIndex (W n) (W_pos n) (k + 2 + 1) = _
    rw [cyclicIndex_succ, hk2]
  have h0 := get_cyclicIndex (W n) (W_pos n) k
  have h1 := get_cyclicIndex (W n) (W_pos n) (k + 1)
  have h2 := get_cyclicIndex (W n) (W_pos n) (k + 2)
  have h3 := get_cyclicIndex (W n) (W_pos n) (k + 3)
  rw [hk] at h0
  rw [hk1] at h1
  rw [hk2] at h2
  rw [hk3] at h3
  have e : (W n).get (nxt (W n) (prv (W n) i)) = (W n).get i := by
    exact congrArg (W n).get ((finRotate _).apply_symm_apply i)
  apply W_no_four_a n hn k
  rcases W_no_bb n hn k with hh | hh
  · grind
  · grind

private theorem W_uniform (n : ℕ) (hn : 1 ≤ n) :
    ∃ w : Fin (W n).length → ℝ, ∀ i, (1 / 4 : ℝ) ≤ w i ∧
      (1 / 4 : ℝ) ≤ xAng (W n) w i ∧ (1 / 4 : ℝ) ≤ yAng (W n) w i ∧
      (1 / 4 : ℝ) ≤ zAng (W n) w i :=
  uniform_angle_structure (W n) (W_hinge_neighbor n hn)

theorem W_has_angle_structure (n : ℕ) (hn : 1 ≤ n) :
    ∃ w, IsAngleStructure (W n) w := by
  obtain ⟨w, hw⟩ := W_uniform n hn
  refine ⟨w, fun i => ?_⟩
  obtain ⟨h1, h2, h3, h4⟩ := hw i
  exact ⟨by linarith, by linarith, by linarith, by linarith⟩

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private theorem iterate_singleton_length (k : ℕ) (b : Bool) :
    (subst^[k] [b]).length = 2 ^ k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    rw [Function.iterate_succ_apply', subst_length, ih, Nat.pow_succ, Nat.mul_comm]

private theorem getElem?_iterate_block (k : ℕ) (u : List Bool) (q j : ℕ)
    (hq : q < u.length) (hj : j < 2 ^ k) :
    (subst^[k] u)[j + 2 ^ k * q]? = (subst^[k] [u[q]])[j]? := by
  induction u generalizing q with
  | nil => simp at hq
  | cons b u ih =>
    change (subst^[k] ([b] ++ u))[j + 2 ^ k * q]? = _
    rw [subst_iterate_append, List.getElem?_append]
    cases q with
    | zero =>
      simp only [Nat.mul_zero, Nat.add_zero, iterate_singleton_length, ite_eq_left hj,
        List.getElem_cons_zero]
    | succ q =>
      have hidx : 2 ^ k ≤ j + 2 ^ k * (q + 1) := by
        rw [Nat.mul_succ]
        omega
      have he : j + 2 ^ k * (q + 1) - 2 ^ k = j + 2 ^ k * q := by
        rw [Nat.mul_succ, ← Nat.add_assoc, Nat.add_sub_cancel]
      simp only [iterate_singleton_length, ite_eq_right (Nat.not_lt.mpr hidx), he,
        List.getElem_cons_succ]
      exact ih q (by simpa using hq)

private theorem W_block_prefix (k r q j : ℕ) (hq : q < (W r).length)
    (hj : j + 1 < 2 ^ k) :
    (W (k + r))[j + 2 ^ k * q]? = (W k)[j]? := by
  have hiter : W (k + r) = subst^[k] (W r) := by
    rw [W, Function.iterate_add_apply]
    rfl
  rw [hiter, getElem?_iterate_block k (W r) q j hq (by omega)]
  cases hb : (W r)[q]
  · obtain ⟨p, b, ha, hc⟩ := W_and_companion k
    have hp : j < p.length := by
      have hh := W_length k
      rw [ha, List.length_append] at hh
      simp at hh
      omega
    rw [hc, ha, List.getElem?_append_left hp, List.getElem?_append_left hp]
  · rfl

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private def blend (t a b : ℝ) : ℝ := t * a + (1 - t) * b

private def xLocal (same : Bool) (a b c : ℝ) : ℝ :=
  if same then a + c else b + a - c

private def yLocal (same : Bool) (a b c : ℝ) : ℝ :=
  if same then 2 * b - a - c else b + c - a

private noncomputable def zLocal (b : ℝ) : ℝ := Real.pi - 2 * b

private noncomputable def localVol (same : Bool) (a b c : ℝ) : ℝ :=
  lob (xLocal same a b c) + lob (yLocal same a b c) + lob (zLocal b)

private def localMargin (d : ℝ) (same : Bool) (a b c : ℝ) : Prop :=
  d ≤ b ∧ d ≤ xLocal same a b c ∧ d ≤ yLocal same a b c ∧ d ≤ zLocal b

private def localPositive (same : Bool) (a b c : ℝ) : Prop :=
  0 < b ∧ 0 < xLocal same a b c ∧ 0 < yLocal same a b c ∧ 0 < zLocal b

private theorem local_sum (s : Bool) (a b c : ℝ) :
    xLocal s a b c + yLocal s a b c + zLocal b = Real.pi := by
  cases s <;> simp [xLocal, yLocal, zLocal] <;> ring

private theorem blend_frozen_margin (s : Bool) {a b c A B C t δ : ℝ}
    (hw : localPositive s a b c) (hu : localMargin (1 / 4) s A B C)
    (ht : 0 ≤ t) (hδ : δ ≤ 1 - t) (hδ₀ : 0 ≤ δ) :
    localMargin (δ / 4) s (blend t a A) (blend t b B) (blend t c C) := by
  rcases hw with ⟨hb, hx, hy, hz⟩
  rcases hu with ⟨hB, hX, hY, hZ⟩
  have aux (p q : ℝ) (hp : 0 ≤ p) (hq : (1 / 4 : ℝ) ≤ q) (ht' : 0 ≤ 1 - t) :
      δ / 4 ≤ blend t p q := by
    unfold blend
    nlinarith only [mul_nonneg ht hp, mul_nonneg ht' (sub_nonneg.mpr hq), hδ]
  have htn : 0 ≤ 1 - t := hδ₀.trans hδ
  have ex : xLocal s (blend t a A) (blend t b B) (blend t c C) =
      blend t (xLocal s a b c) (xLocal s A B C) := by
    cases s <;> simp [xLocal, blend] <;> ring
  have ey : yLocal s (blend t a A) (blend t b B) (blend t c C) =
      blend t (yLocal s a b c) (yLocal s A B C) := by
    cases s <;> simp [yLocal, blend] <;> ring
  have ez : zLocal (blend t b B) = blend t (zLocal b) (zLocal B) := by
    simp [zLocal, blend]
    ring
  exact ⟨aux _ _ hb.le hB htn, ex.symm ▸ aux _ _ hx.le hX htn,
    ey.symm ▸ aux _ _ hy.le hY htn, ez.symm ▸ aux _ _ hz.le hZ htn⟩

private theorem blend_diff (t t' a b : ℝ) :
    |blend t a b - blend t' a b| = |t - t'| * |a - b| := by
  rw [show blend t a b - blend t' a b = (t - t') * (a - b) by unfold blend; ring,
    abs_mul]

private theorem local_repair (s : Bool) {a b c A B C t₀ t t₁ δ : ℝ}
    (hw : localPositive s a b c) (hu : localMargin (1 / 4) s A B C)
    (hδ : 0 < δ) (ht : 0 ≤ t) (htδ : δ ≤ 1 - t)
    (ha : |a - A| ≤ 2) (hc : |c - C| ≤ 2)
    (h₀ : |t₀ - t| ≤ δ / 32) (h₁ : |t₁ - t| ≤ δ / 32) :
    localPositive s (blend t₀ a A) (blend t b B) (blend t₁ c C) := by
  obtain ⟨hb, hx, hy, hz⟩ := blend_frozen_margin s hw hu ht htδ (by linarith)
  have hl : |blend t₀ a A - blend t a A| ≤ δ / 16 := by
    rw [blend_diff]
    exact (mul_le_mul h₀ ha (abs_nonneg _) (by positivity)).trans (by ring_nf; rfl)
  have hr : |blend t₁ c C - blend t c C| ≤ δ / 16 := by
    rw [blend_diff]
    exact (mul_le_mul h₁ hc (abs_nonneg _) (by positivity)).trans (by ring_nf; rfl)
  obtain ⟨hl₁, hl₂⟩ := abs_le.mp hl
  obtain ⟨hr₁, hr₂⟩ := abs_le.mp hr
  refine ⟨by linarith, ?_, ?_, by linarith⟩
  · cases s <;> simp only [xLocal, Bool.false_eq_true, ite_false, ite_true] at hx ⊢ <;> linarith
  · cases s <;> simp only [yLocal, Bool.false_eq_true, ite_false, ite_true] at hy ⊢ <;> linarith

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private def blockIndex (k r : ℕ) :
    Fin (W r).length × Fin (W k).length ≃ Fin (W (k + r)).length :=
  finProdFinEquiv.trans (finCongr (by rw [W_length, W_length, W_length, Nat.pow_add, Nat.mul_comm]))

private theorem blockIndex_val (k r : ℕ) (q : Fin (W r).length) (i : Fin (W k).length) :
    (blockIndex k r (q, i)).val = i.val + (W k).length * q.val := rfl

private theorem blockIndex_letter (k r : ℕ) (q : Fin (W r).length) (i : Fin (W k).length)
    (hi : i.val + 1 < (W k).length) :
    (W (k + r)).get (blockIndex k r (q, i)) = (W k).get i := by
  have h := W_block_prefix k r q.val i.val q.isLt (W_length k ▸ hi)
  rw [← W_length] at h
  have hbig : i.val + (W k).length * q.val < (W (k + r)).length :=
    (blockIndex k r (q, i)).isLt
  rw [List.getElem?_eq_getElem hbig, List.getElem?_eq_getElem i.isLt] at h
  exact Option.some.inj h

private theorem nxt_val_of_lt (ω : List Bool) (i : Fin ω.length) (hi : i.val + 1 < ω.length) :
    (nxt ω i).val = i.val + 1 := by
  have hp : 0 < ω.length := lt_of_le_of_lt (Nat.zero_le _) i.isLt
  letI : NeZero ω.length := ⟨hp.ne'⟩
  rw [nxt, finRotate_apply, Fin.val_add, Fin.val_one']
  have h1 : 1 < ω.length := by omega
  rw [Nat.mod_eq_of_lt h1, Nat.mod_eq_of_lt hi]

private theorem prv_val_of_pos (ω : List Bool) (i : Fin ω.length) (hi : 0 < i.val) :
    (prv ω i).val = i.val - 1 := by
  letI : NeZero ω.length := ⟨Nat.ne_of_gt (lt_trans hi i.isLt)⟩
  have hn : i ≠ 0 := by
    intro h
    rw [h] at hi
    simp at hi
  exact coe_finRotate_symm_of_ne_zero hn

private theorem blockIndex_nxt (k r : ℕ) (q : Fin (W r).length) (i : Fin (W k).length)
    (hi : i.val + 1 < (W k).length) :
    nxt (W (k + r)) (blockIndex k r (q, i)) = blockIndex k r (q, nxt (W k) i) := by
  have hs := nxt_val_of_lt (W k) i hi
  have hh : (blockIndex k r (q, i)).val + 1 < (W (k + r)).length := by
    have ht := (blockIndex k r (q, nxt (W k) i)).isLt
    rw [blockIndex_val, hs] at ht
    rw [blockIndex_val]
    omega
  apply Fin.ext
  rw [nxt_val_of_lt _ _ hh, blockIndex_val, blockIndex_val, hs]
  omega

private theorem blockIndex_prv (k r : ℕ) (q : Fin (W r).length) (i : Fin (W k).length)
    (hi : 0 < i.val) :
    prv (W (k + r)) (blockIndex k r (q, i)) = blockIndex k r (q, prv (W k) i) := by
  have hs := prv_val_of_pos (W k) i hi
  have hh : 0 < (blockIndex k r (q, i)).val := by rw [blockIndex_val]; omega
  apply Fin.ext
  rw [prv_val_of_pos _ _ hh, blockIndex_val, blockIndex_val, hs]
  omega

private def sameAt (ω : List Bool) (i : Fin ω.length) : Bool :=
  decide (ω.get i = ω.get (nxt ω i))

private theorem blockIndex_same (k r : ℕ) (q : Fin (W r).length) (i : Fin (W k).length)
    (hi : i.val + 2 < (W k).length) :
    sameAt (W (k + r)) (blockIndex k r (q, i)) = sameAt (W k) i := by
  have hs : i.val + 1 < (W k).length := by omega
  have ht : (nxt (W k) i).val + 1 < (W k).length := by
    rw [nxt_val_of_lt _ _ hs]
    omega
  simp only [sameAt, blockIndex_nxt k r q i hs, blockIndex_letter k r q i hs,
    blockIndex_letter k r q _ ht]

private theorem localPositive_iff (ω : List Bool) (w : Fin ω.length → ℝ) (i : Fin ω.length) :
    localPositive (sameAt ω i) (w (prv ω i)) (w i) (w (nxt ω i)) ↔
      0 < w i ∧ 0 < xAng ω w i ∧ 0 < yAng ω w i ∧ 0 < zAng ω w i := by
  simp [localPositive, sameAt, xLocal, yLocal, zLocal, xAng, yAng, zAng]

private theorem localMargin_iff (ω : List Bool) (w : Fin ω.length → ℝ) (i : Fin ω.length) :
    localMargin (1 / 4) (sameAt ω i) (w (prv ω i)) (w i) (w (nxt ω i)) ↔
      (1 / 4 : ℝ) ≤ w i ∧ (1 / 4 : ℝ) ≤ xAng ω w i ∧
      (1 / 4 : ℝ) ≤ yAng ω w i ∧ (1 / 4 : ℝ) ≤ zAng ω w i := by
  simp [localMargin, sameAt, xLocal, yLocal, zLocal, xAng, yAng, zAng]

private noncomputable def energy (ω : List Bool) (w : Fin ω.length → ℝ) (i : Fin ω.length) : ℝ :=
  localVol (sameAt ω i) (w (prv ω i)) (w i) (w (nxt ω i))

private theorem energy_eq (ω : List Bool) (w : Fin ω.length → ℝ) (i : Fin ω.length) :
    energy ω w i = lob (xAng ω w i) + lob (yAng ω w i) + lob (zAng ω w i) := by
  simp [energy, localVol, sameAt, xLocal, yLocal, zLocal, xAng, yAng, zAng]

private theorem volFun_eq_energy (ω : List Bool) (w : Fin ω.length → ℝ) :
    volFun ω w = ∑ i, energy ω w i := by
  simp [energy_eq, volFun]

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private theorem nxt_val_mod (ω : List Bool) (i : Fin ω.length) :
    (nxt ω i).val = (i.val + 1) % ω.length := by
  letI : NeZero ω.length := i.neZero
  rw [nxt, finRotate_apply, Fin.val_add, Fin.val_one', Nat.add_mod i.val 1 ω.length,
    Nat.mod_eq_of_lt i.isLt]

private theorem block_col_val (k r : ℕ) (j : Fin (W (k + r)).length) :
    ((blockIndex k r).symm j).2.val = j.val % (W k).length := by
  obtain ⟨⟨q, i⟩, rfl⟩ := (blockIndex k r).surjective j
  rw [Equiv.symm_apply_apply, blockIndex_val, Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt i.isLt]

private theorem block_col_nxt (k r : ℕ) (j : Fin (W (k + r)).length) :
    ((blockIndex k r).symm (nxt (W (k + r)) j)).2 =
      nxt (W k) ((blockIndex k r).symm j).2 := by
  have hd : (W k).length ∣ (W (k + r)).length := by
    simp only [W_length, Nat.pow_add]
    exact dvd_mul_right _ _
  apply Fin.ext
  rw [block_col_val, nxt_val_mod, Nat.mod_mod_of_dvd _ hd, nxt_val_mod, block_col_val]
  exact (Nat.mod_add_mod _ _ _).symm

private theorem block_col_prv (k r : ℕ) (j : Fin (W (k + r)).length) :
    ((blockIndex k r).symm (prv (W (k + r)) j)).2 =
      prv (W k) ((blockIndex k r).symm j).2 := by
  have h := block_col_nxt k r (prv (W (k + r)) j)
  change ((blockIndex k r).symm (finRotate _ ((finRotate _).symm j))).2 =
      finRotate _ ((blockIndex k r).symm ((finRotate _).symm j)).2 at h
  rw [Equiv.apply_symm_apply] at h
  unfold prv
  rw [h, Equiv.symm_apply_apply]

private def depth (m j : ℕ) : ℕ := min (j - 1) (m - 3 - j)

private theorem depth_step (m j : ℕ) :
    depth m j ≤ depth m (j + 1) + 1 ∧ depth m (j + 1) ≤ depth m j + 1 := by
  unfold depth
  omega

private noncomputable def taper (δ : ℝ) (m j : ℕ) : ℝ :=
  min (1 - δ) (δ / 32 * (depth m j : ℝ))

private theorem taper_bounds {δ : ℝ} (hδ : 0 ≤ δ) (hδ' : δ ≤ 1) (m j : ℕ) :
    0 ≤ taper δ m j ∧ δ ≤ 1 - taper δ m j := by
  refine ⟨le_min (by linarith) (by positivity), ?_⟩
  have ht := min_le_left (1 - δ) (δ / 32 * (depth m j : ℝ))
  unfold taper
  linarith

private theorem taper_flat {δ : ℝ} (hδ : 0 < δ) (_hδ' : δ ≤ 1) {N m j : ℕ}
    (hN : 1 ≤ δ / 32 * (N : ℝ)) (h : N ≤ depth m j) :
    taper δ m j = 1 - δ := by
  apply min_eq_left
  have ht : δ / 32 * (N : ℝ) ≤ δ / 32 * (depth m j : ℝ) :=
    mul_le_mul_of_nonneg_left (by exact_mod_cast h) (by positivity)
  linarith

private theorem taper_step {δ : ℝ} (hδ : 0 ≤ δ) (m j : ℕ) :
    |taper δ m (j + 1) - taper δ m j| ≤ δ / 32 := by
  have h := depth_step m j
  have h₁ : (depth m j : ℝ) ≤ (depth m (j + 1) : ℝ) + 1 := by exact_mod_cast h.1
  have h₂ : (depth m (j + 1) : ℝ) ≤ (depth m j : ℝ) + 1 := by exact_mod_cast h.2
  have h₃ := mul_le_mul_of_nonneg_left h₁ (show 0 ≤ δ / 32 by positivity)
  have h₄ := mul_le_mul_of_nonneg_left h₂ (show 0 ≤ δ / 32 by positivity)
  unfold taper
  rw [abs_le]
  constructor <;> by_cases ha : 1 - δ ≤ δ / 32 * (depth m j : ℝ) <;>
    by_cases hb : 1 - δ ≤ δ / 32 * (depth m (j + 1) : ℝ) <;>
    simp only [min_def, ha, hb, ite_true, ite_false] <;>
    linarith

private theorem taper_zero {δ : ℝ} (hδ : δ ≤ 1) {m j : ℕ}
    (h : j ≤ 1 ∨ m - 3 ≤ j) : taper δ m j = 0 := by
  have hd : depth m j = 0 := by unfold depth; omega
  simp [taper, hd, min_eq_right (show (0 : ℝ) ≤ 1 - δ by linarith)]

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private theorem angle_diff_bound {a b : ℝ} (ha : 0 ≤ a) (ha' : a ≤ Real.pi)
    (hb : 0 ≤ b) (hb' : b ≤ Real.pi) : |a - b| ≤ Real.pi := by
  rw [abs_le]
  constructor <;> linarith

private theorem local_vol_blend_uniform (ε : ℝ) (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ δ ≤ 1 ∧
      ∀ (s : Bool) (a b c A B C : ℝ),
        localPositive s a b c → localPositive s A B C →
        localPositive s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) →
        |localVol s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) -
          localVol s a b c| ≤ ε := by
  have hu : UniformContinuousOn lob (Set.Icc 0 Real.pi) :=
    isCompact_Icc.uniformContinuousOn_of_continuous continuous_lob.continuousOn
  obtain ⟨d, hd, hmod⟩ := Metric.uniformContinuousOn_iff.mp hu (ε / 3) (by positivity)
  let δ := min (1 / 2 : ℝ) (d / (2 * Real.pi))
  have hp := Real.pi_pos
  have hδ : 0 < δ := lt_min (by norm_num) (by positivity)
  have hδ₁ : δ ≤ (1 / 2 : ℝ) := min_le_left _ _
  have hδd : δ ≤ d / (2 * Real.pi) := min_le_right _ _
  have hmul := (le_div_iff₀ (show 0 < 2 * Real.pi by positivity)).mp hδd
  refine ⟨δ, hδ, by linarith, fun s a b c A B C ha hb hc => ?_⟩
  let t := 1 - δ
  have one (x y : ℝ) (hx : x ∈ Set.Icc 0 Real.pi) (hy : y ∈ Set.Icc 0 Real.pi)
      (hz : blend t x y ∈ Set.Icc 0 Real.pi) :
      |lob (blend t x y) - lob x| ≤ ε / 3 := by
    have hb : blend t x y - x = δ * (y - x) := by unfold blend t; ring
    have hdist : dist (blend t x y) x < d := by
      rw [Real.dist_eq, hb, abs_mul, abs_of_pos hδ]
      have hh := mul_le_mul_of_nonneg_left (angle_diff_bound hy.1 hy.2 hx.1 hx.2) hδ.le
      linarith
    exact (by simpa only [Real.dist_eq] using (hmod _ hz _ hx hdist).le)
  have angles (a b c : ℝ) (h : localPositive s a b c) :
      xLocal s a b c ∈ Set.Icc 0 Real.pi ∧ yLocal s a b c ∈ Set.Icc 0 Real.pi ∧
        zLocal b ∈ Set.Icc 0 Real.pi := by
    obtain ⟨_, hx, hy, hz⟩ := h
    have hs := local_sum s a b c
    exact ⟨⟨hx.le, by linarith⟩, ⟨hy.le, by linarith⟩, ⟨hz.le, by linarith⟩⟩
  obtain ⟨ax, ay, az⟩ := angles a b c ha
  obtain ⟨bx, by', bz⟩ := angles A B C hb
  obtain ⟨cx, cy, cz⟩ := angles (blend t a A) (blend t b B) (blend t c C) hc
  have ex : xLocal s (blend t a A) (blend t b B) (blend t c C) =
      blend t (xLocal s a b c) (xLocal s A B C) := by
    cases s <;> simp [xLocal, blend] <;> ring
  have ey : yLocal s (blend t a A) (blend t b B) (blend t c C) =
      blend t (yLocal s a b c) (yLocal s A B C) := by
    cases s <;> simp [yLocal, blend] <;> ring
  have ez : zLocal (blend t b B) = blend t (zLocal b) (zLocal B) := by
    unfold zLocal blend
    ring
  rw [ex] at cx
  rw [ey] at cy
  rw [ez] at cz
  have hx := one _ _ ax bx cx
  have hy := one _ _ ay by' cy
  have hz := one _ _ az bz cz
  unfold localVol
  change |lob (xLocal s (blend t a A) (blend t b B) (blend t c C)) +
    lob (yLocal s (blend t a A) (blend t b B) (blend t c C)) + lob (zLocal (blend t b B)) -
    (lob (xLocal s a b c) + lob (yLocal s a b c) + lob (zLocal b))| ≤ ε
  rw [ex, ey, ez, abs_le]
  obtain ⟨hx₁, hx₂⟩ := abs_le.mp hx
  obtain ⟨hy₁, hy₂⟩ := abs_le.mp hy
  obtain ⟨hz₁, hz₂⟩ := abs_le.mp hz
  constructor <;> linarith only [hx₁, hx₂, hy₁, hy₂, hz₁, hz₂]

private theorem weight_bound {ω : List Bool} {w : Fin ω.length → ℝ}
    (hw : IsAngleStructure ω w) (i : Fin ω.length) : 0 ≤ w i ∧ w i ≤ 2 := by
  have hz := (hw i).2.2.2
  have hp := Real.pi_lt_four
  unfold zAng at hz
  exact ⟨(hw i).1.le, by linarith⟩

private theorem margin_positive {s : Bool} {a b c : ℝ}
    (h : localMargin (1 / 4) s a b c) : localPositive s a b c := by
  obtain ⟨h1, h2, h3, h4⟩ := h
  exact ⟨by linarith, by linarith, by linarith, by linarith⟩

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

private def interiorCol {m : ℕ} (j : Fin m) : Prop := 0 < j.val ∧ j.val + 2 < m

private def goodCol (N : ℕ) {m : ℕ} (j : Fin m) : Prop :=
  N + 2 ≤ j.val ∧ j.val + N + 4 ≤ m

private instance (N : ℕ) {m : ℕ} (j : Fin m) : Decidable (goodCol N j) :=
  inferInstanceAs (Decidable (N + 2 ≤ j.val ∧ j.val + N + 4 ≤ m))

private theorem prv_val_zero (ω : List Bool) (i : Fin ω.length) (h : i.val = 0) :
    (prv ω i).val = ω.length - 1 := by
  have hl : 0 < ω.length := by omega
  let j : Fin ω.length := ⟨ω.length - 1, by omega⟩
  have hj : nxt ω j = i := by
    apply Fin.ext
    rw [nxt_val_mod, h]
    change (ω.length - 1 + 1) % ω.length = 0
    rw [show ω.length - 1 + 1 = ω.length by omega, Nat.mod_self]
  have hr : prv ω i = j := (finRotate ω.length).symm_apply_eq.mpr hj.symm
  rw [hr]

private theorem taper_boundary {δ : ℝ} (hδ : δ ≤ 1) (ω : List Bool) (j : Fin ω.length)
    (h : ¬interiorCol j) :
    taper δ ω.length (prv ω j).val = 0 ∧ taper δ ω.length j.val = 0 ∧
      taper δ ω.length (nxt ω j).val = 0 := by
  unfold interiorCol at h
  have hj := j.isLt
  have hp : (prv ω j).val ≤ 1 ∨ ω.length - 3 ≤ (prv ω j).val := by
    by_cases hz : j.val = 0
    · rw [prv_val_zero _ _ hz]
      omega
    · rw [prv_val_of_pos _ _ (by omega)]
      omega
  have hs : (nxt ω j).val ≤ 1 ∨ ω.length - 3 ≤ (nxt ω j).val := by
    by_cases hl : j.val + 1 < ω.length
    · rw [nxt_val_of_lt _ _ hl]
      omega
    · rw [nxt_val_mod, show j.val + 1 = ω.length by omega, Nat.mod_self]
      omega
  exact ⟨taper_zero hδ hp, taper_zero hδ (by omega), taper_zero hδ hs⟩

private theorem goodCol_interior (N : ℕ) {m : ℕ} {j : Fin m} (h : goodCol N j) :
    interiorCol j := by
  unfold goodCol at h
  unfold interiorCol
  omega

private theorem taper_plateau {δ : ℝ} (hδ : 0 < δ) (hδ' : δ ≤ 1) {N : ℕ}
    (hN : 1 ≤ δ / 32 * (N : ℝ)) (ω : List Bool) (j : Fin ω.length) (h : goodCol N j) :
    taper δ ω.length (prv ω j).val = 1 - δ ∧ taper δ ω.length j.val = 1 - δ ∧
      taper δ ω.length (nxt ω j).val = 1 - δ := by
  have hi := goodCol_interior N h
  unfold goodCol at h
  rw [prv_val_of_pos _ _ hi.1, nxt_val_of_lt _ _ (by have := hi.2; omega)]
  refine ⟨taper_flat hδ hδ' hN ?_, taper_flat hδ hδ' hN ?_, taper_flat hδ hδ' hN ?_⟩ <;>
    unfold depth <;> omega

private theorem taper_interior_steps {δ : ℝ} (hδ : 0 ≤ δ) (ω : List Bool) (j : Fin ω.length)
    (h : interiorCol j) :
    |taper δ ω.length (prv ω j).val - taper δ ω.length j.val| ≤ δ / 32 ∧
      |taper δ ω.length (nxt ω j).val - taper δ ω.length j.val| ≤ δ / 32 := by
  have hj := h.2
  rw [prv_val_of_pos _ _ h.1, nxt_val_of_lt _ _ (by omega)]
  constructor
  · rw [abs_sub_comm]
    have hh := taper_step hδ ω.length (j.val - 1)
    rwa [show j.val - 1 + 1 = j.val by have := h.1; omega] at hh
  · exact taper_step hδ ω.length j.val

private theorem weights_sub_bound {a b : ℝ} (ha : 0 ≤ a ∧ a ≤ 2) (hb : 0 ≤ b ∧ b ≤ 2) :
    |a - b| ≤ 2 := by
  rw [abs_le]
  constructor <;> linarith [ha.1, ha.2, hb.1, hb.2]

private theorem transplant {ε δ M : ℝ} {N : ℕ} (hε : 0 ≤ ε) (hδ : 0 < δ)
    (hδ' : δ ≤ 1) (hM : 0 ≤ M) (hN : 1 ≤ δ / 32 * (N : ℝ))
    (hmod : ∀ (s : Bool) (a b c A B C : ℝ),
      localPositive s a b c → localPositive s A B C →
      localPositive s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) →
      |localVol s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) -
        localVol s a b c| ≤ ε)
    (hbound : ∀ (ω : List Bool) (w : Fin ω.length → ℝ), IsAngleStructure ω w →
      ∀ i, |energy ω w i| ≤ M)
    (base ω : List Bool) (col : Fin ω.length → Fin base.length)
    (hp : ∀ i, col (prv ω i) = prv base (col i))
    (hs : ∀ i, col (nxt ω i) = nxt base (col i))
    (u f : Fin ω.length → ℝ) (old : Fin ω.length → ℝ)
    (hu : ∀ i, localMargin (1 / 4) (sameAt ω i) (u (prv ω i)) (u i) (u (nxt ω i)))
    (hf : ∀ i, 0 ≤ f i ∧ f i ≤ 2)
    (hold : ∀ i, |old i| ≤ M)
    (hlocal : ∀ i, interiorCol (col i) →
      localPositive (sameAt ω i) (f (prv ω i)) (f i) (f (nxt ω i)) ∧
      energy ω f i = old i) :
    ∃ v, IsAngleStructure ω v ∧ ∀ i, old i ≤ energy ω v i +
      (if goodCol N (col i) then ε else 2 * M) := by
  classical
  let t (i : Fin ω.length) := taper δ base.length (col i).val
  let v (i : Fin ω.length) := blend (t i) (f i) (u i)
  have hu' : IsAngleStructure ω u := fun i =>
    (localPositive_iff ω u i).mp (margin_positive (hu i))
  have hv : IsAngleStructure ω v := by
    intro i
    apply (localPositive_iff ω v i).mp
    by_cases hi : interiorCol (col i)
    · have hstep := taper_interior_steps hδ.le base (col i) hi
      have hb := taper_bounds hδ.le hδ' base.length (col i).val
      have h₀ : |t (prv ω i) - t i| ≤ δ / 32 := by simpa only [t, hp] using hstep.1
      have h₁ : |t (nxt ω i) - t i| ≤ δ / 32 := by simpa only [t, hs] using hstep.2
      exact local_repair _ (hlocal i hi).1 (hu i) hδ hb.1 hb.2
        (weights_sub_bound (hf _) (weight_bound hu' _))
        (weights_sub_bound (hf _) (weight_bound hu' _)) h₀ h₁
    · obtain ⟨h₀, h₁, h₂⟩ := taper_boundary hδ' base (col i) hi
      simpa only [v, t, hp, hs, h₀, h₁, h₂, blend, zero_mul, sub_zero, one_mul,
        zero_add] using margin_positive (hu i)
  refine ⟨v, hv, fun i => ?_⟩
  by_cases hi : goodCol N (col i)
  · have he := (hlocal i (goodCol_interior N hi)).2
    have hw := (hlocal i (goodCol_interior N hi)).1
    obtain ⟨h₀, h₁, h₂⟩ := taper_plateau hδ hδ' hN base (col i) hi
    have hv' := (localPositive_iff ω v i).mpr (hv i)
    simp only [v, t, hp, hs, h₀, h₁, h₂] at hv'
    have hm := hmod _ _ _ _ _ _ _ hw (margin_positive (hu i)) hv'
    have ha : |energy ω v i - old i| ≤ ε := by
      rw [← he]
      simpa only [energy, v, t, hp, hs, h₀, h₁, h₂] using hm
    simp only [ite_eq_left hi]
    linarith only [(abs_le.mp ha).1]
  · have he := hbound ω v hv i
    simp only [ite_eq_right hi]
    linarith only [(abs_le.mp he).1, (abs_le.mp (hold i)).2]

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

open Filter Topology

private theorem block_energy (k r : ℕ) (q : Fin (W r).length)
    (i : Fin (W k).length) (hi : interiorCol i)
    (v : Fin (W (k + r)).length → ℝ) (w : Fin (W k).length → ℝ)
    (h : ∀ j, v (blockIndex k r (q, j)) = w j) :
    energy (W (k + r)) v (blockIndex k r (q, i)) = energy (W k) w i := by
  have hs : i.val + 1 < (W k).length := by have := hi.2; omega
  simp only [energy, blockIndex_same k r q i hi.2, blockIndex_prv k r q i hi.1,
    blockIndex_nxt k r q i hs, h]

private theorem block_positive (k r : ℕ) (q : Fin (W r).length)
    (i : Fin (W k).length) (hi : interiorCol i)
    (v : Fin (W (k + r)).length → ℝ) (w : Fin (W k).length → ℝ)
    (h : ∀ j, v (blockIndex k r (q, j)) = w j) :
    localPositive (sameAt (W (k + r)) (blockIndex k r (q, i)))
      (v (prv (W (k + r)) (blockIndex k r (q, i)))) (v (blockIndex k r (q, i)))
      (v (nxt (W (k + r)) (blockIndex k r (q, i)))) ↔
    localPositive (sameAt (W k) i) (w (prv (W k) i)) (w i) (w (nxt (W k) i)) := by
  have hs : i.val + 1 < (W k).length := by have := hi.2; omega
  simp only [blockIndex_same k r q i hi.2, blockIndex_prv k r q i hi.1,
    blockIndex_nxt k r q i hs, h]

private theorem W_sum_blocks (k r : ℕ) (f : Fin (W (k + r)).length → ℝ) :
    (∑ j, f j) = ∑ q : Fin (W r).length, ∑ i : Fin (W k).length, f (blockIndex k r (q, i)) := by
  rw [← (blockIndex k r).sum_comp f, Fintype.sum_prod_type]

private theorem hypVol_bdd {ω : List Bool} {M : ℝ}
    (h : ∀ w, IsAngleStructure ω w → ∀ i, |energy ω w i| ≤ M) :
    BddAbove (volFun ω '' {w | IsAngleStructure ω w}) := by
  refine ⟨∑ _ : Fin ω.length, M, ?_⟩
  intro a ha
  obtain ⟨w, hw, rfl⟩ := ha
  rw [volFun_eq_energy]
  exact Finset.sum_le_sum fun i _ => (abs_le.mp (h w hw i)).2

private theorem hypVol_ge {ω : List Bool} {w : Fin ω.length → ℝ} {M : ℝ}
    (h : ∀ w, IsAngleStructure ω w → ∀ i, |energy ω w i| ≤ M)
    (hw : IsAngleStructure ω w) : volFun ω w ≤ hypVol ω :=
  le_csSup (hypVol_bdd h) ⟨w, hw, rfl⟩

private theorem hypVol_le {ω : List Bool} {B : ℝ}
    (hn : ∃ w, IsAngleStructure ω w) (h : ∀ w, IsAngleStructure ω w → volFun ω w ≤ B) :
    hypVol ω ≤ B := by
  obtain ⟨w, hw⟩ := hn
  unfold hypVol
  have hne : (volFun ω '' {v | IsAngleStructure ω v}).Nonempty := ⟨volFun ω w, w, hw, rfl⟩
  apply csSup_le hne
  rintro _ ⟨x, hx, rfl⟩
  exact h x hx

private theorem badCol_card (N m : ℕ) :
    (Finset.univ.filter (fun i : Fin m => ¬goodCol N i)).card ≤ 2 * N + 6 := by
  let f (i : Fin m) : ℕ := if i.val < N + 2 then i.val else N + 2 + (m - 1 - i.val)
  calc
    _ ≤ (Finset.range (2 * N + 6)).card := by
      apply Finset.card_le_card_of_injOn f
      · intro i hi
        have hi' := (Finset.mem_filter.mp hi).2
        have hm := i.isLt
        change f i ∈ Finset.range (2 * N + 6)
        rw [Finset.mem_range]
        unfold f goodCol at *
        split_ifs <;> omega
      · intro i hi j hj he
        have hmi := i.isLt
        have hmj := j.isLt
        apply Fin.ext
        unfold f at he
        split_ifs at he <;> omega
    _ = _ := Finset.card_range _

private theorem error_sum (ε M : ℝ) (hε : 0 ≤ ε) (hM : 0 ≤ M) (N m : ℕ)
    :
    (∑ i : Fin m, if goodCol N i then ε else 2 * M) ≤ (m : ℝ) * ε + (2 * N + 6 : ℝ) * (2 * M) := by
  have hi : ∀ i : Fin m, (if goodCol N i then ε else 2 * M) ≤
      ε + (if ¬goodCol N i then 2 * M else 0) := by
    intro i
    by_cases h : goodCol N i <;> simp [h] <;> linarith
  calc
    _ ≤ ∑ i : Fin m, (ε + if ¬goodCol N i then 2 * M else 0) :=
      Finset.sum_le_sum fun i _ => hi i
    _ = (m : ℝ) * ε + ((Finset.univ.filter (fun i : Fin m => ¬goodCol N i)).card : ℝ) * (2 * M) := by
      rw [Finset.sum_add_distrib, Finset.sum_ite]
      simp [nsmul_eq_mul]
    _ ≤ _ := by
      apply add_le_add le_rfl
      apply mul_le_mul_of_nonneg_right _ (by positivity)
      exact_mod_cast badCol_card N m

private theorem compare_block_scales (ε δ M : ℝ) (N k r : ℕ)
    (hε : 0 ≤ ε) (hδ : 0 < δ) (hδ' : δ ≤ 1) (hM : 0 ≤ M)
    (hN : 1 ≤ δ / 32 * (N : ℝ)) (hk : 1 ≤ k)
    (hmod : ∀ (s : Bool) (a b c A B C : ℝ),
      localPositive s a b c → localPositive s A B C →
      localPositive s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) →
      |localVol s (blend (1 - δ) a A) (blend (1 - δ) b B) (blend (1 - δ) c C) -
        localVol s a b c| ≤ ε)
    (hb : ∀ (ω : List Bool) (w : Fin ω.length → ℝ), IsAngleStructure ω w →
      ∀ i, |energy ω w i| ≤ M) :
    |hypVol (W (k + r)) / 2 ^ (k + r) - hypVol (W k) / 2 ^ k| ≤
      ε + ((2 * N + 6 : ℝ) * (2 * M)) / 2 ^ k := by
  classical
  let small := W k
  let big := W (k + r)
  let e := blockIndex k r
  let E := (small.length : ℝ) * ε + (2 * N + 6 : ℝ) * (2 * M)
  let err (i : Fin small.length) := if goodCol N i then ε else 2 * M
  have he : ∑ i, err i ≤ E := error_sum ε M hε hM N _
  have hn : 1 ≤ k + r := by omega
  obtain ⟨u, hu⟩ := W_uniform k hk
  obtain ⟨U, hU⟩ := W_uniform (k + r) hn
  have hsm : ∀ i, localMargin (1 / 4) (sameAt small i) (u (prv small i)) (u i) (u (nxt small i)) :=
    fun i => (localMargin_iff small u i).mpr (hu i)
  have hlg : ∀ i, localMargin (1 / 4) (sameAt big i) (U (prv big i)) (U i) (U (nxt big i)) :=
    fun i => (localMargin_iff big U i).mpr (hU i)
  let R : ℝ := (W r).length
  have hR : 0 < R := by dsimp [R]; exact_mod_cast W_pos r
  have upper : hypVol big ≤ R * (hypVol small + E) := by
    apply hypVol_le (W_has_angle_structure (k + r) hn)
    intro v hv
    have each (q : Fin (W r).length) :
        (∑ i, energy big v (e (q, i))) ≤ hypVol small + E := by
      let f (i : Fin small.length) := v (e (q, i))
      let old (i : Fin small.length) := energy big v (e (q, i))
      have hloc (i : Fin small.length) (hi : interiorCol i) :
          localPositive (sameAt small i) (f (prv small i)) (f i) (f (nxt small i)) ∧
            energy small f i = old i := by
        exact ⟨(block_positive k r q i hi v f (fun _ => rfl)).mp
          ((localPositive_iff big v _).mpr (hv _)),
          (block_energy k r q i hi v f (fun _ => rfl)).symm⟩
      obtain ⟨w, hw, hle⟩ := transplant hε hδ hδ' hM hN hmod hb small small id
        (fun _ => rfl) (fun _ => rfl) u f old hsm
        (fun i => weight_bound hv (e (q, i))) (fun i => hb big v hv (e (q, i))) hloc
      have hs := Finset.sum_le_sum (fun i (_ : i ∈ Finset.univ) => hle i)
      rw [Finset.sum_add_distrib, ← volFun_eq_energy] at hs
      exact hs.trans (add_le_add (hypVol_ge (hb small) hw) he)
    rw [volFun_eq_energy, W_sum_blocks k r]
    calc
      _ ≤ ∑ _ : Fin (W r).length, (hypVol small + E) :=
        Finset.sum_le_sum fun q _ => each q
      _ = _ := by simp [R, nsmul_eq_mul, mul_add]
  have lower : hypVol small ≤ hypVol big / R + E := by
    apply hypVol_le (W_has_angle_structure k hk)
    intro w hw
    let col (i : Fin big.length) := (e.symm i).2
    let f (i : Fin big.length) := w (col i)
    let old (i : Fin big.length) := energy small w (col i)
    have halign (q : Fin (W r).length) (i : Fin small.length) : col (e (q, i)) = i := by
      simp [col]
    have hloc (j : Fin big.length) (hj : interiorCol (col j)) :
        localPositive (sameAt big j) (f (prv big j)) (f j) (f (nxt big j)) ∧
          energy big f j = old j := by
      obtain ⟨⟨q, i⟩, rfl⟩ := e.surjective j
      rw [halign] at hj
      have hf (l : Fin small.length) : f (e (q, l)) = w l := congrArg w (halign q l)
      refine ⟨(block_positive k r q i hj f w hf).mpr
        ((localPositive_iff small w i).mpr (hw i)), ?_⟩
      change energy big f (e (q, i)) = energy small w (col (e (q, i)))
      rw [halign]
      exact block_energy k r q i hj f w hf
    obtain ⟨v, hv, hle⟩ := transplant hε hδ hδ' hM hN hmod hb small big col
      (block_col_prv k r) (block_col_nxt k r) U f old hlg
      (fun i => weight_bound hw (col i)) (fun i => hb small w hw (col i)) hloc
    have hs := Finset.sum_le_sum (fun i (_ : i ∈ Finset.univ) => hle i)
    rw [Finset.sum_add_distrib, ← volFun_eq_energy] at hs
    have hold : ∑ i, old i = R * volFun small w := by
      rw [W_sum_blocks k r, volFun_eq_energy]
      change (∑ q : Fin (W r).length, ∑ i : Fin small.length,
        energy small w (col (e (q, i)))) = R * _
      simp only [halign, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, R]
    have herr : (∑ i : Fin big.length, (if goodCol N (col i) then ε else 2 * M)) ≤ R * E := by
      rw [W_sum_blocks k r]
      change (∑ q : Fin (W r).length, ∑ i : Fin small.length, err (col (e (q, i)))) ≤ R * E
      simp only [halign, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
      exact mul_le_mul_of_nonneg_left he hR.le
    have hh : R * volFun small w ≤ hypVol big + R * E := by
      rw [hold] at hs
      exact hs.trans (add_le_add (hypVol_ge (hb big) hv) herr)
    have hh' : volFun small w ≤ (hypVol big + E * R) / R := by
      apply (le_div_iff₀ hR).mpr
      convert hh using 1 <;> ring
    rwa [add_div, mul_div_cancel_right₀ _ hR.ne'] at hh'
  have hR' : R = 2 ^ r := by dsimp [R]; exact_mod_cast W_length r
  have hkpos : (0 : ℝ) < 2 ^ k := by positivity
  have hd : (2 : ℝ) ^ (k + r) = 2 ^ k * R := by rw [hR', pow_add]
  have hE : E / 2 ^ k = ε + ((2 * N + 6 : ℝ) * (2 * M)) / 2 ^ k := by
    dsimp [E, small]
    rw [add_div, W_length, Nat.cast_pow, Nat.cast_ofNat, mul_comm ((2 : ℝ) ^ k), mul_div_cancel_right₀ _ hkpos.ne']
  have hup := (div_le_div_iff_of_pos_right hR).mpr upper
  rw [mul_comm R, mul_div_cancel_right₀ _ hR.ne'] at hup
  have U' := (div_le_div_iff_of_pos_right hkpos).mpr hup
  have L' := (div_le_div_iff_of_pos_right hkpos).mpr lower
  change |hypVol big / (2 : ℝ) ^ (k + r) - hypVol small / (2 : ℝ) ^ k| ≤ _
  rw [hd, mul_comm ((2 : ℝ) ^ k), ← div_div, ← hE, abs_le]
  rw [add_div] at U' L'
  constructor <;> linarith

end QEDE019Proof

namespace QEDE019Proof

open OpenProblems.QEDE019

open Filter Topology

private theorem normalized_vol_converges :
    ∃ L : ℝ, Tendsto (fun n : ℕ => hypVol (W n) / 2 ^ n) atTop (𝓝 L) := by
  let f (n : ℕ) := hypVol (W n) / (2 : ℝ) ^ n
  obtain ⟨B, hB⟩ := tetrahedron_volume_bound
  let M := max B 0
  have hM : 0 ≤ M := le_max_right _ _
  have hb (ω : List Bool) (w : Fin ω.length → ℝ) (hw : IsAngleStructure ω w) (i : Fin ω.length) :
      |energy ω w i| ≤ M := by
    rw [energy_eq]
    exact (hB ω w hw i).trans (le_max_left _ _)
  apply cauchySeq_tendsto_of_complete (u := f)
  rw [Metric.cauchySeq_iff]
  intro η hη
  obtain ⟨δ, hδ, hδ', hmod⟩ := local_vol_blend_uniform (η / 8) (by positivity)
  obtain ⟨N, hN⟩ := exists_nat_gt (32 / δ)
  have hN' : 1 ≤ δ / 32 * (N : ℝ) := by
    have hh := (div_lt_iff₀ hδ).mp hN
    rw [div_mul_eq_mul_div, le_div_iff₀ (by norm_num : (0 : ℝ) < 32)]
    nlinarith
  let A : ℝ := (2 * N + 6 : ℝ) * (2 * M)
  obtain ⟨p, hp⟩ := exists_nat_gt (A / (η / 8))
  let k := p + 1
  have hk : 1 ≤ k := by unfold k; omega
  have hp' : (p : ℝ) < (2 : ℝ) ^ k := by
    exact_mod_cast (show p < 2 ^ k by
      have hh : k < 2 ^ k := k.lt_two_pow_self
      unfold k at *
      omega)
  have herr : A / (2 : ℝ) ^ k < η / 8 := by
    have hη8 : (0 : ℝ) < η / 8 := div_pos hη (by norm_num)
    have hpA : A < (p : ℝ) * (η / 8) := (div_lt_iff₀ hη8).mp hp
    exact (div_lt_iff₀ (show (0 : ℝ) < 2 ^ k by positivity)).mpr
      (hpA.trans (by simpa [mul_comm] using mul_lt_mul_of_pos_right hp' hη8))
  have close (m : ℕ) (hm : k ≤ m) : dist (f m) (f k) < η / 4 := by
    obtain ⟨r, rfl⟩ := Nat.exists_eq_add_of_le hm
    have h := compare_block_scales (η / 8) δ M N k r (by positivity) hδ hδ' hM hN' hk hmod hb
    change |f (k + r) - f k| ≤ η / 8 + A / 2 ^ k at h
    rw [Real.dist_eq]
    linarith
  refine ⟨k, fun m hm n hn => ?_⟩
  have hm' := close m hm
  have hn' := close n hn
  have htri := dist_triangle (f m) (f k) (f n)
  rw [dist_comm (f k) (f n)] at htri
  linarith

end QEDE019Proof

theorem solution : OpenProblems.QEDE019.Claim :=
  ⟨QEDE019Proof.W_has_angle_structure, QEDE019Proof.normalized_vol_converges⟩
