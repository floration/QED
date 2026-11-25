import Mathlib
/-! QED-M039: Matching lower bound for OMv on low-VC-dimension matrices
Anand–van den Brand–McCarty give Õ(n²) preprocessing and Õ(n^{2−1/d}) query time for online
Boolean matrix–vector multiplication when the matrix has VC-dimension d. Show that query time
n^{2−c/d} is necessary for some constant c (assuming the OMv conjecture, or unconditionally in the
cell-probe model), for d up to some ω(1) function; or improve the upper bound to n^{2−f(d)} with
f(d) ≫ 1/d.
Informal statement: Assume the OMv conjecture (for every ε > 0, no randomized word-RAM algorithm
solves OMv — an n×n Boolean matrix M, then n Boolean vectors v_1..v_n given online, each M v_i
to be output before v_{i+1} is read — in total time O(n^{3−ε})). Prove there are c > 0 and
D : ℕ → ℕ with D(n) → ∞ such that for every choice d(n) with 1 ≤ d(n) ≤ D(n), every ε > 0 and
every p, no randomized algorithm with O(n^p) preprocessing (on M) answers the n online queries for
matrices of VC-dimension ≤ d(n) in total query time O(n^{3−c/d(n)−ε}), i.e. amortized
O(n^{2−c/d(n)−ε}) per query. (The alternative positive target, query time n^{2−f(d)} with
d·f(d) → ∞, is a separate question and not part of Claim.)
Formalization notes: Uses the shared QED word-RAM block (WordRAM, pasted below) and its online
variant: phase 0 receives `[n]` and M row-major; phase i ≥ 1 receives the n bits of v_i (written
over M[0..n-1]; registers and memory persist), and must halt with output M v_i (n bits, Boolean
semiring). Phase 0's output is ignored. Time: phase 0 within O(Tpre), all query phases together
within O(Tq); randomized = Monte Carlo over random tapes (≥ 2/3, whole transcript correct). Queries
are fixed in advance (oblivious adversary), both in the OMv hypothesis and in the conclusion.
VC-dimension of M: the largest set S of columns shattered by the rows (every T ⊆ S equals
{c ∈ S : M r c = 1} for some row r); `VCLe M n d` says no shattered S has more than d elements.
Word size: correct for every w ≥ (wc+1)·log₂(total input length). Claim := OMv → Conclusion.
Proving `Claim` = the conditional lower bound; `¬Claim` = OMv holds yet for every c, D some
d(n) ≤ D(n) has faster algorithms (i.e. the upper bound can be improved beyond n^{2−c/d}).
-/
namespace OpenProblems.QEDM039

noncomputable section

/-! ### Canonical word-RAM model (QED board, shared block; paste verbatim inside the problem namespace)

* A machine has word size `w`; every register and memory cell holds a natural number `< 2^w`
  (invariant: every register write is reduced mod `2^w`; memory only receives register values
  and input words, which are required to be `< 2^w`).
* Registers `R : ℕ → ℕ` (a program mentions only finitely many) and memory `M : ℕ → ℕ`
  (addresses are register values, hence `< 2^w`: at most `2^w` cells, all initially 0 except input).
* Program: a finite list of the standard unit-cost instructions below; `pc` indexes the list.
  A `pc` outside the list (in particular after `halt`, or a jump past the end) means halted, and a
  halted configuration is a fixed point of `wrStep`.
* Input: a list of words `x₀ … x_{n-1}` placed in `M[0..n-1]`; initially `R 0 = n`, `R 1 = w`,
  all other registers 0. Output: on halting, `M[0 .. R 0 - 1]`.
* Randomness: instruction `rand d` reads the next word of a random tape (word `k` is
  `tape k mod 2^w`). Deterministic runs use the all-zero tape.
* Cost: one step per instruction. `RunsWithin` asks the machine to be halted after `t` steps.
* Word size: an algorithm carries a constant `wc`, and must be correct for EVERY word size
  `w ≥ (wc+1)·(⌊log₂(n+1)⌋+1)` for which all input words fit (`< 2^w`). Requiring all such `w`
  (rather than letting the algorithm pick `w`) rules out the "huge word" loophole: the time bound
  must already hold at `w = Θ(log n)`, while larger `w` never hurts (the program can mask).
