import Mathlib
/-! QED-M041: Proof complexity of the sensitivity theorem
Huang proved that any set of more than half the corners of the n-cube contains a corner with at
least √n neighbours inside the set. Write this as a propositional formula with one variable per
corner. Do polynomial-size proofs exist in resolution, cutting planes or sum-of-squares, measured
against the 2^n variables?
Informal statement: Let N = 2^n, K = 2^{n-1}+1, d = ⌈√n⌉ − 1. SENS_n is the CNF on main variables
x_v (v ∈ {0,1}^n) and sequential-counter variables s_{i,j} (0 ≤ i ≤ N, 0 ≤ j ≤ K), consisting of
the counter clauses (s_{N,K}); (¬s_{0,j}) for 1 ≤ j ≤ K; (¬s_{i,j} ∨ s_{i−1,j} ∨ x_i) and
(¬s_{i,j} ∨ s_{i−1,j} ∨ s_{i−1,j−1}) for 1 ≤ i ≤ N, 1 ≤ j ≤ K (x_1,…,x_N the main variables in a
fixed order), which together say ∑_v x_v ≥ K, and the clauses ¬x_v ∨ ⋁_{u∈U} ¬x_u for every v and
every (d+1)-set U of neighbours of v. Its size is N^{O(1)}, i.e. O(N·K) counter clauses plus
N·n^{O(√n)} = N^{1+o(1)} neighbourhood clauses. It is unsatisfiable by Huang's theorem. Questions:
does SENS_n have refutations of size N^{O(1)} in (a) resolution, (b) cutting planes, (c)
sum-of-squares of degree O(log N)? Claim := (a) ∨ (b) ∨ (c), i.e. SENS_n is easy in at least one
of the three systems. Each part is also stated separately as ClaimRes, ClaimCP, ClaimSoS. Lower
bounds 2^{N^{Ω(1)}} are equally of interest and refute the corresponding part.
Formalization notes:
* Variables: `SVar n = Fin (2^n) ⊕ (Fin (2^n+1) × Fin (K n + 1))`. Main variable `a : Fin (2^n)` is
  the cube vertex with bits `a.testBit k`, and the counter order x_1,…,x_N is a = 0,…,N−1. Two
  vertices are adjacent iff they differ in exactly one of the n bits. Literals are `(v, b)`, with
  `b = true` positive. Clauses are finsets of literals. `sensCNF n` is the exact clause set above.
  The counter clauses force s_{i,j} → (at least j of x_1..x_i are true), and conversely setting
  s_{i,j} := [count_i ≥ j] satisfies them. So SENS_n is satisfiable iff some set of ≥ K vertices
  has no vertex with ≥ d+1 = ⌈√n⌉ neighbours inside it, which Huang's theorem rules out (n = 0, 1
  also check by hand). This is the standard Sinz-style one-directional sequential counter. The
  informal size estimate was corrected to N^{O(1)}: the counter alone has Θ(N·K) = Θ(N²) clauses,
  so the formula is not N^{1+o(1)}. This only matters polynomially.
* Proofs are lists of lines. `ValidSeq step L` says every line follows from the earlier ones by
  `step`.
* Resolution (`resStep`): initial clauses, the resolution rule on a clashing variable, and weakening.
  A refutation contains the empty clause. Size is the number of lines.
* Cutting planes (`cpStep`): lines are integer inequalities ∑ a_v x_v ≥ c. Initial lines are the clause
  inequalities (∑_{pos} x_v + ∑_{neg} (1−x_v) ≥ 1) and the bounds x_v ≥ 0, −x_v ≥ −1. Rules are
  addition, multiplication by a natural number, and division by k > 0 when k divides every
  coefficient, rounding the right-hand side up (⌈c/k⌉ = −⌊−c/k⌋). A refutation contains 0 ≥ c with
  c ≥ 1. Size is the number of lines plus the total binary length of all nonzero coefficients and
  right-hand sides (the standard bit-size measure).
* Sum-of-squares (`SoSRefutes`): a degree-D Positivstellensatz refutation over ℝ of the
  equalities x_v² − x_v = 0 and, for each clause C, ∏_{(v,+)∈C}(1−x_v)·∏_{(v,−)∈C} x_v = 0 (C
  falsified). This is an identity ∑ q_i g_i + ∑ p_j² = −1 with deg q_i + deg g_i ≤ D and
  2·deg p_j ≤ D. "Degree O(log N)" means degree ≤ C·(n+1), since log₂ N = n. No size bound is
  imposed in (c), matching the informal statement.
