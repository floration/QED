import Mathlib
/-! N-134: A monotile that forces quasicrystalline symmetry
Every known aperiodic monotile (Socolar-Taylor, hat, spectre) has tilings whose hulls show only
crystallographic rotational structure. Is there a single topological-disc tile, with no
markings, all of whose tilings are forced to have Penrose-like fivefold (quasicrystalline)
symmetry, while using only finitely many orientations?
Informal statement: Call a compact set T ⊂ ℝ² homeomorphic to a closed disc a monotile if it
tiles ℝ² by isometric copies (reflections allowed). Does there exist a monotile T such that
(i) every tiling by copies of T uses only finitely many orientations of T (up to translation),
and (ii) for every such tiling 𝒯 the translation hull Ω(𝒯) (closure of the translation orbit
of 𝒯 in the standard local topology: agreement on large balls after small translations) is
invariant under rotation by 2π/5?
Formalization notes: The plane is ℂ. An isometric copy of T is the image of T under
z ↦ a z + b or z ↦ a conj(z) + b with |a| = 1 (`copyMap`); these are all isometries of ℂ.
A tiling is a set of tiles (subsets of ℂ), each an isometric copy of T, covering ℂ, with distinct
tiles having disjoint interiors. "Finitely many orientations" means there is a finite list of
linear parts (a, reflect?) such that every tile is a translate of one of the corresponding
copies of T. `patch R 𝒯` is the set of tiles meeting the open ball B(0,R).
`InHull 𝒯' 𝒯` encodes 𝒯' ∈ Ω(𝒯) for the standard local (Hausdorff-type) topology: for every
ε > 0 there are a translation v and a small shift x (|x| < ε) such that 𝒯' + x and 𝒯 + v have
exactly the same tiles meeting B(0, 1/ε). Since Ω(R𝒯) = R Ω(𝒯) and R^5 = id for the rotation R
by 2π/5, rotation invariance of the closed set Ω(𝒯) is equivalent to R𝒯 ∈ Ω(𝒯); the claim uses
that form. Condition (ii) forces strong aperiodicity. Proving `Claim` means exhibiting such a
tile T (and proving it tiles, and that all its tilings satisfy (i) and (ii)); proving `¬Claim`
means showing no disc-like monotile forces fivefold hull symmetry with finitely many
orientations. Note: finitely many orientations does NOT by itself imply finite local complexity
(tiles may slide along fault lines), which is why the hull uses small shifts. The R³ icosahedral
variant is not formalized.
-/
namespace OpenProblems.N134

/-- The isometry `z ↦ a z + b` (if `refl = false`) or `z ↦ a conj(z) + b` (if `refl = true`). -/
def copyMap (a b : ℂ) (refl : Bool) : ℂ → ℂ :=
  fun z => if refl then a * (starRingEnd ℂ) z + b else a * z + b

/-- `S` is an isometric copy of `T` (reflections allowed). -/
def IsCopy (T S : Set ℂ) : Prop :=
  ∃ a b : ℂ, ∃ refl : Bool, ‖a‖ = 1 ∧ S = copyMap a b refl '' T

/-- `𝒯` is a tiling of the plane by isometric copies of `T`. -/
structure IsTiling (T : Set ℂ) (𝒯 : Set (Set ℂ)) : Prop where
  copies : ∀ S ∈ 𝒯, IsCopy T S
  cover : ⋃₀ 𝒯 = Set.univ
  disjointInteriors : ∀ S ∈ 𝒯, ∀ S' ∈ 𝒯, S ≠ S' → Disjoint (interior S) (interior S')

/-- Every tile of `𝒯` is a translate of one of finitely many fixed copies of `T`. -/
def FiniteOrientations (T : Set ℂ) (𝒯 : Set (Set ℂ)) : Prop :=
  ∃ F : Finset (ℂ × Bool), ∀ S ∈ 𝒯, ∃ p ∈ F, ∃ b : ℂ, ‖p.1‖ = 1 ∧ S = copyMap p.1 b p.2 '' T

/-- Translate every tile of a tiling by `v`. -/
def translateTiling (v : ℂ) (𝒯 : Set (Set ℂ)) : Set (Set ℂ) :=
  (fun S : Set ℂ => (fun z : ℂ => z + v) '' S) '' 𝒯

/-- The primitive fifth root of unity `exp(2πi/5)`. -/
noncomputable def zeta5 : ℂ := Complex.exp (2 * (Real.pi : ℂ) * Complex.I / 5)

/-- Rotate every tile of a tiling by `2π/5` about the origin. -/
noncomputable def rotateTiling (𝒯 : Set (Set ℂ)) : Set (Set ℂ) :=
  (fun S : Set ℂ => (fun z : ℂ => zeta5 * z) '' S) '' 𝒯

/-- The tiles of `𝒯` meeting the open ball of radius `R` about `0`. -/
def patch (R : ℝ) (𝒯 : Set (Set ℂ)) : Set (Set ℂ) :=
  {S : Set ℂ | S ∈ 𝒯 ∧ (S ∩ Metric.ball (0 : ℂ) R).Nonempty}

/-- `𝒯'` lies in the translation hull of `𝒯` (closure of its translation orbit in the local topology). -/
def InHull (𝒯' 𝒯 : Set (Set ℂ)) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ x v : ℂ, ‖x‖ < ε ∧
    patch (1 / ε) (translateTiling x 𝒯') = patch (1 / ε) (translateTiling v 𝒯)

def Claim : Prop :=
  ∃ T : Set ℂ, Nonempty (↥T ≃ₜ ↥(Metric.closedBall (0 : ℂ) 1)) ∧
    (∃ 𝒯 : Set (Set ℂ), IsTiling T 𝒯) ∧
    ∀ 𝒯 : Set (Set ℂ), IsTiling T 𝒯 →
      FiniteOrientations T 𝒯 ∧ InHull (rotateTiling 𝒯) 𝒯

end OpenProblems.N134
