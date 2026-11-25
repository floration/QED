import Mathlib
/-! QED-M034: Densest k-Subgraph and k-Biclique FPT-inapproximability from plain ETH
Prove, assuming only ETH (not Gap-ETH), that Densest k-Subgraph has no FPT approximation within some
factor g(k) = ω(1).
Informal statement: Assuming only (deterministic) ETH, prove that there is a function g(k) → ∞ such
that no algorithm running in time f(k)·n^{O(1)} (f computable) approximates (uncolored) Densest
k-Subgraph within factor g(k), i.e. outputs a value v with OPT/g(k) ≤ v ≤ OPT, where OPT is the maximum
number of edges induced by k vertices. (Gap-ETH gives this for every g(k) = k^{o(1)}: Chalermsook et al.,
FOCS 2017. The k-Biclique disjunct of the original W is already known under ETH: Lin, JACM 2018,
arXiv:1406.3700.)
Formalization notes:
* Reading of "any factor ω(1)": it must be "some ω(1) factor" (∃ g → ∞). The reading "for every g = ω(1)"
  is false, since a factor g(k) = k² (indeed k) is trivially achievable in polynomial time.
* Machine model: the board's canonical word-RAM block (pasted verbatim below); deterministic algorithms,
  time O(T) = ⌊C·T + C⌋ steps, for every admissible word size w ≥ (wc+1)·log(input length).
* 3-SAT / ETH: `CNF3` = n variables, clauses of ≤ 3 literals, encoded injectively as `[n, #clauses]` plus
  3 words per clause. `ETH` := ∃ δ > 0, ∀ c, no deterministic algorithm decides 3-SAT in time
  O(2^{δn}·L^c) (L = number of input words; the poly(L) factor is harmless since L ≤ poly(n) after removing
  duplicate clauses). This is the standard Impagliazzo–Paturi ETH.
* Densest k-Subgraph: an instance is (N, a Boolean N×N matrix, k); the graph has edge {i,j} (i ≠ j) iff
  `adjM i j || adjM j i` (so every matrix is a valid graph; loops ignored). Input encoding `[N, k]` plus the
  N² matrix bits (input size Θ(N²), polynomial in N). OPT = max over k-subsets S of the number of edges
  inside S (0 if k > N). A g-approximation outputs a single word v with OPT ≤ g(k)·v and v ≤ OPT. A value
  approximation is weaker than finding a dense set (from a set one counts its edges in poly time), so
  hardness for value approximation is the stronger (standard, gap-based) form.
* FPT time: f(k)·N^c with f : ℕ → ℕ computable (`Computable`, Mathlib) — the standard (strongly uniform)
  FPT notion used in the ETH/Gap-ETH literature.
* Claim := ETH → ∃ g : ℕ → ℝ, (∀ k, 1 ≤ g k) ∧ g → ∞ ∧ ∀ f computable, ∀ c, no deterministic algorithm
  g-approximates DkS in time O(f(k)·N^c). ¬Claim would require proving ETH (¬(A→B) = A ∧ ¬B), so it is
  unreachable without resolving ETH, as usual for conditional hardness. Loophole audit: g ≥ 1 makes the
  output condition satisfiable (v = OPT), brute force solves DkS exactly in time N^{O(k)}, so the model
  is not empty; g is chosen before f, c and the algorithm.
-/
namespace OpenProblems.QEDM034
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

/-! ### 3-SAT and ETH -/

/-- A 3-CNF formula on `n` variables: each clause is a list of at most 3 literals (variable, sign). -/
structure CNF3 where
  n : ℕ
  clauses : List (List (Fin n × Bool))
  short : ∀ cl ∈ clauses, cl.length ≤ 3

/-- Satisfiability. -/
def CNF3.Sat (φ : CNF3) : Prop :=
  ∃ σ : Fin φ.n → Bool, ∀ cl ∈ φ.clauses, ∃ l ∈ cl, σ l.1 = l.2

/-- Literal code `2(v+1) + sign` (never 0). -/
def litCode {n : ℕ} (l : Fin n × Bool) : ℕ := 2 * ((l.1 : ℕ) + 1) + wrBit l.2

/-- A clause as exactly 3 words (padded with 0). -/
def clauseCode {n : ℕ} (cl : List (Fin n × Bool)) : List ℕ :=
  (cl.map litCode ++ [0, 0, 0]).take 3

/-- Word encoding of a formula. -/
def CNF3.enc (φ : CNF3) : List ℕ :=
  [φ.n, φ.clauses.length] ++ wrAllWords (φ.clauses.map clauseCode)

/-- The decision problem 3-SAT. -/
def SAT3 : WRProblem where
  Inst := CNF3
  enc := CNF3.enc
  Correct := fun (φ : CNF3) (out : List ℕ) => WRAnswer φ.Sat out

/-- ETH: for some `δ > 0`, no deterministic algorithm decides 3-SAT in time `O(2^{δ n} · L^c)`. -/
def ETH : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∀ c : ℕ,
    ¬ WRSolvesIn SAT3 (fun φ : CNF3 => (2 : ℝ) ^ (δ * (φ.n : ℝ)) * ((φ.enc.length : ℝ)) ^ c)

/-! ### Densest k-Subgraph -/

/-- An instance: a graph on `Fin N` given by a Boolean matrix (edge `{i,j}`, `i ≠ j`, iff
`adjM i j || adjM j i`), and the parameter `k`. -/
structure DkSInst where
  N : ℕ
  adjM : Fin N → Fin N → Bool
  k : ℕ

/-- Number of edges inside `S`. -/
def DkSInst.edgesIn (x : DkSInst) (S : Finset (Fin x.N)) : ℕ :=
  ((S ×ˢ S).filter (fun p : Fin x.N × Fin x.N =>
    p.1 < p.2 ∧ (x.adjM p.1 p.2 || x.adjM p.2 p.1) = true)).card

/-- `OPT`: the maximum number of edges induced by `k` vertices (0 if `k > N`). -/
def DkSInst.opt (x : DkSInst) : ℕ :=
  ((Finset.univ : Finset (Fin x.N)).powersetCard x.k).sup x.edgesIn

/-- Encoding: `[N, k]` followed by the `N²` matrix bits, row-major. -/
def DkSInst.enc (x : DkSInst) : List ℕ :=
  [x.N, x.k] ++
    List.ofFn (fun t : Fin (x.N * x.N) =>
      wrBit (x.adjM (finProdFinEquiv.symm t).1 (finProdFinEquiv.symm t).2))

/-- `g`-approximate Densest k-Subgraph (value version): output one word `v`, `OPT ≤ g(k)·v ≤ g(k)·OPT`. -/
def DkSApprox (g : ℕ → ℝ) : WRProblem where
  Inst := DkSInst
  enc := DkSInst.enc
  Correct := fun (x : DkSInst) (out : List ℕ) =>
    ∃ v : ℕ, out = [v] ∧ (x.opt : ℝ) ≤ g x.k * (v : ℝ) ∧ v ≤ x.opt

/-- ETH implies: for some approximation factor `g(k) → ∞`, Densest k-Subgraph has no FPT
`g(k)`-approximation algorithm. -/
def Claim : Prop :=
  ETH → ∃ g : ℕ → ℝ, (∀ k : ℕ, 1 ≤ g k) ∧ Filter.Tendsto g Filter.atTop Filter.atTop ∧
    ∀ f : ℕ → ℕ, Computable f → ∀ c : ℕ,
      ¬ WRSolvesIn (DkSApprox g) (fun x : DkSInst => (f x.k : ℝ) * (x.N : ℝ) ^ c)

end
end OpenProblems.QEDM034