-/

/-- The instruction set (all unit cost). Indices `d a b` are register names, `t` a program address. -/
inductive WRInstr where
  /-- `R d := c mod 2^w` (a fixed program constant). -/
  | const (d c : ℕ)
  /-- `R d := M[R a]` (indirect load). -/
  | load (d a : ℕ)
  /-- `M[R a] := R s` (indirect store). -/
  | store (a s : ℕ)
  /-- `R d := (R a + R b) mod 2^w`. -/
  | add (d a b : ℕ)
  /-- `R d := R a - R b`, truncated at 0. -/
  | sub (d a b : ℕ)
  /-- `R d := (R a * R b) mod 2^w` (low word of the product). -/
  | mul (d a b : ℕ)
  /-- `R d := ⌊R a / R b⌋` (and `x / 0 = 0`). -/
  | div (d a b : ℕ)
  /-- Bitwise and / or / xor. -/
  | band (d a b : ℕ)
  | bor (d a b : ℕ)
  | bxor (d a b : ℕ)
  /-- `R d := (R a · 2^(R b)) mod 2^w` and `R d := ⌊R a / 2^(R b)⌋`. -/
  | shl (d a b : ℕ)
  | shr (d a b : ℕ)
  /-- Unconditional jump; jump if `R a = 0`; jump if `R a < R b`. -/
  | jmp (t : ℕ)
  | jz (a t : ℕ)
  | jlt (a b t : ℕ)
  /-- `R d :=` next random word. -/
  | rand (d : ℕ)
  /-- Stop. -/
  | halt

/-- Machine configuration: program counter, registers, memory, number of random words used. -/
structure WRCfg where
  pc : ℕ
  reg : ℕ → ℕ
  mem : ℕ → ℕ
  rc : ℕ

/-- One step of program `prog` with word size `w` and random tape `tape`. -/
def wrStep (prog : List WRInstr) (w : ℕ) (tape : ℕ → ℕ) (s : WRCfg) : WRCfg :=
  match prog[s.pc]? with
  | none => s
  | some ins =>
    let upd : ℕ → ℕ → WRCfg := fun d v =>
      { s with pc := s.pc + 1, reg := Function.update s.reg d (v % 2 ^ w) }
    let jump : Bool → ℕ → WRCfg := fun b t =>
      { s with pc := if b then t else s.pc + 1 }
    match ins with
    | .const d c => upd d c
    | .load d a => upd d (s.mem (s.reg a))
    | .store a r => { s with pc := s.pc + 1, mem := Function.update s.mem (s.reg a) (s.reg r) }
    | .add d a b => upd d (s.reg a + s.reg b)
    | .sub d a b => upd d (s.reg a - s.reg b)
    | .mul d a b => upd d (s.reg a * s.reg b)
    | .div d a b => upd d (s.reg a / s.reg b)
    | .band d a b => upd d (Nat.land (s.reg a) (s.reg b))
    | .bor d a b => upd d (Nat.lor (s.reg a) (s.reg b))
    | .bxor d a b => upd d (Nat.xor (s.reg a) (s.reg b))
    | .shl d a b => upd d (s.reg a * 2 ^ (s.reg b))
    | .shr d a b => upd d (s.reg a / 2 ^ (s.reg b))
    | .jmp t => { s with pc := t }
    | .jz a t => jump (decide (s.reg a = 0)) t
    | .jlt a b t => jump (decide (s.reg a < s.reg b)) t
    | .rand d =>
        { s with pc := s.pc + 1, reg := Function.update s.reg d (tape s.rc % 2 ^ w), rc := s.rc + 1 }
    | .halt => { s with pc := prog.length }

/-- Initial configuration: input in `M[0..n-1]`, `R 0 = n`, `R 1 = w`. -/
def wrInit (w : ℕ) (input : List ℕ) : WRCfg where
  pc := 0
  reg := fun i => if i = 0 then input.length else if i = 1 then w else 0
  mem := fun a => input.getD a 0
  rc := 0

