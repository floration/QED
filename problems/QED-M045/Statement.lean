import Mathlib
/-! QED-M045: Chaos in the symmetric ABC flow
The ABC flow with A = B = C = 1 is the classical steady Euler (Beltrami) flow on the 3-torus believed
to be chaotic. Prove that it has positive topological entropy.
Informal statement: Prove that the flow of ẋ = sin z + cos y, ẏ = sin x + cos z, ż = sin y + cos x on
𝕋³ = (ℝ/2πℤ)³ has positive topological entropy.
Formalization notes: The flow is lifted to ℝ³ = `Fin 3 → ℝ` (coordinates x = v 0, y = v 1, z = v 2);
`IsABCFlow Φ` says Φ solves the ODE with Φ 0 = id (such Φ exists and is unique: the field is smooth,
bounded and globally Lipschitz). The vector field is 2π-periodic, so Φ descends to 𝕋³. The torus
metric `torusDist` is the max of the circular distances of the coordinates. The topological entropy
of a flow is that of its time-1 map, and by Bowen's definition via (n, ε)-separated sets,
h > 0 iff there are ε > 0 and c > 0 such that for infinitely many n there is an (n, ε)-separated set
of cardinality ≥ e^{cn}; separation is for times k = 0, …, n−1 of the time-1 map, i.e. Φ k. Points
are taken as representatives in [0, 2π)³, so distinct representatives are distinct torus points.
Entropy does not depend on the compatible metric. Proving `Claim` proves positive entropy; proving
`¬ Claim` proves zero topological entropy.
-/
namespace OpenProblems.QEDM045

/-- ℝ³ as functions `Fin 3 → ℝ`. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- The 1:1:1 ABC vector field. -/
noncomputable def abc (v : R3) : R3 :=
  ![Real.sin (v 2) + Real.cos (v 1), Real.sin (v 0) + Real.cos (v 2),
    Real.sin (v 1) + Real.cos (v 0)]

/-- `Φ` is the flow of the ABC vector field on ℝ³. -/
def IsABCFlow (Φ : ℝ → R3 → R3) : Prop :=
  ∀ x : R3, Φ 0 x = x ∧ ∀ t : ℝ, HasDerivAt (fun s : ℝ => Φ s x) (abc (Φ t x)) t

/-- Distance on the circle `ℝ / 2πℤ`. -/
noncomputable def circDist (a b : ℝ) : ℝ :=
  |a - b - 2 * Real.pi * ((round ((a - b) / (2 * Real.pi)) : ℤ) : ℝ)|

/-- Max-metric on the torus `(ℝ / 2πℤ)³`, evaluated on representatives. -/
noncomputable def torusDist (x y : R3) : ℝ :=
  max (circDist (x 0) (y 0)) (max (circDist (x 1) (y 1)) (circDist (x 2) (y 2)))

/-- Representatives in the fundamental box `[0, 2π)³`. -/
def InBox (x : R3) : Prop := ∀ i : Fin 3, 0 ≤ x i ∧ x i < 2 * Real.pi

/-- `S` is an `(n, ε)`-separated set for the time-1 map of `Φ`. -/
def IsSeparated (Φ : ℝ → R3 → R3) (n : ℕ) (ε : ℝ) (S : Finset R3) : Prop :=
  (∀ x ∈ S, InBox x) ∧
    ∀ x ∈ S, ∀ y ∈ S, x ≠ y → ∃ k : ℕ, k < n ∧ ε < torusDist (Φ (k : ℝ) x) (Φ (k : ℝ) y)

def Claim : Prop :=
  ∀ Φ : ℝ → R3 → R3, IsABCFlow Φ →
    ∃ ε : ℝ, 0 < ε ∧ ∃ c : ℝ, 0 < c ∧
      ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ ∃ S : Finset R3, IsSeparated Φ n ε S ∧
        Real.exp (c * (n : ℝ)) ≤ (S.card : ℝ)

end OpenProblems.QEDM045
