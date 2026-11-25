import Mathlib
/-! QED-M037: From S_2E to E^NP: near-maximum circuit lower bounds
Chen–Hirahara–Ren and Li showed that symmetric exponential time S₂E requires near-maximum
circuit size. The next target is E^NP: show that some language in E^NP needs circuits of
exponential size.
Informal statement: Prove that for some ε > 0 there is L ∈ E^NP such that for infinitely many n,
L ∩ {0,1}^n has no Boolean circuit of size 2^{εn} (stronger: for all large n). Related target (not
claimed equivalent at this size): AVOID ∈ FP^NP, which by Korten (2021) implies
E^NP ⊄ SIZE[2^n/n].
Formalization notes:
* Circuits: straight-line programs over the basis {AND, OR, NOT} (fan-in 2, NOT ignores its
  second argument). Wires 0..n−1 are the inputs, and gate i is wire n+i. `WellFormed` forces every
  gate to read only earlier wires. The output is the last wire. Size = number of gates. Exponential
  lower bounds are insensitive to the choice of finite complete basis.
* Machines: Mathlib's `Turing.TM2ComputableInPolyTime` on `List Bool` (identity encoding over
  the alphabet `Bool`).
* NP (`InNP`): O(x) ↔ ∃ y, |y| ≤ |x|^k + k, V(⟨x, y⟩) = [true] with V polynomial-time. ⟨·,·⟩ is
  the injective pairing `pairEnc` (bit-doubling of x, then a separator).
* E^NP (`InENP`) in transcript form. Fix O ∈ NP, a constant c and a polynomial-time M. On input x
  (n = |x|) the oracle computation proceeds in rounds. With the answer string a (initially empty),
  M is run on ⟨x, ⟨a, 1^{2^{cn}}⟩⟩. Output `false :: z` means "query z": the bit O(z) is appended
  to a. Output `true :: b :: _` means "halt with answer b" (absorbing). L ∈ E^NP iff for every x
  the computation halts within 2^{cn} rounds with answer [x ∈ L]. This is equivalent to the
  standard definition E^NP = ⋃_c DTIME^{SAT}(2^{cn}):
  (⊆) a 2^{cn}-time SAT-oracle machine makes ≤ 2^{cn} queries. M replays it for 2^{cn} steps using
  the recorded answers and outputs its next query or its result, in time poly(2^{cn}) =
  poly(input length), thanks to the padding 1^{2^{cn}}. Take O = SAT ∈ NP.
  (⊇) an oracle machine for SAT runs the rounds, at 2^{O(n)} rounds × 2^{O(n)} time each. Queries
  to O ∈ NP of length 2^{O(n)} reduce to SAT queries of length 2^{O(n)}.
  The padding is essential. Without it M would be polynomial in n, not exponential.
* Lower bound: `Claim` = ∃ ε > 0, ∃ L ∈ E^NP, for infinitely many n no well-formed circuit with
  ≤ 2^{εn} gates computes L on all strings of length n (input bit j = j-th list entry).
Proving `Claim` = the exponential circuit lower bound for E^NP (the i.o. version). Proving
`¬Claim` = for every ε > 0 every E^NP language has circuits of size ≤ 2^{εn} for all large n
(not expected, and itself a major result). The a.e. version and Korten's AVOID formulation are
not part of Claim.
-/
namespace OpenProblems.QEDM037
noncomputable section

/-! ### Boolean circuits -/

/-- Gate types. -/
inductive GateOp : Type where
  | andG : GateOp
  | orG : GateOp
  | notG : GateOp

/-- A gate reading wires `a` and `b` (`notG` ignores `b`). -/
structure Gate where
  op : GateOp
  a : ℕ
  b : ℕ

/-- The function computed by a gate. -/
def Gate.apply (g : Gate) (u v : Bool) : Bool :=
  match g.op with
  | GateOp.andG => u && v
  | GateOp.orG => u || v
  | GateOp.notG => !u

