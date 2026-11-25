import Mathlib
/-! QED-E082: Binary-error LWE with linearly many samples
For LWE with secret in Z_q^n (q = poly(n)) and uniform binary errors, given m = Cn samples for a fixed
C > 1: find a subexponential algorithm or prove hardness from standard LWE.
Informal statement: Fix q = q(n) with 2 ≤ q(n) ≤ poly(n) and a constant C > 1; let m = ⌈Cn⌉. In
decision binary-error LWE one is given (A, b) with A uniform in Z_q^{m×n} and either b = As + e mod q
(s uniform in Z_q^n, e uniform in {0,1}^m) or b uniform in Z_q^m. Show that (for every such C and q) one of
the following holds: (a) some randomized algorithm running in time 2^{o(n)} distinguishes the two cases
with non-negligible advantage; or (b) binary-error LWE with these parameters is hard (no poly-time
distinguisher has non-negligible advantage) assuming standard decision LWE is hard for some standard
parameter family (dimension n' polynomially related to n, modulus and sample count poly(n), discrete
Gaussian error of width αq' ≥ 2√n'). Known: Arora-Ge linearization solves it in poly time for m ≈ n²;
Micciancio-Peikert prove (b) for m = n(1+O(1/log n)).
NARROWED (referee): only moduli q(n) all of whose prime factors are at most n^{1/2+o(1)} (e.g. q ≤ √n, or q a
power of 2). For q with a prime factor p = n^{a+o(1)}, a > 1/2, (a) already follows: reduce mod p, pass to
normal form (binary secret, (C-1)n samples) and apply the distinguisher of ePrint 2026/2289.
Formalization notes:
* Narrowing: `SmallPrimes q` = there is g(n) → 0 with every prime p ∣ q(n) satisfying p ≤ n^{1/2 + g(n)}
  for all n ≥ 2 (exactly "all prime factors ≤ n^{1/2+o(1)}").
* Machine model: the board's canonical word-RAM block (pasted verbatim below). A distinguisher is a
  `WRAlgo`; it accepts when it halts within the budget with output `[1]` (non-halting runs reject, so the
  budget is a worst-case clock). `wrProb` is the exact probability over a uniform random tape.
  Every statement quantifies over all word sizes admissible for every instance of the given size
  (w ≥ (wc+1)·log(input length) and all words < 2^w).
* Inputs: `[n, m, q]`, then A row-major, then b (all entries < q, one word each). Probabilities are exact
  finite averages (binary case) or weighted sums with the discrete Gaussian mass function (standard case).
* Discrete Gaussian: ρ_s(z) = exp(-π z²/s²) on ℤ, normalized by Σ_z ρ_s(z), reduced mod q' (`dgMod`);
  this is the standard D_{ℤ,s} mod q' error of Regev/Peikert LWE with s = αq'.
* Advantage `adv` = |Pr[accept | LWE] - Pr[accept | uniform]|. `Breaks T` = for some d, for infinitely many n,
  at every admissible word size the advantage with budget O(T n) is ≥ n^{-d} (non-negligible).
  Hardness = no algorithm Breaks with polynomial budget (exactly the negation, quantified over all
  algorithms and all polynomial budgets C·n^c).
* (a) = `BinEasy C q`: one algorithm with budget O(2^{f(n)}), f(n)/n → 0, breaks binary LWE.
  (b) = some standard parameter family `P` (`StdParams`: 2 ≤ q'(n) ≤ n^c, m'(n) ≤ n^c, n ≤ n'(n)^c,
  1 ≤ n'(n) ≤ n^c, width ≥ 2√n') with `LWEHard P → BinHard C q`. "Polynomial loss" is captured because
  both sides are about polynomial time and non-negligible advantage, closed under polynomial blowups.
  The implication form (rather than an explicit black-box reduction) is the standard way to state
  "as hard as LWE"; any black-box reduction proves it.
* Decision versions are used throughout: for (a) distinguishing is the weaker requirement (search ⇒
  decision), and decision-hardness is what the cryptographic applications and Micciancio–Peikert give.
* Judgement call: the informal "either (a) or (b)" is formalized as the dichotomy
  Claim := ∀ C > 1, ∀ poly-bounded q, (a) ∨ (b). Proving Claim settles every (C, q) (possibly with the
  answer depending on (C, q)); ¬Claim exhibits (C, q) where neither holds (no 2^{o(n)} attack exists and
  hardness does not follow from LWE in this sense), which would itself require an unconditional lower
  bound. Loophole audit: for q = 2 binary errors make b exactly uniform, so (a) fails and (b) holds
  (BinHard is then true outright) — correct behaviour; the constraint width ≥ 2√n' keeps the LWE
  hypothesis from being trivially refutable (tiny error ⇒ Gaussian elimination).
