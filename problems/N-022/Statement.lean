import Mathlib
/-! N-022: Blank jigsaw with few edge shapes
A blank n×n jigsaw has each internal edge cut in one of k shapes (a tab fitting only its own blank);
pieces may be rotated. How small can k be if some n×n blank jigsaw still assembles in exactly one way
(up to rotating the whole square)? Counting gives k ≥ c√n; random puzzles need about n.
Informal statement: An n×n jigsaw with k edge types assigns to each internal edge of the n×n grid a type
in [k] and an orientation (which side carries the tab); border edges are flat. Pieces are the n² unit
squares, each a distinct physical object carrying its four (type, tab/blank) labels up to rotation. An
assembly places all pieces bijectively on the cells, each rotated by a multiple of 90°, so that every
internal edge joins a tab and a blank of the same type and all flat edges lie on the border. Let k(n)
be the least k for which some n×n jigsaw with k edge types has exactly one assembly up to the four
rotations of the whole square. Is k(n) = Θ(√n)? Since k(n) ≥ c√n is known (unique assembly forces
all n² pieces to be distinct), Claim is the upper bound k(n) = O(√n).
Formalization notes: Cells are `Fin n × Fin n` (row, column; row 0 on top). Sides are `Fin 4` in
clockwise order 0 = N, 1 = E, 2 = S, 3 = W. A side label is `none` (flat) or `some (t, b)` with type
`t : Fin k` and `b = true` for a tab. `Valid L`: flat exactly on the border, and horizontally /
vertically adjacent cells show the same type with opposite tab/blank. A jigsaw is a valid labelling
`side` of the solved grid; piece p is cell p of the solved grid. An assembly is `(σ, r)`: piece p goes
to cell σ p rotated clockwise r p quarter-turns, so cell c shows on side d the label
`side (σ⁻¹ c) (d − r (σ⁻¹ c))`. Rotating a valid assembly as a whole gives a valid assembly with every
r increased by 1, so the four global rotations of the solved assembly are always 4 distinct
assemblies; "exactly one assembly up to rotation" ⇔ the number of valid assemblies is exactly 4.
Proving `Claim` = ∃ C, ∀ n ≥ 1, a uniquely assembling n×n jigsaw with ≤ C√n edge types.
Proving `¬Claim` = k(n)/√n is unbounded.
-/
namespace OpenProblems.N022

/-- Cells of the n×n grid. -/
abbrev Cell (n : ℕ) : Type := Fin n × Fin n

/-- Side label: flat (`none`) or (type, is-tab). -/
abbrev Label (k : ℕ) : Type := Option (Fin k × Bool)

/-- Two sides fit: same type, one tab and one blank. -/
def Fits {k : ℕ} (x y : Label k) : Prop :=
  ∃ t : Fin k, ∃ b : Bool, x = some (t, b) ∧ y = some (t, !b)

/-- Side `d` of cell `c` is on the outer border. -/
def OnBorder {n : ℕ} (c : Cell n) (d : Fin 4) : Prop :=
  (d = 0 ∧ (c.1 : ℕ) = 0) ∨ (d = 1 ∧ (c.2 : ℕ) + 1 = n) ∨
  (d = 2 ∧ (c.1 : ℕ) + 1 = n) ∨ (d = 3 ∧ (c.2 : ℕ) = 0)

/-- A labelling of the sides of all cells is a correctly fitted puzzle. -/
def Valid {n k : ℕ} (L : Cell n → Fin 4 → Label k) : Prop :=
  (∀ (c : Cell n) (d : Fin 4), L c d = none ↔ OnBorder c d) ∧
  (∀ c c' : Cell n, c.1 = c'.1 → (c.2 : ℕ) + 1 = (c'.2 : ℕ) → Fits (L c 1) (L c' 3)) ∧
  (∀ c c' : Cell n, c.2 = c'.2 → (c.1 : ℕ) + 1 = (c'.1 : ℕ) → Fits (L c 2) (L c' 0))

/-- Labels shown on the grid when piece `p` is put at cell `σ p`, rotated by `r p` quarter-turns. -/
def placed {n k : ℕ} (side : Cell n → Fin 4 → Label k)
    (a : Equiv.Perm (Cell n) × (Cell n → Fin 4)) : Cell n → Fin 4 → Label k :=
  fun c d => side (a.1.symm c) (d - a.2 (a.1.symm c))

/-- Number of valid assemblies of the jigsaw `side`. -/
noncomputable def numAssemblies {n k : ℕ} (side : Cell n → Fin 4 → Label k) : ℕ :=
  Nat.card {a : Equiv.Perm (Cell n) × (Cell n → Fin 4) // Valid (placed side a)}

def Claim : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ n : ℕ, 1 ≤ n → ∃ k : ℕ, (k : ℝ) ≤ C * Real.sqrt (n : ℝ) ∧
    ∃ side : Cell n → Fin 4 → Label k, Valid side ∧ numAssemblies side = 4

end OpenProblems.N022
