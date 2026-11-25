import Mathlib
/-! QED-M027: 2^{Omega(n)} hardness of Euclidean SVP under ETH
Show that for some constant γ > 1, γ-approximate GapSVP in the ℓ₂ norm has no 2^{o(n)}-time randomized algorithm
unless randomized ETH fails; or show the AGMZ technique (Zⁿ gadget plus Theta-function inequality, valid for p > 2)
provably cannot reach p = 2.
Informal statement: Prove there is a constant γ > 1 such that, if randomized ETH holds (there is δ > 0 such that
no bounded-error randomized algorithm decides 3-SAT on n variables in time 2^{δn}·poly(input size)), then
there is δ' > 0 such that no bounded-error randomized algorithm decides γ-GapSVP in the ℓ₂ norm on rank-n
integer lattices in time 2^{δ'n}·poly(input size) (2^{Ω(n)} hardness, which in particular rules out
2^{o(n)}-time algorithms). (The alternative "obstruction" target is a meta-statement about a proof technique
and is not a mathematical proposition; it is not formalized.)
Formalization notes:
* Machine model: the board's canonical word-RAM block (pasted verbatim below): unit-cost word
  operations, word size w ≥ (wc+1)·log n with every input word fitting in a word, time O(T) means
  ⌊C·T + C⌋ steps, randomized = Monte Carlo with two-sided error 1/3 over a uniformly random tape
  (`WRRandSolvesIn`). Since an input integer must fit in one word, w is at least the bit length of the
  largest entry; this is the standard trans-dichotomous convention, and since a w-bit word operation is
  simulated in poly(w) ≤ poly(input bits) bit operations, it changes running times only by the poly(size)
  factor that every time bound below already allows.
* 3-SAT: `CNF3` has `n` variables and a list of clauses of at most 3 literals (variable, sign); encoded as
  `[n, #clauses]` followed by 3 words per clause (literal code 2(v+1)+sign, 0 = empty slot), an injective
  encoding. `RETH` := ∃ δ > 0, ∀ c, no randomized algorithm decides satisfiability in time
  O(2^{δn}·L^c), L = number of input words. This is randomized ETH (Dell–Husfeldt–Marx–Taslaman–Wahlén);
  the poly(L) factor is harmless (duplicates can be removed, so L ≤ poly(n)).
* GapSVP_γ (ℓ₂): instance = integer basis B ∈ ℤ^{d×n} (columns = basis vectors, rank n) and an integer
  threshold r for the SQUARED length. YES: columns linearly independent over ℚ and some nonzero integer
  combination v has ‖Bv‖² ≤ r. NO: columns independent and every nonzero v has ‖Bv‖² > γ²·r. Outside the
  promise any output is accepted (`Correct` is an implication). Rational bases reduce to integer ones by
  scaling, so integer bases are the standard form. Entries are encoded by `wrInt` (zig-zag); the size
  parameter is the total bit length `svpBits` of the encoding.
* Claim := ∃ γ > 1, RETH → ∃ δ > 0, ∀ c, ¬ WRRandSolvesIn (GapSVP γ) (2^{δn}·(bits+1)^c). Here n is the
  lattice rank. Proving Claim = the desired fine-grained reduction for p = 2 (what AGMZ prove for p > 2).
  ¬Claim would mean: for every γ > 1, rETH holds yet GapSVP_γ is solvable in time 2^{δn}poly for every
  δ > 0 — i.e. (since ¬(A→B) = A ∧ ¬B) a proof of rETH, so ¬Claim is not provable without resolving
  rETH; this is the usual status of conditional hardness statements.
* Loophole audit: the model has algorithms (brute force over bounded coefficient vectors solves GapSVP in
  2^{O(n log n)}·poly), so "no algorithm" is not vacuous; the promise sets are nonempty; γ is a fixed real
  > 1 chosen before the algorithm; δ and the constants C, c of the algorithm are quantified so that the
  conclusion is exactly 2^{Ω(n)}·poly hardness.
-/
namespace OpenProblems.QEDM027
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