* "Size N^{O(1)}" means ∃ k, ∀ n, size ≤ (2^n)^k + k.
Proving `Claim` = polynomial-size resolution or cutting-planes refutations, or O(log N)-degree
SoS refutations, of SENS_n. Proving `¬Claim` = superpolynomial lower bounds in resolution and
cutting planes, and an ω(log N) SoS degree lower bound. Since cutting planes p-simulates
resolution, ClaimRes → ClaimCP, so the disjunction is really (b) ∨ (c). The reviewer expects (a)
to fail.
-/
namespace OpenProblems.QEDM041
noncomputable section

/-! ### Generic propositional proof systems -/

/-- Literals over variables `V`: `(v, true)` is `v`, `(v, false)` is `¬v`. -/
abbrev Lit (V : Type) : Type := V × Bool

/-- Clauses. -/
abbrev Clause (V : Type) : Type := Finset (Lit V)

/-- A list of lines is valid if each line follows from the preceding ones by `step`. -/
def ValidSeq {α : Type} (step : List α → α → Prop) (L : List α) : Prop :=
  ∀ i : Fin L.length, step (L.take i.val) (L.get i)

/-- One resolution inference (initial clause, weakening, or resolution on a variable). -/
def resStep {V : Type} [DecidableEq V] (F : Set (Clause V)) (prev : List (Clause V))
    (C : Clause V) : Prop :=
  C ∈ F ∨ (∃ D ∈ prev, D ⊆ C) ∨
    ∃ D₁ ∈ prev, ∃ D₂ ∈ prev, ∃ v : V, (v, true) ∈ D₁ ∧ (v, false) ∈ D₂ ∧
      C = D₁.erase (v, true) ∪ D₂.erase (v, false)

/-- A resolution refutation of `F`. -/
def ResRefutation {V : Type} [DecidableEq V] (F : Set (Clause V)) (L : List (Clause V)) : Prop :=
  ValidSeq (resStep F) L ∧ (∅ : Clause V) ∈ L

/-- A cutting-planes line `∑ v, coef v * x v ≥ rhs`. -/
structure Ineq (V : Type) where
  coef : V → ℤ
  rhs : ℤ

/-- The inequality form of a clause. -/
def clauseIneq {V : Type} [DecidableEq V] (C : Clause V) : Ineq V :=
  ⟨fun v => (if (v, true) ∈ C then (1 : ℤ) else 0) - (if (v, false) ∈ C then (1 : ℤ) else 0),
    1 - ((C.filter fun l : Lit V => l.2 = false).card : ℤ)⟩

/-- One cutting-planes inference. -/
def cpStep {V : Type} [DecidableEq V] (F : Set (Clause V)) (prev : List (Ineq V))
    (I : Ineq V) : Prop :=
  (∃ C ∈ F, I = clauseIneq C) ∨
  (∃ v : V, I = ⟨Pi.single v (1 : ℤ), 0⟩) ∨
  (∃ v : V, I = ⟨Pi.single v (-1 : ℤ), -1⟩) ∨
  (∃ P ∈ prev, ∃ Q ∈ prev, I = ⟨fun v => P.coef v + Q.coef v, P.rhs + Q.rhs⟩) ∨
  (∃ P ∈ prev, ∃ k : ℕ, I = ⟨fun v => (k : ℤ) * P.coef v, (k : ℤ) * P.rhs⟩) ∨
  (∃ P ∈ prev, ∃ k : ℕ, 0 < k ∧ (∀ v : V, (k : ℤ) ∣ P.coef v) ∧
      I = ⟨fun v => P.coef v / (k : ℤ), -((-P.rhs) / (k : ℤ))⟩)

/-- A cutting-planes refutation of `F`: a valid derivation containing `0 ≥ c` with `c ≥ 1`. -/
def CPRefutation {V : Type} [DecidableEq V] (F : Set (Clause V)) (L : List (Ineq V)) : Prop :=
  ValidSeq (cpStep F) L ∧ ∃ I ∈ L, (∀ v : V, I.coef v = 0) ∧ 0 < I.rhs

/-- Binary length of an integer (0 for 0). -/
def bitLen (z : ℤ) : ℕ := if z = 0 then 0 else Nat.log 2 z.natAbs + 1

/-- Bit size of a line. -/
def Ineq.size {V : Type} [Fintype V] (I : Ineq V) : ℕ := (∑ v : V, bitLen (I.coef v)) + bitLen I.rhs

/-- Size of a cutting-planes derivation: lines plus total bit size. -/
def cpSize {V : Type} [Fintype V] (L : List (Ineq V)) : ℕ := (L.map Ineq.size).sum + L.length

/-- The polynomial that vanishes iff the clause `C` is satisfied (on 0/1 points). -/
def falsePoly {V : Type} (C : Clause V) : MvPolynomial V ℝ :=
  ∏ l ∈ C, (if l.2 = true then 1 - MvPolynomial.X l.1 else MvPolynomial.X l.1)

