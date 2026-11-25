import Mathlib
/-! QED-M042: Sparse 3-LPN at noise n^{-1/2}: beating Gaussian elimination
For 3-sparse LPN with m = n^{1.4} samples and noise rate η = n^{-0.6}, is there an algorithm running in
time exp(o(ηn))? (The original also offers, as an alternative, lower bounds in restricted models such
as low-degree or SoS.)
Informal statement: Fix k = 3, m = ⌊n^{1.4}⌋ and η = n^{-0.6}. In the 3-sparse LPN problem a secret s ∈ F_2^n
is uniform, each sample is (a_i, ⟨a_i,s⟩ + e_i) with a_i uniform among weight-3 vectors of F_2^n and
e_i ~ Bernoulli(η) independent, i = 1..m. Prove or disprove: there is a (classical, randomized) algorithm
that, given the m samples, outputs s with probability ≥ 2/3 (for all sufficiently large n) in time
exp(o(ηn)) = exp(o(n^{0.4})).
Formalization notes:
* Machine model: the board's canonical word-RAM block (pasted verbatim below). Randomness: the
  algorithm's random tape of `t` words, uniform, exactly as in `WRRandSolvesIn`; `wrProb` is the
  probability (counting ratio over tapes) that the run halts within `t` steps with a given output. Runs
  that do not halt within the budget count as failures, so the budget is a worst-case time bound.
* Input: `[n, m]` followed, for each sample i, by the three positions of a_i in increasing order (via
  `Finset.orderEmbOfFin`) and the label bit. Output: the n bits of s (`wrBit`). A weight-3 vector is a
  3-element subset of `Fin n`; a_i is uniform over the `Fintype` of such subsets.
* Success probability `lpnSuccess n w t` = Σ over s, (a_i), (e_i) of the exact product weight
  2^{-n} · |W|^{-m} · Π_i η^{e_i}(1-η)^{1-e_i} times the probability over the tape of outputting s.
* exp(o(ηn)): a single algorithm with budget O(exp(f(n))) where f(n)/n^{0.4} → 0. The input has
  O(n^{1.4}) words, so reading it fits in this budget. The word-size convention (all admissible
  w ≥ (wc+1)·log(input length)) must hold for every admissible w, for all n ≥ N.
* Only the algorithmic question is formalized (per the M_fix): Claim = existence of such an algorithm;
  ¬Claim = an unconditional exp(Ω(ηn))-type lower bound (infinitely often) against all word-RAM
  algorithms. The restricted-model lower-bound alternative is a different statement and is not included.
* Loophole audit: s is information-theoretically recoverable w.h.p. in this regime (each variable occurs
  in ≈ 3n^{0.4} equations, ≈ n^{0.8} of the m equations are noisy), and exp(O(ηn·polylog)) algorithms
  exist, so the success threshold is attainable in the model; the question is purely about the o(·).
-/
namespace OpenProblems.QEDM042
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

/-- Probability over a uniform random tape of `t` words that the run on `input` halts within `t`
steps with output `out`. -/
def wrProb (prog : List WRInstr) (w t : ℕ) (input out : List ℕ) : ℝ :=
  (Nat.card {f : Fin t → Fin (2 ^ w) // RunsWithinR prog w (wrTape f) input t out} : ℝ) /
    ((2 : ℝ) ^ w) ^ t

/-- Weight-3 vectors of `𝔽₂ⁿ`, as 3-element subsets of `Fin n`. -/
abbrev W3 (n : ℕ) : Type := {S : Finset (Fin n) // S.card = 3}

/-- Number of samples `m = ⌊n^{1.4}⌋`. -/
def numSamples (n : ℕ) : ℕ := ⌊(n : ℝ) ^ ((7 : ℝ) / 5)⌋₊

/-- Noise rate `η = n^{-0.6}`. -/
def eta (n : ℕ) : ℝ := (n : ℝ) ^ (-((3 : ℝ) / 5))

/-- Encoding of the samples `(a_i, y_i)`: `[n, m]`, then per sample the 3 sorted positions and the label. -/
def lpnEnc (n m : ℕ) (a : Fin m → W3 n) (y : Fin m → ℕ) : List ℕ :=
  [n, m] ++ wrAllWords (List.ofFn (fun i : Fin m =>
    List.ofFn (fun j : Fin 3 => (((a i).1.orderEmbOfFin (a i).2 j : Fin n) : ℕ)) ++ [y i]))

/-- Label `⟨a, s⟩ + e` over `𝔽₂`, as a word in `{0,1}`. -/
def lpnLabel {n : ℕ} (a : W3 n) (s : Fin n → Bool) (e : Bool) : ℕ :=
  ((a.1.filter (fun j : Fin n => s j = true)).card + wrBit e) % 2

/-- Encoding of the secret (the required output). -/
def secretEnc {n : ℕ} (s : Fin n → Bool) : List ℕ := List.ofFn (fun j : Fin n => wrBit (s j))

/-- Exact success probability of program `prog` (word size `w`, budget `t`) on 3-sparse LPN with
`m = ⌊n^{1.4}⌋`, `η = n^{-0.6}`. -/
def lpnSuccess (prog : List WRInstr) (n w t : ℕ) : ℝ :=
  ∑ s : Fin n → Bool, ∑ a : Fin (numSamples n) → W3 n, ∑ e : Fin (numSamples n) → Bool,
    ((2 : ℝ) ^ n)⁻¹ * ((Fintype.card (Fin (numSamples n) → W3 n) : ℕ) : ℝ)⁻¹ *
      (∏ i : Fin (numSamples n), (if e i = true then eta n else 1 - eta n)) *
      wrProb prog w t (lpnEnc n (numSamples n) a (fun (i : Fin _) => lpnLabel (a i) s (e i))) (secretEnc s)

/-- There is a randomized word-RAM algorithm recovering the secret of 3-sparse LPN (`m = ⌊n^{1.4}⌋`,
`η = n^{-0.6}`) with probability ≥ 2/3 for all large `n`, in time `exp(o(η n)) = exp(o(n^{0.4}))`. -/
def Claim : Prop :=
  ∃ f : ℕ → ℝ,
    Filter.Tendsto (fun n : ℕ => f n / (n : ℝ) ^ ((2 : ℝ) / 5)) Filter.atTop (nhds 0) ∧
    ∃ A : WRAlgo, ∃ C : ℝ, ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ w : ℕ,
      (∀ (a : Fin (numSamples n) → W3 n) (y : Fin (numSamples n) → Bool),
          WROK A.wc (lpnEnc n (numSamples n) a (fun (i : Fin _) => wrBit (y i))) w) →
        (2 : ℝ) / 3 ≤ lpnSuccess A.prog n w (wrBudget C (Real.exp (f n)))

end
end OpenProblems.QEDM042
