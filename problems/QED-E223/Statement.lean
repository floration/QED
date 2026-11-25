import Mathlib
/-! QED-E223: Sudoku resolution bounds
Find an explicit family of large unsolvable Sudoku puzzles (n^2 by n^2 grids with some givens) for which
any resolution proof that the puzzle has no solution must be exponentially long.
Informal statement: For n ≥ 2 and a partial assignment A of symbols [n²] to cells of the n²×n² grid, let
SUD_n(A) be the CNF in variables x_{c,v} (cell c holds v) consisting of: unit clauses for A; for every cell c,
⋁_v x_{c,v} and ¬x_{c,v} ∨ ¬x_{c,w} (v ≠ w); for every row, column and n×n box U, every v and distinct
c, c' ∈ U, ¬x_{c,v} ∨ ¬x_{c',v}; and for every U and v, ⋁_{c∈U} x_{c,v}. Prove that there is a family
(A_n), computable from n (given in unary) in polynomial time, and ε > 0, such that for all sufficiently
large n, SUD_n(A_n) is unsatisfiable and every resolution refutation of SUD_n(A_n) has at least 2^{n^ε}
clauses.
Formalization notes:
* Grid: cells are `Fin (n^2) × Fin (n^2)` (row, column), symbols `Fin (n^2)`; a variable is
  (cell, symbol), a literal is (variable, sign) with sign `true` = positive. Clauses are `Finset`s of
  literals, a CNF is a `Set` of clauses. Units are the n² rows, n² columns and the n² boxes
  {(r,c) : r / n = i, c / n = j} for i, j : Fin n (indexing by `Fin n` avoids empty "boxes" that would put
  the empty clause in the CNF).
* Resolution: a refutation is a list of clauses, each either a clause of the CNF or the resolvent
  (C \ {x}) ∪ (D \ {¬x}) of two earlier clauses C ∋ x, D ∋ ¬x, and containing the empty clause. Size =
  number of lines. This is standard (tree-like or DAG-like refutations, no weakening rule; weakening does
  not change minimal size). Satisfiability is ordinary Boolean satisfiability.
* Explicitness ("polynomial-time constructible"): the family is produced by a function
  `F : List Bool → List Bool` computable in polynomial time by Mathlib's multi-tape Turing machines
  (`Turing.TM2ComputableInPolyTime`, identity encodings over `Bool`), run on the unary input
  `List.replicate n true`. The output bit with index ((r·n² + c)·n² + v) (missing bits = false) says
  "cell (r,c) is given symbol v"; we require the output to be a genuine partial assignment (at most one
  given per cell). Without the explicitness requirement the statement is equivalent to mere existence of
  hard instances (a brute-force search would make any such family computable), so polynomial time is
  essential and is the standard meaning of "explicit" here.
* The exponent 2^{n^{Ω(1)}} is rendered as ∃ ε > 0, eventually size ≥ 2^{n^ε} (a constant factor in
  the exponent is absorbed by decreasing ε). Proving `Claim` gives such an explicit hard family;
  `¬Claim` says every polynomial-time family of unsatisfiable puzzles has, for infinitely many n,
  refutations of size < 2^{n^ε} for every ε > 0.
-/
namespace OpenProblems.QEDE223

noncomputable section

/-- Cells of the `n² × n²` grid: (row, column). -/
abbrev Cell (n : ℕ) : Type := Fin (n ^ 2) × Fin (n ^ 2)

/-- Variable `x_{c,v}`: cell `c` holds symbol `v`. -/
abbrev SVar (n : ℕ) : Type := Cell n × Fin (n ^ 2)

/-- A literal: a variable with a sign (`true` = positive). -/
abbrev Lit (n : ℕ) : Type := SVar n × Bool

/-- A clause is a finite set of literals. -/
abbrev Clause (n : ℕ) : Type := Finset (Lit n)