/-- SoS hypotheses (equalities `g = 0`) for a CNF: Booleanity and clause polynomials. -/
def sosHyps {V : Type} (F : Set (Clause V)) : Set (MvPolynomial V ℝ) :=
  {p | ∃ v : V, p = MvPolynomial.X v ^ 2 - MvPolynomial.X v} ∪ {p | ∃ C ∈ F, p = falsePoly C}

/-- A degree-`D` sum-of-squares (Positivstellensatz) refutation of the equalities `hyps`. -/
def SoSRefutes {V : Type} (hyps : Set (MvPolynomial V ℝ)) (D : ℕ) : Prop :=
  ∃ (k r : ℕ) (g q : Fin k → MvPolynomial V ℝ) (p : Fin r → MvPolynomial V ℝ),
    (∀ i : Fin k, g i ∈ hyps) ∧
    (∀ i : Fin k, (q i).totalDegree + (g i).totalDegree ≤ D) ∧
    (∀ j : Fin r, 2 * (p j).totalDegree ≤ D) ∧
    (∑ i : Fin k, q i * g i) + (∑ j : Fin r, p j ^ 2) = -1

/-! ### The formula SENS_n -/

/-- `⌈√n⌉`. -/
def ceilSqrt (n : ℕ) : ℕ := Nat.sqrt n + if Nat.sqrt n * Nat.sqrt n = n then 0 else 1

/-- Threshold `K = 2^{n-1} + 1`. -/
def K (n : ℕ) : ℕ := 2 ^ (n - 1) + 1

/-- `d = ⌈√n⌉ − 1`; clauses forbid `d + 1` neighbours. -/
def dSens (n : ℕ) : ℕ := ceilSqrt n - 1

/-- Variables: main variables (cube vertices) and counter variables `s_{i,j}`. -/
abbrev SVar (n : ℕ) : Type := Fin (2 ^ n) ⊕ (Fin (2 ^ n + 1) × Fin (K n + 1))

/-- Main variable of vertex `a`. -/
def xv (n : ℕ) (a : Fin (2 ^ n)) : SVar n := Sum.inl a

/-- Counter variable `s_{i,j}`. -/
def sv (n : ℕ) (i : Fin (2 ^ n + 1)) (j : Fin (K n + 1)) : SVar n := Sum.inr (i, j)

/-- Cube adjacency of vertices given by their bit patterns. -/
def Adj (n : ℕ) (a b : Fin (2 ^ n)) : Prop :=
  (Finset.univ.filter fun k : Fin n => a.val.testBit k.val ≠ b.val.testBit k.val).card = 1

/-- The clauses of SENS_n. -/
def SensClause (n : ℕ) (C : Clause (SVar n)) : Prop :=
  C = {(sv n (Fin.last (2 ^ n)) (Fin.last (K n)), true)} ∨
  (∃ j : Fin (K n), C = {(sv n (0 : Fin (2 ^ n + 1)) j.succ, false)}) ∨
  (∃ (i : Fin (2 ^ n)) (j : Fin (K n)),
      C = {(sv n i.succ j.succ, false), (sv n i.castSucc j.succ, true), (xv n i, true)}) ∨
  (∃ (i : Fin (2 ^ n)) (j : Fin (K n)),
      C = {(sv n i.succ j.succ, false), (sv n i.castSucc j.succ, true),
        (sv n i.castSucc j.castSucc, true)}) ∨
  (∃ (v : Fin (2 ^ n)) (U : Finset (Fin (2 ^ n))),
      (∀ u ∈ U, Adj n v u) ∧ U.card = dSens n + 1 ∧
        C = insert (xv n v, false) (U.image fun u : Fin (2 ^ n) => (xv n u, false)))

/-- SENS_n as a set of clauses. -/
def sensCNF (n : ℕ) : Set (Clause (SVar n)) := {C | SensClause n C}

/-- (a) Polynomial-size resolution refutations. -/
def ClaimRes : Prop :=
  ∃ k : ℕ, ∀ n : ℕ, ∃ L : List (Clause (SVar n)),
    ResRefutation (sensCNF n) L ∧ L.length ≤ (2 ^ n) ^ k + k

/-- (b) Polynomial-size cutting-planes refutations. -/
def ClaimCP : Prop :=
  ∃ k : ℕ, ∀ n : ℕ, ∃ L : List (Ineq (SVar n)),
    CPRefutation (sensCNF n) L ∧ cpSize L ≤ (2 ^ n) ^ k + k

/-- (c) Sum-of-squares refutations of degree `O(log N) = O(n)`. -/
def ClaimSoS : Prop :=
  ∃ C : ℕ, ∀ n : ℕ, SoSRefutes (sosHyps (sensCNF n)) (C * (n + 1))

def Claim : Prop := ClaimRes ∨ ClaimCP ∨ ClaimSoS

end
end OpenProblems.QEDM041