/-! ### 3-SAT and randomized ETH -/

/-- A 3-CNF formula on `n` variables: each clause is a list of at most 3 literals (variable, sign). -/
structure CNF3 where
  n : ℕ
  clauses : List (List (Fin n × Bool))
  short : ∀ cl ∈ clauses, cl.length ≤ 3

/-- `σ` satisfies `φ`: every clause has a literal `(v, b)` with `σ v = b`. -/
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

/-- Randomized ETH: for some `δ > 0` no bounded-error randomized algorithm decides 3-SAT in time
`O(2^{δ n} · L^c)` (`L` = number of input words), for any `c`. -/
def RETH : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∀ c : ℕ,
    ¬ WRRandSolvesIn SAT3 (fun φ : CNF3 => (2 : ℝ) ^ (δ * (φ.n : ℝ)) * ((φ.enc.length : ℝ)) ^ c)

/-! ### GapSVP in the ℓ₂ norm -/

/-- An SVP instance: basis matrix `B` (`d × n`, columns are the basis vectors) and a threshold `r` for
the squared length. -/
structure SVPInst where
  d : ℕ
  n : ℕ
  B : Fin d → Fin n → ℤ
  r : ℕ

/-- `‖B v‖₂²` for an integer coefficient vector `v`. -/
def SVPInst.normSq (x : SVPInst) (v : Fin x.n → ℤ) : ℤ :=
  ∑ i : Fin x.d, (∑ j : Fin x.n, x.B i j * v j) ^ 2

/-- The columns of `B` are linearly independent (so the lattice has rank `n`). -/
def SVPInst.Indep (x : SVPInst) : Prop :=
  LinearIndependent ℚ (fun j : Fin x.n => fun i : Fin x.d => ((x.B i j : ℤ) : ℚ))

/-- YES instances: `λ₁(L(B))² ≤ r`. -/
def SVPInst.Yes (x : SVPInst) : Prop :=
  x.Indep ∧ ∃ v : Fin x.n → ℤ, v ≠ 0 ∧ x.normSq v ≤ (x.r : ℤ)

/-- NO instances: `λ₁(L(B))² > γ² r`. -/
def SVPInst.No (γ : ℝ) (x : SVPInst) : Prop :=
  x.Indep ∧ ∀ v : Fin x.n → ℤ, v ≠ 0 → γ ^ 2 * (x.r : ℝ) < ((x.normSq v : ℤ) : ℝ)

/-- Encoding `[d, n, r]` followed by the entries of `B` row-major (zig-zag integers). -/
def SVPInst.enc (x : SVPInst) : List ℕ :=
  [x.d, x.n, x.r] ++
    List.ofFn (fun t : Fin (x.d * x.n) =>
      wrInt (x.B (finProdFinEquiv.symm t).1 (finProdFinEquiv.symm t).2))

/-- Total bit length of the encoding. -/
def SVPInst.bits (x : SVPInst) : ℕ := (x.enc.map (fun a : ℕ => Nat.log 2 a + 1)).sum

/-- The promise problem `γ`-GapSVP (ℓ₂): output `[1]` on YES, `[0]` on NO, anything otherwise. -/
def GapSVP (γ : ℝ) : WRProblem where
  Inst := SVPInst
  enc := SVPInst.enc
  Correct := fun (x : SVPInst) (out : List ℕ) => (x.Yes → out = [1]) ∧ (x.No γ → out = [0])

/-- Some `γ > 1` is such that randomized ETH implies `2^{Ω(n)}` (times any polynomial in the input
size) randomized hardness of `γ`-GapSVP in the ℓ₂ norm on rank-`n` lattices. -/
def Claim : Prop :=
  ∃ γ : ℝ, 1 < γ ∧
    (RETH → ∃ δ : ℝ, 0 < δ ∧ ∀ c : ℕ,
      ¬ WRRandSolvesIn (GapSVP γ)
          (fun x : SVPInst => (2 : ℝ) ^ (δ * (x.n : ℝ)) * ((x.bits : ℝ) + 1) ^ c))

end
end OpenProblems.QEDM027
