/-!
# A structured counter language compiled to Mathlib `FinTM2`

Registers are unary stacks (`Fin R`; register `0` is the input stack), plus one output stack of
`Bool`. Programs: `inc`, `dec`, `out`, `seq`, `loop` (while register ≠ 0), `ite` (if register = 0).
Big-step semantics count steps exactly; one TM2 step per counted step, plus one final halt step.
-/

namespace QEDTM

variable {R : ℕ}

inductive Prog (R : ℕ) where
  | inc (r : Fin R)
  | dec (r : Fin R)
  | out (b : Bool)
  | seq (p q : Prog R)
  | loop (r : Fin R) (body : Prog R)
  | ite (r : Fin R) (z nz : Prog R)

/-- Machine state: register values and emitted bits (oldest first). -/
@[ext] structure St (R : ℕ) where
  reg : Fin R → ℕ
  out : List Bool

def St.inc (s : St R) (r : Fin R) : St R := ⟨Function.update s.reg r (s.reg r + 1), s.out⟩
def St.dec (s : St R) (r : Fin R) : St R := ⟨Function.update s.reg r (s.reg r - 1), s.out⟩
def St.emit (s : St R) (b : Bool) : St R := ⟨s.reg, s.out ++ [b]⟩

/-- Big-step semantics with exact step count. -/
inductive Run : Prog R → St R → St R → ℕ → Prop
  | inc (r s) : Run (.inc r) s (s.inc r) 1
  | dec (r s) : Run (.dec r) s (s.dec r) 1
  | out (b s) : Run (.out b) s (s.emit b) 1
  | seq {p q s s₁ s₂ t₁ t₂} : Run p s s₁ t₁ → Run q s₁ s₂ t₂ → Run (.seq p q) s s₂ (t₁ + t₂)
  | loopZ {r b s} : s.reg r = 0 → Run (.loop r b) s s 1
  | loopS {r b s s₁ s₂ t₁ t₂} : s.reg r ≠ 0 → Run b s s₁ t₁ → Run (.loop r b) s₁ s₂ t₂ →
      Run (.loop r b) s s₂ (t₁ + t₂ + 1)
  | iteZ {r z nz s s' t} : s.reg r = 0 → Run z s s' t → Run (.ite r z nz) s s' (t + 1)
  | iteS {r z nz s s' t} : s.reg r ≠ 0 → Run nz s s' t → Run (.ite r z nz) s s' (t + 1)

/-! ### Flat code -/

inductive Ins (R : ℕ) where
  | inc (r : Fin R) (j : ℕ)
  | dec (r : Fin R) (j : ℕ)
  | out (b : Bool) (j : ℕ)
  | jz (r : Fin R) (j₁ j₂ : ℕ)
  | halt

def Prog.size : Prog R → ℕ
  | .inc _ | .dec _ | .out _ => 1
  | .seq p q => p.size + q.size
  | .loop _ b => b.size + 1
  | .ite _ z nz => z.size + nz.size + 1

/-- Code of `p` placed at address `a`, exiting to `e`. -/
def Prog.compile : Prog R → ℕ → ℕ → List (Ins R)
  | .inc r, _, e => [.inc r e]
  | .dec r, _, e => [.dec r e]
  | .out b, _, e => [.out b e]
  | .seq p q, a, e => p.compile a (a + p.size) ++ q.compile (a + p.size) e
  | .loop r b, a, e => .jz r e (a + 1) :: b.compile (a + 1) a
  | .ite r z nz, a, e => .jz r (a + 1) (a + 1 + z.size) :: (z.compile (a + 1) e ++ nz.compile (a + 1 + z.size) e)

lemma Prog.length_compile (p : Prog R) (a e : ℕ) : (p.compile a e).length = p.size := by
  induction p generalizing a e with
  | inc | dec | out => rfl
  | seq p q ihp ihq => simp [compile, size, ihp, ihq]
  | loop r b ih => simp [compile, size, ih]
  | ite r z nz ihz ihnz => simp [compile, size, ihz, ihnz]

/-- One instruction. -/
def stepIns : Ins R → St R → Option (ℕ × St R)
  | .inc r j, s => some (j, s.inc r)
  | .dec r j, s => some (j, s.dec r)
  | .out b j, s => some (j, s.emit b)
  | .jz r j₁ j₂, s => some (if s.reg r = 0 then j₁ else j₂, s)
  | .halt, _ => none

/-- Flat machine step. -/
def fstep (code : List (Ins R)) (c : ℕ × St R) : Option (ℕ × St R) :=
  stepIns (code.getD c.1 .halt) c.2

/-- `n` iterations of the flat step (on `Option`). -/
def fiter (code : List (Ins R)) : ℕ → Option (ℕ × St R) → Option (ℕ × St R)
  | 0, c => c
  | n + 1, c => fiter code n (c.bind (fstep code))

lemma fiter_add (code : List (Ins R)) (m n : ℕ) (c) :
    fiter code (m + n) c = fiter code n (fiter code m c) := by
  induction m generalizing c with
  | zero => simp [fiter]
  | succ m ih => rw [Nat.add_right_comm, fiter, ih, fiter]

/-- `code` contains `l` at address `a`. -/
def At (code : List (Ins R)) (a : ℕ) (l : List (Ins R)) : Prop :=
  ∀ i, i < l.length → code.getD (a + i) .halt = l.getD i .halt

lemma At.left {code : List (Ins R)} {a l₁ l₂} (h : At code a (l₁ ++ l₂)) : At code a l₁ := by
  intro i hi
  have := h i (by simp; omega)
  rw [this, List.getD_append _ _ _ _ hi]

lemma At.right {code : List (Ins R)} {a l₁ l₂} (h : At code a (l₁ ++ l₂)) :
    At code (a + l₁.length) l₂ := by
  intro i hi
  have := h (l₁.length + i) (by simp; omega)
  rw [← Nat.add_assoc] at this
  rw [this, List.getD_append_right _ _ _ _ (by omega)]
  simp

lemma At.cons_head {code : List (Ins R)} {a x l} (h : At code a (x :: l)) :
    code.getD a .halt = x := by
  have := h 0 (by simp); simpa using this

lemma At.cons_tail {code : List (Ins R)} {a x l} (h : At code a (x :: l)) : At code (a + 1) l := by
  intro i hi
  have := h (i + 1) (by simp; omega)
  rw [show a + 1 + i = a + (i + 1) by omega, this]; simp

lemma fiter_one (code : List (Ins R)) (pc : ℕ) (s : St R) :
    fiter code 1 (some (pc, s)) = fstep code (pc, s) := by
  simp only [fiter, Option.bind_some]

/-- Compilation is correct: a run of `t` steps becomes exactly `t` flat steps. -/
theorem compile_run {p : Prog R} {s s' : St R} {t : ℕ} (h : Run p s s' t) :
    ∀ (code : List (Ins R)) (a e : ℕ), At code a (p.compile a e) →
      fiter code t (some (a, s)) = some (e, s') := by
  induction h with
  | inc r s =>
    intro code a e hc
    simp only [Prog.compile] at hc
    rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head]
  | dec r s =>
    intro code a e hc
    simp only [Prog.compile] at hc
    rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head]
  | out b s =>
    intro code a e hc
    simp only [Prog.compile] at hc
    rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head]
  | seq _ _ ih₁ ih₂ =>
    intro code a e hc
    simp only [Prog.compile] at hc
    rw [fiter_add, ih₁ code a _ hc.left]
    have := hc.right
    rw [Prog.length_compile] at this
    exact ih₂ code _ e this
  | loopZ hz =>
    intro code a e hc
    simp only [Prog.compile] at hc
    rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head, hz, if_true]
  | loopS hnz _ _ ih₁ ih₂ =>
    rename_i r b s s₁ s₂ t₁ t₂ _ _
    intro code a e hc
    have hc' := hc
    simp only [Prog.compile] at hc
    have h1 : fiter code 1 (some (a, s)) = some (a + 1, s) := by
      rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head, hnz, if_false]
    rw [show t₁ + t₂ + 1 = 1 + (t₁ + t₂) by omega, fiter_add, fiter_add, h1,
      ih₁ code (a + 1) a hc.cons_tail]
    exact ih₂ code a e hc'
  | iteZ hz _ ih =>
    rename_i r z nz s s' t _
    intro code a e hc
    simp only [Prog.compile] at hc
    have h1 : fiter code 1 (some (a, s)) = some (a + 1, s) := by
      rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head, hz, if_true]
    rw [show t + 1 = 1 + t from Nat.add_comm _ _, fiter_add, h1]
    exact ih code (a + 1) e hc.cons_tail.left
  | iteS hnz _ ih =>
    rename_i r z nz s s' t _
    intro code a e hc
    simp only [Prog.compile] at hc
    have h1 : fiter code 1 (some (a, s)) = some (a + 1 + z.size, s) := by
      rw [fiter_one]; simp only [fstep, stepIns, hc.cons_head, hnz, if_false]
    rw [show t + 1 = 1 + t from Nat.add_comm _ _, fiter_add, h1]
    have := hc.cons_tail.right
    rw [Prog.length_compile] at this
    exact ih code _ e this

end QEDTM


/-! # Register macros with exact specifications -/

namespace QEDTM

variable {R : ℕ}

open Function

/-- `clear r`. -/
def mClear (r : Fin R) : Prog R := .loop r (.dec r)

/-- `move a b`: `b += a; a := 0`. -/
def mMove (a b : Fin R) : Prog R := .loop a (.seq (.dec a) (.inc b))

/-- `move2 a b c`: `b += a; c += a; a := 0`. -/
def mMove2 (a b c : Fin R) : Prog R := .loop a (.seq (.dec a) (.seq (.inc b) (.inc c)))

/-- `copy a b t`: `b += a` using the scratch `t` (which must be `0`). -/
def mCopy (a b t : Fin R) : Prog R := .seq (mMove2 a b t) (mMove t a)

/-- `incs r c`: `r := c` (for `r = 0`). -/
def mIncs (r : Fin R) : ℕ → Prog R
  | 0 => mClear r
  | c + 1 => .seq (mIncs r c) (.inc r)

/-- Generic counting-loop lemma: if the body decreases `r` by one and transforms the state by `G`,
then the loop runs `G` iterated. -/
lemma run_loop_gen (r : Fin R) (b : Prog R) (F : St R → St R) (τ : St R → ℕ)
    (hF0 : ∀ s, s.reg r = 0 → F s = s) (hτ0 : ∀ s, s.reg r = 0 → τ s = 1)
    (hstep : ∀ s, s.reg r ≠ 0 → ∃ s₁ t₁, Run b s s₁ t₁ ∧ s₁.reg r + 1 = s.reg r ∧
      F s₁ = F s ∧ t₁ + τ s₁ + 1 = τ s) :
    ∀ s, Run (.loop r b) s (F s) (τ s) := by
  intro s
  obtain ⟨k, hk⟩ : ∃ k, s.reg r = k := ⟨_, rfl⟩
  induction k generalizing s with
  | zero => rw [hF0 s hk, hτ0 s hk]; exact Run.loopZ hk
  | succ k ih =>
    obtain ⟨s₁, t₁, h1, hr, hF, ht⟩ := hstep s (by omega)
    have := Run.loopS (by omega) h1 (ih s₁ (by omega))
    rw [hF, ht] at this; exact this

lemma run_clear (r : Fin R) (s : St R) :
    Run (mClear r) s ⟨update s.reg r 0, s.out⟩ (2 * s.reg r + 1) := by
  refine run_loop_gen r (.dec r) (fun s => ⟨update s.reg r 0, s.out⟩) (fun s => 2 * s.reg r + 1)
    (fun s h => by ext1 <;> simp [← h]) (fun s h => by simp [h]) ?_ s
  intro s hs
  refine ⟨s.dec r, 1, Run.dec r s, by simp [St.dec]; omega, ?_, by simp [St.dec]; omega⟩
  ext1 <;> simp [St.dec]

lemma run_move (a b : Fin R) (hab : a ≠ b) (s : St R) :
    Run (mMove a b) s ⟨update (update s.reg b (s.reg b + s.reg a)) a 0, s.out⟩ (3 * s.reg a + 1) := by
  refine run_loop_gen a _ (fun s => ⟨update (update s.reg b (s.reg b + s.reg a)) a 0, s.out⟩)
    (fun s => 3 * s.reg a + 1) (fun s h => ?_) (fun s h => by simp [h]) ?_ s
  · ext1
    · funext x; simp only [update_apply]; split_ifs <;> simp_all
    · rfl
  · intro s hs
    refine ⟨(s.dec a).inc b, 2, Run.seq (Run.dec a s) (Run.inc b _), ?_, ?_, ?_⟩
    · simp [St.dec, St.inc, update_apply, hab]; omega
    · ext1
      · funext x; simp only [St.dec, St.inc, update_apply]
        split_ifs <;> simp_all <;> omega
      · rfl
    · simp [St.dec, St.inc, update_apply, hab]; omega

lemma run_move2 (a b c : Fin R) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) (s : St R) :
    Run (mMove2 a b c) s ⟨update (update (update s.reg b (s.reg b + s.reg a)) c (s.reg c + s.reg a)) a 0,
      s.out⟩ (4 * s.reg a + 1) := by
  refine run_loop_gen a _ (fun s => ⟨update (update (update s.reg b (s.reg b + s.reg a)) c
      (s.reg c + s.reg a)) a 0, s.out⟩) (fun s => 4 * s.reg a + 1) (fun s h => ?_) (fun s h => by simp [h]) ?_ s
  · ext1
    · funext x; simp only [update_apply]; split_ifs <;> simp_all
    · rfl
  · intro s hs
    refine ⟨((s.dec a).inc b).inc c, 3, Run.seq (Run.dec a s) (Run.seq (Run.inc b _) (Run.inc c _)), ?_, ?_, ?_⟩
    · simp [St.dec, St.inc, update_apply, hab, hac]; omega
    · ext1
      · funext x; simp only [St.dec, St.inc, update_apply]
        split_ifs <;> simp_all <;> omega
      · rfl
    · simp [St.dec, St.inc, update_apply, hab, hac]; omega