-/
namespace OpenProblems.QEDE082
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

/-- Encoding of an LWE instance `(A, b)`: `[n, m, q]`, `A` row-major, then `b`. -/
def lweEnc (n m q : ℕ) (A : Fin m → Fin n → Fin q) (b : Fin m → ℕ) : List ℕ :=
  [n, m, q] ++
    List.ofFn (fun t : Fin (m * n) =>
      ((A (finProdFinEquiv.symm t).1 (finProdFinEquiv.symm t).2 : Fin q) : ℕ)) ++
    List.ofFn b

/-- `(A s + e) mod q`, with `e` given as natural numbers. -/
def lweRHS {n m q : ℕ} (A : Fin m → Fin n → Fin q) (s : Fin n → Fin q) (e : Fin m → ℕ) :
    Fin m → ℕ :=
  fun i => ((∑ j : Fin n, ((A i j : Fin q) : ℕ) * ((s j : Fin q) : ℕ)) + e i) % q

/-- Admissible word sizes for all instances of shape `(n, m, q)`. -/
def AdmAll (wc n m q w : ℕ) : Prop :=
  ∀ (A : Fin m → Fin n → Fin q) (b : Fin m → Fin q), WROK wc (lweEnc n m q A (fun (i : Fin _) => (b i : ℕ))) w

/-- Acceptance probability on uniform `(A, b)`. -/
def accUnif (prog : List WRInstr) (n m q w t : ℕ) : ℝ :=
  ((Fintype.card (Fin m → Fin n → Fin q) : ℕ) : ℝ)⁻¹ * ((Fintype.card (Fin m → Fin q) : ℕ) : ℝ)⁻¹ *
    ∑ A : Fin m → Fin n → Fin q, ∑ b : Fin m → Fin q,
      wrProb prog w t (lweEnc n m q A (fun (i : Fin _) => (b i : ℕ))) [1]

/-- Acceptance probability on binary-error LWE samples (`e` uniform in `{0,1}^m`). -/
def accBin (prog : List WRInstr) (n m q w t : ℕ) : ℝ :=
  ((Fintype.card (Fin m → Fin n → Fin q) : ℕ) : ℝ)⁻¹ * ((Fintype.card (Fin n → Fin q) : ℕ) : ℝ)⁻¹ *
    ((2 : ℝ) ^ m)⁻¹ *
    ∑ A : Fin m → Fin n → Fin q, ∑ s : Fin n → Fin q, ∑ e : Fin m → Bool,
      wrProb prog w t (lweEnc n m q A (lweRHS A s (fun (i : Fin _) => wrBit (e i)))) [1]

/-- Gaussian function `ρ_s(z) = exp(-π z² / s²)`. -/
def rho (s : ℝ) (z : ℤ) : ℝ := Real.exp (-Real.pi * (z : ℝ) ^ 2 / s ^ 2)

/-- Discrete Gaussian `D_{ℤ,s}` reduced mod `q`: probability of residue `e`. -/
def dgMod (s : ℝ) (q : ℕ) (e : Fin q) : ℝ :=
  (∑' z : ℤ, if z % (q : ℤ) = ((e : ℕ) : ℤ) then rho s z else 0) / (∑' z : ℤ, rho s z)

/-- Acceptance probability on standard LWE samples with discrete Gaussian error of width `s`. -/
def accGauss (prog : List WRInstr) (n m q w t : ℕ) (s : ℝ) : ℝ :=
  ((Fintype.card (Fin m → Fin n → Fin q) : ℕ) : ℝ)⁻¹ * ((Fintype.card (Fin n → Fin q) : ℕ) : ℝ)⁻¹ *
    ∑ A : Fin m → Fin n → Fin q, ∑ sec : Fin n → Fin q, ∑ e : Fin m → Fin q,
      (∏ i : Fin m, dgMod s q (e i)) *
        wrProb prog w t (lweEnc n m q A (lweRHS A sec (fun (i : Fin _) => ((e i : Fin q) : ℕ)))) [1]

/-- Non-negligible advantage: for some `d`, for infinitely many `n`, at every admissible word size the
advantage `adv n w` is at least `n^{-d}`. -/
def NonNegl (adm : ℕ → ℕ → Prop) (adv : ℕ → ℕ → ℝ) : Prop :=
  ∃ d : ℕ, ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ ∀ w : ℕ, adm n w → 1 / (n : ℝ) ^ d ≤ adv n w

