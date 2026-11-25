import Mathlib
/-! QED-M030: All-Edges Sparse Triangle below m^{4/3} on balanced instances
For each edge of a sparse balanced tripartite graph (three parts of size N, m = Θ(N^{3/2})
edges, all degrees O(√N)), report whether it lies in a triangle, in time O(m^{4/3-ε}); this is
Patrascu's balanced regime, left open by Alman and Vassilevska Williams.
Informal statement: Model: word-RAM with Θ(log N)-bit words. Is there a fixed ε > 0 such that for
all constants α, δ > 0 there is a randomized (Monte Carlo, success ≥ 2/3) word-RAM algorithm that,
given a tripartite graph on parts A, B, C with |A| = |B| = |C| = N, m ≥ α·N^{3/2} edges and maximum
degree ≤ δ·√N (so m ≤ 3δ·N^{3/2}), decides for every edge whether it lies in a triangle, in time
O(m^{4/3-ε})? (The alternative "derive an m^{4/3-o(1)} lower bound from a hypothesis surviving
AVW" is a separate conditional question, not part of Claim.)
Formalization notes: Uses the shared QED word-RAM block (WordRAM, pasted below): unit-cost
standard instructions on w-bit words, algorithm correct for every w ≥ (wc+1)·log₂ n, randomized =
Monte Carlo over random tapes counted with Nat.card, time O(T) = ⌊C·T + C⌋ steps with C fixed
before the instance. Input: the standard edge-list encoding `TriGraph.enc` (sizes, then the three
duplicate-free edge lists AB, BC, AC, vertices numbered from 0 in each part). Output: one word per
edge in input order, 1 if the edge lies in a triangle, 0 otherwise. The family `Balanced α δ`
encodes m = Θ(N^{3/2}) and max degree O(√N) with explicit constants; ε is quantified before the
constants ("some fixed ε"), the algorithm and its O-constant after them. Deterministic algorithms
are a special case of randomized ones. Proving `Claim` = such an algorithm; `¬Claim` = for every
ε > 0, some balanced family has no O(m^{4/3-ε}) randomized word-RAM algorithm (an unconditional
lower bound, out of reach).
-/
namespace OpenProblems.QEDM030

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

/-- A tripartite graph with parts `A = {0..nA-1}`, `B = {0..nB-1}`, `C = {0..nC-1}`, given by
duplicate-free edge lists `AB` (pairs `(a,b)`), `BC` (pairs `(b,c)`) and `AC` (pairs `(a,c)`). -/
structure TriGraph where
  nA : ℕ
  nB : ℕ
  nC : ℕ
  AB : List (ℕ × ℕ)
  BC : List (ℕ × ℕ)
  AC : List (ℕ × ℕ)
  hAB : AB.Nodup ∧ ∀ e ∈ AB, e.1 < nA ∧ e.2 < nB
  hBC : BC.Nodup ∧ ∀ e ∈ BC, e.1 < nB ∧ e.2 < nC
  hAC : AC.Nodup ∧ ∀ e ∈ AC, e.1 < nA ∧ e.2 < nC

/-- Number of edges. -/
def TriGraph.m (G : TriGraph) : ℕ := G.AB.length + G.BC.length + G.AC.length

/-- The edge `(a,b)` of `AB` (resp. `(b,c)` of `BC`, `(a,c)` of `AC`) lies in a triangle. -/
def TriGraph.triAB (G : TriGraph) (e : ℕ × ℕ) : Prop := ∃ c : ℕ, (e.2, c) ∈ G.BC ∧ (e.1, c) ∈ G.AC
def TriGraph.triBC (G : TriGraph) (e : ℕ × ℕ) : Prop := ∃ a : ℕ, (a, e.1) ∈ G.AB ∧ (a, e.2) ∈ G.AC
def TriGraph.triAC (G : TriGraph) (e : ℕ × ℕ) : Prop := ∃ b : ℕ, (e.1, b) ∈ G.AB ∧ (b, e.2) ∈ G.BC

/-- Degrees of `a ∈ A`, `b ∈ B`, `c ∈ C`. -/
def TriGraph.degA (G : TriGraph) (a : ℕ) : ℕ :=
  (G.AB.filter (fun e => e.1 == a)).length + (G.AC.filter (fun e => e.1 == a)).length
def TriGraph.degB (G : TriGraph) (b : ℕ) : ℕ :=
  (G.AB.filter (fun e => e.2 == b)).length + (G.BC.filter (fun e => e.1 == b)).length
def TriGraph.degC (G : TriGraph) (c : ℕ) : ℕ :=
  (G.BC.filter (fun e => e.2 == c)).length + (G.AC.filter (fun e => e.2 == c)).length

/-- Standard edge-list encoding: `[nA, nB, nC, |AB|, |BC|, |AC|]` then the three edge lists. -/
def TriGraph.enc (G : TriGraph) : List ℕ :=
  [G.nA, G.nB, G.nC, G.AB.length, G.BC.length, G.AC.length] ++
    wrPairs G.AB ++ wrPairs G.BC ++ wrPairs G.AC

/-- `o` labels the edge list `es` correctly: one word per edge, 1 iff the edge is in a triangle. -/
def TriLabels (tri : ℕ × ℕ → Prop) (es : List (ℕ × ℕ)) (o : List ℕ) : Prop :=
  o.length = es.length ∧ ∀ i : ℕ, i < es.length → WRAnswer (tri (es.getD i (0, 0))) [o.getD i 0]

/-- Correct All-Edges-Triangle output: one bit per edge, in input order (AB, then BC, then AC). -/
def TriGraph.Correct (G : TriGraph) (out : List ℕ) : Prop :=
  TriLabels G.triAB G.AB (out.take G.AB.length) ∧
  TriLabels G.triBC G.BC ((out.drop G.AB.length).take G.BC.length) ∧
  TriLabels G.triAC G.AC (out.drop (G.AB.length + G.BC.length))

/-- Balanced instances: `|A| = |B| = |C| = N`, `m ≥ α N^{3/2}`, every degree `≤ δ √N`. -/
def Balanced (α δ : ℝ) (G : TriGraph) : Prop :=
  G.nB = G.nA ∧ G.nC = G.nA ∧
  α * (G.nA : ℝ) ^ ((3 : ℝ) / 2) ≤ (G.m : ℝ) ∧
  (∀ a : ℕ, a < G.nA → (G.degA a : ℝ) ≤ δ * Real.sqrt G.nA) ∧
  (∀ b : ℕ, b < G.nA → (G.degB b : ℝ) ≤ δ * Real.sqrt G.nA) ∧
  (∀ c : ℕ, c < G.nA → (G.degC c : ℝ) ≤ δ * Real.sqrt G.nA)

/-- All-Edges Sparse Triangle restricted to the balanced family. -/
def BalancedAET (α δ : ℝ) : WRProblem where
  Inst := {G : TriGraph // Balanced α δ G}
  enc := fun (G : {G : TriGraph // Balanced α δ G}) => G.1.enc
  Correct := fun (G : {G : TriGraph // Balanced α δ G}) (out : List ℕ) => G.1.Correct out

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∀ α δ : ℝ, 0 < α → 0 < δ →
    WRRandSolvesIn (BalancedAET α δ) (fun (G : {G : TriGraph // Balanced α δ G}) => (G.1.m : ℝ) ^ ((4 : ℝ) / 3 - ε))

end

end OpenProblems.QEDM030