lemma run_copy (a b t : Fin R) (hab : a ≠ b) (hat : a ≠ t) (hbt : b ≠ t) (s : St R)
    (ht : s.reg t = 0) :
    Run (mCopy a b t) s ⟨update s.reg b (s.reg b + s.reg a), s.out⟩ (7 * s.reg a + 2) := by
  have h1 := run_move2 a b t hab hat hbt s
  have h2 := run_move t a (Ne.symm hat) ⟨update (update (update s.reg b (s.reg b + s.reg a)) t
    (s.reg t + s.reg a)) a 0, s.out⟩
  have := Run.seq h1 h2
  unfold mCopy
  convert this using 1
  · ext1
    · funext x; simp only [update_apply]; split_ifs <;> simp_all
    · rfl
  · simp [update_apply, hat.symm, hbt.symm, ht]; omega

lemma run_incs (r : Fin R) : ∀ (c : ℕ) (s : St R), s.reg r = 0 →
    Run (mIncs r c) s ⟨update s.reg r c, s.out⟩ (c + 1) := by
  intro c
  induction c with
  | zero =>
    intro s hs
    have := run_clear r s
    rw [hs] at this; simp only [mIncs]; simpa using this
  | succ c ih =>
    intro s hs
    have := Run.seq (ih s hs) (Run.inc r _)
    simp only [mIncs]
    convert this using 1
    ext1 <;> simp [St.inc]

/-- `loop a (dec a; dec b)`: `b := b - a; a := 0`. -/
lemma run_subloop (a b : Fin R) (hab : a ≠ b) (s : St R) :
    Run (.loop a (.seq (.dec a) (.dec b))) s
      ⟨update (update s.reg b (s.reg b - s.reg a)) a 0, s.out⟩ (3 * s.reg a + 1) := by
  refine run_loop_gen a _ (fun s => ⟨update (update s.reg b (s.reg b - s.reg a)) a 0, s.out⟩)
    (fun s => 3 * s.reg a + 1) (fun s h => ?_) (fun s h => by simp [h]) ?_ s
  · ext1
    · funext x; simp only [update_apply]; split_ifs <;> simp_all
    · rfl
  · intro s hs
    refine ⟨(s.dec a).dec b, 2, Run.seq (Run.dec a s) (Run.dec b _), ?_, ?_, ?_⟩
    · simp [St.dec, update_apply, hab]; omega
    · ext1
      · funext x; simp only [St.dec, update_apply]
        split_ifs <;> simp_all <;> omega
      · rfl
    · simp [St.dec, update_apply, hab]; omega

/-- `loop x (dec x; copy y g t)`: `g += x * y; x := 0`. -/
lemma run_mulloop (x y g t : Fin R) (hxy : x ≠ y) (hxg : x ≠ g) (hxt : x ≠ t) (hyg : y ≠ g)
    (hyt : y ≠ t) (hgt : g ≠ t) (s : St R) (hst : s.reg t = 0) :
    Run (.loop x (.seq (.dec x) (mCopy y g t))) s
      ⟨update (update s.reg g (s.reg g + s.reg x * s.reg y)) x 0, s.out⟩
      (s.reg x * (7 * s.reg y + 4) + 1) := by
  -- strengthen with the invariant `t = 0`
  have key : ∀ s : St R, s.reg t = 0 → Run (.loop x (.seq (.dec x) (mCopy y g t))) s
      ⟨update (update s.reg g (s.reg g + s.reg x * s.reg y)) x 0, s.out⟩
      (s.reg x * (7 * s.reg y + 4) + 1) := by
    intro s hs
    obtain ⟨k, hk⟩ : ∃ k, s.reg x = k := ⟨_, rfl⟩
    induction k generalizing s with
    | zero =>
      have : (⟨update (update s.reg g (s.reg g + s.reg x * s.reg y)) x 0, s.out⟩ : St R) = s := by
        ext1
        · funext z; simp only [update_apply]; split_ifs <;> simp_all
        · rfl
      rw [this, hk]; simpa using Run.loopZ (b := .seq (.dec x) (mCopy y g t)) hk
    | succ k ih =>
      have hc := run_copy y g t hyg hyt hgt (s.dec x) (by simp [St.dec, update_apply, hxt.symm, hs])
      have h1 := Run.seq (Run.dec x s) hc
      set s1 : St R := ⟨update (s.dec x).reg g ((s.dec x).reg g + (s.dec x).reg y), (s.dec x).out⟩
      have hk' : s1.reg x = k := by simp [s1, St.dec, update_apply, hxg, hk]
      have h2 := ih s1 (by simp [s1, St.dec, update_apply, hgt.symm, hxt.symm, hs]) hk'
      have := Run.loopS (by omega) h1 h2
      convert this using 1
      · ext1
        · funext z; simp only [s1, St.dec, update_apply]
          split_ifs <;> simp_all <;> ring
        · rfl
      · simp [s1, St.dec, update_apply, hxy.symm, hyg, hk, hxg, hxg.symm, hyg.symm]; ring
  exact key s hst

/-- Body of the division loop. -/
def divBody (x m c r t q : Fin R) : Prog R :=
  .seq (.dec x) (.seq (.inc r) (.seq (.dec c)
    (.ite c (.seq (.inc q) (.seq (mClear r) (mCopy m c t))) (.seq (.inc t) (.dec t)))))

lemma run_divloop (x m c r t q : Fin R) (hxm : x ≠ m) (hxc : x ≠ c) (hxr : x ≠ r) (hxt : x ≠ t)
    (hxq : x ≠ q) (hmc : m ≠ c) (hmr : m ≠ r) (hmt : m ≠ t) (hmq : m ≠ q) (hcr : c ≠ r)
    (hct : c ≠ t) (hcq : c ≠ q) (hrt : r ≠ t) (hrq : r ≠ q) (htq : t ≠ q) :
    ∀ (k : ℕ) (s : St R), s.reg x = k → 1 ≤ s.reg m → s.reg r + s.reg c = s.reg m → 1 ≤ s.reg c →
      s.reg t = 0 →
      ∃ T ≤ k * (9 * s.reg m + 12) + 1, Run (.loop x (divBody x m c r t q)) s
        ⟨update (update (update (update s.reg x 0) r ((s.reg r + k) % s.reg m)) c
          (s.reg m - (s.reg r + k) % s.reg m)) q (s.reg q + (s.reg r + k) / s.reg m), s.out⟩ T := by
  intro k
  induction k with
  | zero =>
    intro s hx hm hrc hc ht
    refine ⟨1, by omega, ?_⟩
    have hlt : s.reg r < s.reg m := by omega
    have : (⟨update (update (update (update s.reg x 0) r ((s.reg r + 0) % s.reg m)) c
          (s.reg m - (s.reg r + 0) % s.reg m)) q (s.reg q + (s.reg r + 0) / s.reg m), s.out⟩ : St R) = s := by
      ext1
      · funext z
        simp only [Nat.add_zero, Nat.mod_eq_of_lt hlt, Nat.div_eq_of_lt hlt, Nat.add_zero, update_apply]
        split_ifs <;> subst_vars <;> simp_all <;> omega
      · rfl
    rw [this]; exact Run.loopZ hx
  | succ k ih =>
    intro s hx hm hrc hc ht
    set M := s.reg m
    set sA := ((s.dec x).inc r).dec c with hsA
    have hA : Run (.seq (.dec x) (.seq (.inc r) (.dec c))) s sA 3 :=
      Run.seq (Run.dec x s) (Run.seq (Run.inc r _) (Run.dec c _))
    have eAx : sA.reg x = k := by simp [sA, St.dec, St.inc, update_apply, hxr, hxc]; omega
    have eAm : sA.reg m = M := by simp [sA, St.dec, St.inc, update_apply, hxm.symm, hmr, hmc, M]
    have eAr : sA.reg r = s.reg r + 1 := by simp [sA, St.dec, St.inc, update_apply, hxr.symm, hcr.symm]
    have eAc : sA.reg c = s.reg c - 1 := by simp [sA, St.dec, St.inc, update_apply, hxc.symm, hcr]
    have eAt : sA.reg t = 0 := by simp [sA, St.dec, St.inc, update_apply, hxt.symm, hrt.symm, hct.symm, ht]
    have eAq : sA.reg q = s.reg q := by simp [sA, St.dec, St.inc, update_apply, hxq.symm, hrq.symm, hcq.symm]
    have eAo : sA.out = s.out := rfl
    by_cases hc1 : s.reg c = 1
    · -- wrap around
      have hcz : sA.reg c = 0 := by omega
      have hB := Run.inc q sA
      set sB := sA.inc q
      have hC := run_clear r sB
      set sC : St R := ⟨update sB.reg r 0, sB.out⟩
      have hD := run_copy m c t hmc hmt hct sC (by simp [sC, sB, St.inc, update_apply, hrt.symm, htq, eAt])
      set sD : St R := ⟨update sC.reg c (sC.reg c + sC.reg m), sC.out⟩
      have eDx : sD.reg x = k := by simp [sD, sC, sB, St.inc, update_apply, hxc, hxr, hxq, eAx]
      have eDm : sD.reg m = M := by simp [sD, sC, sB, St.inc, update_apply, hmc, hmr, hmq, eAm]
      have eDr : sD.reg r = 0 := by simp [sD, sC, sB, update_apply, hcr.symm]
      have eDc : sD.reg c = M := by simp [sD, sC, sB, St.inc, update_apply, hcr, hcq, hcz, hmr, hmq, eAm]
      have eDt : sD.reg t = 0 := by simp [sD, sC, sB, St.inc, update_apply, hct.symm, hrt.symm, htq, eAt]
      have eDq : sD.reg q = s.reg q + 1 := by simp [sD, sC, sB, St.inc, update_apply, hcq.symm, hrq.symm, eAq]
      have e1 : sB.reg r = s.reg r + 1 := by simp [sB, St.inc, update_apply, hrq, eAr]
      have e2 : sC.reg m = M := by simp [sC, sB, St.inc, update_apply, hmr, hmq, eAm]
      obtain ⟨T, hT, hrun⟩ := ih sD eDx (by omega) (by omega) (by omega) eDt
      have hbody : Run (divBody x m c r t q) s sD
          (1 + (1 + (1 + ((1 + ((2 * sB.reg r + 1) + (7 * sC.reg m + 2))) + 1)))) :=
        Run.seq (Run.dec x s) (Run.seq (Run.inc r _) (Run.seq (Run.dec c _)
          (Run.iteZ (nz := .seq (.inc t) (.dec t)) hcz (Run.seq hB (Run.seq hC hD)))))
      have hr1 : s.reg r + 1 = M := by omega
      have heq : (⟨update (update (update (update sD.reg x 0) r ((sD.reg r + k) % sD.reg m)) c
          (sD.reg m - (sD.reg r + k) % sD.reg m)) q (sD.reg q + (sD.reg r + k) / sD.reg m), sD.out⟩ : St R) =
          ⟨update (update (update (update s.reg x 0) r ((s.reg r + (k + 1)) % M)) c
          (M - (s.reg r + (k + 1)) % M)) q (s.reg q + (s.reg r + (k + 1)) / M), s.out⟩ := by
        ext1
        · funext z
          have key1 : (sD.reg r + k) % sD.reg m = (s.reg r + (k + 1)) % M := by
            rw [eDr, eDm, show s.reg r + (k + 1) = k + M * 1 by omega, Nat.add_mul_mod_self_left]; simp
          have key2 : sD.reg q + (sD.reg r + k) / sD.reg m = s.reg q + (s.reg r + (k + 1)) / M := by
            rw [eDq, eDr, eDm, show s.reg r + (k + 1) = k + M * 1 by omega,
              Nat.add_mul_div_left _ _ (by omega)]; ring
          rw [key1, key2, eDm]
          simp only [update_apply]
          split_ifs <;> try rfl
          simp only [sD, sC, sB, sA, St.inc, St.dec, update_apply]
          split_ifs <;> simp_all
        · rfl
      rw [heq] at hrun
      refine ⟨_, ?_, Run.loopS (by omega) hbody hrun⟩
      rw [eDm] at hT; rw [e1, e2]; nlinarith
    · -- no wrap
      have hcnz : sA.reg c ≠ 0 := by omega
      have hbody : Run (divBody x m c r t q) s sA (1 + (1 + (1 + (2 + 1)))) := by
        have hs := Run.seq (Run.inc t sA) (Run.dec t _)
        have heq : (sA.inc t).dec t = sA := by ext1 <;> simp [St.inc, St.dec]
        rw [heq] at hs
        exact Run.seq (Run.dec x s) (Run.seq (Run.inc r _) (Run.seq (Run.dec c _)
          (Run.iteS (z := .seq (.inc q) (.seq (mClear r) (mCopy m c t))) hcnz hs)))
      obtain ⟨T, hT, hrun⟩ := ih sA eAx (by omega) (by omega) (by omega) eAt
      have heq : (⟨update (update (update (update sA.reg x 0) r ((sA.reg r + k) % sA.reg m)) c
          (sA.reg m - (sA.reg r + k) % sA.reg m)) q (sA.reg q + (sA.reg r + k) / sA.reg m), sA.out⟩ : St R) =
          ⟨update (update (update (update s.reg x 0) r ((s.reg r + (k + 1)) % M)) c
          (M - (s.reg r + (k + 1)) % M)) q (s.reg q + (s.reg r + (k + 1)) / M), s.out⟩ := by
        ext1
        · funext z
          have key1 : (sA.reg r + k) % sA.reg m = (s.reg r + (k + 1)) % M := by
            rw [eAr, eAm]; congr 1; omega
          have key2 : sA.reg q + (sA.reg r + k) / sA.reg m = s.reg q + (s.reg r + (k + 1)) / M := by
            rw [eAq, eAr, eAm]; congr 2; omega
          rw [key1, key2, eAm]
          simp only [update_apply]
          split_ifs <;> try rfl
          simp only [sA, St.inc, St.dec, update_apply]
          split_ifs <;> simp_all
        · rfl
      rw [heq] at hrun
      refine ⟨_, ?_, Run.loopS (by omega) hbody hrun⟩
      rw [eAm] at hT; nlinarith

