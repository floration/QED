import Mathlib
/-! QED-E137: A 3×3 magic square of distinct squares
Can nine different perfect squares be arranged in a 3×3 grid so that every row, every column and both diagonals have the same sum? Such squares exist in size 4×4 and larger, and 3×3 examples with seven square entries are known, but no full 3×3 example has been found and none has been ruled out.
Informal statement: Decide whether there exist integers $x_{ij}$ ($1\le i,j\le 3$) such that the nine numbers $x_{ij}^2$ are pairwise distinct and the matrix $(x_{ij}^2)$ is magic: its three row sums, three column sums and two diagonal sums are all equal.
Formalization notes:
* `IsMagic M` says the three row sums, three column sums, the main diagonal and the
  anti-diagonal of `M : Fin 3 → Fin 3 → ℤ` all equal the sum of row 0.
* Distinctness of the nine squares is injectivity of (i,j) ↦ x i j ^ 2 on `Fin 3 × Fin 3`.
  This excludes trivial solutions (e.g. all entries equal); it also forces at most one entry
  to be 0, and allows the integers x i j to be negative (only their squares matter).
* `Claim` asserts existence. Proving `Claim` = exhibiting a 3×3 magic square of nine
  distinct squares; proving `¬Claim` = showing none exists.
-/
namespace OpenProblems.QEDE137
noncomputable section

/-- All row, column and both diagonal sums of `M` are equal. -/
def IsMagic (M : Fin 3 → Fin 3 → ℤ) : Prop :=
  let S : ℤ := M 0 0 + M 0 1 + M 0 2
  (∀ i : Fin 3, M i 0 + M i 1 + M i 2 = S) ∧
  (∀ j : Fin 3, M 0 j + M 1 j + M 2 j = S) ∧
  M 0 0 + M 1 1 + M 2 2 = S ∧
  M 0 2 + M 1 1 + M 2 0 = S

def Claim : Prop :=
  ∃ x : Fin 3 → Fin 3 → ℤ,
    Function.Injective (fun q : Fin 3 × Fin 3 => x q.1 q.2 ^ 2) ∧
    IsMagic (fun i j : Fin 3 => x i j ^ 2)

end
end OpenProblems.QEDE137
