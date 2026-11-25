import Mathlib
/-! QED-M101: Infinitely many knot types in the symmetric ABC flow
Steady Euler flows can carry knotted streamlines. Show that the ABC flow with A = B = C = 1 on the 3-torus has closed
streamlines, each lying in an embedded ball, tied in infinitely many different knot types.
Informal statement: Let X = (sin z + cos y, sin x + cos z, sin y + cos x) on 𝕋³ = (ℝ/2πℤ)³. Prove that the periodic
orbits of X that lie in some embedded 3-ball B ⊂ 𝕋³ realize infinitely many distinct knot types (as knots in
B ≅ a ball in ℝ³). (Stronger, not formalized here: every knot type is realized.)
Formalization notes: Work on the universal cover ℝ³ = (Fin 3 → ℝ) with the 2π-periodic field `abc`. A closed orbit of
X in 𝕋³ lying in an embedded ball lifts to a genuinely periodic, non-constant integral curve γ of `abc` in ℝ³
contained in a lifted ball B̃ on which the projection to 𝕋³ is injective (`InjectiveModLattice`); conversely such a
γ projects to a closed orbit in an embedded ball. Balls are taken tame: B̃ = h(closed unit ball) for a homeomorphism h
of ℝ³ (every smooth or PL ball is of this form). The knot type of the orbit in B is then the ambient-isotopy class
in ℝ³ of the lifted curve. `KnotEquiv` is ambient isotopy: a jointly continuous family of homeomorphisms H_t of ℝ³
with H_0 = id carrying K₁ onto K₂ (orientation-preserving, so a chiral knot and its mirror are different types; this
is the standard notion, and for these smooth knots it agrees with equivalence under orientation-preserving
homeomorphisms). Claim: there is a sequence of such orbit-knots, pairwise not ambient isotopic. Proving Claim = the
result; proving ¬Claim = only finitely many knot types occur among ball-contained closed orbits.
-/
namespace OpenProblems.QEDM101

/-- The ABC field with `A = B = C = 1`, as a `2π`-periodic field on `ℝ³`. -/
noncomputable def abc (x : Fin 3 → ℝ) : Fin 3 → ℝ :=
  ![Real.sin (x 2) + Real.cos (x 1), Real.sin (x 0) + Real.cos (x 2), Real.sin (x 1) + Real.cos (x 0)]

/-- The projection `ℝ³ → 𝕋³ = (ℝ/2πℤ)³` is injective on `B`. -/
def InjectiveModLattice (B : Set (Fin 3 → ℝ)) : Prop :=
  ∀ a ∈ B, ∀ b ∈ B, (∀ i : Fin 3, ∃ k : ℤ, a i - b i = 2 * Real.pi * (k : ℝ)) → a = b

/-- `B` is a tame closed 3-ball in `ℝ³` that projects injectively to the torus. -/
def IsTameBallInTorus (B : Set (Fin 3 → ℝ)) : Prop :=
  (∃ h : (Fin 3 → ℝ) ≃ₜ (Fin 3 → ℝ), B = h '' Metric.closedBall (0 : Fin 3 → ℝ) 1) ∧
    InjectiveModLattice B

/-- `K` is the image of a non-constant periodic integral curve of `abc` in `ℝ³`. -/
def IsClosedOrbit (K : Set (Fin 3 → ℝ)) : Prop :=
  ∃ γ : ℝ → (Fin 3 → ℝ), ∃ T : ℝ, 0 < T ∧
    (∀ t : ℝ, HasDerivAt γ (abc (γ t)) t) ∧ (∀ t : ℝ, γ (t + T) = γ t) ∧
    (∃ t₁ t₂ : ℝ, γ t₁ ≠ γ t₂) ∧ K = Set.range γ

/-- A closed orbit lying in a tame ball of the torus (lifted to `ℝ³`). -/
def IsBallOrbitKnot (K : Set (Fin 3 → ℝ)) : Prop :=
  IsClosedOrbit K ∧ ∃ B : Set (Fin 3 → ℝ), IsTameBallInTorus B ∧ K ⊆ B

/-- Ambient isotopy of subsets of `ℝ³`. -/
def KnotEquiv (K₁ K₂ : Set (Fin 3 → ℝ)) : Prop :=
  ∃ H : ℝ → (Fin 3 → ℝ) ≃ₜ (Fin 3 → ℝ),
    Continuous (fun p : ℝ × (Fin 3 → ℝ) => H p.1 p.2) ∧
    (∀ x : Fin 3 → ℝ, H 0 x = x) ∧ (H 1) '' K₁ = K₂

def Claim : Prop :=
  ∃ K : ℕ → Set (Fin 3 → ℝ), (∀ n : ℕ, IsBallOrbitKnot (K n)) ∧
    ∀ m n : ℕ, m ≠ n → ¬ KnotEquiv (K m) (K n)

end OpenProblems.QEDM101
