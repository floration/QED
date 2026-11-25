import Mathlib
/-! QED-E052: A shape with Heesch number 7
Some shapes cannot tile the whole plane but can still be surrounded by a ring of copies of themselves, and that ring by another ring, and so on, up to some limit. The number of rings possible is the shape's Heesch number. The record is 6, found in 2021. Find a shape whose Heesch number is finite but at least 7.
Informal statement: For a closed topological disk $T\subset\mathbb R^2$ that does not tile the plane, the Heesch number $H(T)$ is the largest $k$ such that there is a patch of congruent copies of $T$ made of $T$ surrounded by $k$ successive coronas. Each corona is a ring of copies covering a neighbourhood of the previous patch's boundary, and each intermediate union must be a closed disk (no holes). Exhibit $T$ with $7\le H(T)<\infty$. (The polyform version — a polyomino, polyhex or polyiamond with $7\le H<\infty$ — is a special case: such a polyform is a closed disk $T$, so it would prove the formal `Claim`.)
Formalization notes:
* Plane: `EuclideanSpace ℝ (Fin 2)`; congruent copies are images `g '' T` under isometries
  `g : E ≃ᵢ E` (reflections allowed, as in Kaplan's Heesch computations).
* Closed topological disk: a set homeomorphic (as a subspace) to the closed unit disk. Such a set
  is compact with nonempty interior, so interior-disjoint copies are genuinely non-overlapping.
* k successive coronas (hole-free convention): cumulative finite patches A 0 = {T} ⊆ A 1 ⊆ … ⊆
  A k of copies, with pairwise disjoint interiors (stated for copies with different images, so
  symmetries of T giving the same copy are harmless), such that every union U_i of the copies in
  A i is a closed topological disk, U_i ⊆ interior U_{i+1} (the corona covers a neighbourhood of
  the previous patch, in particular surrounds it), and every new copy in A (i+1) \ A i touches
  U_i (corona tiles are adjacent to the previous patch).
* `HasCoronas T k` is monotone (drop the outer coronas), so H(T) = sup {k : HasCoronas T k}.
  "7 ≤ H(T) < ∞" is then `HasCoronas T 7 ∧ ∃ k, ¬ HasCoronas T k`; no definition of tiling
  is needed (a tile of the plane admits coronas of every order, so H < ∞ implies T does not
  tile).
* Proving `Claim` = a closed disk with finite Heesch number ≥ 7 exists. Proving `¬Claim` = every
  closed disk with finite Heesch number has H ≤ 6.
-/
namespace OpenProblems.QEDE052
noncomputable section

/-- The Euclidean plane. -/
abbrev E : Type := EuclideanSpace ℝ (Fin 2)

/-- `S` is a closed topological disk. -/
def IsClosedDisk (S : Set E) : Prop := Nonempty (Metric.closedBall (0 : E) 1 ≃ₜ S)

/-- Union of the copies `g '' T`, `g ∈ A`. -/
def patchUnion (T : Set E) (A : Set (E ≃ᵢ E)) : Set E := ⋃ g ∈ A, g '' T

/-- `T` can be surrounded by `k` successive hole-free coronas. -/
def HasCoronas (T : Set E) (k : ℕ) : Prop :=
  ∃ A : ℕ → Set (E ≃ᵢ E),
    A 0 = {IsometryEquiv.refl E} ∧
    (∀ i : ℕ, i ≤ k → (A i).Finite ∧ IsClosedDisk (patchUnion T (A i))) ∧
    (∀ g ∈ A k, ∀ h ∈ A k, g '' T ≠ h '' T →
      Disjoint (interior (g '' T)) (interior (h '' T))) ∧
    (∀ i : ℕ, i < k →
      A i ⊆ A (i + 1) ∧
      patchUnion T (A i) ⊆ interior (patchUnion T (A (i + 1))) ∧
      ∀ g ∈ A (i + 1) \ A i, (g '' T ∩ patchUnion T (A i)).Nonempty)

/-- A closed disk with finite Heesch number at least 7. -/
def Claim : Prop :=
  ∃ T : Set E, IsClosedDisk T ∧ HasCoronas T 7 ∧ ∃ k : ℕ, ¬ HasCoronas T k

end
end OpenProblems.QEDE052