/-- Division core: `q += x / m`, `r := x % m` (others cleared); requires `m ≥ 1`. -/
def divCore (x m c r t q : Fin R) : Prog R :=
  .seq (mCopy m c t) (.seq (.loop x (divBody x m c r t q)) (.seq (mClear c) (mClear m)))

lemma run_divcore (x m c r t q : Fin R) (hxm : x ≠ m) (hxc : x ≠ c) (hxr : x ≠ r) (hxt : x ≠ t)
    (hxq : x ≠ q) (hmc : m ≠ c) (hmr : m ≠ r) (hmt : m ≠ t) (hmq : m ≠ q) (hcr : c ≠ r)
    (hct : c ≠ t) (hcq : c ≠ q) (hrt : r ≠ t) (hrq : r ≠ q) (htq : t ≠ q) (s : St R)
    (hm : 1 ≤ s.reg m) (hc : s.reg c = 0) (hr : s.reg r = 0) (ht : s.reg t = 0) :
    ∃ T ≤ s.reg x * (9 * s.reg m + 12) + 11 * s.reg m + 10, Run (divCore x m c r t q) s
      ⟨update (update (update (update s.reg x 0) m 0) r (s.reg x % s.reg m)) q
        (s.reg q + s.reg x / s.reg m), s.out⟩ T := by
  set A := s.reg x
  set B := s.reg m
  have r1 := run_copy m c t hmc hmt hct s ht
  set s1 : St R := ⟨update s.reg c (s.reg c + s.reg m), s.out⟩
  obtain ⟨T, hT, r2⟩ := run_divloop x m c r t q hxm hxc hxr hxt hxq hmc hmr hmt hmq hcr hct hcq hrt hrq htq
    A s1 (by simp [s1, update_of_ne hxc, A]) (by simp [s1, update_of_ne hmc]; omega)
    (by simp [s1, update_of_ne hcr.symm, update_of_ne hmc, hc, hr])
    (by simp [s1, hc]; omega) (by simp [s1, update_of_ne hct.symm, ht])
  have e1m : s1.reg m = B := by simp [s1, update_of_ne hmc]; rfl
  have e1r : s1.reg r = 0 := by simp [s1, update_of_ne hcr.symm, hr]
  rw [e1m, e1r, Nat.zero_add] at r2
  set s2 : St R := ⟨update (update (update (update s1.reg x 0) r (A % B)) c (B - A % B)) q
    (s1.reg q + A / B), s1.out⟩
  have r3 := run_clear c s2
  set s3 : St R := ⟨update s2.reg c 0, s2.out⟩
  have r4 := run_clear m s3
  have hfin : (⟨update s3.reg m 0, s3.out⟩ : St R) =
      ⟨update (update (update (update s.reg x 0) m 0) r (A % B)) q (s.reg q + A / B), s.out⟩ := by
    ext1
    · funext z
      have e1q : s1.reg q = s.reg q := by simp [s1, update_of_ne hcq.symm]
      by_cases hz1 : z = m
      · subst hz1; simp [hmq, hmr]
      by_cases hz2 : z = q
      · subst hz2; simp [s3, s2, hz1, hmq.symm, hcq.symm, e1q]
      by_cases hz3 : z = r
      · subst hz3; simp [s3, s2, hz1, hz2, hcr.symm]
      by_cases hz4 : z = c
      · subst hz4; simp [s3, s2, hz1, hz2, hz3, hc, hxc.symm]
      by_cases hz5 : z = x
      · subst hz5; simp [s3, s2, hz1, hz2, hz3, hz4]
      · simp [s3, s2, s1, hz1, hz2, hz3, hz4, hz5]
    · rfl
  rw [hfin] at r4
  refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.seq r3 r4))⟩
  have e2c : s2.reg c ≤ B := by simp [s2, hcq]
  have e3m : s3.reg m = B := by simp [s3, s2, s1, hmc, hmq, hmr, update_of_ne hxm.symm]; rfl
  rw [e3m]
  have : s.reg c = 0 := hc
  simp only [this] at *
  nlinarith

end QEDTM


/-! # Arithmetic expressions compiled to the counter language -/

namespace QEDTM

open Function

/-- Expressions over `V` variables. `ite c a b` is `if c = 0 then a else b`. -/
inductive Exp (V : ℕ) where
  | var (i : Fin V)
  | const (c : ℕ)
  | add (a b : Exp V)
  | sub (a b : Exp V)
  | mul (a b : Exp V)
  | div (a b : Exp V)
  | mod (a b : Exp V)
  | ite (c a b : Exp V)

variable {V : ℕ}

def Exp.eval (env : Fin V → ℕ) : Exp V → ℕ
  | .var i => env i
  | .const c => c
  | .add a b => a.eval env + b.eval env
  | .sub a b => a.eval env - b.eval env
  | .mul a b => a.eval env * b.eval env
  | .div a b => a.eval env / b.eval env
  | .mod a b => a.eval env % b.eval env
  | .ite c a b => if c.eval env = 0 then a.eval env else b.eval env

/-- Scratch depth used. -/
def Exp.need : Exp V → ℕ
  | .var _ => 1
  | .const _ => 0
  | .add a b | .sub a b => max a.need (b.need + 1)
  | .mul a b => max (a.need + 2) (b.need + 2) + 1
  | .div a b | .mod a b => max (a.need + 6) (b.need + 6)
  | .ite c a b => max (c.need + 1) (max (a.need + 1) (b.need + 1))

/-- Time bound. -/
def Exp.tb (env : Fin V → ℕ) : Exp V → ℕ
  | .var i => 7 * env i + 2
  | .const c => c + 1
  | .add a b => a.tb env + b.tb env + 3 * b.eval env + 1
  | .sub a b => a.tb env + b.tb env + 3 * b.eval env + 1
  | .mul a b => a.tb env + b.tb env + a.eval env * (7 * b.eval env + 4) + 2 * b.eval env + 3
  | .div a b | .mod a b =>
      a.tb env + b.tb env + a.eval env * (9 * b.eval env + 12) + 30 * b.eval env + 3 * a.eval env + 40
  | .ite c a b => c.tb env + a.tb env + b.tb env + 2 * c.eval env + 3

/-! Register layout: `0` input, `1 … V` variables, `V+1 … V+D` scratch. -/

variable (D : ℕ)

abbrev Rg (V D : ℕ) := V + 1 + D

def vreg (i : Fin V) : Fin (Rg V D) := ⟨i.val + 1, by have := i.2; unfold Rg; omega⟩

def sreg (d : ℕ) : Fin (Rg V D) := ⟨(V + 1 + d) % (Rg V D), Nat.mod_lt _ (by unfold Rg; omega)⟩

variable {D}

lemma sreg_val {d : ℕ} (hd : d < D) : (sreg (V := V) D d).val = V + 1 + d := by
  show (V + 1 + d) % (V + 1 + D) = V + 1 + d
  exact Nat.mod_eq_of_lt (by omega)

lemma sreg_ne_vreg {d : ℕ} (hd : d < D) (i : Fin V) : sreg (V := V) D d ≠ vreg D i := by
  intro h
  have h1 := congrArg Fin.val h
  rw [sreg_val hd] at h1
  have h2 : (vreg (V := V) D i).val = i.val + 1 := rfl
  have := i.2
  omega

