import Mathlib
/-! QED-E053: A polyomino of odd order
Is there a non-rectangular polyomino whose order (fewest congruent copies tiling some rectangle) is odd?
Informal statement: For a polyomino P that tiles a rectangle with congruent copies (rotations and reflections allowed), ord(P) is the least number of copies in such a tiling. Does some non-rectangular P have ord(P) odd?
Formalization notes: Cells are points of ℤ × ℤ (unit squares indexed by lower-left corner). A polyomino is a nonempty finite cell set connected under edge-adjacency (|dx| + |dy| = 1). A congruent copy is the image under one of the 8 symmetries of ℤ² (optional coordinate swap, then signs e₁, e₂ ∈ ℤˣ = {±1}) followed by a translation; `place g` is injective, so a single copy never overlaps itself. `TilesRectWith P k` says k copies exactly partition an a × b rectangle with a, b ≥ 1 (cover plus pairwise disjointness). k = 0 is impossible because the rectangle is nonempty, and the empty set is excluded by `IsPolyomino`. `IsRect P` says P is a translate of an a × b rectangle, a, b ≥ 1. `Claim` = such an odd-order polyomino exists. `¬Claim` = every non-rectangular rectifiable polyomino has even order (or tiles no rectangle).
-/
namespace OpenProblems.QEDE053

/-- The a × b rectangle [0,a) × [0,b) of cells. -/
def rect (a b : ℕ) : Set (ℤ × ℤ) := {z | 0 ≤ z.1 ∧ z.1 < a ∧ 0 ≤ z.2 ∧ z.2 < b}

/-- `P` is a translate of a nonempty rectangle. -/
def IsRect (P : Finset (ℤ × ℤ)) : Prop :=
  ∃ (a b : ℕ) (t : ℤ × ℤ), 0 < a ∧ 0 < b ∧ ∀ z : ℤ × ℤ, z ∈ P ↔ z - t ∈ rect a b

/-- Edge-adjacent cells. -/
def Adj (p q : ℤ × ℤ) : Prop := |p.1 - q.1| + |p.2 - q.2| = 1

/-- `P` is a polyomino: nonempty and edge-connected. -/
def IsPolyomino (P : Finset (ℤ × ℤ)) : Prop :=
  P.Nonempty ∧ ∀ p ∈ P, ∀ q ∈ P,
    Relation.ReflTransGen (fun x y : ℤ × ℤ => x ∈ P ∧ y ∈ P ∧ Adj x y) p q

/-- A symmetry of ℤ² (swap flag, two signs, translation) applied to a cell. -/
def place (g : Bool × ℤˣ × ℤˣ × (ℤ × ℤ)) (p : ℤ × ℤ) : ℤ × ℤ :=
  ((g.2.1 : ℤ) * (if g.1 then p.2 else p.1) + g.2.2.2.1,
   (g.2.2.1 : ℤ) * (if g.1 then p.1 else p.2) + g.2.2.2.2)

/-- `k` congruent copies of `P` exactly tile some nonempty rectangle. -/
def TilesRectWith (P : Finset (ℤ × ℤ)) (k : ℕ) : Prop :=
  ∃ (a b : ℕ) (c : Fin k → Bool × ℤˣ × ℤˣ × (ℤ × ℤ)), 0 < a ∧ 0 < b ∧
    (∀ z : ℤ × ℤ, z ∈ rect a b ↔ ∃ i : Fin k, ∃ p ∈ P, place (c i) p = z) ∧
    (∀ (i j : Fin k) (p q : ℤ × ℤ), p ∈ P → q ∈ P →
      place (c i) p = place (c j) q → i = j)

def Claim : Prop :=
  ∃ P : Finset (ℤ × ℤ), IsPolyomino P ∧ ¬ IsRect P ∧
    ∃ k : ℕ, Odd k ∧ TilesRectWith P k ∧ ∀ k' : ℕ, k' < k → ¬ TilesRectWith P k'

end OpenProblems.QEDE053