/-- Output of a configuration: `M[0 .. R 0 - 1]`. -/
def wrOutput (s : WRCfg) : List ℕ := (List.range (s.reg 0)).map s.mem

/-- Halted: the program counter has left the program. -/
def WRHalted (prog : List WRInstr) (s : WRCfg) : Prop := prog.length ≤ s.pc

/-- With random tape `tape`, the run on `input` has halted after `t` steps (i.e. within `t` steps,
since halted configurations are fixed points) with output `out`. -/
def RunsWithinR (prog : List WRInstr) (w : ℕ) (tape : ℕ → ℕ) (input : List ℕ) (t : ℕ)
    (out : List ℕ) : Prop :=
  WRHalted prog ((wrStep prog w tape)^[t] (wrInit w input)) ∧
    wrOutput ((wrStep prog w tape)^[t] (wrInit w input)) = out

/-- Deterministic run (all-zero random tape). -/
def RunsWithin (prog : List WRInstr) (w : ℕ) (input : List ℕ) (t : ℕ) (out : List ℕ) : Prop :=
  RunsWithinR prog w (fun _ => 0) input t out

/-- An algorithm: a program and a word-size constant `wc` (it may assume `w ≥ (wc+1)·log n`). -/
structure WRAlgo where
  prog : List WRInstr
  wc : ℕ

/-- Admissible word sizes for an input: `w ≥ (wc+1)(⌊log₂(n+1)⌋+1)` (so `n < 2^w`) and every
input word fits in `w` bits. -/
def WROK (wc : ℕ) (input : List ℕ) (w : ℕ) : Prop :=
  (wc + 1) * (Nat.log 2 (input.length + 1) + 1) ≤ w ∧ ∀ x ∈ input, x < 2 ^ w

/-- The step budget `⌊C·T + C⌋₊` used for "time O(T)" (the additive `C` absorbs small inputs). -/
def wrBudget (C T : ℝ) : ℕ := ⌊C * T + C⌋₊

/-- A (batch) problem: instances, a word encoding of each instance, and the set of correct outputs. -/
structure WRProblem where
  Inst : Type
  enc : Inst → List ℕ
  Correct : Inst → List ℕ → Prop

/-- Deterministic: some algorithm solves every instance `x` within `O(T x)` steps, for every
admissible word size. (`T` may depend on any parameters of the instance.) -/
def WRSolvesIn (P : WRProblem) (T : P.Inst → ℝ) : Prop :=
  ∃ A : WRAlgo, ∃ C : ℝ, ∀ x : P.Inst, ∀ w : ℕ, WROK A.wc (P.enc x) w →
    ∃ out : List ℕ, RunsWithin A.prog w (P.enc x) (wrBudget C (T x)) out ∧ P.Correct x out

/-- The random tape determined by `L` random `w`-bit words (word `k ≥ L` reads as 0; a run of `L`
steps reads at most `L` words, so uniform `f` is exactly a uniformly random tape). -/
def wrTape {L w : ℕ} (f : Fin L → Fin (2 ^ w)) : ℕ → ℕ :=
  fun k => if h : k < L then (f ⟨k, h⟩ : ℕ) else 0

/-- Randomized (Monte Carlo, worst-case time): for every instance and admissible `w`, at least 2/3
of the random tapes make the algorithm halt within `O(T x)` steps with a correct output. -/
def WRRandSolvesIn (P : WRProblem) (T : P.Inst → ℝ) : Prop :=
  ∃ A : WRAlgo, ∃ C : ℝ, ∀ x : P.Inst, ∀ w : ℕ, WROK A.wc (P.enc x) w →
    2 * (2 ^ w) ^ (wrBudget C (T x)) ≤
      3 * Nat.card {f : Fin (wrBudget C (T x)) → Fin (2 ^ w) //
        ∃ out : List ℕ, RunsWithinR A.prog w (wrTape f) (P.enc x) (wrBudget C (T x)) out ∧
          P.Correct x out}

/-! #### Online (multi-phase) variant
Phase inputs `x₀, x₁, …` arrive one at a time. Before phase `j` the words of `x_j` overwrite
`M[0..|x_j|-1]`, `R 0 := |x_j|`, `pc := 0`; all other registers, memory and the random-tape position
persist. The phase's output is read when it halts. Phase `j` cannot see `x_{j+1}`, so answers are
online. Inputs are fixed in advance (oblivious adversary). -/