/-- `A` breaks binary-error LWE (`m = ⌈C n⌉`, modulus `q n`) with budget `O(T n)`. -/
def BinBreaks (C : ℝ) (q : ℕ → ℕ) (A : WRAlgo) (Cst : ℝ) (T : ℕ → ℝ) : Prop :=
  NonNegl (fun (n w : ℕ) => AdmAll A.wc n ⌈C * (n : ℝ)⌉₊ (q n) w)
    (fun (n w : ℕ) => |accBin A.prog n ⌈C * (n : ℝ)⌉₊ (q n) w (wrBudget Cst (T n)) -
                 accUnif A.prog n ⌈C * (n : ℝ)⌉₊ (q n) w (wrBudget Cst (T n))|)

/-- (a): a `2^{o(n)}`-time distinguisher for binary-error LWE. -/
def BinEasy (C : ℝ) (q : ℕ → ℕ) : Prop :=
  ∃ f : ℕ → ℝ, Filter.Tendsto (fun n : ℕ => f n / (n : ℝ)) Filter.atTop (nhds 0) ∧
    ∃ A : WRAlgo, ∃ Cst : ℝ, BinBreaks C q A Cst (fun (n : ℕ) => (2 : ℝ) ^ (f n))

/-- Binary-error LWE is hard for polynomial time. -/
def BinHard (C : ℝ) (q : ℕ → ℕ) : Prop :=
  ∀ A : WRAlgo, ∀ Cst : ℝ, ∀ c : ℕ, ¬ BinBreaks C q A Cst (fun (n : ℕ) => (n : ℝ) ^ c)

/-- A family of standard LWE parameters indexed by the security parameter `n`. -/
structure LWEParams where
  dim : ℕ → ℕ
  modulus : ℕ → ℕ
  samples : ℕ → ℕ
  width : ℕ → ℝ

/-- Standard parameters: polynomially related dimension, polynomial modulus and sample count, Gaussian
width `s = αq' ≥ 2√n'`. -/
def StdParams (P : LWEParams) : Prop :=
  ∃ c : ℕ, ∀ n : ℕ, 1 ≤ n →
    2 ≤ P.modulus n ∧ P.modulus n ≤ n ^ c ∧ P.samples n ≤ n ^ c ∧
    1 ≤ P.dim n ∧ P.dim n ≤ n ^ c ∧ n ≤ P.dim n ^ c ∧
    2 * Real.sqrt (P.dim n : ℝ) ≤ P.width n

/-- Standard decision LWE with parameters `P` is hard for polynomial time. -/
def LWEHard (P : LWEParams) : Prop :=
  ∀ A : WRAlgo, ∀ Cst : ℝ, ∀ c : ℕ,
    ¬ NonNegl (fun (n w : ℕ) => AdmAll A.wc (P.dim n) (P.samples n) (P.modulus n) w)
      (fun (n w : ℕ) =>
        |accGauss A.prog (P.dim n) (P.samples n) (P.modulus n) w (wrBudget Cst ((n : ℝ) ^ c))
            (P.width n) -
          accUnif A.prog (P.dim n) (P.samples n) (P.modulus n) w (wrBudget Cst ((n : ℝ) ^ c))|)

/-- Every prime factor of `q n` is at most `n^{1/2 + o(1)}`. -/
def SmallPrimes (q : ℕ → ℕ) : Prop :=
  ∃ g : ℕ → ℝ, Filter.Tendsto g Filter.atTop (nhds 0) ∧
    ∀ n : ℕ, 2 ≤ n → ∀ p : ℕ, p.Prime → p ∣ q n → (p : ℝ) ≤ (n : ℝ) ^ ((1 : ℝ) / 2 + g n)

/-- Dichotomy for binary-error LWE with `m = ⌈C n⌉` samples: for every `C > 1` and polynomially bounded
modulus whose prime factors are all ≤ `n^{1/2+o(1)}`, either a `2^{o(n)}` attack exists, or hardness follows from standard LWE. -/
def Claim : Prop :=
  ∀ C : ℝ, 1 < C → ∀ q : ℕ → ℕ, (∃ c : ℕ, ∀ n : ℕ, 2 ≤ q n ∧ q n ≤ n ^ c + c) → SmallPrimes q →
    BinEasy C q ∨ ∃ P : LWEParams, StdParams P ∧ (LWEHard P → BinHard C q)

end
end OpenProblems.QEDE082