/-- The units of a Sudoku grid: rows, columns and `n × n` boxes, as sets of cells. -/
def units (n : ℕ) : Set (Finset (Cell n)) :=
  {U | ∃ r : Fin (n ^ 2), U = Finset.univ.filter (fun c : Cell n => c.1 = r)} ∪
  {U | ∃ k : Fin (n ^ 2), U = Finset.univ.filter (fun c : Cell n => c.2 = k)} ∪
  {U | ∃ i j : Fin n, U = Finset.univ.filter
      (fun c : Cell n => c.1.val / n = i.val ∧ c.2.val / n = j.val)}

/-- The Sudoku CNF `SUD_n(A)` for a set `A` of givens (cell, symbol). -/
def sud (n : ℕ) (A : Set (Cell n × Fin (n ^ 2))) : Set (Clause n) :=
  -- unit clauses for the givens
  {C | ∃ g ∈ A, C = {(g, true)}} ∪
  -- every cell holds some symbol
  {C | ∃ c : Cell n, C = Finset.univ.image (fun v : Fin (n ^ 2) => ((c, v), true))} ∪
  -- every cell holds at most one symbol
  {C | ∃ c : Cell n, ∃ v w : Fin (n ^ 2), v ≠ w ∧ C = {((c, v), false), ((c, w), false)}} ∪
  -- no symbol twice in a unit
  {C | ∃ U ∈ units n, ∃ c ∈ U, ∃ c' ∈ U, c ≠ c' ∧ ∃ v : Fin (n ^ 2),
      C = {((c, v), false), ((c', v), false)}} ∪
  -- every symbol occurs in every unit
  {C | ∃ U ∈ units n, ∃ v : Fin (n ^ 2), C = U.image (fun c : Cell n => ((c, v), true))}

/-- A CNF is satisfiable if some Boolean assignment makes a literal of every clause true. -/
def Satisfiable {n : ℕ} (F : Set (Clause n)) : Prop :=
  ∃ α : SVar n → Bool, ∀ C ∈ F, ∃ l ∈ C, α l.1 = l.2

/-- `L` is a resolution refutation of `F`: every line is a clause of `F` or the resolvent of two
earlier lines, and the empty clause occurs. -/
def IsRefutation {n : ℕ} (F : Set (Clause n)) (L : List (Clause n)) : Prop :=
  (∅ : Clause n) ∈ L ∧
  ∀ i : Fin L.length, L.get i ∈ F ∨
    ∃ j k : Fin L.length, j < i ∧ k < i ∧ ∃ x : SVar n,
      (x, true) ∈ L.get j ∧ (x, false) ∈ L.get k ∧
      L.get i = (L.get j).erase (x, true) ∪ (L.get k).erase (x, false)

/-- Polynomial-time computability on bit strings (Mathlib multi-tape Turing machines). -/
def PolyTimeFn (F : List Bool → List Bool) : Prop :=
  Nonempty (Turing.TM2ComputableInPolyTime (id : List Bool → List Bool)
    (id : List Bool → List Bool) F)

/-- The set of givens decoded from the output bit string: bit `((r n² + c) n² + v)` set means
cell `(r, c)` is given symbol `v`. -/
def givens (n : ℕ) (out : List Bool) : Set (Cell n × Fin (n ^ 2)) :=
  {g | out.getD ((g.1.1.val * n ^ 2 + g.1.2.val) * n ^ 2 + g.2.val) false = true}

/-- A set of givens is a partial assignment: at most one symbol per cell. -/
def IsPartialAssignment {n : ℕ} (A : Set (Cell n × Fin (n ^ 2))) : Prop :=
  ∀ c : Cell n, ∀ v w : Fin (n ^ 2), (c, v) ∈ A → (c, w) ∈ A → v = w

def Claim : Prop :=
  ∃ F : List Bool → List Bool, PolyTimeFn F ∧
    ∃ ε : ℝ, 0 < ε ∧ ∃ N : ℕ, ∀ n : ℕ, N ≤ n → 2 ≤ n →
      IsPartialAssignment (givens n (F (List.replicate n true))) ∧
      ¬ Satisfiable (sud n (givens n (F (List.replicate n true)))) ∧
      ∀ L : List (Clause n), IsRefutation (sud n (givens n (F (List.replicate n true)))) L →
        (2 : ℝ) ^ ((n : ℝ) ^ ε) ≤ (L.length : ℝ)

end

end OpenProblems.QEDE223
