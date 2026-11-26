namespace QEDSud

open OpenProblems.QEDE223 QEDTM

lemma coreN_gv_lt {n : ℕ} (hn : 40 ≤ n) {b q : ℕ} (hb : b < n) (hq : q < n)
    (h : (coreN n).blank b q = false) : (coreN n).gv b q < n := by
  have hok := coreN_ok hn
  rw [← hok.rf_gv b hb q hq h]; exact hok.rf_lt b hb q hq

theorem givens_eq {n : ℕ} (hn : 40 ≤ n) :
    givens n (Fgen givE (List.replicate n true)) = givensOf (coreN n) n := by
  ext ⟨⟨R, C⟩, v⟩
  have hnp : 0 < n := by omega
  have hR := div_lt' R; have hR' := mod_lt' R
  have hC := div_lt' C; have hC' := mod_lt' C
  have hv := div_lt' v; have hv' := mod_lt' v
  have eR : R.val = R.val / n * n + R.val % n := val_eq R.val
  have eC : C.val = C.val / n * n + C.val % n := val_eq C.val
  have ev : v.val = v.val / n * n + v.val % n := val_eq v.val
  have hidx : (R.val * n ^ 2 + C.val) * n ^ 2 + v.val =
      ((((((R.val / n) * n + R.val % n) * n + C.val / n) * n + C.val % n) * n + v.val / n) * n + v.val % n) := by
    conv_lhs => rw [eR, eC, ev]
    ring
  show (Fgen givE (List.replicate n true)).getD _ false = true ↔ givenP (coreN n) n R.val C.val v.val
  rw [hidx, Fgen_getD givE n _ _ _ _ _ _ hR hR' hC hC' hv hv', decide_eq_true_iff, givE_iff]
  simp only [envD]
  simp only [show ((0 : Fin 7).val = 0) from rfl, show ((1 : Fin 7).val = 1) from rfl,
    show ((2 : Fin 7).val = 2) from rfl, show ((3 : Fin 7).val = 3) from rfl, show ((4 : Fin 7).val = 4) from rfl,
    show ((5 : Fin 7).val = 5) from rfl, show ((6 : Fin 7).val = 6) from rfl]
  simp only [if_true, show (1 : ℕ) ≠ 0 from by decide, show (2 : ℕ) ≠ 0 from by decide,
    show (3 : ℕ) ≠ 0 from by decide, show (4 : ℕ) ≠ 0 from by decide, show (5 : ℕ) ≠ 0 from by decide,
    show (6 : ℕ) ≠ 0 from by decide, show (2 : ℕ) ≠ 1 from by decide, show (3 : ℕ) ≠ 1 from by decide,
    show (4 : ℕ) ≠ 1 from by decide, show (5 : ℕ) ≠ 1 from by decide, show (6 : ℕ) ≠ 1 from by decide,
    show (3 : ℕ) ≠ 2 from by decide, show (4 : ℕ) ≠ 2 from by decide, show (5 : ℕ) ≠ 2 from by decide,
    show (6 : ℕ) ≠ 2 from by decide, show (4 : ℕ) ≠ 3 from by decide, show (5 : ℕ) ≠ 3 from by decide,
    show (6 : ℕ) ≠ 3 from by decide, show (5 : ℕ) ≠ 4 from by decide, show (6 : ℕ) ≠ 4 from by decide,
    show (6 : ℕ) ≠ 5 from by decide, if_false]
  unfold givenP
  by_cases hc : R.val % n = 0 ∧ C.val / n = 0
  · rw [if_pos (show R.val % n + C.val / n = 0 by rw [hc.1, hc.2]), if_pos hc]
    constructor
    · rintro ⟨hb, ha, hcq⟩
      refine ⟨hb, ?_⟩
      rw [ev, ha, hcq]; simp
    · rintro ⟨hb, he⟩
      have hlt := coreN_gv_lt hn hR hC' hb
      refine ⟨hb, ?_, ?_⟩
      · rw [he]; exact Nat.div_eq_of_lt hlt
      · rw [he]; exact Nat.mod_eq_of_lt hlt
  · rw [if_neg (show ¬ (R.val % n + C.val / n = 0) from fun h' => hc (Nat.add_eq_zero_iff.1 h')), if_neg hc]
    constructor
    · rintro ⟨ha, hcq⟩
      unfold baseV
      rw [ev, ha, hcq]
    · intro he
      constructor
      · rw [he, baseV_div hnp]
      · rw [he, baseV_mod hnp]

