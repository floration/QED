namespace OpenProblems.QEDE019

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

/-- One step of substitution doubles the word and flips its final letter. -/
theorem W_succ_and_double (n : ℕ) :
    ∃ (p : List Bool) (b : Bool), W (n + 1) = p ++ [!b] ∧ W n ++ W n = p ++ [b] := by
  obtain ⟨q, b, hW, hV⟩ := W_and_companion n
  refine ⟨W n ++ q, b, ?_, ?_⟩
  · rw [W_succ_eq_append, hV, List.append_assoc]
  · rw [List.append_assoc, ← hW]

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

open Filter Topology in
/-- A geometric bound on consecutive normalized volumes implies convergence. -/
theorem convergence_of_geometric_bound (C r : ℝ) (hr₀ : 0 ≤ r) (hr₁ : r < 1)
    (h : ∀ n : ℕ, 1 ≤ n →
      dist (hypVol (W n) / 2 ^ n) (hypVol (W (n + 1)) / 2 ^ (n + 1)) ≤ C * r ^ n) :
    ∃ L : ℝ, Tendsto (fun n : ℕ => hypVol (W n) / 2 ^ n) atTop (𝓝 L) := by
  let f : ℕ → ℝ := fun n => hypVol (W n) / 2 ^ n
  have hs : Summable (fun n : ℕ => (C * r) * r ^ n) :=
    (summable_geometric_of_lt_one hr₀ hr₁).mul_left _
  have hc : CauchySeq (fun n : ℕ => f (n + 1)) := by
    apply cauchySeq_of_dist_le_of_summable _ _ hs
    intro n
    have hn := h (n + 1) (by omega)
    change dist (f (n + 1)) (f (n + 1 + 1)) ≤ (C * r) * r ^ n
    have heq : C * r ^ (n + 1) = (C * r) * r ^ n := by
      rw [pow_succ, ← mul_assoc, mul_right_comm]
    exact heq ▸ hn
  obtain ⟨L, hL⟩ := cauchySeq_tendsto_of_complete hc
  exact ⟨L, (tendsto_add_atTop_iff_nat 1).mp hL⟩

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

end OpenProblems.QEDE019