/-- All wire values: the inputs followed by the gate values in order. -/
def evalWires (x : List Bool) (C : List Gate) : List Bool :=
  C.foldl (fun vals g => vals ++ [g.apply (vals.getD g.a false) (vals.getD g.b false)]) x

/-- Gate `i` reads only inputs and earlier gates. -/
def WellFormed (n : ℕ) (C : List Gate) : Prop :=
  ∀ i : Fin C.length, (C.get i).a < n + i.val ∧ (C.get i).b < n + i.val

/-- Output of the circuit: the last wire. -/
def circOut (x : List Bool) (C : List Gate) : Bool :=
  (evalWires x C).getD ((evalWires x C).length - 1) false

/-- `L` restricted to length `n` has a circuit with at most `s` gates. -/
def HasCircuit (L : List Bool → Prop) (n : ℕ) (s : ℝ) : Prop :=
  ∃ C : List Gate, WellFormed n C ∧ (C.length : ℝ) ≤ s ∧
    ∀ x : List Bool, x.length = n → (circOut x C = true ↔ L x)

/-! ### Polynomial time, NP and E^NP -/

/-- Bit strings encoded as themselves over the alphabet `Bool`. -/
def listBoolEnc : Computability.FinEncoding (List Bool) where
  Γ := Bool
  encode := id
  decode := Option.some
  decode_encode := fun _ => rfl
  ΓFin := inferInstance

/-- `F` is computable in polynomial time by a Mathlib multi-stack Turing machine. -/
def PolyTimeFn (F : List Bool → List Bool) : Prop :=
  Nonempty (Turing.TM2ComputableInPolyTime listBoolEnc listBoolEnc F)

/-- Bit doubling `b ↦ true b`. -/
def dbl : List Bool → List Bool
  | [] => []
  | b :: t => true :: b :: dbl t

/-- Injective pairing of bit strings. -/
def pairEnc (x y : List Bool) : List Bool := dbl x ++ [false] ++ y

/-- `O` is in NP. -/
def InNP (O : List Bool → Prop) : Prop :=
  ∃ (V : List Bool → List Bool) (k : ℕ), PolyTimeFn V ∧
    ∀ x : List Bool, O x ↔ ∃ y : List Bool, y.length ≤ x.length ^ k + k ∧ V (pairEnc x y) = [true]

/-- The input of the round machine: `x`, the answers so far, and padding `1^{2^{c|x|}}`. -/
def roundInput (c : ℕ) (x ans : List Bool) : List Bool :=
  pairEnc x (pairEnc ans (List.replicate (2 ^ (c * x.length)) true))

open Classical in
/-- The oracle answers collected after `t` rounds. -/
def answers (M : List Bool → List Bool) (O : List Bool → Prop) (c : ℕ) (x : List Bool) :
    ℕ → List Bool
  | 0 => []
  | t + 1 =>
      match M (roundInput c x (answers M O c x t)) with
      | false :: z => answers M O c x t ++ [decide (O z)]
      | _ => answers M O c x t

/-- `some b` if the machine has halted with answer `b` at round `t`. -/
def haltBit (M : List Bool → List Bool) (O : List Bool → Prop) (c : ℕ) (x : List Bool) (t : ℕ) :
    Option Bool :=
  match M (roundInput c x (answers M O c x t)) with
  | true :: b :: _ => some b
  | _ => none

/-- `L ∈ E^NP` (transcript form, see the notes). -/
def InENP (L : List Bool → Prop) : Prop :=
  ∃ O : List Bool → Prop, InNP O ∧ ∃ c : ℕ, ∃ M : List Bool → List Bool, PolyTimeFn M ∧
    ∀ x : List Bool, ∃ t : ℕ, t ≤ 2 ^ (c * x.length) ∧
      ∃ b : Bool, haltBit M O c x t = some b ∧ (L x ↔ b = true)

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ L : List Bool → Prop, InENP L ∧
    ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ ¬ HasCircuit L n ((2 : ℝ) ^ (ε * (n : ℝ)))

end
end OpenProblems.QEDM037
