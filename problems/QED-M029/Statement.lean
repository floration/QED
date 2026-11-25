import Mathlib
/-! QED-M029: A uniformly samplable counterexample to the poly-time low-degree conjecture
Find a uniform randomized polynomial-time sampler for a permutation-invariant graph distribution with
vanishing low-degree advantage up to degree Θ((log n)^{r-1}) that is nevertheless detected by a
polynomial-time test after constant-rate edge resampling (removing the non-uniform advice in Mao's
counterexample).
Informal statement: For some fixed r ≥ 3, give a single randomized algorithm that, given 1^n, samples in
expected poly(n) time from a permutation-invariant distribution P_n on n-vertex graphs whose low-degree
advantage over G(n,1/2) vanishes (→ 0) up to degree D_n = Θ((log n)^{r-1}), while after independent edge
resampling at a fixed rate δ ∈ (0,1) a deterministic poly-time test distinguishes it from G(n,1/2) with
both error probabilities → 0. (A sufficient route via Mao's construction: find in poly(n) time evaluation
points with every ≤ L of the vectors φ(x_i) linearly independent; this route is not part of the Claim.)
Formalization notes:
* Machine model: the board's canonical word-RAM block (pasted verbatim below). Input of the sampler:
  the unary string 1^n (`List.replicate n 1`), so admissible word sizes are w ≥ (wc+1)·log n.
  Output: the n×n adjacency matrix, row-major, as n² bits.
* Expected time with an unbounded random tape: the first t tape words are uniform `Fin t → Fin (2^w)`
  (`wrTape`); a run of t steps reads at most t words, so `haltProb t` (fraction of length-t tapes on
  which the machine has halted after t steps) is exactly Pr[T ≤ t] for a uniformly random infinite tape,
  and `outProb t G` is exactly Pr[T ≤ t ∧ output = G]. E[T] = Σ_t Pr[T > t]; "expected poly time" is
  ∀ t, Σ_{s<t} (1 - haltProb s) ≤ C·n^c + C. The output law is P(G) = sup_t outProb t G (a monotone
  limit); we additionally require Σ_G P(G) = 1 (a.s. halting with a valid graph encoding).
* Graphs: subsets G of `edges n` = {(i,j) : i < j}; `adj G i j` symmetric. Relabelling by σ ∈ S_n:
  (i,j) ∈ σ•G iff {σ i, σ j} ∈ G. Permutation invariance: P(σ•G) = P(G).
* Low-degree advantage: with Fourier characters χ_S(G) = (-1)^{|S∩G|} on {0,1}^{edges} and likelihood
  ratio L = dP/dQ (Q = G(n,1/2) uniform), ‖L^{≤D}‖² - 1 = Σ_{1≤|S|≤D} (E_P χ_S)². This is the standard
  quantity (Hopkins). "Vanishes" = → 0 as n → ∞; D_n = ⌈c₀ (log n)^{r-1}⌉ with c₀ > 0. Since the
  advantage is monotone in D, demanding it at D_n ≥ c₀(log n)^{r-1} captures "D_n = Θ((log n)^{r-1})".
