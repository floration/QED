import Mathlib
/-! QED-E067: Is the complete-pivoting growth factor exactly 8 for 8×8 matrices?
The worst-case growth factor g_n of Gaussian elimination with complete pivoting is attained value n
by Hadamard matrices for n = 8, and g_8 = 8 is conjectured (Edelman–Urschel). Decide whether g_8 = 8.
Informal statement: With g_n the maximal complete-pivoting growth factor over nonsingular real n×n
matrices, prove or disprove g_8 = 8. (Claim: g_8 ≤ 8; since an 8×8 Hadamard matrix has growth exactly
8, this is equivalent to g_8 = 8. Determining g_7 is a separate question, not part of Claim.)
Formalization notes: After row/column permutations every matrix is in completely pivoted (CP) form:
at each stage m (0-based) the pivot entry (m,m) of the Schur complement has maximal absolute value
in the active block {i, j ≥ m}. `stage A m` is the matrix after eliminating pivots 0..m−1 (entries
with i or j < m are frozen). A is nonsingular iff all pivots are nonzero (given CP). The growth factor
is max_{m,i,j ≥ m} |stage A m i j| / max_{i,j} |a_ij|, and max |a_ij| = |a_00| for CP matrices; all
pivot ties are covered since every tie-breaking produces some CP matrix. `ent` reads entries with ℕ
indices (0 outside range).
Proving `Claim` = g_8 ≤ 8 (hence g_8 = 8). Proving `¬Claim` = an 8×8 CP nonsingular matrix with growth > 8.
-/
namespace OpenProblems.QEDE067

/-- Entry with natural-number indices (0 out of range). -/
def ent {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ) (i j : ℕ) : ℝ :=
  if h : i < n ∧ j < n then M ⟨i, h.1⟩ ⟨j, h.2⟩ else 0

/-- Matrix after `m` steps of Gaussian elimination without further pivoting. -/
noncomputable def stage {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : ℕ → Matrix (Fin n) (Fin n) ℝ
  | 0 => A
  | m + 1 => Matrix.of fun i j =>
      if m < (i : ℕ) ∧ m < (j : ℕ) then
        stage A m i j - ent (stage A m) (i : ℕ) m * ent (stage A m) m (j : ℕ) / ent (stage A m) m m
      else stage A m i j

/-- `A` is nonsingular and in completely pivoted form. -/
def IsCP {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∀ m : ℕ, m < n → ent (stage A m) m m ≠ 0 ∧
    ∀ i j : Fin n, m ≤ (i : ℕ) → m ≤ (j : ℕ) → |stage A m i j| ≤ |ent (stage A m) m m|

def Claim : Prop :=
  ∀ A : Matrix (Fin 8) (Fin 8) ℝ, IsCP A →
    ∀ m : ℕ, m < 8 → ∀ i j : Fin 8, m ≤ (i : ℕ) → m ≤ (j : ℕ) →
      |stage A m i j| ≤ 8 * |A 0 0|

end OpenProblems.QEDE067