/-- Feed the next phase input into a (halted) configuration. -/
def wrFeed (s : WRCfg) (x : List ℕ) : WRCfg :=
  { s with pc := 0, reg := Function.update s.reg 0 x.length,
           mem := fun a => if a < x.length then x.getD a 0 else s.mem a }

/-- `wrPhases prog w tape s xs ts os`: starting from `s`, phase `j` gets input `xs[j]`, halts within
`ts[j]` steps and outputs `os[j]`. -/
def wrPhases (prog : List WRInstr) (w : ℕ) (tape : ℕ → ℕ) :
    WRCfg → List (List ℕ) → List ℕ → List (List ℕ) → Prop
  | _, [], [], [] => True
  | s, x :: xs, t :: ts, o :: os =>
      WRHalted prog ((wrStep prog w tape)^[t] (wrFeed s x)) ∧
      wrOutput ((wrStep prog w tape)^[t] (wrFeed s x)) = o ∧
      wrPhases prog w tape ((wrStep prog w tape)^[t] (wrFeed s x)) xs ts os
  | _, _, _, _ => False

/-- An online problem: instances, the list of phase inputs, and correct lists of phase outputs. -/
structure WROnlineProblem where
  Inst : Type
  phases : Inst → List (List ℕ)
  Correct : Inst → List (List ℕ) → Prop

/-- All words of all phases. -/
def wrAllWords (xs : List (List ℕ)) : List ℕ := xs.foldr (· ++ ·) []

/-- Randomized online solution with first-phase (preprocessing) time `O(Tpre x)` and total time of
all later phases `O(Tq x)` (so amortized time per later phase is `Tq x / (#phases - 1)`). -/
def WROnlineRandSolvesIn (P : WROnlineProblem) (Tpre Tq : P.Inst → ℝ) : Prop :=
  ∃ A : WRAlgo, ∃ C : ℝ, ∀ x : P.Inst, ∀ w : ℕ, WROK A.wc (wrAllWords (P.phases x)) w →
    2 * (2 ^ w) ^ (wrBudget C (Tpre x) + wrBudget C (Tq x)) ≤
      3 * Nat.card {f : Fin (wrBudget C (Tpre x) + wrBudget C (Tq x)) → Fin (2 ^ w) //
        ∃ ts : List ℕ, ∃ outs : List (List ℕ),
          wrPhases A.prog w (wrTape f) (wrInit w []) (P.phases x) ts outs ∧
          (ts.take 1).sum ≤ wrBudget C (Tpre x) ∧ (ts.drop 1).sum ≤ wrBudget C (Tq x) ∧
          P.Correct x outs}

/-- Deterministic online solution (all-zero tape). -/
def WROnlineSolvesIn (P : WROnlineProblem) (Tpre Tq : P.Inst → ℝ) : Prop :=
  ∃ A : WRAlgo, ∃ C : ℝ, ∀ x : P.Inst, ∀ w : ℕ, WROK A.wc (wrAllWords (P.phases x)) w →
    ∃ ts : List ℕ, ∃ outs : List (List ℕ),
      wrPhases A.prog w (fun _ => 0) (wrInit w []) (P.phases x) ts outs ∧
      (ts.take 1).sum ≤ wrBudget C (Tpre x) ∧ (ts.drop 1).sum ≤ wrBudget C (Tq x) ∧
      P.Correct x outs

/-! #### Encoding helpers -/

/-- Boolean as a word. -/
def wrBit (b : Bool) : ℕ := cond b 1 0

/-- Integer as a word (zig-zag: `z ≥ 0 ↦ 2z`, `z < 0 ↦ 2|z| + 1`). -/
def wrInt (z : ℤ) : ℕ := 2 * z.natAbs + (if z < 0 then 1 else 0)

/-- A list of pairs as a flat list of words. -/
def wrPairs : List (ℕ × ℕ) → List ℕ
  | [] => []
  | p :: l => p.1 :: p.2 :: wrPairs l