* Resampling at rate δ: each edge independently, with probability δ, is replaced by a fresh fair bit:
  kernel K(b,b') = 1-δ/2 if b = b', δ/2 otherwise. G(n,1/2) is invariant under it.
* Test: a deterministic word-RAM algorithm on the adjacency matrix, budget O(n^c); "accept" = halts within
  budget with output [1]. Distinguishing: Pr_{P_δ}[reject] + Pr_Q[accept] ≤ ε for all large n, uniformly in
  the admissible word sizes of sampler and test. (Mao's rank test is deterministic; allowing only
  deterministic tests is a slight strengthening of the requirement.)
* Each distribution P_{n,w} may depend on the admissible word size w; all requirements are imposed for
  every admissible w (the model's convention).
* Claim = existence of (r, c₀, δ, sampler, test). ¬Claim = no uniform expected-poly-time sampler yields such
  a counterexample. Loophole audit: P = G(n,1/2) has advantage 0 but fails the test requirement; a
  sampler emitting garbage has P = 0, violating Σ P = 1; the test must succeed on BOTH sides, so trivial
  tests fail.
-/
namespace OpenProblems.QEDM029
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

/-! ### Graphs, Fourier characters, low-degree advantage, resampling -/

/-- Potential edges `(i, j)` with `i < j`. -/
def edges (n : ℕ) : Finset (Fin n × Fin n) :=
  (Finset.univ : Finset (Fin n × Fin n)).filter (fun p : Fin n × Fin n => p.1 < p.2)

/-- All graphs on `Fin n` (edge sets). -/
def graphs (n : ℕ) : Finset (Finset (Fin n × Fin n)) := (edges n).powerset

/-- Adjacency in `G` (symmetric). -/
def adj {n : ℕ} (G : Finset (Fin n × Fin n)) (i j : Fin n) : Prop := (i, j) ∈ G ∨ (j, i) ∈ G

instance {n : ℕ} (G : Finset (Fin n × Fin n)) (i j : Fin n) : Decidable (adj G i j) := by
  unfold adj; infer_instance

/-- Relabelling by `σ`: `{i,j}` is an edge of `σ • G` iff `{σ i, σ j}` is an edge of `G`. -/
def relabel {n : ℕ} (σ : Equiv.Perm (Fin n)) (G : Finset (Fin n × Fin n)) :
    Finset (Fin n × Fin n) :=
  (edges n).filter (fun p : Fin n × Fin n => adj G (σ p.1) (σ p.2))

/-- Adjacency-matrix encoding (row-major, `n²` bits). -/
def graphEnc {n : ℕ} (G : Finset (Fin n × Fin n)) : List ℕ :=
  List.ofFn (fun t : Fin (n * n) =>
    wrBit (decide (adj G (finProdFinEquiv.symm t).1 (finProdFinEquiv.symm t).2)))

/-- Fourier character `χ_S(G) = (-1)^{|S ∩ G|}`. -/
def chi {n : ℕ} (S G : Finset (Fin n × Fin n)) : ℝ := (-1 : ℝ) ^ (S ∩ G).card

/-- Low-degree advantage `‖L^{≤D}‖² - 1 = Σ_{1 ≤ |S| ≤ D} (E_P χ_S)²` of `P` over `G(n,1/2)`. -/
def lowDegAdv (n D : ℕ) (P : Finset (Fin n × Fin n) → ℝ) : ℝ :=
  ∑ S ∈ (graphs n).filter (fun S : Finset (Fin n × Fin n) => 1 ≤ S.card ∧ S.card ≤ D),
    (∑ G ∈ graphs n, P G * chi S G) ^ 2

/-- Law after resampling each edge independently with probability `δ` by a fair bit. -/
def resample (n : ℕ) (δ : ℝ) (P : Finset (Fin n × Fin n) → ℝ) (H : Finset (Fin n × Fin n)) : ℝ :=
  ∑ G ∈ graphs n, P G *
    ∏ e ∈ edges n, (if (e ∈ G ↔ e ∈ H) then 1 - δ / 2 else δ / 2)

/-- `G(n, 1/2)`. -/
def unifG (n : ℕ) (_H : Finset (Fin n × Fin n)) : ℝ := ((1 : ℝ) / 2) ^ (edges n).card

/-! ### Sampler semantics (unbounded random tape, expected time) -/

/-- `Pr[T ≤ t]`: fraction of length-`t` tapes on which the run on `input` has halted after `t` steps. -/
def haltProb (prog : List WRInstr) (w : ℕ) (input : List ℕ) (t : ℕ) : ℝ :=
  (Nat.card {f : Fin t → Fin (2 ^ w) //
      WRHalted prog ((wrStep prog w (wrTape f))^[t] (wrInit w input))} : ℝ) / ((2 : ℝ) ^ w) ^ t

/-- `Pr[T ≤ t ∧ output = out]`. -/
def outProb (prog : List WRInstr) (w : ℕ) (input : List ℕ) (t : ℕ) (out : List ℕ) : ℝ :=
  (Nat.card {f : Fin t → Fin (2 ^ w) // RunsWithinR prog w (wrTape f) input t out} : ℝ) /
    ((2 : ℝ) ^ w) ^ t

/-- The sampler's output law on graphs: `P(G) = lim_t Pr[T ≤ t ∧ output = enc G]` (monotone in `t`). -/
def sampLaw (prog : List WRInstr) (w n : ℕ) (G : Finset (Fin n × Fin n)) : ℝ :=
  ⨆ t : ℕ, outProb prog w (List.replicate n 1) t (graphEnc G)

/-- Expected running time on `1^n` at most `C n^c + C`: `Σ_{s<t} Pr[T > s] ≤ C n^c + C` for all `t`. -/
def ExpTimeLE (prog : List WRInstr) (w n : ℕ) (C : ℝ) (c : ℕ) : Prop :=
  ∀ t : ℕ, ∑ s ∈ Finset.range t, (1 - haltProb prog w (List.replicate n 1) s) ≤
    C * (n : ℝ) ^ c + C

/-- Acceptance of graph `H` by the deterministic test `T` (word size `w`, budget `b`), as 0/1. -/
def testAcc (T : WRAlgo) (w b n : ℕ) (H : Finset (Fin n × Fin n)) : ℝ := by
  classical
  exact if RunsWithin T.prog w (graphEnc H) b [1] then 1 else 0

/-- Some `r ≥ 3`, `c₀ > 0`, `δ ∈ (0,1)`, a uniform expected-poly-time sampler on `1^n` and a
deterministic poly-time test such that the sampled law is permutation invariant, has vanishing degree
`⌈c₀ (log n)^{r-1}⌉` advantage, and after `δ`-resampling is distinguished from `G(n,1/2)` by the test. -/
def Claim : Prop :=
  ∃ r : ℕ, 3 ≤ r ∧ ∃ c₀ : ℝ, 0 < c₀ ∧ ∃ δ : ℝ, 0 < δ ∧ δ < 1 ∧
  ∃ S : WRAlgo, ∃ CS : ℝ, ∃ cS : ℕ, ∃ T : WRAlgo, ∃ CT : ℝ, ∃ cT : ℕ,
    (∀ n w : ℕ, WROK S.wc (List.replicate n 1) w →
      ExpTimeLE S.prog w n CS cS ∧
      ∑ G ∈ graphs n, sampLaw S.prog w n G = 1 ∧
      ∀ σ : Equiv.Perm (Fin n), ∀ G ∈ graphs n,
        sampLaw S.prog w n (relabel σ G) = sampLaw S.prog w n G) ∧
    ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ w : ℕ, WROK S.wc (List.replicate n 1) w →
      lowDegAdv n ⌈c₀ * Real.log (n : ℝ) ^ (r - 1)⌉₊ (sampLaw S.prog w n) ≤ ε ∧
      ∀ w' : ℕ, (∀ H ∈ graphs n, WROK T.wc (graphEnc H) w') →
        (1 - ∑ H ∈ graphs n, resample n δ (sampLaw S.prog w n) H *
              testAcc T w' (wrBudget CT ((n : ℝ) ^ cT)) n H) +
          ∑ H ∈ graphs n, unifG n H * testAcc T w' (wrBudget CT ((n : ℝ) ^ cT)) n H ≤ ε

end
end OpenProblems.QEDM029