lemma sreg_inj {d d' : ℕ} (hd : d < D) (hd' : d' < D) (h : sreg (V := V) D d = sreg D d') : d = d' := by
  have := congrArg Fin.val h; rw [sreg_val hd, sreg_val hd'] at this; omega

lemma sreg_ne {d d' : ℕ} (hd : d < D) (hd' : d' < D) (h : d ≠ d') : sreg (V := V) D d ≠ sreg D d' :=
  fun h' => h (sreg_inj hd hd' h')

/-- `skip` using a register (net no-op). -/
def mSkip {R : ℕ} (t : Fin R) : Prog R := .seq (.inc t) (.dec t)

lemma run_skip {R : ℕ} (t : Fin R) (s : St R) : Run (mSkip t) s s 2 := by
  have := Run.seq (Run.inc t s) (Run.dec t _)
  unfold mSkip
  convert this using 1
  ext1 <;> simp [St.inc, St.dec]

variable (D) in
/-- Compile `e` into scratch register `tg` using scratch levels `≥ d`. -/
def cE : Exp V → ℕ → ℕ → Prog (Rg V D)
  | .var i, tg, d => mCopy (vreg D i) (sreg D tg) (sreg D d)
  | .const c, tg, _ => mIncs (sreg D tg) c
  | .add a b, tg, d => .seq (cE a tg d) (.seq (cE b d (d + 1)) (mMove (sreg D d) (sreg D tg)))
  | .sub a b, tg, d => .seq (cE a tg d) (.seq (cE b d (d + 1))
      (.loop (sreg D d) (.seq (.dec (sreg D d)) (.dec (sreg D tg)))))
  | .mul a b, tg, d => .seq (cE a d (d + 2)) (.seq (cE b (d + 1) (d + 2))
      (.seq (.loop (sreg D d) (.seq (.dec (sreg D d)) (mCopy (sreg D (d + 1)) (sreg D tg) (sreg D (d + 2)))))
        (mClear (sreg D (d + 1)))))
  | .div a b, tg, d =>
      .seq (cE a d (d + 6)) (.seq (cE b (d + 1) (d + 6))
        (.ite (sreg D (d + 1)) (mClear (sreg D d))
          (.seq (divCore (sreg D d) (sreg D (d + 1)) (sreg D (d + 2)) (sreg D (d + 3)) (sreg D (d + 4))
            (sreg D tg)) (mClear (sreg D (d + 3))))))
  | .mod a b, tg, d =>
      .seq (cE a d (d + 6)) (.seq (cE b (d + 1) (d + 6))
        (.ite (sreg D (d + 1)) (mMove (sreg D d) (sreg D tg))
          (.seq (divCore (sreg D d) (sreg D (d + 1)) (sreg D (d + 2)) (sreg D (d + 3)) (sreg D (d + 4))
            (sreg D (d + 5))) (.seq (mMove (sreg D (d + 3)) (sreg D tg)) (mClear (sreg D (d + 5)))))))
  | .ite c a b, tg, d => .seq (cE c d (d + 1))
      (.ite (sreg D d) (cE a tg (d + 1)) (.seq (mClear (sreg D d)) (cE b tg (d + 1))))

/-- Variable values read from the variable registers. -/
def envOf (s : St (Rg V D)) : Fin V → ℕ := fun i => s.reg (vreg D i)

lemma envOf_update (s : St (Rg V D)) {j : ℕ} (hj : j < D) (v : ℕ) (o : List Bool) :
    envOf (D := D) ⟨update s.reg (sreg D j) v, o⟩ = envOf s := by
  funext i; simp only [envOf]; exact update_of_ne (sreg_ne_vreg hj i).symm _ _

/-- Specification of `cE` for an expression. -/
def Spec (e : Exp V) : Prop := ∀ (tg d : ℕ), tg < d → d + e.need ≤ D → ∀ (s : St (Rg V D)),
    s.reg (sreg D tg) = 0 → (∀ j, d ≤ j → j < D → s.reg (sreg D j) = 0) →
    ∃ t ≤ e.tb (envOf s), Run (cE D e tg d) s
      ⟨update s.reg (sreg D tg) (e.eval (envOf s)), s.out⟩ t

lemma spec_var (i : Fin V) : Spec (D := D) (.var i) := by
  intro tg d htg hD s h0 hs
  have hdD : d < D := by simp [Exp.need] at hD; omega
  have h := run_copy (vreg D i) (sreg D tg) (sreg D d) (sreg_ne_vreg (by omega) i).symm
    (sreg_ne_vreg hdD i).symm (sreg_ne (by omega) hdD (by omega)) s (hs d le_rfl hdD)
  refine ⟨_, le_refl _, ?_⟩
  simpa [cE, Exp.eval, Exp.tb, envOf, h0] using h

lemma spec_const (c : ℕ) : Spec (V := V) (D := D) (.const c) := by
  intro tg d htg hD s h0 hs
  exact ⟨_, le_refl _, by simpa [cE, Exp.eval, Exp.tb] using run_incs (sreg D tg) c s h0⟩

lemma spec_add {a b : Exp V} (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.add a b) := by
  intro tg d htg hD s h0 hs
  simp only [Exp.need] at hD
  have := le_max_left a.need (b.need + 1); have := le_max_right a.need (b.need + 1)
  have hdD : d < D := by omega
  have htD : tg < D := by omega
  have hne : sreg (V := V) D d ≠ sreg D tg := sreg_ne hdD htD (by omega)
  obtain ⟨t1, ht1, r1⟩ := iha tg d htg (by omega) s h0 hs
  set s1 : St (Rg V D) := ⟨update s.reg (sreg D tg) (a.eval (envOf s)), s.out⟩
  have e1 : envOf s1 = envOf s := envOf_update s htD _ _
  obtain ⟨t2, ht2, r2⟩ := ihb d (d + 1) (by omega) (by omega) s1
    (by simp [s1, update_of_ne hne, hs d le_rfl hdD])
    (fun j hj hjD => by simp [s1, update_of_ne (sreg_ne hjD htD (by omega)), hs j (by omega) hjD])
  set s2 : St (Rg V D) := ⟨update s1.reg (sreg D d) (b.eval (envOf s1)), s1.out⟩
  have r3 := run_move (sreg D d) (sreg D tg) hne s2
  have hfin : (⟨update (update s2.reg (sreg D tg) (s2.reg (sreg D tg) + s2.reg (sreg D d))) (sreg D d) 0,
      s2.out⟩ : St (Rg V D)) = ⟨update s.reg (sreg D tg) ((a.add b).eval (envOf s)), s.out⟩ := by
    ext1
    · funext x
      simp only [s2, s1, e1, Exp.eval, update_apply]
      split_ifs <;> simp_all [hs d le_rfl hdD, Nat.add_comm]
    · rfl
  rw [hfin] at r3
  refine ⟨_, ?_, Run.seq r1 (Run.seq r2 r3)⟩
  rw [e1] at ht2
  simp only [Exp.tb, s2, s1, e1, update_self]; omega

lemma spec_sub {a b : Exp V} (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.sub a b) := by
  intro tg d htg hD s h0 hs
  simp only [Exp.need] at hD
  have := le_max_left a.need (b.need + 1); have := le_max_right a.need (b.need + 1)
  have hdD : d < D := by omega
  have htD : tg < D := by omega
  have hne : sreg (V := V) D d ≠ sreg D tg := sreg_ne hdD htD (by omega)
  obtain ⟨t1, ht1, r1⟩ := iha tg d htg (by omega) s h0 hs
  set s1 : St (Rg V D) := ⟨update s.reg (sreg D tg) (a.eval (envOf s)), s.out⟩
  have e1 : envOf s1 = envOf s := envOf_update s htD _ _
  obtain ⟨t2, ht2, r2⟩ := ihb d (d + 1) (by omega) (by omega) s1
    (by simp [s1, update_of_ne hne, hs d le_rfl hdD])
    (fun j hj hjD => by simp [s1, update_of_ne (sreg_ne hjD htD (by omega)), hs j (by omega) hjD])
  set s2 : St (Rg V D) := ⟨update s1.reg (sreg D d) (b.eval (envOf s1)), s1.out⟩
  have r3 := run_subloop (sreg D d) (sreg D tg) hne s2
  have hfin : (⟨update (update s2.reg (sreg D tg) (s2.reg (sreg D tg) - s2.reg (sreg D d))) (sreg D d) 0,
      s2.out⟩ : St (Rg V D)) = ⟨update s.reg (sreg D tg) ((a.sub b).eval (envOf s)), s.out⟩ := by
    ext1
    · funext x
      simp only [s2, s1, e1, Exp.eval, update_apply]
      split_ifs <;> simp_all [hs d le_rfl hdD]
    · rfl
  rw [hfin] at r3
  refine ⟨_, ?_, Run.seq r1 (Run.seq r2 r3)⟩
  rw [e1] at ht2
  simp only [Exp.tb, s2, s1, e1, update_self]; omega

lemma spec_mul {a b : Exp V} (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.mul a b) := by
  intro tg d htg hD s h0 hs
  simp only [Exp.need] at hD
  have := le_max_left (a.need + 2) (b.need + 2); have := le_max_right (a.need + 2) (b.need + 2)
  have hdD : d + 2 < D := by omega
  have htD : tg < D := by omega
  have n01 : sreg (V := V) D d ≠ sreg D (d + 1) := sreg_ne (by omega) (by omega) (by omega)
  have n0t : sreg (V := V) D d ≠ sreg D tg := sreg_ne (by omega) htD (by omega)
  have n02 : sreg (V := V) D d ≠ sreg D (d + 2) := sreg_ne (by omega) (by omega) (by omega)
  have n1t : sreg (V := V) D (d + 1) ≠ sreg D tg := sreg_ne (by omega) htD (by omega)
  have n12 : sreg (V := V) D (d + 1) ≠ sreg D (d + 2) := sreg_ne (by omega) (by omega) (by omega)
  have nt2 : sreg (V := V) D tg ≠ sreg D (d + 2) := sreg_ne htD (by omega) (by omega)
  have z0 := hs d le_rfl (by omega)
  have z1 := hs (d + 1) (by omega) (by omega)
  have z2 := hs (d + 2) (by omega) (by omega)
  obtain ⟨t1, ht1, r1⟩ := iha d (d + 2) (by omega) (by omega) s z0 (fun j hj hjD => hs j (by omega) hjD)
  set A := a.eval (envOf s)
  set s1 : St (Rg V D) := ⟨update s.reg (sreg D d) A, s.out⟩
  have e1 : envOf s1 = envOf s := envOf_update s (by omega) _ _
  obtain ⟨t2, ht2, r2⟩ := ihb (d + 1) (d + 2) (by omega) (by omega) s1
    (by simp [s1, update_of_ne n01.symm, z1])
    (fun j hj hjD => by
      simp [s1, update_of_ne (sreg_ne hjD (by omega) (by omega) : sreg (V := V) D j ≠ sreg D d), hs j (by omega) hjD])
  set B := b.eval (envOf s1)
  set s2 : St (Rg V D) := ⟨update s1.reg (sreg D (d + 1)) B, s1.out⟩
  have r3 := run_mulloop (sreg D d) (sreg D (d + 1)) (sreg D tg) (sreg D (d + 2)) n01 n0t n02 n1t n12 nt2 s2
    (by simp [s2, s1, update_of_ne n12.symm, update_of_ne n02.symm, z2])
  set s3 : St (Rg V D) := ⟨update (update s2.reg (sreg D tg) (s2.reg (sreg D tg) + s2.reg (sreg D d) * s2.reg (sreg D (d + 1)))) (sreg D d) 0, s2.out⟩
  have r4 := run_clear (sreg D (d + 1)) s3
  have hfin : (⟨update s3.reg (sreg D (d + 1)) 0, s3.out⟩ : St (Rg V D)) =
      ⟨update s.reg (sreg D tg) ((a.mul b).eval (envOf s)), s.out⟩ := by
    ext1
    · funext x
      simp only [s3, s2, s1, e1, Exp.eval, update_apply, A, B]
      split_ifs <;> simp_all
    · rfl
  rw [hfin] at r4
  refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.seq r3 r4))⟩
  have q1 : s2.reg (sreg D d) = A := by simp [s2, s1, update_of_ne n01]
  have q2 : s2.reg (sreg D (d + 1)) = B := by simp [s2]
  have q3 : s3.reg (sreg D (d + 1)) = B := by simp [s3, update_of_ne n01.symm, update_of_ne n1t, q2]
  rw [q1, q2, q3]
  rw [e1] at ht2
  have hB : B = b.eval (envOf s) := by simp only [B, e1]
  simp only [Exp.tb]
  rw [← hB]
  linarith

lemma spec_div {a b : Exp V} (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.div a b) := by
    intro tg d htg hD s h0 hs
    simp only [Exp.need] at hD
    have := le_max_left (a.need + 6) (b.need + 6); have := le_max_right (a.need + 6) (b.need + 6)
    have sn : ∀ i j, i < D → j < D → i ≠ j → sreg (V := V) D i ≠ sreg D j := fun i j hi hj h => sreg_ne hi hj h
    have n01 := sn d (d + 1) (by omega) (by omega) (by omega)
    have n02 := sn d (d + 2) (by omega) (by omega) (by omega)
    have n03 := sn d (d + 3) (by omega) (by omega) (by omega)
    have n04 := sn d (d + 4) (by omega) (by omega) (by omega)
    have n05 := sn d (d + 5) (by omega) (by omega) (by omega)
    have n0t := sn d tg (by omega) (by omega) (by omega)
    have n12 := sn (d + 1) (d + 2) (by omega) (by omega) (by omega)
    have n13 := sn (d + 1) (d + 3) (by omega) (by omega) (by omega)
    have n14 := sn (d + 1) (d + 4) (by omega) (by omega) (by omega)
    have n15 := sn (d + 1) (d + 5) (by omega) (by omega) (by omega)
    have n1t := sn (d + 1) tg (by omega) (by omega) (by omega)
    have n23 := sn (d + 2) (d + 3) (by omega) (by omega) (by omega)
    have n24 := sn (d + 2) (d + 4) (by omega) (by omega) (by omega)
    have n25 := sn (d + 2) (d + 5) (by omega) (by omega) (by omega)
    have n2t := sn (d + 2) tg (by omega) (by omega) (by omega)
    have n34 := sn (d + 3) (d + 4) (by omega) (by omega) (by omega)
    have n35 := sn (d + 3) (d + 5) (by omega) (by omega) (by omega)
    have n3t := sn (d + 3) tg (by omega) (by omega) (by omega)
    have n45 := sn (d + 4) (d + 5) (by omega) (by omega) (by omega)
    have n4t := sn (d + 4) tg (by omega) (by omega) (by omega)
    have n5t := sn (d + 5) tg (by omega) (by omega) (by omega)
    have z0 := hs d le_rfl (by omega)
    have z1 := hs (d + 1) (by omega) (by omega)
    have z2 := hs (d + 2) (by omega) (by omega)
    have z3 := hs (d + 3) (by omega) (by omega)
    have z4 := hs (d + 4) (by omega) (by omega)
    have z5 := hs (d + 5) (by omega) (by omega)
    obtain ⟨t1, ht1, r1⟩ := iha d (d + 6) (by omega) (by omega) s z0 (fun j hj hjD => hs j (by omega) hjD)
    set A := a.eval (envOf s)
    set s1 : St (Rg V D) := ⟨update s.reg (sreg D d) A, s.out⟩
    have e1 : envOf s1 = envOf s := envOf_update s (by omega) _ _
    obtain ⟨t2, ht2, r2⟩ := ihb (d + 1) (d + 6) (by omega) (by omega) s1
      (by simp [s1, update_of_ne n01.symm, z1])
      (fun j hj hjD => by
        simp [s1, update_of_ne (sn j d hjD (by omega) (by omega)), hs j (by omega) hjD])
    rw [e1] at r2 ht2
    set B := b.eval (envOf s)
    set s2 : St (Rg V D) := ⟨update s1.reg (sreg D (d + 1)) B, s1.out⟩
    have q0 : s2.reg (sreg D d) = A := by simp [s2, s1, update_of_ne n01]
    have q1 : s2.reg (sreg D (d + 1)) = B := by simp [s2]
    have q2 : s2.reg (sreg D (d + 2)) = 0 := by simp [s2, s1, update_of_ne n12.symm, update_of_ne n02.symm, z2]
    have q3 : s2.reg (sreg D (d + 3)) = 0 := by simp [s2, s1, update_of_ne n13.symm, update_of_ne n03.symm, z3]
    have q4 : s2.reg (sreg D (d + 4)) = 0 := by simp [s2, s1, update_of_ne n14.symm, update_of_ne n04.symm, z4]
    have q5 : s2.reg (sreg D (d + 5)) = 0 := by simp [s2, s1, update_of_ne n15.symm, update_of_ne n05.symm, z5]
    have qt : s2.reg (sreg D tg) = 0 := by simp [s2, s1, update_of_ne n1t.symm, update_of_ne n0t.symm, h0]
    by_cases hB0 : B = 0
    · have r3 := run_clear (sreg D d) s2
      have hfin : (⟨update s2.reg (sreg D d) 0, s2.out⟩ : St (Rg V D)) =
          ⟨update s.reg (sreg D tg) ((a.div b).eval (envOf s)), s.out⟩ := by
        ext1
        · funext z
          simp only [Exp.eval]; rw [show b.eval (envOf s) = 0 from hB0, Nat.div_zero]
          by_cases hz0 : z = sreg D d
          · subst hz0; simp [n0t, z0]
          by_cases hz1 : z = sreg D (d + 1)
          · subst hz1; simp [s2, n1t, hz0, hB0, z1]
          by_cases hzt : z = sreg D tg
          · subst hzt; simp [s2, s1, hz0, hz1, h0]
          · simp [s2, s1, hz0, hz1, hzt]
        · rfl
      rw [hfin] at r3
      refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.iteZ (by rw [q1, hB0]) r3))⟩
      rw [q0]; simp only [Exp.tb]; omega
    · obtain ⟨T, hT, r3⟩ := run_divcore (sreg D d) (sreg D (d + 1)) (sreg D (d + 2)) (sreg D (d + 3))
        (sreg D (d + 4)) (sreg D tg) n01 n02 n03 n04 n0t n12 n13 n14 n1t n23 n24 n2t n34 n3t n4t s2
        (by rw [q1]; omega) q2 q3 q4
      rw [q0, q1] at hT; rw [q0, q1, qt, Nat.zero_add] at r3
      set s3 : St (Rg V D) := ⟨update (update (update (update s2.reg (sreg D d) 0) (sreg D (d + 1)) 0)
        (sreg D (d + 3)) (A % B)) (sreg D tg) (A / B), s2.out⟩
      have r4 := run_clear (sreg D (d + 3)) s3
      have hfin : (⟨update s3.reg (sreg D (d + 3)) 0, s3.out⟩ : St (Rg V D)) =
          ⟨update s.reg (sreg D tg) ((a.div b).eval (envOf s)), s.out⟩ := by
        ext1
        · funext z
          simp only [Exp.eval]
          by_cases hz3 : z = sreg D (d + 3)
          · subst hz3; simp [n3t, z3]
          by_cases hzt : z = sreg D tg
          · subst hzt; simp [s3, hz3]; rfl
          by_cases hz1 : z = sreg D (d + 1)
          · subst hz1; simp [s3, hz3, hzt, z1]
          by_cases hz0 : z = sreg D d
          · subst hz0; simp [s3, hz3, hzt, hz1, z0]
          · simp [s3, s2, s1, hz0, hz1, hz3, hzt]
        · rfl
      rw [hfin] at r4
      refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.iteS (by rw [q1]; exact hB0) (Run.seq r3 r4)))⟩
      have : s3.reg (sreg D (d + 3)) = A % B := by simp [s3, n3t]
      rw [this]
      have hm : A % B < B := Nat.mod_lt _ (by omega)
      simp only [Exp.tb]; nlinarith

