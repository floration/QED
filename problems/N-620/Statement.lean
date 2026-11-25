import Mathlib
/-! N-620: Knotted billiards in a regular tetrahedron
A billiard ball bouncing periodically inside a regular tetrahedron, never hitting an edge or a
corner, traces a closed polygon in space. Do infinitely many knot types occur among these
polygons (in particular, is any of them knotted)?
Informal statement: Call a periodic billiard trajectory in a regular tetrahedron T ⊂ ℝ³
admissible if it never meets an edge or vertex of T and its image is an embedded closed polygon.
(a) Does some admissible trajectory form a nontrivial knot? (b) Prove that the set of knot types
of admissible periodic trajectories is infinite. The Claim is (b), which implies (a).
Formalization notes: T = {x ∈ ℝ³ : ⟪x, vᵢ⟫ ≥ −1 for i = 0..3} with vertices
v₀ = (1,1,1), v₁ = (1,−1,−1), v₂ = (−1,1,−1), v₃ = (−1,−1,1); face i is {⟪x, vᵢ⟫ = −1}, with
outward normal −vᵢ. A periodic trajectory (`PeriodicOrbit`) is an N-periodic sequence of bounce
points pₖ (N ≥ 1), each in the relative interior of a face φ(k) (on that face and strictly inside
the other three half-spaces, so never on an edge or vertex), consecutive bounce points on
different faces (so the open chords lie in the interior of T, by convexity), and the reflection
law: the outgoing direction p_{k+2} − p_{k+1} is a positive multiple of the mirror image of the
incoming direction p_{k+1} − p_k in the plane of face φ(k+1), R(d) = d − (2/3)⟪d, v⟫ v. The
image is ⋃_{k<N} [pₖ, p_{k+1}]; admissible means it is a topological circle (image of a
continuous injective map from the unit circle in ℂ). This automatically discards orbits that
retrace themselves or self-intersect; orbits traversing their image twice are allowed, as in the
notes. Knot types are compared up to homeomorphisms of ℝ³ (`KnotEquiv`): for polygonal (tame)
knots this is ambient isotopy up to mirror image, and since each such class contains at most two
isotopy classes, "infinitely many knot types" and "nontrivial knot" mean the same under either
convention. The unknot is represented by a planar triangle. Proving `Claim` = exhibiting, for
every n, n admissible orbits with pairwise inequivalent images; `¬Claim` = only finitely many
knot types occur.
-/
namespace OpenProblems.N620

/-- Points of ℝ³. -/
abbrev R3 : Type := Fin 3 → ℝ

/-- Euclidean inner product on ℝ³. -/
def dot (x y : R3) : ℝ := ∑ i : Fin 3, x i * y i

/-- Vertices of the regular tetrahedron `T`. -/
def tetVert : Fin 4 → R3 :=
  ![![(1 : ℝ), 1, 1], ![(1 : ℝ), -1, -1], ![(-1 : ℝ), 1, -1], ![(-1 : ℝ), -1, 1]]

/-- The regular tetrahedron `T = {x | ∀ i, ⟪x, vᵢ⟫ ≥ −1}`. -/
def tetra : Set R3 := {x : R3 | ∀ i : Fin 4, -1 ≤ dot x (tetVert i)}

/-- `p` lies in the relative interior of face `i` (the face opposite vertex `i`). -/
def OnFaceInt (i : Fin 4) (p : R3) : Prop :=
  dot p (tetVert i) = -1 ∧ ∀ j : Fin 4, j ≠ i → -1 < dot p (tetVert j)

/-- Reflection of a direction vector in the plane of face `i` (normal `vᵢ`, `‖vᵢ‖² = 3`). -/
def refl (i : Fin 4) (d : R3) : R3 :=
  d - ((2 : ℝ) / 3 * dot d (tetVert i)) • tetVert i

/-- A periodic billiard trajectory in `T` avoiding edges and vertices. -/
structure PeriodicOrbit where
  N : ℕ
  hN : 0 < N
  p : ℕ → R3
  face : ℕ → Fin 4
  periodic : ∀ k, p (k + N) = p k
  on_face : ∀ k, OnFaceInt (face k) (p k)
  next_face : ∀ k, face (k + 1) ≠ face k
  reflection : ∀ k, ∃ c : ℝ, 0 < c ∧
    p (k + 2) - p (k + 1) = c • refl (face (k + 1)) (p (k + 1) - p k)

/-- The image of the trajectory: the union of its chords over one period. -/
def PeriodicOrbit.image (o : PeriodicOrbit) : Set R3 :=
  ⋃ k : Fin o.N, segment ℝ (o.p (k : ℕ)) (o.p ((k : ℕ) + 1))

/-- The image is an embedded closed curve (homeomorphic to a circle). -/
def PeriodicOrbit.Admissible (o : PeriodicOrbit) : Prop :=
  ∃ γ : Metric.sphere (0 : ℂ) 1 → R3,
    Continuous γ ∧ Function.Injective γ ∧ Set.range γ = o.image

/-- Knot equivalence up to homeomorphism of ℝ³. -/
def KnotEquiv (K₁ K₂ : Set R3) : Prop :=
  ∃ h : R3 ≃ₜ R3, h '' K₁ = K₂

/-- A planar triangle, representing the unknot. -/
def unknot : Set R3 :=
  segment ℝ (0 : R3) (Pi.single 0 1) ∪ segment ℝ (Pi.single 0 1) (Pi.single 1 1) ∪
    segment ℝ (Pi.single 1 1) (0 : R3)

/-- Part (a), implied by `Claim`: some admissible orbit is knotted. (Not the Claim.) -/
def SomeKnottedOrbit : Prop :=
  ∃ o : PeriodicOrbit, o.Admissible ∧ ¬ KnotEquiv o.image unknot

/-- Part (b): infinitely many knot types occur among admissible periodic orbits. -/
def Claim : Prop :=
  ∀ n : ℕ, ∃ o : Fin n → PeriodicOrbit, (∀ i, (o i).Admissible) ∧
    ∀ i j : Fin n, i ≠ j → ¬ KnotEquiv (o i).image (o j).image

end OpenProblems.N620