/-- Output `out` is the yes/no answer to `b`: `[1]` if `b`, `[0]` otherwise. -/
def WRAnswer (b : Prop) (out : List ℕ) : Prop := (b ∧ out = [1]) ∨ (¬ b ∧ out = [0])

/-! ### Problem-specific definitions -/

/-- An OMv instance: matrix `M r c` (`r, c < n`) and query vectors `V i c` (`i, c < n`). -/
structure OMvInst where
  n : ℕ
  M : ℕ → ℕ → Bool
  V : ℕ → ℕ → Bool

/-- Phase inputs: `[n] ++ M` (row-major), then the `n` query vectors. -/
def OMvInst.phases (x : OMvInst) : List (List ℕ) :=
  ([x.n] ++ (List.range (x.n * x.n)).map (fun t => wrBit (x.M (t / x.n) (t % x.n)))) ::
    (List.range x.n).map (fun i => (List.range x.n).map (fun c => wrBit (x.V i c)))

/-- The Boolean product `M v_i`. -/
def OMvInst.answer (x : OMvInst) (i : ℕ) : List ℕ :=
  (List.range x.n).map (fun r => wrBit ((List.range x.n).any (fun c => x.M r c && x.V i c)))

/-- Correct transcript: phase `i+1` outputs `M v_i` (phase 0 output arbitrary). -/
def OMvInst.Correct (x : OMvInst) (outs : List (List ℕ)) : Prop :=
  outs.drop 1 = (List.range x.n).map x.answer

/-- General OMv. -/
def OMvP : WROnlineProblem where
  Inst := OMvInst
  phases := fun (x : OMvInst) => x.phases
  Correct := fun (x : OMvInst) (outs : List (List ℕ)) => x.Correct outs

/-- The OMv conjecture (randomized, total time including preprocessing). -/
def OMvConjecture : Prop :=
  ∀ ε : ℝ, 0 < ε → ¬ WROnlineRandSolvesIn OMvP
    (fun (x : OMvInst) => (x.n : ℝ) ^ ((3 : ℝ) - ε))
    (fun (x : OMvInst) => (x.n : ℝ) ^ ((3 : ℝ) - ε))

/-- The `n × n` Boolean matrix `M` has VC-dimension at most `d` (rows shattering column sets). -/
def VCLe (M : ℕ → ℕ → Bool) (n d : ℕ) : Prop :=
  ∀ S : Finset ℕ, (∀ c ∈ S, c < n) →
    (∀ T : Finset ℕ, T ⊆ S → ∃ r : ℕ, r < n ∧ ∀ c ∈ S, (M r c = true ↔ c ∈ T)) →
    S.card ≤ d

/-- OMv restricted to matrices of VC-dimension at most `dfun n`. -/
def VCOMv (dfun : ℕ → ℕ) : WROnlineProblem where
  Inst := {x : OMvInst // VCLe x.M x.n (dfun x.n)}
  phases := fun (x : {x : OMvInst // VCLe x.M x.n (dfun x.n)}) => x.1.phases
  Correct := fun (x : {x : OMvInst // VCLe x.M x.n (dfun x.n)}) (outs : List (List ℕ)) =>
    x.1.Correct outs

/-- The desired lower bound: query time `n^{2 - c/d - o(1)}` for all `d ≤ D(n)`. -/
def Conclusion : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ D : ℕ → ℕ, Filter.Tendsto D Filter.atTop Filter.atTop ∧
    ∀ dfun : ℕ → ℕ, (∀ n : ℕ, 1 ≤ dfun n ∧ dfun n ≤ D n) →
      ∀ ε : ℝ, 0 < ε → ∀ p : ℕ,
        ¬ WROnlineRandSolvesIn (VCOMv dfun)
          (fun (x : {x : OMvInst // VCLe x.M x.n (dfun x.n)}) => (x.1.n : ℝ) ^ p)
          (fun (x : {x : OMvInst // VCLe x.M x.n (dfun x.n)}) =>
            (x.1.n : ℝ) ^ ((3 : ℝ) - c / (dfun x.1.n : ℝ) - ε))

def Claim : Prop := OMvConjecture → Conclusion

end

end OpenProblems.QEDM039
