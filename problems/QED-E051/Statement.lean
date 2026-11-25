import Mathlib
/-! QED-E051: Translational tiling of the plane with two tiles: decidable?
Given two finite sets of grid cells, can translated copies (no rotations) of them tile ℤ² exactly? Is there an algorithm deciding this?
Informal statement: Is the set of pairs (F₁, F₂) of finite subsets of ℤ² such that ℤ² = (F₁ + A₁) ⊔ (F₂ + A₂) for some A₁, A₂ ⊆ ℤ² decidable?
Formalization notes: Tiles are given as lists of cells in ℕ × ℕ (every finite subset of ℤ² can be translated into the first quadrant, and tileability is translation invariant, so this loses nothing). Duplicates in a list are harmless (`cells` is a set). `TwoTiles F₁ F₂` says every z ∈ ℤ² lies in exactly one placed copy, where a copy is a pair (tile index, translation vector) with the vector in the corresponding Aⱼ. That is a disjoint exact cover. An empty tile is allowed (the instance then degenerates to one-tile tiling, which is decidable, so it creates no loophole). `Claim` = the problem is decidable (computable in Mathlib's Partrec sense). `¬Claim` = undecidable. The connected-polyomino variant is not encoded.
-/
namespace OpenProblems.QEDE051

/-- The cells of a tile, as a subset of ℤ². -/
def cells (F : List (ℕ × ℕ)) : Set (ℤ × ℤ) :=
  {z | ∃ p ∈ F, z = ((p.1 : ℤ), (p.2 : ℤ))}

/-- Translates of `F₁` and `F₂` tile ℤ² exactly. -/
def TwoTiles (F₁ F₂ : List (ℕ × ℕ)) : Prop :=
  ∃ A₁ A₂ : Set (ℤ × ℤ), ∀ z : ℤ × ℤ, ∃! q : Bool × (ℤ × ℤ),
    (q.1 = false ∧ q.2 ∈ A₁ ∧ z - q.2 ∈ cells F₁) ∨
    (q.1 = true ∧ q.2 ∈ A₂ ∧ z - q.2 ∈ cells F₂)

/-- Two-tile translational tiling of the plane is decidable. -/
def Claim : Prop :=
  ComputablePred (fun F : List (ℕ × ℕ) × List (ℕ × ℕ) => TwoTiles F.1 F.2)

end OpenProblems.QEDE051