lemma spec_mod {a b : Exp V} (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.mod a b) := by
    intro tg d htg hD s h0 hs
    simp only [Exp.need] at hD
    have := le_max_left (a.need + 6) (b.need + 6); have := le_max_right (a.need + 6) (b.need + 6)
    have sn : ∀ i j, i < D → j < D → i ≠ j → sreg (V := V) D i ≠ sreg D j := fun i j hi hj h => sreg_ne hi hj h
    have n01 := sn d (d + 1) (by omega) (by omega) (by omega)
    have n02 := sn d (d + 2) (by omega) (by omega) (by omega)
    have n03 := sn d (d + 3) (by omega) (by omega) (by omega)
    have n04 := sn d (d + 4) (by omega) (by omega) (by omega)
    have n05 := sn d (d + 5) (by omega) (by omega) (by omega)
    have n0t := sn d tg (by omega) (by omega) (by omega)
    have n12 := sn (d + 1) (d + 2) (by omega) (by omega) (by omega)
    have n13 := sn (d + 1) (d + 3) (by omega) (by omega) (by omega)
    have n14 := sn (d + 1) (d + 4) (by omega) (by omega) (by omega)
    have n15 := sn (d + 1) (d + 5) (by omega) (by omega) (by omega)
    have n1t := sn (d + 1) tg (by omega) (by omega) (by omega)
    have n23 := sn (d + 2) (d + 3) (by omega) (by omega) (by omega)
    have n24 := sn (d + 2) (d + 4) (by omega) (by omega) (by omega)
    have n25 := sn (d + 2) (d + 5) (by omega) (by omega) (by omega)
    have n2t := sn (d + 2) tg (by omega) (by omega) (by omega)
    have n34 := sn (d + 3) (d + 4) (by omega) (by omega) (by omega)
    have n35 := sn (d + 3) (d + 5) (by omega) (by omega) (by omega)
    have n3t := sn (d + 3) tg (by omega) (by omega) (by omega)
    have n45 := sn (d + 4) (d + 5) (by omega) (by omega) (by omega)
    have n4t := sn (d + 4) tg (by omega) (by omega) (by omega)
    have n5t := sn (d + 5) tg (by omega) (by omega) (by omega)
    have z0 := hs d le_rfl (by omega)
    have z1 := hs (d + 1) (by omega) (by omega)
    have z2 := hs (d + 2) (by omega) (by omega)
    have z3 := hs (d + 3) (by omega) (by omega)
    have z4 := hs (d + 4) (by omega) (by omega)
    have z5 := hs (d + 5) (by omega) (by omega)
    obtain ⟨t1, ht1, r1⟩ := iha d (d + 6) (by omega) (by omega) s z0 (fun j hj hjD => hs j (by omega) hjD)
    set A := a.eval (envOf s)
    set s1 : St (Rg V D) := ⟨update s.reg (sreg D d) A, s.out⟩
    have e1 : envOf s1 = envOf s := envOf_update s (by omega) _ _
    obtain ⟨t2, ht2, r2⟩ := ihb (d + 1) (d + 6) (by omega) (by omega) s1
      (by simp [s1, update_of_ne n01.symm, z1])
      (fun j hj hjD => by
        simp [s1, update_of_ne (sn j d hjD (by omega) (by omega)), hs j (by omega) hjD])
    rw [e1] at r2 ht2
    set B := b.eval (envOf s)
    set s2 : St (Rg V D) := ⟨update s1.reg (sreg D (d + 1)) B, s1.out⟩
    have q0 : s2.reg (sreg D d) = A := by simp [s2, s1, update_of_ne n01]
    have q1 : s2.reg (sreg D (d + 1)) = B := by simp [s2]
    have q2 : s2.reg (sreg D (d + 2)) = 0 := by simp [s2, s1, update_of_ne n12.symm, update_of_ne n02.symm, z2]
    have q3 : s2.reg (sreg D (d + 3)) = 0 := by simp [s2, s1, update_of_ne n13.symm, update_of_ne n03.symm, z3]
    have q4 : s2.reg (sreg D (d + 4)) = 0 := by simp [s2, s1, update_of_ne n14.symm, update_of_ne n04.symm, z4]
    have q5 : s2.reg (sreg D (d + 5)) = 0 := by simp [s2, s1, update_of_ne n15.symm, update_of_ne n05.symm, z5]
    have qt : s2.reg (sreg D tg) = 0 := by simp [s2, s1, update_of_ne n1t.symm, update_of_ne n0t.symm, h0]
    by_cases hB0 : B = 0
    · have r3 := run_move (sreg D d) (sreg D tg) n0t s2
      have hfin : (⟨update (update s2.reg (sreg D tg) (s2.reg (sreg D tg) + s2.reg (sreg D d))) (sreg D d) 0,
          s2.out⟩ : St (Rg V D)) = ⟨update s.reg (sreg D tg) ((a.mod b).eval (envOf s)), s.out⟩ := by
        ext1
        · funext z
          rw [qt, q0]
          simp only [Exp.eval]; rw [show b.eval (envOf s) = 0 from hB0, Nat.mod_zero]
          by_cases hz0 : z = sreg D d
          · subst hz0; simp [n0t, z0]
          by_cases hzt : z = sreg D tg
          · subst hzt; simp [hz0]; rfl
          by_cases hz1 : z = sreg D (d + 1)
          · subst hz1; simp [s2, hz0, hzt, hB0, z1]
          · simp [s2, s1, hz0, hz1, hzt]
        · rfl
      rw [hfin] at r3
      refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.iteZ (by rw [q1, hB0]) r3))⟩
      rw [q0]; simp only [Exp.tb]; omega
    · obtain ⟨T, hT, r3⟩ := run_divcore (sreg D d) (sreg D (d + 1)) (sreg D (d + 2)) (sreg D (d + 3))
        (sreg D (d + 4)) (sreg D (d + 5)) n01 n02 n03 n04 n05 n12 n13 n14 n15 n23 n24 n25 n34 n35 n45 s2
        (by rw [q1]; omega) q2 q3 q4
      rw [q0, q1] at hT; rw [q0, q1, q5, Nat.zero_add] at r3
      set s3 : St (Rg V D) := ⟨update (update (update (update s2.reg (sreg D d) 0) (sreg D (d + 1)) 0)
        (sreg D (d + 3)) (A % B)) (sreg D (d + 5)) (A / B), s2.out⟩
      have r4 := run_move (sreg D (d + 3)) (sreg D tg) n3t s3
      set s4 : St (Rg V D) := ⟨update (update s3.reg (sreg D tg) (s3.reg (sreg D tg) + s3.reg (sreg D (d + 3))))
        (sreg D (d + 3)) 0, s3.out⟩
      have r5 := run_clear (sreg D (d + 5)) s4
      have hfin : (⟨update s4.reg (sreg D (d + 5)) 0, s4.out⟩ : St (Rg V D)) =
          ⟨update s.reg (sreg D tg) ((a.mod b).eval (envOf s)), s.out⟩ := by
        ext1
        · funext z
          simp only [Exp.eval]
          by_cases hz5 : z = sreg D (d + 5)
          · subst hz5; simp [n5t, z5]
          by_cases hz3 : z = sreg D (d + 3)
          · subst hz3; simp [s4, hz5, n3t, z3, n35]
          by_cases hzt : z = sreg D tg
          · subst hzt; simp [s4, s3, hz5, hz3, qt, n3t.symm, n5t.symm, n1t.symm, n0t.symm, update_of_ne n35]; rfl
          by_cases hz1 : z = sreg D (d + 1)
          · subst hz1; simp [s4, s3, hz3, hzt, hz5, z1]
          by_cases hz0 : z = sreg D d
          · subst hz0; simp [s4, s3, hz3, hzt, hz5, hz1, z0]
          · simp [s4, s3, s2, s1, hz0, hz1, hz3, hzt, hz5]
        · rfl
      rw [hfin] at r5
      refine ⟨_, ?_, Run.seq r1 (Run.seq r2 (Run.iteS (by rw [q1]; exact hB0) (Run.seq r3 (Run.seq r4 r5))))⟩
      have e3 : s3.reg (sreg D (d + 3)) = A % B := by simp [s3, n35]
      have e4 : s4.reg (sreg D (d + 5)) = A / B := by simp [s4, s3, n35.symm, n5t]
      rw [e3, e4]
      have hm : A % B < B := Nat.mod_lt _ (by omega)
      have hd : A / B ≤ A := Nat.div_le_self _ _
      simp only [Exp.tb]; nlinarith

lemma spec_ite {c a b : Exp V} (ihc : Spec (D := D) c) (iha : Spec (D := D) a) (ihb : Spec (D := D) b) : Spec (D := D) (.ite c a b) := by
  intro tg d htg hD s h0 hs
  simp only [Exp.need] at hD
  have := le_max_left (c.need + 1) (max (a.need + 1) (b.need + 1))
  have := le_max_right (c.need + 1) (max (a.need + 1) (b.need + 1))
  have := le_max_left (a.need + 1) (b.need + 1); have := le_max_right (a.need + 1) (b.need + 1)
  have hdD : d < D := by omega
  have htD : tg < D := by omega
  have z0 := hs d le_rfl hdD
  obtain ⟨t1, ht1, r1⟩ := ihc d (d + 1) (by omega) (by omega) s z0 (fun j hj hjD => hs j (by omega) hjD)
  set C := c.eval (envOf s)
  by_cases hC : C = 0
  · have hs1 : (⟨update s.reg (sreg D d) C, s.out⟩ : St (Rg V D)) = s := by
      ext1
      · funext x; simp only [update_apply, hC]; split_ifs with h <;> simp_all
      · rfl
    obtain ⟨t2, ht2, r2⟩ := iha tg (d + 1) (by omega) (by omega) s h0 (fun j hj hjD => hs j (by omega) hjD)
    rw [hs1] at r1
    have hfin : (⟨update s.reg (sreg D tg) (a.eval (envOf s)), s.out⟩ : St (Rg V D)) =
        ⟨update s.reg (sreg D tg) ((c.ite a b).eval (envOf s)), s.out⟩ := by
      simp only [Exp.eval]; rw [if_pos hC]
    rw [hfin] at r2
    refine ⟨_, ?_, Run.seq r1 (Run.iteZ z0 r2)⟩
    simp only [Exp.tb]; omega
  · have r2 := run_clear (sreg D d) ⟨update s.reg (sreg D d) C, s.out⟩
    have hs2 : (⟨update (update s.reg (sreg D d) C) (sreg D d) 0, s.out⟩ : St (Rg V D)) = s := by
      ext1
      · funext x; simp only [update_apply]; split_ifs with h <;> simp_all
      · rfl
    simp only [update_self] at r2
    rw [hs2] at r2
    obtain ⟨t3, ht3, r3⟩ := ihb tg (d + 1) (by omega) (by omega) s h0 (fun j hj hjD => hs j (by omega) hjD)
    have hfin : (⟨update s.reg (sreg D tg) (b.eval (envOf s)), s.out⟩ : St (Rg V D)) =
        ⟨update s.reg (sreg D tg) ((c.ite a b).eval (envOf s)), s.out⟩ := by
      simp only [Exp.eval]; rw [if_neg hC]
    rw [hfin] at r3
    refine ⟨_, ?_, Run.seq r1 (Run.iteS (by simpa using hC) (Run.seq r2 r3))⟩
    simp only [Exp.tb]; omega

/-- Correctness of the expression compiler. -/
theorem cE_spec (e : Exp V) : Spec (D := D) e := by
  induction e with
  | var i => exact spec_var i
  | const c => exact spec_const c
  | add a b iha ihb => exact spec_add iha ihb
  | sub a b iha ihb => exact spec_sub iha ihb
  | mul a b iha ihb => exact spec_mul iha ihb
  | div a b iha ihb => exact spec_div iha ihb
  | mod a b iha ihb => exact spec_mod iha ihb
  | ite c a b ihc iha ihb => exact spec_ite ihc iha ihb

end QEDTM


/-! # Polynomial bounds for expression values and running time -/

namespace QEDTM

variable {V : ℕ}

/-- Exponent bound: with all variables `≤ N` and `X = N + 2`, both value and time are `≤ X ^ bnd`. -/
def Exp.bnd : Exp V → ℕ
  | .var _ => 3
  | .const c => c + 1
  | .add a b | .sub a b => max a.bnd b.bnd + 3
  | .mul a b => a.bnd + b.bnd + 5
  | .div a b | .mod a b => a.bnd + b.bnd + 7
  | .ite c a b => max c.bnd (max a.bnd b.bnd) + 3

lemma le_pow_self_of_two {X : ℕ} (hX : 2 ≤ X) (c : ℕ) : c + 1 ≤ X ^ (c + 1) := by
  calc c + 1 ≤ 2 ^ (c + 1) := Nat.lt_two_pow_self.le.trans' (by omega)
    _ ≤ X ^ (c + 1) := Nat.pow_le_pow_left hX _

lemma pow_mono' {X : ℕ} (hX : 2 ≤ X) {a b : ℕ} (h : a ≤ b) : X ^ a ≤ X ^ b :=
  Nat.pow_le_pow_right (by omega) h

lemma mul_pow_le {X : ℕ} (hX : 2 ≤ X) (k m j : ℕ) (hk : k ≤ 2 ^ j) : k * X ^ m ≤ X ^ (m + j) := by
  rw [pow_add]
  calc k * X ^ m ≤ 2 ^ j * X ^ m := Nat.mul_le_mul_right _ hk
    _ ≤ X ^ j * X ^ m := Nat.mul_le_mul_right _ (Nat.pow_le_pow_left hX _)
    _ = X ^ m * X ^ j := Nat.mul_comm _ _

