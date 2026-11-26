namespace QEDE007Proof

open OpenProblems.QEDE007
open scoped BigOperators
open Relation

private noncomputable def quarter : ℝ := Real.pi / 4

private theorem quarter_pos : 0 < quarter := by
  unfold quarter
  positivity

private noncomputable abbrev Phase := Set.Icc (0 : ℝ) quarter

private noncomputable def force {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    (u : α → Phase) (p : α) (t : ℝ) : ℝ :=
  (∑ q ∈ nbr p, Real.sin ((u q : ℝ) - t)) -
    if axis p then Real.sin (2 * t) else 0

private theorem sin_phase_diff_mono (a b c d : Phase)
    (h : (a : ℝ) - (b : ℝ) ≤ (c : ℝ) - (d : ℝ)) :
    Real.sin ((a : ℝ) - b) ≤ Real.sin ((c : ℝ) - d) := by
  apply Real.strictMonoOn_sin.monotoneOn _ _ h
  all_goals
    have ha := a.property
    have hb := b.property
    have hc := c.property
    have hd := d.property
    simp only [Set.mem_Icc, quarter] at *
    constructor <;> linarith [Real.pi_pos]

private theorem force_mono {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    {u v : α → Phase} (h : u ≤ v) (p : α) (t : Phase) :
    force nbr axis u p t ≤ force nbr axis v p t := by
  unfold force
  apply sub_le_sub_right
  apply Finset.sum_le_sum
  intro q hq
  have hh : (u q : ℝ) ≤ (v q : ℝ) := h q
  exact sin_phase_diff_mono _ _ _ _ (sub_le_sub_right hh _)

private theorem force_strictAnti {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    (u : α → Phase) (p : α) (hp : (nbr p).Nonempty) :
    StrictAnti (fun t : Phase => force nbr axis u p t) := by
  intro t s hts
  have ht := t.property
  have hs := s.property
  change (t : ℝ) < (s : ℝ) at hts
  have hedges : (∑ q ∈ nbr p, Real.sin ((u q : ℝ) - s)) <
      ∑ q ∈ nbr p, Real.sin ((u q : ℝ) - t) := by
    apply Finset.sum_lt_sum_of_nonempty hp
    intro q hq
    have hq' := (u q).property
    apply Real.strictMonoOn_sin
    · simp only [Set.mem_Icc, quarter] at *
      constructor <;> linarith [Real.pi_pos]
    · simp only [Set.mem_Icc, quarter] at *
      constructor <;> linarith [Real.pi_pos]
    · linarith
  have ha : (if axis p then Real.sin (2 * (t : ℝ)) else 0) ≤
      (if axis p then Real.sin (2 * (s : ℝ)) else 0) := by
    split_ifs
    · apply Real.strictMonoOn_sin.monotoneOn
      · simp only [Set.mem_Icc, quarter] at *
        constructor <;> linarith [Real.pi_pos]
      · simp only [Set.mem_Icc, quarter] at *
        constructor <;> linarith [Real.pi_pos]
      · linarith
    · exact le_rfl
  unfold force
  linarith

private theorem force_has_zero {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    (u : α → Phase) (p : α) : ∃ t : Phase, force nbr axis u p t = 0 := by
  have hc : Continuous (force nbr axis u p) := by
    unfold force
    cases h : axis p <;> simp only [h, Bool.false_eq_true, ite_false, ite_true] <;> fun_prop
  have hzero : (0 : ℝ) ≤ force nbr axis u p 0 := by
    have hs : 0 ≤ ∑ q ∈ nbr p, Real.sin ((u q : ℝ) - 0) := by
      apply Finset.sum_nonneg
      intro q _
      obtain ⟨h₁, h₂⟩ := (u q).property
      exact Real.sin_nonneg_of_nonneg_of_le_pi (by linarith)
        (by unfold quarter at h₂; linarith [Real.pi_pos])
    simpa [force] using hs
  have hquarter : force nbr axis u p quarter ≤ 0 := by
    have hs : (∑ q ∈ nbr p, Real.sin ((u q : ℝ) - quarter)) ≤ 0 := by
      apply Finset.sum_nonpos
      intro q _
      obtain ⟨h₁, h₂⟩ := (u q).property
      rw [← neg_nonneg, ← Real.sin_neg]
      exact Real.sin_nonneg_of_nonneg_of_le_pi (by linarith)
        (by unfold quarter; linarith [Real.pi_pos])
    unfold force
    split_ifs
    · have hsin : Real.sin (2 * quarter) = 1 := by
        rw [show 2 * quarter = Real.pi / 2 by unfold quarter; ring, Real.sin_pi_div_two]
      linarith
    · linarith
  obtain ⟨t, ht, he⟩ := intermediate_value_Icc' quarter_pos.le hc.continuousOn
    (show (0 : ℝ) ∈ Set.Icc (force nbr axis u p quarter) (force nbr axis u p 0) from ⟨hquarter, hzero⟩)
  exact ⟨⟨t, ht⟩, he⟩

/-- The sector force equations have a solution in the closed phase box. -/
theorem sector_equilibrium {α : Type*} (nbr : α → Finset α) (axis diagonal : α → Bool)
    (hn : ∀ p, diagonal p = false → (nbr p).Nonempty) :
    ∃ u : α → Phase, (∀ p, diagonal p = true → (u p : ℝ) = quarter) ∧
      (∀ p, diagonal p = false → force nbr axis u p (u p) = 0) := by
  classical
  letI : Fact ((0 : ℝ) ≤ quarter) := ⟨quarter_pos.le⟩
  let root (u : α → Phase) (p : α) : Phase := Classical.choose (force_has_zero nbr axis u p)
  have hroot (u : α → Phase) (p : α) : force nbr axis u p (root u p) = 0 :=
    Classical.choose_spec (force_has_zero nbr axis u p)
  let update : (α → Phase) →o (α → Phase) :=
    { toFun := fun u p => if diagonal p then ⟨quarter, quarter_pos.le, le_rfl⟩ else root u p
      monotone' := by
        intro u v huv p
        by_cases hd : diagonal p = true
        · simp [hd]
        · have hd' : diagonal p = false := Bool.eq_false_iff.mpr hd
          simp only [hd', Bool.false_eq_true, ite_false]
          apply le_of_not_gt
          intro h
          have hlt := force_strictAnti nbr axis v p (hn p hd') h
          have hle := force_mono nbr axis huv p (root u p)
          change force nbr axis v p (root u p) < force nbr axis v p (root v p) at hlt
          rw [hroot v p] at hlt
          rw [hroot u p] at hle
          linarith }
  have hfix (p : α) : update update.lfp p = update.lfp p :=
    congrFun update.map_lfp p
  refine ⟨update.lfp, ?_, ?_⟩
  · intro p hp
    have h := hfix p
    change (if diagonal p then (⟨quarter, quarter_pos.le, le_rfl⟩ : Phase)
      else root update.lfp p) = _ at h
    simpa [hp] using congrArg Subtype.val h.symm
  · intro p hp
    have h := hfix p
    change (if diagonal p then (⟨quarter, quarter_pos.le, le_rfl⟩ : Phase)
      else root update.lfp p) = _ at h
    simp only [hp, Bool.false_eq_true, ite_false] at h
    rw [← h]
    exact hroot _ _

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007
open Relation

private theorem zero_propagates {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    (u : α → Phase) {p q : α} (he : force nbr axis u p (u p) = 0)
    (hp : (u p : ℝ) = 0) (hq : q ∈ nbr p) : (u q : ℝ) = 0 := by
  rw [hp] at he
  have hs : ∑ r ∈ nbr p, Real.sin (u r : ℝ) = 0 := by
    simpa [force, ite_self] using he
  have hnon (r : α) (_ : r ∈ nbr p) : 0 ≤ Real.sin (u r : ℝ) := by
    obtain ⟨ha, hb⟩ := (u r).property
    exact Real.sin_nonneg_of_nonneg_of_le_pi ha (by unfold quarter at hb; linarith [Real.pi_pos])
  have hq' := Finset.single_le_sum hnon hq
  rw [hs] at hq'
  apply le_antisymm _ (u q).property.1
  by_contra! h
  exact (not_lt_of_ge hq') (Real.sin_pos_of_pos_of_lt_pi h
    (by have hh := (u q).property.2; unfold quarter at hh; linarith [Real.pi_pos]))

private theorem quarter_propagates {α : Type*} (nbr : α → Finset α) (axis : α → Bool)
    (u : α → Phase) {p : α} (he : force nbr axis u p (u p) = 0)
    (hp : (u p : ℝ) = quarter) :
    axis p = false ∧ ∀ q ∈ nbr p, (u q : ℝ) = quarter := by
  rw [hp] at he
  have hneg (q : α) (_ : q ∈ nbr p) : 0 ≤ Real.sin (quarter - (u q : ℝ)) := by
    obtain ⟨ha, hb⟩ := (u q).property
    exact Real.sin_nonneg_of_nonneg_of_le_pi (by linarith)
      (by unfold quarter; linarith [Real.pi_pos])
  have hs0 : 0 ≤ ∑ q ∈ nbr p, Real.sin (quarter - (u q : ℝ)) := Finset.sum_nonneg hneg
  have hs1 : Real.sin (2 * quarter) = 1 := by
    rw [show 2 * quarter = Real.pi / 2 by unfold quarter; ring, Real.sin_pi_div_two]
  have ht : (∑ q ∈ nbr p, Real.sin ((u q : ℝ) - quarter)) =
      -(∑ q ∈ nbr p, Real.sin (quarter - (u q : ℝ))) := by
    rw [← Finset.sum_neg_distrib]
    apply Finset.sum_congr rfl
    intro q _
    rw [← Real.sin_neg, neg_sub]
  unfold force at he
  rw [ht, hs1] at he
  have ha : axis p = false := by
    cases h : axis p
    · rfl
    · simp [h] at he
      linarith
  simp [ha] at he
  refine ⟨ha, fun q hq => ?_⟩
  have hq' := Finset.single_le_sum hneg hq
  apply le_antisymm (u q).property.2
  by_contra! h
  have hp' : 0 < quarter - (u q : ℝ) := by linarith
  have hh : quarter - (u q : ℝ) < Real.pi := by
    have h₀ := (u q).property.1
    unfold quarter
    linarith [Real.pi_pos]
  have hsin := Real.sin_pos_of_pos_of_lt_pi hp' hh
  linarith

/-- Paths to the diagonal and to the reflecting axis force strict inequalities. -/
theorem sector_interior {α : Type*} (nbr : α → Finset α) (axis diagonal : α → Bool)
    (u : α → Phase)
    (hdiag : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (he : ∀ p, diagonal p = false → force nbr axis u p (u p) = 0)
    (htoDiag : ∀ p, diagonal p = false →
      ∃ d, diagonal d = true ∧ ReflTransGen (fun p q => diagonal p = false ∧ q ∈ nbr p) p d)
    (htoAxis : ∀ p, diagonal p = false →
      ∃ a, diagonal a = false ∧ axis a = true ∧
        ReflTransGen (fun p q => diagonal p = false ∧ q ∈ nbr p) p a)
    (p : α) (hp : diagonal p = false) :
    0 < (u p : ℝ) ∧ (u p : ℝ) < quarter := by
  constructor
  · apply lt_of_le_of_ne (u p).property.1
    intro hz
    obtain ⟨d, hd, hpath⟩ := htoDiag p hp
    have prop {x y : α} (hh : ReflTransGen (fun p q => diagonal p = false ∧ q ∈ nbr p) x y)
        (h : (u x : ℝ) = 0) : (u y : ℝ) = 0 := by
      induction hh with
      | refl => exact h
      | tail _ hstep ih => exact zero_propagates nbr axis u (he _ hstep.1) ih hstep.2
    have heq := prop hpath hz.symm
    rw [hdiag _ hd] at heq
    exact quarter_pos.ne' heq
  · apply lt_of_le_of_ne (u p).property.2
    intro hq
    obtain ⟨a, ha, haxis, hpath⟩ := htoAxis p hp
    have prop {x y : α} (hh : ReflTransGen (fun p q => diagonal p = false ∧ q ∈ nbr p) x y)
        (h : (u x : ℝ) = quarter) : (u y : ℝ) = quarter := by
      induction hh with
      | refl => exact h
      | tail _ hstep ih => exact (quarter_propagates nbr axis u (he _ hstep.1) ih).2 _ hstep.2
    have hf := (quarter_propagates nbr axis u (he _ ha) (prop hpath hq)).1
    simp [haxis] at hf

/-- Positive edge weights on a connected spanning subgraph imply QED's stability condition. -/
theorem stable_of_positive_paths {n : ℕ} (θ : Pt n → ℝ)
    (hnon : ∀ i j, Adj i j → 0 ≤ Real.cos (θ j - θ i))
    (hpath : ∀ i j, OnSurface i → OnSurface j →
      ReflTransGen (fun a b => Adj a b ∧ 0 < Real.cos (θ b - θ a)) i j) :
    IsLinearlyStable θ := by
  classical
  intro x hx
  obtain ⟨i, j, hi, hj, hne⟩ := hx
  have hp := hpath i j hi hj
  have find {a b : Pt n}
      (h : ReflTransGen (fun a b => Adj a b ∧ 0 < Real.cos (θ b - θ a)) a b)
      (hne : x a ≠ x b) :
      ∃ u v, Adj u v ∧ 0 < Real.cos (θ v - θ u) ∧ x u ≠ x v := by
    induction h with
    | refl => exact (hne rfl).elim
    | @tail b c _ hstep ih =>
      by_cases hbc : x b = x c
      · exact ih (fun he => hne (he.trans hbc))
      · exact ⟨b, c, hstep.1, hstep.2, hbc⟩
  obtain ⟨u, v, huv, hp', hneq⟩ := find hp hne
  let e (a b : Pt n) := if Adj a b then Real.cos (θ b - θ a) * (x b - x a)^2 else 0
  have he (a b : Pt n) : 0 ≤ e a b := by
    unfold e
    split_ifs with h
    · exact mul_nonneg (hnon _ _ h) (sq_nonneg _)
    · exact le_rfl
  have hev : 0 < e u v := by
    unfold e
    rw [ite_eq_left huv]
    exact mul_pos hp' (sq_pos_of_ne_zero (sub_ne_zero.mpr hneq.symm))
  have hrow : e u v ≤ ∑ b : Pt n, e u b :=
    Finset.single_le_sum (fun b _ => he u b) (Finset.mem_univ v)
  have htotal : (∑ b : Pt n, e u b) ≤ ∑ a : Pt n, ∑ b : Pt n, e a b :=
    Finset.single_le_sum (fun a _ => Finset.sum_nonneg (fun b _ => he a b)) (Finset.mem_univ u)
  exact hev.trans_le (hrow.trans htotal)

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private theorem rot_four {n : ℕ} (p : Pt n) :
    rot (rot (rot (rot p))) = p := by
  rcases p with ⟨x, y, z⟩
  simp [rot]

private theorem plaquette_next (n : ℕ) (h : Fin (n + 1)) (k : Fin 4) :
    plaquette n h (k + 1) = rot (plaquette n h k) := by
  fin_cases k <;> simp [plaquette, Function.iterate_succ_apply', rot_four]

private theorem plaquette_height (n : ℕ) (h : Fin (n + 1)) (k : Fin 4) :
    (plaquette n h k).2.2 = h := by
  fin_cases k <;> rfl

private theorem wrap_quarter_turn {a : ℝ} {σ k : ℤ} (hσ : σ = 1 ∨ σ = -1)
    (h : a = σ * (Real.pi / 2) + 2 * Real.pi * k) :
    wrap a = σ * (Real.pi / 2) := by
  unfold wrap
  apply (toIocMod_eq_iff Real.two_pi_pos).mpr
  refine ⟨?_, ⟨k, ?_⟩⟩
  · rcases hσ with hs | hs <;> rw [hs] <;> norm_num <;>
      constructor <;> linarith [Real.pi_pos]
  · rw [h, zsmul_eq_mul]
    ring

/-- Rotational equivariance already forces the winding around either horizontal core. -/
theorem winding_of_rot_symmetry {n : ℕ} (θ : Pt n → ℝ) (hθ : IsRotSymmetric θ)
    (h : Fin (n + 1)) (hh : h = 0 ∨ h = Fin.last n) :
    windingSum θ (plaquette n h) = 2 * Real.pi ∨
      windingSum θ (plaquette n h) = -(2 * Real.pi) := by
  obtain ⟨σ, hσ, hrot⟩ := hθ
  have hall (k : Fin 4) :
      wrap (θ (plaquette n h (k + 1)) - θ (plaquette n h k)) = σ * (Real.pi / 2) := by
    have hp : OnSurface (plaquette n h k) := by
      unfold OnSurface
      rw [plaquette_height]
      tauto
    obtain ⟨z, hz⟩ := hrot _ hp
    rw [plaquette_next]
    apply wrap_quarter_turn hσ (k := z)
    linarith
  unfold windingSum
  simp only [hall, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rcases hσ with hs | hs
  · left
    rw [hs]
    push_cast
    ring
  · right
    rw [hs]
    push_cast
    ring

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007 Relation

def mid (n : ℕ) : ℕ := (n + 1) / 2

def Sector (n : ℕ) :=
  {p : Pt n // OnSurface p ∧ mid n ≤ p.2.1.val ∧ p.2.1.val ≤ p.1.val}

private noncomputable instance (n : ℕ) : Fintype (Sector n) := by
  classical
  unfold Sector
  infer_instance

private noncomputable def neighbors {n : ℕ} (p : Sector n) : Finset (Sector n) := by
  classical
  exact Finset.univ.filter fun q => Adj p.val q.val

private def diagonal {n : ℕ} (p : Sector n) : Bool := decide (p.val.1.val = p.val.2.1.val)

private def axis {n : ℕ} (p : Sector n) : Bool := decide (p.val.2.1.val = mid n)

private theorem diagonal_false {n : ℕ} (p : Sector n) :
    diagonal p = false ↔ p.val.2.1.val < p.val.1.val := by
  have hp := p.property.2.2
  simp [diagonal]
  omega

private theorem offdiag_surface {n : ℕ} (hn : 3 ≤ n) (p : Sector n)
    (hp : diagonal p = false) :
    p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n := by
  have hd := (diagonal_false p).mp hp
  have hm := p.property.2.1
  have hx := p.val.1.isLt
  have hmpos : 0 < mid n := by unfold mid; omega
  have hs := p.property.1
  simp only [OnSurface] at hs
  rcases hs with h | h | h | h | h | h
  · have hv := congrArg Fin.val h
    simp only [Fin.val_zero, Fin.val_last] at hv
    omega
  · exact Or.inl h
  · have hv := congrArg Fin.val h
    simp only [Fin.val_zero, Fin.val_last] at hv
    omega
  · have hv := congrArg Fin.val h
    simp only [Fin.val_zero, Fin.val_last] at hv
    omega
  · exact Or.inr (Or.inl h)
  · exact Or.inr (Or.inr h)

private def alongY {n : ℕ} (p : Sector n)
    (hs : p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n)
    (j : ℕ) (hj : mid n ≤ j) (hjx : j ≤ p.val.1.val) : Sector n :=
  ⟨(p.val.1, ⟨j, lt_of_le_of_lt hjx p.val.1.isLt⟩, p.val.2.2),
    by unfold OnSurface; tauto, hj, hjx⟩

private theorem alongY_eq {n : ℕ} (p : Sector n)
    (hs : p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n) :
    alongY p hs p.val.2.1.val p.property.2.1 p.property.2.2 = p := by
  apply Subtype.ext
  rcases p with ⟨⟨x, y, z⟩, _⟩
  rfl

private theorem alongY_edge {n : ℕ} (p : Sector n)
    (hs : p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n)
    {i j : ℕ} (hi : mid n ≤ i) (hj : mid n ≤ j)
    (hix : i ≤ p.val.1.val) (hjx : j ≤ p.val.1.val)
    (hedge : i + 1 = j ∨ j + 1 = i) :
    alongY p hs j hj hjx ∈ neighbors (alongY p hs i hi hix) := by
  classical
  simp only [neighbors, Finset.mem_filter, Finset.mem_univ, true_and]
  refine ⟨(alongY p hs i hi hix).property.1, (alongY p hs j hj hjx).property.1, ?_⟩
  change |(p.val.1.val : ℤ) - p.val.1.val| + |(i : ℤ) - j| +
    |(p.val.2.2.val : ℤ) - p.val.2.2.val| = 1
  simp only [sub_self, abs_zero, zero_add, add_zero]
  rcases hedge with h | h
  · rw [show (i : ℤ) - j = -1 by omega]
    decide
  · rw [show (i : ℤ) - j = 1 by omega]
    decide

private abbrev sectorStep {n : ℕ} (p q : Sector n) : Prop :=
  diagonal p = false ∧ q ∈ neighbors p

private theorem alongY_up {n : ℕ} (p : Sector n)
    (hs : p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n)
    (i j : ℕ) (hi : mid n ≤ i) (hij : i ≤ j) (hj : j ≤ p.val.1.val) :
    ReflTransGen sectorStep
      (alongY p hs i hi (hij.trans hj)) (alongY p hs j (hi.trans hij) hj) := by
  induction j, hij using Nat.le_induction with
  | base => exact .refl
  | succ j hij ih =>
    have hj' : j ≤ p.val.1.val := by omega
    exact (ih hj').tail
      ⟨(diagonal_false _).mpr (by change j < p.val.1.val; omega),
        alongY_edge p hs (hi.trans hij) (by omega) hj' hj (Or.inl rfl)⟩

private theorem alongY_down {n : ℕ} (p : Sector n)
    (hs : p.val.1 = Fin.last n ∨ p.val.2.2 = 0 ∨ p.val.2.2 = Fin.last n)
    (i j : ℕ) (hi : mid n ≤ i) (hij : i ≤ j) (hj : j < p.val.1.val) :
    ReflTransGen sectorStep
      (alongY p hs j (hi.trans hij) hj.le) (alongY p hs i hi (hij.trans hj.le)) := by
  induction j, hij using Nat.le_induction with
  | base => exact .refl
  | succ j hij ih =>
    have hj' : j < p.val.1.val := by omega
    exact (ih hj').head
      ⟨(diagonal_false _).mpr (by exact hj),
        alongY_edge p hs (by omega) (hi.trans hij) hj.le hj'.le (Or.inr rfl)⟩

/-- The phase equation has a strict solution on the actual cube sector. -/
theorem cube_sector_equilibrium (n : ℕ) (hn : 3 ≤ n) :
    ∃ u : Sector n → Phase,
      (∀ p, diagonal p = true → (u p : ℝ) = quarter) ∧
      (∀ p, diagonal p = false →
        force neighbors axis u p (u p) = 0 ∧ 0 < (u p : ℝ) ∧ (u p : ℝ) < quarter) := by
  have hne (p : Sector n) (hp : diagonal p = false) : (neighbors p).Nonempty := by
    have hs := offdiag_surface hn p hp
    have hd := (diagonal_false p).mp hp
    have hj : p.val.2.1.val + 1 ≤ p.val.1.val := by omega
    refine ⟨alongY p hs (p.val.2.1.val + 1) (by have := p.property.2.1; omega) hj, ?_⟩
    simpa only [alongY_eq] using
      (alongY_edge p hs p.property.2.1 (by have := p.property.2.1; omega) hd.le hj (Or.inl rfl))
  obtain ⟨u, hd, he⟩ := sector_equilibrium neighbors axis diagonal hne
  refine ⟨u, hd, fun p hp => ⟨he p hp, ?_⟩⟩
  apply sector_interior neighbors axis diagonal u hd he _ _ p hp
  · intro a ha
    have hs := offdiag_surface hn a ha
    let d := alongY a hs a.val.1.val (a.property.2.1.trans a.property.2.2) le_rfl
    refine ⟨d, by simp [d, diagonal, alongY], ?_⟩
    have hh := alongY_up a hs a.val.2.1.val a.val.1.val a.property.2.1 a.property.2.2 le_rfl
    rwa [alongY_eq] at hh
  · intro a ha
    have hs := offdiag_surface hn a ha
    have hlt := (diagonal_false a).mp ha
    let b := alongY a hs (mid n) le_rfl (a.property.2.1.trans hlt.le)
    refine ⟨b, (diagonal_false _).mpr (lt_of_le_of_lt a.property.2.1 hlt),
      by simp [b, axis, alongY], ?_⟩
    have hh := alongY_down a hs (mid n) a.val.2.1.val le_rfl a.property.2.1 hlt
    rwa [alongY_eq] at hh

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private def swapXY {n : ℕ} (p : Pt n) : Pt n := (p.2.1, p.1, p.2.2)

private theorem swap_surface {n : ℕ} (p : Pt n) : OnSurface (swapXY p) ↔ OnSurface p := by
  unfold swapXY OnSurface
  tauto

private noncomputable def halfPhase {n : ℕ} (u : Sector n → Phase) (p : Pt n) : ℝ := by
  classical
  exact if h : OnSurface p ∧ mid n ≤ p.2.1.val ∧ p.2.1.val ≤ p.1.val then
    (u ⟨p, h⟩ : ℝ)
  else 0

private theorem halfPhase_sector {n : ℕ} (u : Sector n → Phase) (p : Sector n) :
    halfPhase u p.val = (u p : ℝ) := by
  unfold halfPhase
  rw [dif_pos p.property]
  rfl

private noncomputable def firstQuadrant {n : ℕ} (u : Sector n → Phase) (p : Pt n) : ℝ :=
  if p.2.1.val ≤ p.1.val then halfPhase u p
  else Real.pi / 2 - halfPhase u (swapXY p)

private theorem firstQuadrant_sector {n : ℕ} (u : Sector n → Phase) (p : Sector n) :
    firstQuadrant u p.val = (u p : ℝ) := by
  unfold firstQuadrant
  rw [ite_eq_left p.property.2.2, halfPhase_sector]

private theorem firstQuadrant_reflect {n : ℕ} (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (p : Pt n) (hs : OnSurface p) (hx : mid n ≤ p.1.val) (hy : mid n ≤ p.2.1.val) :
    firstQuadrant u (swapXY p) = Real.pi / 2 - firstQuadrant u p := by
  unfold firstQuadrant
  by_cases he : p.1.val = p.2.1.val
  · have hp : swapXY p = p := by
      rcases p with ⟨x, y, z⟩
      change x.val = y.val at he
      have hxy : x = y := Fin.ext he
      subst y
      rfl
    rw [hp]
    have hle : p.2.1.val ≤ p.1.val := he.ge
    simp only [ite_eq_left hle]
    let q : Sector n := ⟨p, hs, hy, hle⟩
    have hq := halfPhase_sector u q
    change halfPhase u p = (u q : ℝ) at hq
    have hdiag : diagonal q = true := by simp [diagonal, q, he]
    rw [hq, hd _ hdiag]
    unfold quarter
    ring
  · by_cases hxy : p.2.1.val ≤ p.1.val
    · have hyx : ¬(swapXY p).2.1.val ≤ (swapXY p).1.val := by
        change ¬p.1.val ≤ p.2.1.val
        omega
      rw [ite_eq_left hxy, ite_eq_right hyx]
      rfl
    · have hyx : (swapXY p).2.1.val ≤ (swapXY p).1.val := by
        change p.1.val ≤ p.2.1.val
        omega
      rw [ite_eq_right hxy, ite_eq_left hyx]
      ring

private theorem rev_pos_iff {n : ℕ} (hn : Odd n) (x : Fin (n + 1)) :
    mid n ≤ x.rev.val ↔ ¬mid n ≤ x.val := by
  obtain ⟨k, hk⟩ := hn
  have hx := x.isLt
  simp only [mid, Fin.val_rev]
  omega

private noncomputable def extendedPhase {n : ℕ} (u : Sector n → Phase) (p : Pt n) : ℝ :=
  if mid n ≤ p.1.val then
    if mid n ≤ p.2.1.val then firstQuadrant u p
    else firstQuadrant u (rot p) + 3 * (Real.pi / 2)
  else
    if mid n ≤ p.2.1.val then firstQuadrant u (rot (rot (rot p))) + Real.pi / 2
    else firstQuadrant u (rot (rot p)) + 2 * (Real.pi / 2)

private theorem ext_rotation {n : ℕ} (hn : Odd n) (u : Sector n → Phase) (p : Pt n) :
    ∃ k : ℤ, extendedPhase u (rot p) = extendedPhase u p + 1 * (Real.pi / 2) + 2 * Real.pi * k := by
  have hx : (rot p).1 = p.2.1.rev := rfl
  have hy : (rot p).2.1 = p.1 := rfl
  unfold extendedPhase
  simp only [hx, hy, rev_pos_iff hn]
  by_cases h₁ : mid n ≤ p.1.val <;> by_cases h₂ : mid n ≤ p.2.1.val <;>
    simp only [h₁, h₂, not_true, not_false_eq_true, ite_true, ite_false, rot_four]
  · exact ⟨0, by push_cast; ring⟩
  · exact ⟨-1, by push_cast; ring⟩
  · exact ⟨0, by push_cast; ring⟩
  · exact ⟨0, by push_cast; ring⟩

/-- The sector phases extend to a rotationally equivariant phase on the cube. -/
theorem extendedPhase_rot_symmetric {n : ℕ} (hn : Odd n) (u : Sector n → Phase) :
    IsRotSymmetric (extendedPhase u) := by
  refine ⟨1, Or.inl rfl, fun p _ => ?_⟩
  simpa only [Int.cast_one] using ext_rotation hn u p

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private def rotEquiv (n : ℕ) : Pt n ≃ Pt n where
  toFun := rot
  invFun := fun p => rot (rot (rot p))
  left_inv := rot_four
  right_inv := rot_four

private theorem rot_surface {n : ℕ} (p : Pt n) : OnSurface (rot p) ↔ OnSurface p := by
  rcases p with ⟨x, y, z⟩
  simp only [rot, OnSurface]
  have h₀ : y.rev = 0 ↔ y = Fin.last n := by
    constructor
    · intro h
      have h' := congrArg Fin.rev h
      simpa using h'
    · rintro rfl
      exact Fin.rev_last _
  have h₁ : y.rev = Fin.last n ↔ y = 0 := by
    constructor
    · intro h
      have h' := congrArg Fin.rev h
      simpa using h'
    · rintro rfl
      simp
  rw [h₀, h₁]
  tauto

private theorem rev_diff {n : ℕ} (a b : Fin (n + 1)) :
    |(a.rev.val : ℤ) - b.rev.val| = |(a.val : ℤ) - b.val| := by
  have ha : (a.rev.val : ℤ) = (n : ℤ) - a.val := by
    have h := a.isLt
    simp only [Fin.val_rev]
    omega
  have hb : (b.rev.val : ℤ) = (n : ℤ) - b.val := by
    have h := b.isLt
    simp only [Fin.val_rev]
    omega
  rw [ha, hb, show (n : ℤ) - a.val - ((n : ℤ) - b.val) = (b.val : ℤ) - a.val by ring,
    abs_sub_comm]

private theorem rot_adj {n : ℕ} (p q : Pt n) : Adj (rot p) (rot q) ↔ Adj p q := by
  unfold Adj
  rw [rot_surface, rot_surface]
  change (_ ∧ _ ∧ |(p.2.1.rev.val : ℤ) - q.2.1.rev.val| +
    |(p.1.val : ℤ) - q.1.val| + |(p.2.2.val : ℤ) - q.2.2.val| = 1) ↔ _
  rw [rev_diff, add_comm |(p.2.1.val : ℤ) - q.2.1.val|]

private theorem swap_adj {n : ℕ} (p q : Pt n) : Adj (swapXY p) (swapXY q) ↔ Adj p q := by
  unfold Adj
  rw [swap_surface, swap_surface]
  change (_ ∧ _ ∧ |(p.2.1.val : ℤ) - q.2.1.val| +
    |(p.1.val : ℤ) - q.1.val| + |(p.2.2.val : ℤ) - q.2.2.val| = 1) ↔ _
  rw [add_comm |(p.2.1.val : ℤ) - q.2.1.val|]

private theorem sin_rot_diff {n : ℕ} (hn : Odd n) (u : Sector n → Phase) (p q : Pt n) :
    Real.sin (extendedPhase u (rot q) - extendedPhase u (rot p)) =
      Real.sin (extendedPhase u q - extendedPhase u p) := by
  obtain ⟨kp, hp⟩ := ext_rotation hn u p
  obtain ⟨kq, hq⟩ := ext_rotation hn u q
  rw [hp, hq]
  have h : extendedPhase u q + 1 * (Real.pi / 2) + 2 * Real.pi * (kq : ℝ) -
      (extendedPhase u p + 1 * (Real.pi / 2) + 2 * Real.pi * (kp : ℝ)) =
      (extendedPhase u q - extendedPhase u p) + (((kq - kp : ℤ) : ℝ) * (2 * Real.pi)) := by
    push_cast
    ring
  rw [h, Real.sin_add_int_mul_two_pi]

private theorem cos_rot_diff {n : ℕ} (hn : Odd n) (u : Sector n → Phase) (p q : Pt n) :
    Real.cos (extendedPhase u (rot q) - extendedPhase u (rot p)) =
      Real.cos (extendedPhase u q - extendedPhase u p) := by
  obtain ⟨kp, hp⟩ := ext_rotation hn u p
  obtain ⟨kq, hq⟩ := ext_rotation hn u q
  rw [hp, hq]
  have h : extendedPhase u q + 1 * (Real.pi / 2) + 2 * Real.pi * (kq : ℝ) -
      (extendedPhase u p + 1 * (Real.pi / 2) + 2 * Real.pi * (kp : ℝ)) =
      (extendedPhase u q - extendedPhase u p) + (((kq - kp : ℤ) : ℝ) * (2 * Real.pi)) := by
    push_cast
    ring
  rw [h, Real.cos_add_int_mul_two_pi]

private noncomputable def fullForce {n : ℕ} (θ : Pt n → ℝ) (p : Pt n) : ℝ := by
  classical
  exact ∑ q : Pt n, if Adj p q then Real.sin (θ q - θ p) else 0

private theorem fullForce_rot {n : ℕ} (hn : Odd n) (u : Sector n → Phase) (p : Pt n) :
    fullForce (extendedPhase u) (rot p) = fullForce (extendedPhase u) p := by
  classical
  unfold fullForce
  rw [← (rotEquiv n).sum_comp (fun q : Pt n =>
    if Adj (rot p) q then Real.sin (extendedPhase u q - extendedPhase u (rot p)) else 0)]
  apply Finset.sum_congr rfl
  intro q _
  change (if Adj (rot p) (rot q) then Real.sin (extendedPhase u (rot q) - extendedPhase u (rot p)) else 0) = _
  simp only [rot_adj, sin_rot_diff hn]

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private theorem rot_pos_conditions {n : ℕ} (hn : Odd n) (p : Pt n) :
    (mid n ≤ (rot p).1.val ↔ ¬mid n ≤ p.2.1.val) ∧
    (mid n ≤ (rot p).2.1.val ↔ mid n ≤ p.1.val) := by
  exact ⟨rev_pos_iff hn _, Iff.rfl⟩

private theorem rot_surface_iter {n : ℕ} (p : Pt n) (h : OnSurface p) :
    OnSurface (rot p) := (rot_surface p).mpr h

private theorem extended_first {n : ℕ} (u : Sector n → Phase) (p : Pt n)
    (hx : mid n ≤ p.1.val) (hy : mid n ≤ p.2.1.val) :
    extendedPhase u p = firstQuadrant u p := by
  simp [extendedPhase, hx, hy]

private theorem extended_sector {n : ℕ} (u : Sector n → Phase) (p : Sector n) :
    extendedPhase u p.val = (u p : ℝ) := by
  rw [extended_first u _ (p.property.2.1.trans p.property.2.2) p.property.2.1,
    firstQuadrant_sector]

private theorem swap_rot {n : ℕ} (p : Pt n) :
    swapXY (rot p) = rot (rot (rot (swapXY p))) := by
  rcases p with ⟨x, y, z⟩
  simp [swapXY, rot]

private theorem swap_rot_two {n : ℕ} (p : Pt n) :
    swapXY (rot (rot p)) = rot (rot (swapXY p)) := by
  rcases p with ⟨x, y, z⟩
  simp [swapXY, rot]

private theorem swap_rot_three {n : ℕ} (p : Pt n) :
    swapXY (rot (rot (rot p))) = rot (swapXY p) := by
  rcases p with ⟨x, y, z⟩
  simp [swapXY, rot]

private theorem extended_swap_sum {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter) (p : Pt n) (hp : OnSurface p) :
    ∃ k : ℤ, extendedPhase u (swapXY p) + extendedPhase u p =
      Real.pi / 2 + (k : ℝ) * (2 * Real.pi) := by
  have hs₁ := rot_surface_iter p hp
  have hs₂ := rot_surface_iter _ hs₁
  have hs₃ := rot_surface_iter _ hs₂
  have hr₀ := rot_pos_conditions hn p
  have hr₁ := rot_pos_conditions hn (rot p)
  have hr₂ := rot_pos_conditions hn (rot (rot p))
  by_cases hx : mid n ≤ p.1.val <;> by_cases hy : mid n ≤ p.2.1.val
  · refine ⟨0, ?_⟩
    have hf := firstQuadrant_reflect u hd p hp hx hy
    simp only [extendedPhase, show (swapXY p).1.val = p.2.1.val by rfl,
      show (swapXY p).2.1.val = p.1.val by rfl, hx, hy, ite_true, hf, Int.cast_zero, zero_mul]
    ring
  · refine ⟨1, ?_⟩
    have hxp := hr₀.1.mpr hy
    have hyp := hr₀.2.mpr hx
    have hf := firstQuadrant_reflect u hd (rot p) hs₁ hxp hyp
    simp only [extendedPhase, show (swapXY p).1.val = p.2.1.val by rfl,
      show (swapXY p).2.1.val = p.1.val by rfl, hx, hy, ite_true, ite_false,
      ← swap_rot, hf, Int.cast_one]
    ring
  · refine ⟨1, ?_⟩
    have hp₀ : ¬mid n ≤ (rot p).1.val := fun h => (hr₀.1.mp h) hy
    have hxp : mid n ≤ (rot (rot (rot p))).1.val :=
      hr₂.1.mpr (fun h => hp₀ (hr₁.2.mp h))
    have hyp : mid n ≤ (rot (rot (rot p))).2.1.val :=
      hr₂.2.mpr (hr₁.1.mpr (fun h => hx (hr₀.2.mp h)))
    have hf := firstQuadrant_reflect u hd (rot (rot (rot p))) hs₃ hxp hyp
    simp only [extendedPhase, show (swapXY p).1.val = p.2.1.val by rfl,
      show (swapXY p).2.1.val = p.1.val by rfl, hx, hy, ite_true, ite_false,
      ← swap_rot_three, hf, Int.cast_one]
    ring
  · refine ⟨1, ?_⟩
    have hxp : mid n ≤ (rot (rot p)).1.val := hr₁.1.mpr (fun h => hx (hr₀.2.mp h))
    have hyp : mid n ≤ (rot (rot p)).2.1.val := hr₁.2.mpr (hr₀.1.mpr hy)
    have hf := firstQuadrant_reflect u hd (rot (rot p)) hs₂ hxp hyp
    simp only [extendedPhase, show (swapXY p).1.val = p.2.1.val by rfl,
      show (swapXY p).2.1.val = p.1.val by rfl, hx, hy, ite_false,
      ← swap_rot_two, hf, Int.cast_one]
    ring

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private theorem adj_coordinates {n : ℕ} {p q : Pt n} (h : Adj p q) :
    ((p.1.val + 1 = q.1.val ∨ q.1.val + 1 = p.1.val) ∧ p.2.1 = q.2.1 ∧ p.2.2 = q.2.2) ∨
    (p.1 = q.1 ∧ (p.2.1.val + 1 = q.2.1.val ∨ q.2.1.val + 1 = p.2.1.val) ∧ p.2.2 = q.2.2) ∨
    (p.1 = q.1 ∧ p.2.1 = q.2.1 ∧ (p.2.2.val + 1 = q.2.2.val ∨ q.2.2.val + 1 = p.2.2.val)) := by
  obtain ⟨_, _, h⟩ := h
  have hx0 := abs_nonneg ((p.1.val : ℤ) - q.1.val)
  have hy0 := abs_nonneg ((p.2.1.val : ℤ) - q.2.1.val)
  have hz0 := abs_nonneg ((p.2.2.val : ℤ) - q.2.2.val)
  have equal (a b : Fin (n + 1)) (h : |(a.val : ℤ) - b.val| = 0) : a = b := by
    have hh := abs_eq_zero.mp h
    apply Fin.ext
    omega
  have adjacent (a b : Fin (n + 1)) (h : |(a.val : ℤ) - b.val| = 1) :
      a.val + 1 = b.val ∨ b.val + 1 = a.val := by
    have hle := abs_le.mp h.le
    have hn : (a.val : ℤ) - b.val ≠ 0 := by intro hh; rw [hh, abs_zero] at h; omega
    omega
  by_cases hx : |(p.1.val : ℤ) - q.1.val| = 0
  · by_cases hy : |(p.2.1.val : ℤ) - q.2.1.val| = 0
    · exact Or.inr (Or.inr ⟨equal _ _ hx, equal _ _ hy, adjacent _ _ (by omega)⟩)
    · exact Or.inr (Or.inl ⟨equal _ _ hx, adjacent _ _ (by omega), equal _ _ (by omega)⟩)
  · exact Or.inl ⟨adjacent _ _ (by omega), equal _ _ (by omega), equal _ _ (by omega)⟩

private def flipY {n : ℕ} (p : Pt n) : Pt n := (p.1, p.2.1.rev, p.2.2)

private theorem flipY_surface {n : ℕ} (p : Pt n) : OnSurface (flipY p) ↔ OnSurface p := by
  have h : flipY p = swapXY (rot p) := by rcases p with ⟨x, y, z⟩; rfl
  rw [h, swap_surface, rot_surface]

private theorem flipY_adj_at_axis {n : ℕ} (hn : Odd n) (p : Pt n)
    (hs : OnSurface p) (hy : p.2.1.val = mid n) : Adj p (flipY p) := by
  refine ⟨hs, (flipY_surface p).mpr hs, ?_⟩
  change |(p.1.val : ℤ) - p.1.val| + |(p.2.1.val : ℤ) - p.2.1.rev.val| +
    |(p.2.2.val : ℤ) - p.2.2.val| = 1
  obtain ⟨k, hk⟩ := hn
  have hrev : p.2.1.rev.val + 1 = p.2.1.val := by
    simp only [Fin.val_rev]
    unfold mid at hy
    have h := p.2.1.isLt
    omega
  rw [show (p.2.1.val : ℤ) - p.2.1.rev.val = 1 by omega]
  norm_num

private theorem offdiag_neighbors {n : ℕ} (hn : Odd n) (p : Sector n)
    (hp : diagonal p = false) {q : Pt n} (hq : Adj p.val q) :
    (∃ s : Sector n, s.val = q) ∨ (axis p = true ∧ q = flipY p.val) := by
  have hd := (diagonal_false p).mp hp
  have hm := p.property.2.1
  have hsurf := hq.2.1
  by_cases hy : mid n ≤ q.2.1.val
  · left
    have hxy : q.2.1.val ≤ q.1.val := by
      rcases adj_coordinates hq with ⟨hx, hyy, _⟩ | ⟨hxx, hy', _⟩ | ⟨hxx, hyy, _⟩
      · have h := congrArg Fin.val hyy
        omega
      · have h := congrArg Fin.val hxx
        omega
      · have h₁ := congrArg Fin.val hxx
        have h₂ := congrArg Fin.val hyy
        omega
    exact ⟨⟨q, hsurf, hy, hxy⟩, rfl⟩
  · right
    rcases adj_coordinates hq with ⟨_, hy', _⟩ | ⟨hx, hy', hz⟩ | ⟨_, hy', _⟩
    · exact (hy (hy' ▸ hm)).elim
    · have hc : p.val.2.1.val = mid n := by omega
      refine ⟨by simp [axis, hc], ?_⟩
      have hrev : q.2.1 = p.val.2.1.rev := by
        apply Fin.ext
        simp only [Fin.val_rev]
        obtain ⟨k, hk⟩ := hn
        unfold mid at hc
        have h := p.val.2.1.isLt
        omega
      exact Prod.ext hx.symm (Prod.ext hrev hz.symm)
    · exact (hy (hy' ▸ hm)).elim

private theorem extended_flip_axis {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (p : Pt n) (hp : OnSurface p) (hx : mid n ≤ p.1.val) (hy : mid n ≤ p.2.1.val) :
    extendedPhase u (flipY p) = 2 * Real.pi - extendedPhase u p := by
  have hy' : ¬mid n ≤ p.2.1.rev.val := fun h => (rev_pos_iff hn _).mp h hy
  have hf := firstQuadrant_reflect u hd p hp hx hy
  have hrot : rot (flipY p) = swapXY p := by
    rcases p with ⟨x, y, z⟩
    simp [rot, flipY, swapXY]
  simp only [extendedPhase, show (flipY p).1.val = p.1.val by rfl,
    show (flipY p).2.1.val = p.2.1.rev.val by rfl, hx, hy, hy', ite_true, ite_false,
    hrot, hf]
  ring

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007

private theorem fullForce_sector {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (p : Sector n) (hoff : diagonal p = false) :
    fullForce (extendedPhase u) p.val = force neighbors axis u p (u p) := by
  classical
  let S (q : Pt n) := OnSurface q ∧ mid n ≤ q.2.1.val ∧ q.2.1.val ≤ q.1.val
  let f (q : Pt n) := if Adj p.val q then
    Real.sin (extendedPhase u q - extendedPhase u p.val) else 0
  have hs : (∑ q ∈ Finset.univ.filter S, f q) =
      ∑ q ∈ neighbors p, Real.sin ((u q : ℝ) - (u p : ℝ)) := by
    rw [Finset.sum_subtype _ (show ∀ q, q ∈ Finset.univ.filter S ↔ S q from by simp)]
    change (∑ q : Sector n, f q.val) = _
    simp only [f, extended_sector, neighbors, Finset.sum_filter]
  have hcompl : (∑ q ∈ Finset.univ.filter (fun q => ¬S q), f q) =
      -(if axis p then Real.sin (2 * (u p : ℝ)) else 0) := by
    by_cases ha : axis p = true
    · have hf : Adj p.val (flipY p.val) :=
        flipY_adj_at_axis hn _ p.property.1 (by simpa [axis] using ha)
      have hm : flipY p.val ∈ Finset.univ.filter (fun q => ¬S q) := by
        simp only [Finset.mem_filter, Finset.mem_univ, true_and]
        intro h
        have hh := (rev_pos_iff hn p.val.2.1).mp h.2.1
        exact hh p.property.2.1
      rw [Finset.sum_eq_single (flipY p.val)]
      · have hφ := extended_flip_axis hn u hd p.val p.property.1
          (p.property.2.1.trans p.property.2.2) p.property.2.1
        simp only [f, ite_eq_left hf, ite_eq_left ha, hφ, extended_sector]
        rw [show 2 * Real.pi - (u p : ℝ) - (u p : ℝ) =
          -(2 * (u p : ℝ)) + 2 * Real.pi by ring, Real.sin_add_two_pi, Real.sin_neg]
      · intro q hq hne
        have hS := (Finset.mem_filter.mp hq).2
        have hnq : ¬ Adj p.val q := by
          intro hh
          rcases offdiag_neighbors hn p hoff hh with ⟨s, rfl⟩ | ⟨_, he⟩
          · exact hS s.property
          · exact hne he
        simp [f, hnq]
      · exact fun hm' => (hm' hm).elim
    · rw [Finset.sum_eq_zero]
      · simp [ha]
      · intro q hq
        have hS := (Finset.mem_filter.mp hq).2
        have hnq : ¬ Adj p.val q := by
          intro hh
          rcases offdiag_neighbors hn p hoff hh with ⟨s, rfl⟩ | ⟨he, _⟩
          · exact hS s.property
          · exact ha he
        simp [f, hnq]
  change (∑ q, f q) = _
  rw [← Finset.sum_filter_add_sum_filter_not (s := Finset.univ) (p := S) (f := f), hs, hcompl]
  unfold force
  ring

private def swapEquiv (n : ℕ) : Pt n ≃ Pt n where
  toFun := swapXY
  invFun := swapXY
  left_inv := by intro p; rcases p with ⟨x, y, z⟩; rfl
  right_inv := by intro p; rcases p with ⟨x, y, z⟩; rfl

private theorem fullForce_diag {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (p : Sector n) (hdiag : diagonal p = true) :
    fullForce (extendedPhase u) p.val = 0 := by
  classical
  have hfix : swapXY p.val = p.val := by
    have h := Fin.ext (by simpa [diagonal] using hdiag :
      p.val.1.val = p.val.2.1.val)
    exact Prod.ext h.symm (Prod.ext h rfl)
  let f (q : Pt n) := if Adj p.val q then
    Real.sin (extendedPhase u q - extendedPhase u p.val) else 0
  have hphase : extendedPhase u p.val = Real.pi / 4 := (extended_sector u p).trans (hd p hdiag)
  have hneg (q : Pt n) : f (swapXY q) = -f q := by
    have ha : Adj p.val (swapXY q) ↔ Adj p.val q := by
      have hh := swap_adj p.val q
      rwa [hfix] at hh
    by_cases hq : Adj p.val q
    · obtain ⟨k, hk⟩ := extended_swap_sum hn u hd q hq.2.1
      simp only [f, ite_eq_left hq, ite_eq_left (ha.mpr hq)]
      have he : extendedPhase u (swapXY q) - extendedPhase u p.val =
          -(extendedPhase u q - extendedPhase u p.val) + (k : ℝ) * (2 * Real.pi) := by
        linarith
      rw [he, Real.sin_add_int_mul_two_pi, Real.sin_neg]
    · have hnq : ¬Adj p.val (swapXY q) := fun h => hq (ha.mp h)
      simp [f, hq, hnq]
  have hh := (swapEquiv n).sum_comp f
  change (∑ q, f (swapXY q)) = ∑ q, f q at hh
  simp only [hneg, Finset.sum_neg_distrib] at hh
  change (∑ q, f q) = 0
  linarith

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007 Relation

private theorem swap_trig_diff {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter) (p q : Pt n)
    (hp : OnSurface p) (hq : OnSurface q) :
    Real.sin (extendedPhase u (swapXY q) - extendedPhase u (swapXY p)) =
      -Real.sin (extendedPhase u q - extendedPhase u p) ∧
    Real.cos (extendedPhase u (swapXY q) - extendedPhase u (swapXY p)) =
      Real.cos (extendedPhase u q - extendedPhase u p) := by
  obtain ⟨kp, hkp⟩ := extended_swap_sum hn u hd p hp
  obtain ⟨kq, hkq⟩ := extended_swap_sum hn u hd q hq
  have he : extendedPhase u (swapXY q) - extendedPhase u (swapXY p) =
      -(extendedPhase u q - extendedPhase u p) + (((kq - kp : ℤ) : ℝ) * (2 * Real.pi)) := by
    push_cast
    linarith
  rw [he, Real.sin_add_int_mul_two_pi, Real.cos_add_int_mul_two_pi, Real.sin_neg, Real.cos_neg]
  exact ⟨rfl, rfl⟩

private theorem fullForce_swap {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter) (p : Pt n) :
    fullForce (extendedPhase u) (swapXY p) = -fullForce (extendedPhase u) p := by
  classical
  unfold fullForce
  rw [← (swapEquiv n).sum_comp (fun q : Pt n =>
    if Adj (swapXY p) q then Real.sin (extendedPhase u q - extendedPhase u (swapXY p)) else 0),
    ← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro q _
  change (if Adj (swapXY p) (swapXY q) then _ else 0) = _
  simp only [swap_adj]
  split_ifs with h
  · exact (swap_trig_diff hn u hd p q h.1 h.2.1).1
  · simp

private def inFirst {n : ℕ} (p : Pt n) : Prop :=
  mid n ≤ p.1.val ∧ mid n ≤ p.2.1.val

private theorem some_rotation_first {n : ℕ} (hn : Odd n) (p : Pt n) :
    inFirst p ∨ inFirst (rot p) ∨ inFirst (rot (rot p)) ∨ inFirst (rot (rot (rot p))) := by
  have h₀ := rot_pos_conditions hn p
  have h₁ := rot_pos_conditions hn (rot p)
  have h₂ := rot_pos_conditions hn (rot (rot p))
  unfold inFirst
  grind

private theorem extended_equilibrium {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (he : ∀ p, diagonal p = false → force neighbors axis u p (u p) = 0) :
    IsEquilibrium (extendedPhase u) := by
  have onSector (p : Sector n) : fullForce (extendedPhase u) p.val = 0 := by
    cases h : diagonal p
    · rw [fullForce_sector hn u hd p h, he p h]
    · exact fullForce_diag hn u hd p h
  have onFirst (p : Pt n) (hp : OnSurface p) (hf : inFirst p) :
      fullForce (extendedPhase u) p = 0 := by
    by_cases h : p.2.1.val ≤ p.1.val
    · exact onSector ⟨p, hp, hf.2, h⟩
    · have hq := onSector ⟨swapXY p, (swap_surface p).mpr hp, hf.1, by
        change p.1.val ≤ p.2.1.val
        omega⟩
      change fullForce (extendedPhase u) (swapXY p) = 0 at hq
      rw [fullForce_swap hn u hd] at hq
      linarith
  intro p hp
  change fullForce (extendedPhase u) p = 0
  rcases some_rotation_first hn p with h | h | h | h
  · exact onFirst p hp h
  · have hh := onFirst _ ((rot_surface _).mpr hp) h
    simpa only [fullForce_rot hn] using hh
  · have hh := onFirst _ ((rot_surface _).mpr ((rot_surface _).mpr hp)) h
    simpa only [fullForce_rot hn] using hh
  · have hh := onFirst _ ((rot_surface _).mpr ((rot_surface _).mpr ((rot_surface _).mpr hp))) h
    simpa only [fullForce_rot hn] using hh

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007 Relation

private def centralCoord {n : ℕ} (x : Fin (n + 1)) : Prop :=
  x.val = mid n ∨ x.val + 1 = mid n

private def coreEdge {n : ℕ} (p q : Pt n) : Prop :=
  centralCoord p.1 ∧ centralCoord p.2.1 ∧
    centralCoord q.1 ∧ centralCoord q.2.1 ∧ p.2.2 = q.2.2

private theorem central_rev {n : ℕ} (hn : Odd n) (x : Fin (n + 1)) :
    centralCoord x.rev ↔ centralCoord x := by
  obtain ⟨k, hk⟩ := hn
  have hx := x.isLt
  simp only [centralCoord, Fin.val_rev, mid]
  omega

private theorem core_rot {n : ℕ} (hn : Odd n) (p q : Pt n) :
    coreEdge (rot p) (rot q) ↔ coreEdge p q := by
  simp only [coreEdge, rot, central_rev hn]
  tauto

private theorem core_swap {n : ℕ} (p q : Pt n) :
    coreEdge (swapXY p) (swapXY q) ↔ coreEdge p q := by
  simp only [coreEdge, swapXY]
  tauto

private theorem firstPhase_edge_pos {n : ℕ} (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (p q : Pt n) (h : Adj p q) (hp : inFirst p) (hq : inFirst q) :
    0 < Real.cos (extendedPhase u q - extendedPhase u p) := by
  have sameLower (a b : Pt n) (ha : OnSurface a) (hb : OnSurface b)
      (ha' : inFirst a) (hb' : inFirst b)
      (h₁ : a.2.1.val ≤ a.1.val) (h₂ : b.2.1.val ≤ b.1.val) :
      0 < Real.cos (extendedPhase u b - extendedPhase u a) := by
    let x : Sector n := ⟨a, ha, ha'.2, h₁⟩
    let y : Sector n := ⟨b, hb, hb'.2, h₂⟩
    change 0 < Real.cos (extendedPhase u y.val - extendedPhase u x.val)
    rw [extended_sector, extended_sector]
    have hx := (u x).property
    have hy := (u y).property
    simp only [Set.mem_Icc, quarter] at hx hy
    exact Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], by linarith [Real.pi_pos]⟩
  have sameUpper (a b : Pt n) (ha : OnSurface a) (hb : OnSurface b)
      (ha' : inFirst a) (hb' : inFirst b)
      (h₁ : a.1.val ≤ a.2.1.val) (h₂ : b.1.val ≤ b.2.1.val) :
      0 < Real.cos (extendedPhase u b - extendedPhase u a) := by
    have fa : extendedPhase u (swapXY a) = Real.pi / 2 - extendedPhase u a := by
      rw [extended_first u _ ha'.2 ha'.1, extended_first u _ ha'.1 ha'.2]
      exact firstQuadrant_reflect u hd a ha ha'.1 ha'.2
    have fb : extendedPhase u (swapXY b) = Real.pi / 2 - extendedPhase u b := by
      rw [extended_first u _ hb'.2 hb'.1, extended_first u _ hb'.1 hb'.2]
      exact firstQuadrant_reflect u hd b hb hb'.1 hb'.2
    have hh := sameLower (swapXY a) (swapXY b) ((swap_surface _).mpr ha) ((swap_surface _).mpr hb)
      ⟨ha'.2, ha'.1⟩ ⟨hb'.2, hb'.1⟩ h₁ h₂
    rw [fa, fb, show Real.pi / 2 - extendedPhase u b -
      (Real.pi / 2 - extendedPhase u a) = -(extendedPhase u b - extendedPhase u a) by ring,
      Real.cos_neg] at hh
    exact hh
  have hs :
      (p.2.1.val ≤ p.1.val ∧ q.2.1.val ≤ q.1.val) ∨
        (p.1.val ≤ p.2.1.val ∧ q.1.val ≤ q.2.1.val) := by
    rcases adj_coordinates h with ⟨hx, hy, _⟩ | ⟨hx, hy, _⟩ | ⟨hx, hy, _⟩
    · have he := congrArg Fin.val hy
      omega
    · have he := congrArg Fin.val hx
      omega
    · have he₁ := congrArg Fin.val hx
      have he₂ := congrArg Fin.val hy
      omega
  rcases hs with ⟨ha, hb⟩ | ⟨ha, hb⟩
  · exact sameLower p q h.1 h.2.1 hp hq ha hb
  · exact sameUpper p q h.1 h.2.1 hp hq ha hb

private theorem axisPhase_edge {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (hb : ∀ p, diagonal p = false → (u p : ℝ) < quarter)
    (p : Pt n) (hp : OnSurface p) (hf : inFirst p) (hy : p.2.1.val = mid n) :
    0 ≤ Real.cos (extendedPhase u (flipY p) - extendedPhase u p) ∧
      (¬coreEdge p (flipY p) → 0 < Real.cos (extendedPhase u (flipY p) - extendedPhase u p)) := by
  let s : Sector n := ⟨p, hp, hf.2, by rw [hy]; exact hf.1⟩
  have hs : extendedPhase u p = (u s : ℝ) := extended_sector u s
  rw [extended_flip_axis hn u hd p hp hf.1 hf.2, hs,
    show 2 * Real.pi - (u s : ℝ) - (u s : ℝ) = -(2 * (u s : ℝ)) + 2 * Real.pi by ring,
    Real.cos_add_two_pi, Real.cos_neg]
  have h₁ := (u s).property.1
  have h₂ := (u s).property.2
  unfold quarter at h₂
  refine ⟨Real.cos_nonneg_of_mem_Icc ⟨by linarith [Real.pi_pos], by linarith⟩, ?_⟩
  intro hnot
  have hx : mid n < p.1.val := by
    by_contra! hle
    have h := le_antisymm hle hf.1
    have hyrev : centralCoord p.2.1.rev := (central_rev hn _).mpr (Or.inl hy)
    exact hnot ⟨Or.inl h, Or.inl hy, Or.inl h, hyrev, rfl⟩
  have hstrict := hb s ((diagonal_false _).mpr (by change p.2.1.val < p.1.val; omega))
  unfold quarter at hstrict
  exact Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], by linarith⟩

private theorem edge_from_first {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (hb : ∀ p, diagonal p = false → (u p : ℝ) < quarter)
    (p q : Pt n) (ha : Adj p q) (hp : inFirst p) :
    0 ≤ Real.cos (extendedPhase u q - extendedPhase u p) ∧
      (¬coreEdge p q → 0 < Real.cos (extendedPhase u q - extendedPhase u p)) := by
  by_cases hq : inFirst q
  · have h := firstPhase_edge_pos u hd p q ha hp hq
    exact ⟨h.le, fun _ => h⟩
  have crossY (a b : Pt n) (h : Adj a b) (hfirst : inFirst a)
      (hby : ¬mid n ≤ b.2.1.val) :
      0 ≤ Real.cos (extendedPhase u b - extendedPhase u a) ∧
        (¬coreEdge a b → 0 < Real.cos (extendedPhase u b - extendedPhase u a)) := by
    have hpay := hfirst.2
    rcases adj_coordinates h with ⟨_, hy, _⟩ | ⟨hx, hy, hz⟩ | ⟨_, hy, _⟩
    · exact (hby (hy ▸ hpay)).elim
    · have hm : a.2.1.val = mid n := by omega
      have hrev : b.2.1 = a.2.1.rev := by
        apply Fin.ext
        simp only [Fin.val_rev]
        obtain ⟨k, hk⟩ := hn
        unfold mid at hm
        have hj := a.2.1.isLt
        omega
      have he : b = flipY a := Prod.ext hx.symm (Prod.ext hrev hz.symm)
      rw [he]
      exact axisPhase_edge hn u hd hb a h.1 hfirst hm
    · exact (hby (hy ▸ hpay)).elim
  by_cases hy : mid n ≤ q.2.1.val
  · have hx : ¬mid n ≤ q.1.val := fun hh => hq ⟨hh, hy⟩
    have h := crossY (swapXY p) (swapXY q) ((swap_adj _ _).mpr ha) ⟨hp.2, hp.1⟩ hx
    rwa [(swap_trig_diff hn u hd p q ha.1 ha.2.1).2, core_swap] at h
  · exact crossY p q ha hp hy

private theorem all_edge_weights {n : ℕ} (hn : Odd n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (hb : ∀ p, diagonal p = false → (u p : ℝ) < quarter)
    (p q : Pt n) (ha : Adj p q) :
    0 ≤ Real.cos (extendedPhase u q - extendedPhase u p) ∧
      (¬coreEdge p q → 0 < Real.cos (extendedPhase u q - extendedPhase u p)) := by
  rcases some_rotation_first hn p with h | h | h | h
  · exact edge_from_first hn u hd hb p q ha h
  · have hh := edge_from_first hn u hd hb _ _ ((rot_adj _ _).mpr ha) h
    simpa only [cos_rot_diff hn, core_rot hn] using hh
  · have hh := edge_from_first hn u hd hb _ _ ((rot_adj _ _).mpr ((rot_adj _ _).mpr ha)) h
    simpa only [cos_rot_diff hn, core_rot hn] using hh
  · have hh := edge_from_first hn u hd hb _ _ ((rot_adj _ _).mpr ((rot_adj _ _).mpr ((rot_adj _ _).mpr ha))) h
    simpa only [cos_rot_diff hn, core_rot hn] using hh

end QEDE007Proof

namespace QEDE007Proof

open OpenProblems.QEDE007 Relation

private abbrev safeStep {n : ℕ} (p q : Pt n) : Prop := Adj p q ∧ ¬coreEdge p q

private theorem safe_symm {n : ℕ} {p q : Pt n} (h : safeStep p q) : safeStep q p := by
  obtain ⟨⟨hp, hq, he⟩, hc⟩ := h
  refine ⟨⟨hq, hp, ?_⟩, ?_⟩
  · simpa only [abs_sub_comm (q.1.val : ℤ) p.1.val,
      abs_sub_comm (q.2.1.val : ℤ) p.2.1.val, abs_sub_comm (q.2.2.val : ℤ) p.2.2.val] using he
  · unfold coreEdge at hc ⊢
    grind

private theorem path_rev {n : ℕ} {p q : Pt n} (h : ReflTransGen safeStep p q) :
    ReflTransGen safeStep q p := by
  induction h with
  | refl => exact .refl
  | tail _ hh ih => exact ih.head (safe_symm hh)

private theorem path_swap {n : ℕ} {p q : Pt n} (h : ReflTransGen safeStep p q) :
    ReflTransGen safeStep (swapXY p) (swapXY q) := by
  induction h with
  | refl => exact .refl
  | tail _ hh ih =>
    exact ih.tail ⟨(swap_adj _ _).mpr hh.1, fun h => hh.2 ((core_swap _ _).mp h)⟩

private theorem path_along_nat {α : Type*} {R : α → α → Prop} (f : ℕ → α)
    (a b : ℕ) (hab : a ≤ b) (hs : ∀ j, a ≤ j → j < b → R (f j) (f (j + 1))) :
    ReflTransGen R (f a) (f b) := by
  induction b, hab using Nat.le_induction with
  | base => exact .refl
  | succ b hab ih =>
    exact (ih (fun j ha hb => hs j ha (by omega))).tail (hs b hab (by omega))

private def setX {n : ℕ} (p : Pt n) (j : ℕ) : Pt n :=
  (Fin.ofNat (n + 1) j, p.2.1, p.2.2)

private def setZ {n : ℕ} (p : Pt n) (j : ℕ) : Pt n :=
  (p.1, p.2.1, Fin.ofNat (n + 1) j)

private theorem setX_val {n : ℕ} (p : Pt n) (j : ℕ) (hj : j ≤ n) :
    (setX p j).1.val = j := Nat.mod_eq_of_lt (by omega)

private theorem setZ_val {n : ℕ} (p : Pt n) (j : ℕ) (hj : j ≤ n) :
    (setZ p j).2.2.val = j := Nat.mod_eq_of_lt (by omega)

private theorem setX_orig {n : ℕ} (p : Pt n) : setX p p.1.val = p :=
  Prod.ext (Fin.ext (setX_val p _ (by have := p.1.isLt; omega))) rfl

private theorem setZ_orig {n : ℕ} (p : Pt n) : setZ p p.2.2.val = p :=
  Prod.ext rfl (Prod.ext rfl (Fin.ext (setZ_val p _ (by have := p.2.2.isLt; omega))))

private theorem noCentralBoundary {n : ℕ} (hn : 3 ≤ n) (x : Fin (n + 1))
    (hx : x = 0 ∨ x = Fin.last n) : ¬centralCoord x := by
  rcases hx with rfl | rfl <;> simp only [centralCoord, Fin.val_zero, Fin.val_last, mid] <;> omega

private theorem xPath {n : ℕ} (p : Pt n)
    (hp : p.2.1 = 0 ∨ p.2.1 = Fin.last n ∨ p.2.2 = 0 ∨ p.2.2 = Fin.last n)
    (a b : ℕ) (hab : a ≤ b) (hb : b ≤ n)
    (hSafe : ∀ j, a ≤ j → j < b → ¬coreEdge (setX p j) (setX p (j + 1))) :
    ReflTransGen safeStep (setX p a) (setX p b) := by
  apply path_along_nat _ _ _ hab
  intro j ha hj
  have hs (j : ℕ) : OnSurface (setX p j) := by
    unfold OnSurface setX
    tauto
  refine ⟨⟨hs _, hs _, ?_⟩, hSafe j ha hj⟩
  change |((setX p j).1.val : ℤ) - (setX p (j + 1)).1.val| +
    |(p.2.1.val : ℤ) - p.2.1.val| + |(p.2.2.val : ℤ) - p.2.2.val| = 1
  rw [setX_val _ _ (by omega), setX_val _ _ (by omega),
    show (j : ℤ) - ((j + 1 : ℕ) : ℤ) = -1 by omega]
  norm_num

private theorem zPath {n : ℕ} (hn : 3 ≤ n) (p : Pt n)
    (hp : p.1 = 0 ∨ p.1 = Fin.last n) (a b : ℕ) (hab : a ≤ b) (hb : b ≤ n) :
    ReflTransGen safeStep (setZ p a) (setZ p b) := by
  apply path_along_nat _ _ _ hab
  intro j ha hj
  have hs (j : ℕ) : OnSurface (setZ p j) := by
    unfold OnSurface setZ
    tauto
  refine ⟨⟨hs _, hs _, ?_⟩, fun hc => noCentralBoundary hn p.1 hp hc.1⟩
  change |(p.1.val : ℤ) - p.1.val| + |(p.2.1.val : ℤ) - p.2.1.val| +
    |((setZ p j).2.2.val : ℤ) - (setZ p (j + 1)).2.2.val| = 1
  rw [setZ_val _ _ (by omega), setZ_val _ _ (by omega),
    show (j : ℤ) - ((j + 1 : ℕ) : ℤ) = -1 by omega]
  norm_num

private theorem xPath_to_side {n : ℕ} (p : Pt n)
    (hp : p.2.2 = 0 ∨ p.2.2 = Fin.last n) :
    ∃ q, (q.1 = 0 ∨ q.1 = Fin.last n) ∧ ReflTransGen safeStep p q := by
  have hx : p.1.val ≤ n := by have := p.1.isLt; omega
  have hx0 : (setX p 0).1 = 0 := Fin.ext (setX_val p 0 (by omega))
  have hxn : (setX p n).1 = Fin.last n := Fin.ext (by rw [setX_val _ _ le_rfl]; rfl)
  by_cases hf : mid n ≤ p.1.val
  · refine ⟨setX p n, Or.inr hxn, ?_⟩
    have hh := xPath p (Or.inr (Or.inr hp)) p.1.val n hx le_rfl
      (fun j ha hb hc => by
        have hj := hc.2.2.1
        unfold centralCoord at hj
        rw [setX_val _ _ (by omega)] at hj
        omega)
    simpa only [setX_orig] using hh
  · refine ⟨setX p 0, Or.inl hx0, ?_⟩
    have hh := xPath p (Or.inr (Or.inr hp)) 0 p.1.val (Nat.zero_le _) hx
      (fun j ha hb hc => by
        have hj := hc.1
        unfold centralCoord at hj
        rw [setX_val _ _ (by omega)] at hj
        omega)
    exact path_rev (by simpa only [setX_orig] using hh)

private theorem path_to_corner {n : ℕ} (hn : 3 ≤ n) (p : Pt n) (hp : OnSurface p) :
    ReflTransGen safeStep p (Fin.last n, Fin.last n, 0) := by
  have yToCorner (a : Pt n) (ha : a.2.1 = 0 ∨ a.2.1 = Fin.last n) :
      ReflTransGen safeStep a (Fin.last n, Fin.last n, 0) := by
    let b := setX a n
    have hb : b.1 = Fin.last n := Fin.ext (by simp [b, setX_val])
    have hab : ReflTransGen safeStep a b := by
      have hh := xPath a (by rcases ha with h | h; exact Or.inl h; exact Or.inr (Or.inl h))
        a.1.val n (by have := a.1.isLt; omega) le_rfl
        (fun j _ _ hc => noCentralBoundary hn a.2.1 ha hc.2.1)
      simpa only [setX_orig] using hh
    let c := setZ b 0
    have hbc : ReflTransGen safeStep b c := by
      have hh := zPath hn b (Or.inr hb) 0 b.2.2.val (Nat.zero_le _) (by have := b.2.2.isLt; omega)
      exact path_rev (by simpa only [setZ_orig] using hh)
    have hcd : ReflTransGen safeStep c (Fin.last n, Fin.last n, 0) := by
      have hd : (swapXY c).2.1 = Fin.last n := hb
      have hh := xPath (swapXY c) (Or.inr (Or.inl hd)) (swapXY c).1.val n
        (by have := (swapXY c).1.isLt; omega) le_rfl
        (fun j _ _ hc => noCentralBoundary hn (swapXY c).2.1 (Or.inr hd) hc.2.1)
      rw [setX_orig] at hh
      have h1 : swapXY (swapXY c) = c := by rcases c with ⟨x, y, z⟩; rfl
      have h2 : swapXY (setX (swapXY c) n) = (Fin.last n, Fin.last n, 0) := by
        refine Prod.ext hd (Prod.ext ?_ ?_)
        · apply Fin.ext
          change (setX (swapXY c) n).1.val = n
          exact setX_val _ _ le_rfl
        · exact Fin.ext (setZ_val b 0 (by omega))
      rw [← h1, ← h2]
      exact path_swap hh
    exact hab.trans (hbc.trans hcd)
  have xToCorner (a : Pt n) (ha : a.1 = 0 ∨ a.1 = Fin.last n) :
      ReflTransGen safeStep a (Fin.last n, Fin.last n, 0) := by
    have hh := path_swap (yToCorner (swapXY a) ha)
    have h : swapXY (swapXY a) = a := by rcases a with ⟨x, y, z⟩; rfl
    simpa only [h, show swapXY (Fin.last n, Fin.last n, 0) = (Fin.last n, Fin.last n, 0) by rfl] using hh
  rcases hp with hx | hx | hy | hy | hz | hz
  · exact xToCorner p (Or.inl hx)
  · exact xToCorner p (Or.inr hx)
  · exact yToCorner p (Or.inl hy)
  · exact yToCorner p (Or.inr hy)
  · obtain ⟨q, hq, hpath⟩ := xPath_to_side p (Or.inl hz)
    exact hpath.trans (xToCorner q hq)
  · obtain ⟨q, hq, hpath⟩ := xPath_to_side p (Or.inr hz)
    exact hpath.trans (xToCorner q hq)

private theorem extended_stable {n : ℕ} (hn : Odd n) (hn3 : 3 ≤ n) (u : Sector n → Phase)
    (hd : ∀ p, diagonal p = true → (u p : ℝ) = quarter)
    (hb : ∀ p, diagonal p = false → (u p : ℝ) < quarter) :
    IsLinearlyStable (extendedPhase u) := by
  apply stable_of_positive_paths _ (fun p q h => (all_edge_weights hn u hd hb p q h).1)
  intro p q hp hq
  have path := (path_to_corner hn3 p hp).trans (path_rev (path_to_corner hn3 q hq))
  clear hq
  induction path with
  | refl => exact .refl
  | tail _ hh ih => exact ih.tail ⟨hh.1, (all_edge_weights hn u hd hb _ _ hh.1).2 hh.2⟩

theorem full_claim : OpenProblems.QEDE007.Claim := by
  intro n hn hn3
  obtain ⟨u, hd, hu⟩ := cube_sector_equilibrium n hn3
  have hr := extendedPhase_rot_symmetric hn u
  exact ⟨extendedPhase u, extended_equilibrium hn u hd (fun p hp => (hu p hp).1), hr,
    winding_of_rot_symmetry _ hr _ (Or.inr rfl), winding_of_rot_symmetry _ hr _ (Or.inl rfl),
    extended_stable hn hn3 u hd (fun p hp => (hu p hp).2.2)⟩

end QEDE007Proof

theorem solution : OpenProblems.QEDE007.Claim := QEDE007Proof.full_claim