lemma pow_bound (m t : ℕ) (ht : 13 * m ≤ t) : 2 ^ m * 17 ^ t ≤ 18 ^ t := by
  obtain ⟨u, rfl⟩ : ∃ u, t = 13 * m + u := ⟨t - 13 * m, by omega⟩
  have h13 : 2 * 17 ^ 13 ≤ 18 ^ 13 := by norm_num
  calc 2 ^ m * 17 ^ (13 * m + u) = (2 * 17 ^ 13) ^ m * 17 ^ u := by rw [pow_add, pow_mul, mul_pow]; ring
    _ ≤ (18 ^ 13) ^ m * 18 ^ u := Nat.mul_le_mul (Nat.pow_le_pow_left h13 m) (Nat.pow_le_pow_left (by norm_num) u)
    _ = 18 ^ (13 * m + u) := by rw [pow_add, pow_mul]

lemma sqrt_bound {n : ℕ} (hn : 20000 ≤ n) : 13 * (Nat.sqrt n + 1) ≤ (2 * (n / 8) - 1) / 2 := by
  have h1 : 141 ≤ Nat.sqrt n := Nat.le_sqrt.2 (by omega)
  have h2 : Nat.sqrt n * Nat.sqrt n ≤ n := Nat.sqrt_le n
  generalize Nat.sqrt n = r at *
  have h3 : 8 * (13 * r + 15) + 16 ≤ r * r := by nlinarith
  omega

end QEDSud

open OpenProblems.QEDE223 QEDSud QEDTM in
theorem solution : OpenProblems.QEDE223.Claim := by
  refine ⟨Fgen givE, gen_polytime givE, 1 / 2, by norm_num, 20000, fun n hN _ => ?_⟩
  have hn : 40 ≤ n := by omega
  have hok := coreN_ok hn
  have hH : 0 < 2 * (n / 8) - 1 := by omega
  rw [givens_eq hn]
  have hyp := core_hyp hok hH
  refine ⟨hyp.pa, core_unsat hok (by omega), fun L hL => ?_⟩
  have hlow := sud_lower hyp (by omega) L hL
  set t := (2 * (n / 8) - 1) / 2
  set m := Nat.sqrt n + 1
  have hmt := pow_bound m t (sqrt_bound hN)
  have h2m : 2 ^ m ≤ L.length := by
    have hpos : 0 < 17 ^ t := by positivity
    have : 2 ^ m * 17 ^ t ≤ L.length * 17 ^ t := hmt.trans hlow
    exact Nat.le_of_mul_le_mul_right this hpos
  have hsq : Real.sqrt n ≤ m := by
    rw [Real.sqrt_le_left]
    · have := Nat.lt_succ_sqrt n
      have : (n : ℝ) < ((Nat.sqrt n + 1 : ℕ) : ℝ) * ((Nat.sqrt n + 1 : ℕ) : ℝ) := by exact_mod_cast this
      simp only [m]; nlinarith
    · positivity
  calc (2 : ℝ) ^ ((n : ℝ) ^ ((1 : ℝ) / 2)) = (2 : ℝ) ^ Real.sqrt n := by rw [Real.sqrt_eq_rpow]
    _ ≤ (2 : ℝ) ^ (m : ℝ) := Real.rpow_le_rpow_of_exponent_le (by norm_num) hsq
    _ = ((2 ^ m : ℕ) : ℝ) := by rw [Real.rpow_natCast]; push_cast; rfl
    _ ≤ (L.length : ℝ) := by exact_mod_cast h2m