theorem Exp.bound (e : Exp V) (env : Fin V → ℕ) (N : ℕ) (henv : ∀ i, env i ≤ N) :
    e.eval env ≤ (N + 2) ^ e.bnd ∧ e.tb env ≤ (N + 2) ^ e.bnd := by
  have hX : 2 ≤ N + 2 := by omega
  set X := N + 2
  induction e with
  | var i =>
    have := henv i
    simp only [eval, tb, bnd]
    have h3 : X ^ 3 = X * X * X := by ring
    have hXN : X = N + 2 := rfl
    have hXX : (X * X) * 2 ≤ (X * X) * X := Nat.mul_le_mul_left (X * X) hX
    have hsq : X * X = N * N + 4 * N + 4 := by rw [hXN]; ring
    rw [h3]
    constructor <;> omega
  | const c =>
    simp only [eval, tb, bnd]
    exact ⟨(Nat.le_succ c).trans (le_pow_self_of_two hX c), le_pow_self_of_two hX c⟩
  | add a b iha ihb | sub a b iha ihb =>
    obtain ⟨ea, ta⟩ := iha; obtain ⟨eb, tb'⟩ := ihb
    simp only [eval, tb, bnd]
    have ha := pow_mono' hX (le_max_left a.bnd b.bnd)
    have hb := pow_mono' hX (le_max_right a.bnd b.bnd)
    have k2 := mul_pow_le hX 6 (max a.bnd b.bnd) 3 (by norm_num)
    have : 1 ≤ X ^ (max a.bnd b.bnd) := Nat.one_le_pow _ _ (by omega)
    constructor <;> omega
  | mul a b iha ihb =>
    obtain ⟨ea, ta⟩ := iha; obtain ⟨eb, tb'⟩ := ihb
    simp only [eval, tb, bnd]
    have p1 : 1 ≤ X ^ a.bnd := Nat.one_le_pow _ _ (by omega)
    have p2 : 1 ≤ X ^ b.bnd := Nat.one_le_pow _ _ (by omega)
    have hab : a.eval env * b.eval env ≤ X ^ a.bnd * X ^ b.bnd := Nat.mul_le_mul ea eb
    have hab2 : a.eval env * (7 * b.eval env + 4) ≤ X ^ a.bnd * (11 * X ^ b.bnd) :=
      Nat.mul_le_mul ea (by omega)
    have h5 : 32 ≤ X ^ 5 := by
      calc 32 = 2 ^ 5 := by norm_num
        _ ≤ X ^ 5 := Nat.pow_le_pow_left hX 5
    have e5 : X ^ (a.bnd + b.bnd + 5) = X ^ a.bnd * X ^ b.bnd * X ^ 5 := by rw [pow_add, pow_add]
    rw [e5]
    have q1 : X ^ a.bnd ≤ X ^ a.bnd * X ^ b.bnd := Nat.le_mul_of_pos_right _ p2
    have q2 : X ^ b.bnd ≤ X ^ a.bnd * X ^ b.bnd := Nat.le_mul_of_pos_left _ p1
    constructor <;> nlinarith
  | div a b iha ihb | mod a b iha ihb =>
    obtain ⟨ea, ta⟩ := iha; obtain ⟨eb, tb'⟩ := ihb
    simp only [eval, tb, bnd]
    have p1 : 1 ≤ X ^ a.bnd := Nat.one_le_pow _ _ (by omega)
    have p2 : 1 ≤ X ^ b.bnd := Nat.one_le_pow _ _ (by omega)
    have hab2 : a.eval env * (9 * b.eval env + 12) ≤ X ^ a.bnd * (21 * X ^ b.bnd) :=
      Nat.mul_le_mul ea (by omega)
    have h7 : 128 ≤ X ^ 7 := by
      calc 128 = 2 ^ 7 := by norm_num
        _ ≤ X ^ 7 := Nat.pow_le_pow_left hX 7
    have e7 : X ^ (a.bnd + b.bnd + 7) = X ^ a.bnd * X ^ b.bnd * X ^ 7 := by rw [pow_add, pow_add]
    rw [e7]
    have q1 : X ^ a.bnd ≤ X ^ a.bnd * X ^ b.bnd := Nat.le_mul_of_pos_right _ p2
    have q2 : X ^ b.bnd ≤ X ^ a.bnd * X ^ b.bnd := Nat.le_mul_of_pos_left _ p1
    have d1 : a.eval env / b.eval env ≤ a.eval env := Nat.div_le_self _ _
    have d2 : a.eval env % b.eval env ≤ a.eval env := Nat.mod_le _ _
    constructor <;> nlinarith
  | ite c a b ihc iha ihb =>
    obtain ⟨ec, tc⟩ := ihc; obtain ⟨ea, ta⟩ := iha; obtain ⟨eb, tb'⟩ := ihb
    simp only [eval, tb, bnd]
    have hc := pow_mono' hX (le_max_left c.bnd (max a.bnd b.bnd))
    have ha := pow_mono' hX ((le_max_left a.bnd b.bnd).trans (le_max_right c.bnd _))
    have hb := pow_mono' hX ((le_max_right a.bnd b.bnd).trans (le_max_right c.bnd _))
    have k2 := mul_pow_le hX 8 (max c.bnd (max a.bnd b.bnd)) 3 (by norm_num)
    have : 1 ≤ X ^ (max c.bnd (max a.bnd b.bnd)) := Nat.one_le_pow _ _ (by omega)
    constructor
    · split_ifs <;> omega
    · omega

end QEDTM


/-! # From counter programs to Mathlib `TM2ComputableInPolyTime` -/

namespace QEDTM

open Turing Function

variable {R : ℕ}

/-- Jump targets of an instruction are at most `B`. -/
def Ins.TLe (B : ℕ) : Ins R → Prop
  | .inc _ j | .dec _ j | .out _ j => j ≤ B
  | .jz _ j₁ j₂ => j₁ ≤ B ∧ j₂ ≤ B
  | .halt => True

lemma Ins.TLe.mono {B B' : ℕ} {x : Ins R} (h : x.TLe B) (hB : B ≤ B') : x.TLe B' := by
  cases x <;> simp_all [Ins.TLe] <;> omega

lemma compile_tle (p : Prog R) : ∀ a e, ∀ x ∈ p.compile a e, x.TLe (max e (a + p.size)) := by
  induction p with
  | inc r => intro a e x hx; simp [Prog.compile] at hx; subst hx; simp [Ins.TLe]
  | dec r => intro a e x hx; simp [Prog.compile] at hx; subst hx; simp [Ins.TLe]
  | out b => intro a e x hx; simp [Prog.compile] at hx; subst hx; simp [Ins.TLe]
  | seq p q ihp ihq =>
    intro a e x hx
    simp only [Prog.compile, List.mem_append] at hx
    rcases hx with hx | hx
    · exact (ihp _ _ x hx).mono (by simp [Prog.size] <;> omega)
    · exact (ihq _ _ x hx).mono (by simp [Prog.size] <;> omega)
  | loop r b ih =>
    intro a e x hx
    simp only [Prog.compile, List.mem_cons] at hx
    rcases hx with rfl | hx
    · simp [Ins.TLe, Prog.size] <;> omega
    · exact (ih _ _ x hx).mono (by simp [Prog.size] <;> omega)
  | ite r z nz ihz ihnz =>
    intro a e x hx
    simp only [Prog.compile, List.mem_cons, List.mem_append] at hx
    rcases hx with rfl | hx | hx
    · simp [Ins.TLe, Prog.size] <;> omega
    · exact (ihz _ _ x hx).mono (by simp [Prog.size] <;> omega)
    · exact (ihnz _ _ x hx).mono (by simp [Prog.size] <;> omega)

/-- Label of an address. -/
def lab (m j : ℕ) : Fin (m + 1) := ⟨j % (m + 1), Nat.mod_lt _ (by omega)⟩

abbrev Gam (R : ℕ) : Option (Fin R) → Type := fun _ => Bool

def insStmt (m : ℕ) : Ins R → TM2.Stmt (Gam R) (Fin (m + 1)) Bool
  | .inc r j => .push (some r) (fun _ => true) (.goto fun _ => lab m j)
  | .dec r j => .pop (some r) (fun v _ => v) (.goto fun _ => lab m j)
  | .out b j => .push none (fun _ => b) (.goto fun _ => lab m j)
  | .jz r j₁ j₂ => .peek (some r) (fun _ o => o.isSome)
      (.branch (fun v => v) (.load (fun _ => false) (.goto fun _ => lab m j₂)) (.goto fun _ => lab m j₁))
  | .halt => .halt

variable (code : List (Ins R)) (hR : 0 < R)

/-- The bundled machine. -/
def machine : FinTM2 where
  K := Option (Fin R)
  k₀ := some ⟨0, hR⟩
  k₁ := none
  Γ := Gam R
  Λ := Fin (code.length + 1)
  main := 0
  σ := Bool
  initialState := false
  m := fun l => insStmt code.length (code.getD l.val .halt)

/-- The raw program. -/
def Mprog (code : List (Ins R)) : Fin (code.length + 1) → TM2.Stmt (Gam R) (Fin (code.length + 1)) Bool :=
  fun l => insStmt code.length (code.getD l.val .halt)

/-- Simulation relation. -/
def Rel (c : TM2.Cfg (Gam R) (Fin (code.length + 1)) Bool) (pc : ℕ) (s : St R) : Prop :=
  pc ≤ code.length ∧ c.l = some (lab code.length pc) ∧ c.var = false ∧
    (∀ r, (c.stk (some r)).length = s.reg r) ∧ c.stk none = s.out.reverse

variable {code}

lemma lab_val {m j : ℕ} (h : j ≤ m) : (lab m j).val = j := Nat.mod_eq_of_lt (by omega)

/-- One flat step is one TM2 step. -/
lemma sim_step (hcode : ∀ x ∈ code, x.TLe code.length)
    {c : TM2.Cfg (Gam R) (Fin (code.length + 1)) Bool} {pc pc' : ℕ} {s s' : St R}
    (hrel : Rel code c pc s) (hst : fstep code (pc, s) = some (pc', s')) :
    ∃ c', TM2.step (Mprog code) c = some c' ∧ Rel code c' pc' s' := by
  obtain ⟨hpc, hl, hv, hreg, hout⟩ := hrel
  rcases c with ⟨l, v, S⟩
  simp only at hl hv hreg hout
  subst hl hv
  have hlab : (lab code.length pc).val = pc := lab_val hpc
  -- the instruction
  have hmem : ∀ x, code.getD pc .halt = x → x ≠ .halt → x ∈ code := by
    intro x hx hne
    rw [List.getD_eq_getElem?_getD] at hx
    rcases h : code[pc]? with _ | y
    · rw [h] at hx; simp at hx; exact absurd hx.symm hne
    · rw [h] at hx; simp at hx; subst hx; exact List.mem_of_getElem? h
  have key : TM2.step (Mprog code) ⟨some (lab code.length pc), false, S⟩ =
      some (TM2.stepAux (insStmt code.length (code.getD pc .halt)) false S) := by
    simp only [TM2.step, Mprog, hlab]
  rw [key]
  unfold fstep at hst
  cases hx : code.getD pc .halt with
  | inc r j =>
    simp only [hx, stepIns, Option.some.injEq, Prod.mk.injEq] at hst
    obtain ⟨rfl, rfl⟩ := hst
    have hj : j ≤ code.length := by
      have := hcode _ (hmem _ hx (by simp)); simpa [Ins.TLe] using this
    refine ⟨_, rfl, hj, ?_, ?_, ?_, ?_⟩
    · simp [insStmt]
    · simp [insStmt]
    · intro r'
      by_cases h : r' = r
      · subst h; simp [insStmt, St.inc, hreg]
      · simp [insStmt, St.inc, update_apply, h, hreg]
    · simp [insStmt, TM2.stepAux, St.inc, update_apply, hout]
  | dec r j =>
    simp only [hx, stepIns, Option.some.injEq, Prod.mk.injEq] at hst
    obtain ⟨rfl, rfl⟩ := hst
    have hj : j ≤ code.length := by
      have := hcode _ (hmem _ hx (by simp)); simpa [Ins.TLe] using this
    refine ⟨_, rfl, hj, ?_, ?_, ?_, ?_⟩
    · simp [insStmt]
    · simp [insStmt]
    · intro r'
      by_cases h : r' = r
      · subst h; simp [insStmt, St.dec, hreg]
      · simp [insStmt, St.dec, update_apply, h, hreg]
    · simp [insStmt, TM2.stepAux, St.dec, update_apply, hout]
  | out b j =>
    simp only [hx, stepIns, Option.some.injEq, Prod.mk.injEq] at hst
    obtain ⟨rfl, rfl⟩ := hst
    have hj : j ≤ code.length := by
      have := hcode _ (hmem _ hx (by simp)); simpa [Ins.TLe] using this
    refine ⟨_, rfl, hj, ?_, ?_, ?_, ?_⟩
    · simp [insStmt]
    · simp [insStmt]
    · intro r'
      simp [insStmt, TM2.stepAux, St.emit, update_apply, hreg]
    · simp [insStmt, TM2.stepAux, St.emit, update_apply, hout]
  | jz r j₁ j₂ =>
    simp only [hx, stepIns, Option.some.injEq, Prod.mk.injEq] at hst
    obtain ⟨rfl, rfl⟩ := hst
    have hj := hcode _ (hmem _ hx (by simp))
    simp only [Ins.TLe] at hj
    by_cases hz : s.reg r = 0
    · have hnil : S (some r) = [] := List.eq_nil_of_length_eq_zero ((hreg r).trans hz)
      refine ⟨_, rfl, by simp [hz]; omega, ?_, ?_, ?_, ?_⟩
      · simp [insStmt, hnil, hz]
      · simp [insStmt, hnil]
      · intro r'; simp [insStmt, hnil, hreg]
      · simp [insStmt, hnil, hout]
    · obtain ⟨y, ys, hys⟩ : ∃ y ys, S (some r) = y :: ys := by
        cases h : S (some r) with
        | nil => have := hreg r; rw [h] at this; simp at this; omega
        | cons y ys => exact ⟨y, ys, rfl⟩
      refine ⟨_, rfl, by simp [hz]; omega, ?_, ?_, ?_, ?_⟩
      · simp [insStmt, hys, hz]
      · simp [insStmt, hys]
      · intro r'; simp [insStmt, hys, hreg]
      · simp [insStmt, hys, hout]
  | halt =>
    rw [List.getD_eq_getElem?_getD] at hx
    simp [hx, stepIns] at hst

include hR in
lemma sim_iter (hcode : ∀ x ∈ code, x.TLe code.length) :
    ∀ (n : ℕ) (c : TM2.Cfg (Gam R) (Fin (code.length + 1)) Bool) (pc pc' : ℕ) (s s' : St R),
      Rel code c pc s → fiter code n (some (pc, s)) = some (pc', s') →
      ∃ c', (flip bind (TM2.step (Mprog code)))^[n] (some c) = some c' ∧ Rel code c' pc' s' := by
  intro n
  induction n with
  | zero =>
    intro c pc pc' s s' hrel h
    simp only [fiter, Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, rfl⟩ := h
    exact ⟨c, rfl, hrel⟩
  | succ n ih =>
    intro c pc pc' s s' hrel h
    simp only [fiter, Option.bind_some] at h
    rcases hf : fstep code (pc, s) with _ | ⟨pc1, s1⟩
    · rw [hf] at h
      have : ∀ m, fiter code m (none : Option (ℕ × St R)) = none := by
        intro m; induction m with
        | zero => rfl
        | succ m ihm => simp [fiter, ihm]
      rw [this] at h; cases h
    · rw [hf] at h
      obtain ⟨c1, hc1, hrel1⟩ := sim_step hcode hrel hf
      obtain ⟨c', hc', hrel'⟩ := ih c1 pc1 pc' s1 s' hrel1 h
      refine ⟨c', ?_, hrel'⟩
      rw [Function.iterate_succ_apply]
      have e1 : flip bind (TM2.step (Mprog code)) (some c) = some c1 := hc1
      rw [e1]; exact hc'

include hR in
/-- **Counter programs with polynomial running time give TM2 polytime computability.** -/
theorem polytime_of_prog (P : Prog R) (F : List Bool → List Bool) (T : Polynomial ℕ)
    (h : ∀ l : List Bool, ∃ (s' : St R) (t : ℕ), t + 1 ≤ T.eval l.length ∧
      Run P ⟨fun r => if r.val = 0 then l.length else 0, []⟩ s' t ∧ (∀ r, s'.reg r = 0) ∧
      s'.out.reverse = F l) :
    Nonempty (TM2ComputableInPolyTime (id : List Bool → List Bool) id F) := by
  classical
  set code : List (Ins R) := P.compile 0 P.size ++ [.halt] with hcode_def
  have hlen : code.length = P.size + 1 := by simp [code, Prog.length_compile]
  have hcode : ∀ x ∈ code, x.TLe code.length := by
    intro x hx
    simp only [code, List.mem_append, List.mem_singleton] at hx
    rcases hx with hx | rfl
    · exact (compile_tle P 0 P.size x hx).mono (by rw [hlen]; omega)
    · simp [Ins.TLe]
  have hAt : At code 0 (P.compile 0 P.size) := by
    intro i hi
    simp only [code, Nat.zero_add]
    rw [List.getD_append _ _ _ _ hi]
  let tm := machine code hR
  choose S1 T1 hT1 hrun1 hzero1 hout1 using h
  refine ⟨TM2ComputableInPolyTime.mk ⟨tm, Equiv.refl Bool, Equiv.refl Bool⟩ T (fun l => ?_)⟩
  have ht := hT1 l; have hrun := hrun1 l; have hzero := hzero1 l; have hout := hout1 l
  set s' := S1 l; set t := T1 l
  have hfl := compile_run hrun code 0 P.size hAt
  -- initial configuration is related
  have hinit : Rel code (initList tm (List.map (Equiv.refl Bool).invFun (id l))) 0
      ⟨fun r => if r.val = 0 then l.length else 0, []⟩ := by
    refine ⟨by omega, rfl, rfl, fun r => ?_, ?_⟩
    · simp only [initList, tm, machine]
      by_cases hr : r = ⟨0, hR⟩
      · subst hr; simp; rfl
      · have : (some r : Option (Fin R)) ≠ some ⟨0, hR⟩ := by simpa using hr
        have hv : r.val ≠ 0 := fun h' => hr (Fin.ext h')
        simp [this, hv]
    · simp [initList, tm, machine]
  refine ⟨⟨t + 1, ?_⟩, ht⟩
  obtain ⟨c', hc', hrel'⟩ := sim_iter hR hcode t _ 0 P.size _ s' hinit hfl
  obtain ⟨-, hl', hv', hreg', hout'⟩ := hrel'
  rcases c' with ⟨l', v', S'⟩
  simp only at hl' hv' hreg' hout'
  subst hl' hv'
  -- the halt step
  have hhalt : TM2.step (Mprog code) ⟨some (lab code.length P.size), false, S'⟩ =
      some ⟨none, false, S'⟩ := by
    have hl : (lab code.length P.size).val = P.size := lab_val (by omega)
    simp only [TM2.step, Mprog, hl]
    have : code.getD P.size .halt = .halt := by
      simp only [code]
      rw [List.getD_append_right _ _ _ _ (by rw [Prog.length_compile])]
      simp [Prog.length_compile]
    rw [this]; rfl
  rw [Function.iterate_succ_apply']
  have hstep : FinTM2.step tm = TM2.step (Mprog code) := rfl
  rw [hstep]
  erw [hc']
  have e2 : flip bind (TM2.step (Mprog code)) (some ⟨some (lab code.length P.size), false, S'⟩) =
      some ⟨none, false, S'⟩ := hhalt
  erw [e2]
  simp only [Option.map_some, haltList, tm, machine]
  congr 2
  funext k
  rcases k with _ | r
  · simp only [dite_true]
    rw [hout', hout]
    have : List.map (Equiv.refl Bool).invFun (id (F l)) = F l := by simp [Equiv.refl]
    rw [this]; rfl
  · have h0 : (S' (some r)).length = 0 := (hreg' r).trans (hzero r)
    simp [List.eq_nil_of_length_eq_zero h0]

end QEDTM


/-! # The generator: six nested digit loops around one compiled expression -/

namespace QEDTM

open Function

/-- Countdown loop: runs `body` with `r = k-1, …, 0`, appending `f (k-1) ++ … ++ f 0`. -/
lemma run_countdown {R : ℕ} (r : Fin R) (body : Prog R) (ρ : Fin R → ℕ) (f : ℕ → List Bool) (Tb K : ℕ)
    (hb : ∀ v, v < K → ∀ o, ∃ t ≤ Tb, Run body ⟨update ρ r v, o⟩ ⟨update ρ r v, o ++ f v⟩ t) :
    ∀ k, k ≤ K → ∀ o, ∃ t ≤ k * (Tb + 2) + 1, Run (.loop r (.seq (.dec r) body)) ⟨update ρ r k, o⟩
      ⟨update ρ r 0, o ++ (List.range k).reverse.flatMap f⟩ t := by
  intro k
  induction k with
  | zero => intro _ o; exact ⟨1, by omega, by simpa using Run.loopZ (b := .seq (.dec r) body) (by simp)⟩
  | succ k ih =>
    intro hk o
    have hd : (St.dec ⟨update ρ r (k + 1), o⟩ r : St R) = ⟨update ρ r k, o⟩ := by
      ext1 <;> simp [St.dec]
    obtain ⟨t1, ht1, r1⟩ := hb k (by omega) o
    obtain ⟨t2, ht2, r2⟩ := ih (by omega) (o ++ f k)
    have h1 := Run.seq (Run.dec r ⟨update ρ r (k + 1), o⟩) (hd ▸ r1)
    have r2' : Run (.loop r (.seq (.dec r) body)) ⟨update ρ r k, o ++ f k⟩
        ⟨update ρ r 0, o ++ (List.range (k + 1)).reverse.flatMap f⟩ t2 := by
      simpa [List.range_succ, List.flatMap_append] using r2
    refine ⟨_, ?_, Run.loopS (by simp) h1 r2'⟩
    nlinarith

variable (D : ℕ)

/-- Variable index of loop level `j` (`j = 0` innermost: variable `6`). -/
def dv (j : ℕ) : Fin 7 := ⟨(6 - j) % 7, Nat.mod_lt _ (by omega)⟩

def inReg : Fin (Rg 7 D) := ⟨0, by unfold Rg; omega⟩
def nReg : Fin (Rg 7 D) := vreg D 0

variable (e : Exp 7)

def inner : Prog (Rg 7 D) :=
  .seq (cE D e 0 1) (.ite (sreg D 0) (.out false) (.seq (.out true) (mClear (sreg D 0))))

def lev : ℕ → Prog (Rg 7 D)
  | 0 => inner D e
  | j + 1 => .seq (mCopy (nReg D) (vreg D (dv j)) (sreg D 1))
      (.loop (vreg D (dv j)) (.seq (.dec (vreg D (dv j))) (lev j)))

def gen : Prog (Rg 7 D) := .seq (mMove (inReg D) (nReg D)) (.seq (lev D e 6) (mClear (nReg D)))

/-- The emitted bits of level `j` for register file `ρ`. -/
def outL : ℕ → (Fin (Rg 7 D) → ℕ) → List Bool
  | 0, ρ => [decide (e.eval (fun i => ρ (vreg D i)) ≠ 0)]
  | j + 1, ρ => (List.range (ρ (nReg D))).reverse.flatMap (fun v => outL j (update ρ (vreg D (dv j)) v))

/-- Time bound for level `j` with `n = ρ N`. -/
def Tl (n : ℕ) : ℕ → ℕ
  | 0 => 3 * (n + 2) ^ e.bnd + 4
  | j + 1 => 7 * n + 3 + n * (Tl n j + 2)

lemma dv_val {j : ℕ} (hj : j < 6) : (dv j).val = 6 - j := Nat.mod_eq_of_lt (by omega)

lemma vreg_inj {D : ℕ} {i i' : Fin 7} (h : vreg D i = vreg D i') : i = i' := by
  have := congrArg Fin.val h; simp [vreg] at this; exact Fin.ext this

lemma vreg_ne_n {D : ℕ} {i : Fin 7} (hi : i.val ≠ 0) : vreg D i ≠ nReg D := by
  intro h; exact hi (congrArg Fin.val (vreg_inj h))

theorem lev_spec (hD : e.need + 2 ≤ D) : ∀ j, j ≤ 6 → ∀ (ρ : Fin (Rg 7 D) → ℕ) (o : List Bool),
    (∀ k, k < D → ρ (sreg D k) = 0) → (∀ i, i < j → ρ (vreg D (dv i)) = 0) →
    (∀ i : Fin 7, ρ (vreg D i) ≤ ρ (nReg D)) →
    ∃ t ≤ Tl e (ρ (nReg D)) j, Run (lev D e j) ⟨ρ, o⟩ ⟨ρ, o ++ outL D e j ρ⟩ t := by
  intro j
  induction j with
  | zero =>
    intro _ ρ o hs _ hle
    have hD0 : 0 < D := by omega
    obtain ⟨t1, ht1, r1⟩ := cE_spec (D := D) e 0 1 (by omega) (by omega) ⟨ρ, o⟩ (hs 0 hD0)
      (fun k _ hk => hs k hk)
    set v := e.eval (envOf (D := D) ⟨ρ, o⟩)
    have hbound := (Exp.bound e (envOf (D := D) ⟨ρ, o⟩) (ρ (nReg D)) (fun i => hle i)).2
    have hval := (Exp.bound e (envOf (D := D) ⟨ρ, o⟩) (ρ (nReg D)) (fun i => hle i)).1
    by_cases hv : v = 0
    · have hst : (⟨update ρ (sreg D 0) v, o⟩ : St (Rg 7 D)) = ⟨ρ, o⟩ := by
        ext1
        · funext z; simp only [update_apply, hv]; split_ifs with h <;> simp_all [hs 0 hD0]
        · rfl
      rw [hst] at r1
      have r2 := Run.out false (⟨ρ, o⟩ : St (Rg 7 D))
      have hst2 : St.emit ⟨ρ, o⟩ false = (⟨ρ, o ++ outL D e 0 ρ⟩ : St (Rg 7 D)) := by
        simp only [St.emit, outL]; congr 3; simp [envOf, v] at hv ⊢; exact hv
      rw [hst2] at r2
      refine ⟨_, ?_, Run.seq r1 (Run.iteZ (by simpa using hs 0 hD0) r2)⟩
      simp only [Tl]; nlinarith
    · have r2 := Run.out true (⟨update ρ (sreg D 0) v, o⟩ : St (Rg 7 D))
      have r3 := run_clear (sreg D 0) (St.emit ⟨update ρ (sreg D 0) v, o⟩ true)
      have hst : (⟨update (St.emit ⟨update ρ (sreg D 0) v, o⟩ true).reg (sreg D 0) 0,
          (St.emit ⟨update ρ (sreg D 0) v, o⟩ true).out⟩ : St (Rg 7 D)) = ⟨ρ, o ++ outL D e 0 ρ⟩ := by
        ext1
        · funext z; simp only [St.emit, update_apply]; split_ifs with h <;> simp_all [hs 0 hD0]
        · simp only [St.emit, outL]; congr 2; simp [envOf, v] at hv ⊢; exact hv
      rw [hst] at r3
      refine ⟨_, ?_, Run.seq r1 (Run.iteS (by simpa using hv) (Run.seq r2 r3))⟩
      simp only [Tl, St.emit, update_self]; nlinarith
  | succ j ih =>
    intro hj ρ o hs hd hle
    set n := ρ (nReg D)
    set Dj := vreg D (dv j)
    have hdj : (dv j).val = 6 - j := dv_val (by omega)
    have hDjn : Dj ≠ nReg D := vreg_ne_n (by omega)
    have hDj0 : ρ Dj = 0 := hd j (by omega)
    have hD1 : 1 < D := by omega
    have hs1 : sreg (V := 7) D 1 ≠ Dj := sreg_ne_vreg hD1 _
    have hsn : sreg (V := 7) D 1 ≠ nReg D := sreg_ne_vreg hD1 _
    have r1 := run_copy (nReg D) Dj (sreg D 1) hDjn.symm hsn.symm hs1.symm ⟨ρ, o⟩ (hs 1 hD1)
    simp only [hDj0, Nat.zero_add] at r1
    -- body spec for every value
    have hbody : ∀ v, v < n → ∀ o', ∃ t ≤ Tl e n j, Run (lev D e j) ⟨update ρ Dj v, o'⟩
        ⟨update ρ Dj v, o' ++ outL D e j (update ρ Dj v)⟩ t := by
      intro v hv o'
      have hN : update ρ Dj v (nReg D) = n := by rw [update_of_ne hDjn.symm]
      have := ih (by omega) (update ρ Dj v) o'
        (fun k hk => by rw [update_of_ne (sreg_ne_vreg hk _)]; exact hs k hk)
        (fun i hi => by
          have hne : vreg D (dv i) ≠ Dj := by
            intro h; have := congrArg Fin.val (vreg_inj h)
            rw [dv_val (by omega), dv_val (by omega)] at this; omega
          rw [update_of_ne hne]; exact hd i (by omega))
        (fun i => by
          rw [hN]
          by_cases hi : vreg D i = Dj
          · rw [hi, update_self]; omega
          · rw [update_of_ne hi]; exact hle i)
      rw [hN] at this; exact this
    obtain ⟨t2, ht2, r2⟩ := run_countdown Dj (lev D e j) ρ (fun v => outL D e j (update ρ Dj v))
      (Tl e n j) n hbody n le_rfl o
    have hρ : update ρ Dj 0 = ρ := by rw [← hDj0]; exact update_eq_self _ _
    rw [hρ] at r2
    refine ⟨_, ?_, Run.seq r1 r2⟩
    simp only [Tl]; nlinarith

lemma Tl_le (n : ℕ) : ∀ j, Tl e n j ≤ (n + 2) ^ (e.bnd + 5 * j + 3) := by
  have hX : 2 ≤ n + 2 := by omega
  have p1 : 1 ≤ (n + 2) ^ e.bnd := Nat.one_le_pow _ _ (by omega)
  intro j
  induction j with
  | zero =>
    simp only [Tl]
    have := mul_pow_le hX 7 e.bnd 3 (by norm_num)
    simp only [Nat.mul_zero, Nat.add_zero]; omega
  | succ j ih =>
    simp only [Tl]
    set M := e.bnd + 5 * j + 3
    have pM : 1 ≤ (n + 2) ^ M := Nat.one_le_pow _ _ (by omega)
    have h1 : (n + 2) ^ (M + 1) = (n + 2) ^ M * (n + 2) := pow_succ _ _
    have h2 := mul_pow_le hX 10 (M + 1) 4 (by norm_num)
    have e1 : e.bnd + 5 * (j + 1) + 3 = M + 1 + 4 := by omega
    rw [e1]
    have : n * (Tl e n j + 2) ≤ (n + 2) * (n + 2) ^ M + 2 * (n + 2) := by nlinarith
    nlinarith

/-- The initial register file after moving the input into `N`. -/
def ρ0 (n : ℕ) : Fin (Rg 7 D) → ℕ := fun r => if r = nReg D then n else 0

/-- The computed function. -/
def Fgen (l : List Bool) : List Bool := (outL (e.need + 2) e 6 (ρ0 (e.need + 2) l.length)).reverse

theorem gen_polytime : Nonempty (Turing.TM2ComputableInPolyTime (id : List Bool → List Bool) id (Fgen e)) := by
  set D := e.need + 2 with hDdef
  refine polytime_of_prog (R := Rg 7 D) (by unfold Rg; omega) (gen D e) (Fgen e)
    ((Polynomial.X + Polynomial.C 2) ^ (e.bnd + 40)) ?_
  intro l
  set n := l.length
  have hin : (inReg D : Fin (Rg 7 D)) ≠ nReg D := by
    intro h
    have h0 := congrArg Fin.val h
    have h1 : (inReg D : Fin (Rg 7 D)).val = 0 := rfl
    have h2 : (nReg D : Fin (Rg 7 D)).val = 1 := rfl
    omega
  have r1 := run_move (inReg D) (nReg D) hin ⟨fun r => if r.val = 0 then n else 0, []⟩
  have hρ : (⟨update (update (fun r : Fin (Rg 7 D) => if r.val = 0 then n else 0) (nReg D)
      ((if (nReg D : Fin (Rg 7 D)).val = 0 then n else 0) + (if (inReg D : Fin (Rg 7 D)).val = 0 then n else 0)))
      (inReg D) 0, []⟩ : St (Rg 7 D)) = ⟨ρ0 D n, []⟩ := by
    ext1
    · funext z
      simp only [update_apply, ρ0]
      have hN : (nReg D : Fin (Rg 7 D)).val = 1 := rfl
      have hI : (inReg D : Fin (Rg 7 D)).val = 0 := rfl
      by_cases h1 : z = inReg D
      · subst h1; simp [hin, hin.symm]
      · by_cases h2 : z = nReg D
        · subst h2; simp [hN, hI, Ne.symm hin]
        · simp only [h1, h2, if_false]
          have : z.val ≠ 0 := fun h => h1 (Fin.ext (h.trans hI.symm))
          simp [this]
    · rfl
  simp only [] at r1
  rw [hρ] at r1
  have hN0 : ρ0 D n (nReg D) = n := by simp [ρ0]
  obtain ⟨t2, ht2, r2⟩ := lev_spec D e le_rfl 6 le_rfl (ρ0 D n) []
    (fun k hk => by simp [ρ0, nReg, sreg_ne_vreg hk])
    (fun i hi => by
      have : vreg D (dv i) ≠ nReg D := vreg_ne_n (by rw [dv_val (by omega)]; omega)
      simp [ρ0, this])
    (fun i => by simp only [ρ0]; split_ifs <;> simp)
  rw [hN0] at ht2
  have r3 := run_clear (nReg D) ⟨ρ0 D n, [] ++ outL D e 6 (ρ0 D n)⟩
  refine ⟨_, _, ?_, Run.seq r1 (Run.seq r2 r3), ?_, ?_⟩
  · have hT := Tl_le e n 6
    have hX : 2 ≤ n + 2 := by omega
    have hp : (n + 2) ^ (e.bnd + 33) ≤ (n + 2) ^ (e.bnd + 40) := Nat.pow_le_pow_right (by omega) (by omega)
    have hk := mul_pow_le hX 64 (e.bnd + 33) 7 (by norm_num)
    have p1 : n + 2 ≤ (n + 2) ^ (e.bnd + 33) := by
      calc n + 2 = (n + 2) ^ 1 := (pow_one _).symm
        _ ≤ _ := Nat.pow_le_pow_right (by omega) (by omega)
    simp only [Polynomial.eval_pow, Polynomial.eval_add, Polynomial.eval_X, Polynomial.eval_C]
    simp only [ρ0, if_pos rfl] at *
    simp only [show e.bnd + 5 * 6 + 3 = e.bnd + 33 by ring] at hT
    have : (if (inReg D : Fin (Rg 7 D)).val = 0 then n else 0) = n := by simp [inReg]
    rw [this]
    nlinarith
  · intro r; by_cases hr : r = nReg D <;> simp [update_apply, ρ0, hr]
  · simp [Fgen]; rfl

end QEDTM

namespace QEDTM

open Function

lemma getD_flatMap_range {α : Type*} (g : ℕ → List α) (m : ℕ) (hg : ∀ v, (g v).length = m) (d : α) :
    ∀ n v i, v < n → i < m → ((List.range n).flatMap g).getD (v * m + i) d = (g v).getD i d := by
  intro n
  induction n with
  | zero => intro v i hv; omega
  | succ n ih =>
    intro v i hv hi
    have hlen : ((List.range n).flatMap g).length = n * m := by
      simp [List.length_flatMap, hg, List.sum_replicate]
    rw [List.range_succ, List.flatMap_append, List.flatMap_singleton]
    rcases Nat.lt_succ_iff_lt_or_eq.1 hv with hv | rfl
    · rw [List.getD_append _ _ _ _ (by rw [hlen]; nlinarith), ih v i hv hi]
    · rw [List.getD_append_right _ _ _ _ (by rw [hlen]; omega), hlen]; simp

variable (D : ℕ) (e : Exp 7)

lemma outL_length (n : ℕ) : ∀ j (ρ : Fin (Rg 7 D) → ℕ), ρ (nReg D) = n → j ≤ 6 →
    (outL D e j ρ).length = n ^ j := by
  intro j
  induction j with
  | zero => intro ρ _ _; simp [outL]
  | succ j ih =>
    intro ρ hρ hj
    simp only [outL, hρ, List.length_flatMap]
    have : ∀ v, (outL D e j (update ρ (vreg D (dv j)) v)).length = n ^ j := fun v =>
      ih _ (by rw [update_of_ne (vreg_ne_n (by rw [dv_val (by omega)]; omega)).symm]; exact hρ) (by omega)
    simp [this, List.sum_replicate, pow_succ, Nat.mul_comm]

/-- Index of a digit tuple. -/
def idx (n : ℕ) (u : ℕ → ℕ) : ℕ → ℕ
  | 0 => 0
  | j + 1 => u j * n ^ j + idx n u j

/-- Register file after setting the inner `j` digits. -/
def upd (u : ℕ → ℕ) : ℕ → (Fin (Rg 7 D) → ℕ) → (Fin (Rg 7 D) → ℕ)
  | 0, ρ => ρ
  | j + 1, ρ => upd u j (update ρ (vreg D (dv j)) (u j))

lemma idx_lt (n : ℕ) (u : ℕ → ℕ) (hu : ∀ i, u i < n) : ∀ j, idx n u j < n ^ j := by
  intro j
  induction j with
  | zero => simp [idx]
  | succ j ih =>
    simp only [idx, pow_succ]
    have := hu j
    nlinarith

lemma outL_decode (n : ℕ) (u : ℕ → ℕ) (hu : ∀ i, u i < n) : ∀ j (ρ : Fin (Rg 7 D) → ℕ),
    ρ (nReg D) = n → j ≤ 6 →
    (outL D e j ρ).reverse.getD (idx n u j) false =
      decide (e.eval (fun i => upd D u j ρ (vreg D i)) ≠ 0) := by
  intro j
  induction j with
  | zero =>
    intro ρ _ _
    simp only [outL, idx, upd, List.reverse_singleton]
    rfl
  | succ j ih =>
    intro ρ hρ hj
    have hne : vreg D (dv j) ≠ nReg D := vreg_ne_n (by rw [dv_val (by omega)]; omega)
    simp only [outL, hρ, List.reverse_flatMap, List.reverse_reverse, idx, upd]
    rw [getD_flatMap_range (List.reverse ∘ fun v => outL D e j (update ρ (vreg D (dv j)) v)) (n ^ j)
      (fun v => by
        simp only [Function.comp, List.length_reverse]
        exact outL_length D e n j _ (by rw [update_of_ne hne.symm]; exact hρ) (by omega))
      false n (u j) (idx n u j) (hu j) (idx_lt n u hu j)]
    exact ih _ (by rw [update_of_ne hne.symm]; exact hρ) (by omega)

/-- The environment `[n, b, o, t, q, a, c]`. -/
def envD (n b o t q a c : ℕ) : Fin 7 → ℕ := fun i =>
  if i.val = 0 then n else if i.val = 1 then b else if i.val = 2 then o else if i.val = 3 then t else
  if i.val = 4 then q else if i.val = 5 then a else c

/-- **Decoding the generator's output.** -/
theorem Fgen_getD (n b o t q a c : ℕ) (hb : b < n) (ho : o < n) (ht : t < n) (hq : q < n) (ha : a < n)
    (hc : c < n) :
    (Fgen e (List.replicate n true)).getD (((((b * n + o) * n + t) * n + q) * n + a) * n + c) false =
      decide (e.eval (envD n b o t q a c) ≠ 0) := by
  set D := e.need + 2
  let u : ℕ → ℕ := fun i => if i = 0 then c else if i = 1 then a else if i = 2 then q else
    if i = 3 then t else if i = 4 then o else if i = 5 then b else 0
  have hu : ∀ i, u i < n := by
    intro i; simp only [u]; split_ifs <;> omega
  have hidx : idx n u 6 = ((((b * n + o) * n + t) * n + q) * n + a) * n + c := by
    simp [idx, u]; ring
  have h := outL_decode D e n u hu 6 (ρ0 D n) (by simp [ρ0]) le_rfl
  simp only [Fgen, List.length_replicate]
  rw [← hidx]
  convert h using 3
  congr 1
  funext i
  fin_cases i <;> simp [envD, upd, u, ρ0, update_apply, vreg, nReg, dv, Fin.ext_iff]

end QEDTM
