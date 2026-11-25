import Mathlib
/-! QED-E049: Ropelength lower bound for the trefoil
Tie a knot in a rope of thickness 1 using as little rope as possible. For the simplest knot, the trefoil, computer experiments find tight knots using about 16.37 units of rope. The last refereed proof shows that every knotted rope needs at least 15.66 units, and a 2026 computer-assisted preprint claims 15.76. Raise the proven lower bound for the trefoil substantially, ideally to 16.
Informal statement: For a $C^{1,1}$ simple closed curve $\gamma\subset\mathbb R^3$ let $\mathrm{Rop}(\gamma)=\mathrm{length}(\gamma)/(2\,\mathrm{reach}(\gamma))$ (length over tube diameter), and $R(3_1)=\inf\{\mathrm{Rop}(\gamma):\gamma\text{ a trefoil}\}$ (attained). Known: $15.66\le R(3_1)\lesssim16.372$ (refereed lower bound; numerical upper value), with an unrefereed claim $R(K)>15.7561$ for all nontrivial $K$. Formal target: a lower bound strictly beyond 15.7561, i.e. $R(3_1)>15.7561$, with a verifiable (here: Lean) proof; ideally $R(3_1)\ge16$.
Formalization notes:
* Curves: `γ : ℝ → ℝ³`, 1-periodic, C¹ with nowhere-vanishing derivative, injective on [0,1)
  (a regular embedded closed C¹ curve). Its image is `γ '' [0,1]`.
* Reach (Federer): sup of r ≥ 0 such that every point at distance < r from the image has a
  unique nearest point on it. For a closed C¹ curve, reach > 0 iff the curve is C^{1,1}, and the
  reach equals the thickness Δ[γ] (Gonzalez–Maddocks–Schuricht–von der Mosel); reach is finite
  for a closed curve, so the `sSup` is a real supremum. Curves of reach 0 have infinite
  ropelength and are excluded explicitly (avoiding the junk value x/0 = 0).
* Length = ∫₀¹ |γ'(t)| dt; Rop = length / (2·reach) (diameter convention, matching 15.66).
* Knot type: γ is a trefoil iff for all large N the inscribed polygon γ(0), γ(1/N), …,
  γ((N−1)/N) is a polygonal trefoil. For a regular embedded C¹ closed curve the inscribed
  polygons are, for N large, embedded and isotopic to γ, so this is the knot type of γ.
* Polygonal knots: a list `l` of vertices in ℝ³ (closed polygon, edge from the last vertex back
  to the first), embedded (`Simple`: ≥ 3 vertices and the PL parametrization `param` is
  injective on [0, n)). Every tame knot has polygonal representatives, so knot types = classes
  of polygonal knots.
* Knot type (`Iso`): equivalence closure of three elementary moves: cyclic relabelling
  (`rotate 1`), subdivision of the first edge at an interior point, and a straight-line slide of
  the first vertex along which every intermediate polygon is embedded. Rotation lets these act
  anywhere. Reidemeister's Δ-move (replace edge [a,b] by [a,c] ∪ [c,b] when the triangle abc
  meets the knot only in [a,b]) is a subdivision followed by a slide of the new vertex, and its
  inverse is in the closure. Conversely every move is realised by a PL ambient isotopy. So
  `Iso` is exactly PL ambient isotopy of oriented polygonal knots (Reidemeister 1927), which is
  the same as ambient isotopy of tame knots. Mirror images are not identified (no reflection
  move), and orientation is kept (no reversal move).

* `trefoil`: 12 integer points sampled from the (2,3) torus knot and rounded. Checked
  numerically: the polygon is embedded (minimum distance between non-adjacent edges ≈ 12.8,
  much larger than the rounding error) and a generic projection has 5 crossings with knot
  determinant 3; the only knot of crossing number ≤ 5 with determinant 3 is the trefoil.
* The infimum R(3₁) is attained, so "a bound beyond 15.7561" means exactly R(3₁) > 15.7561;
  `Claim` says: some L > 15.7561 bounds the ropelength of every trefoil from below. (This is the
  2026 preprint's claimed inequality specialised to the trefoil; a formal proof of it, or of
  anything stronger such as L = 16, is what is asked.) The best refereed bound is 15.66.
  Proving `Claim` = R(3₁) > 15.7561. Proving `¬Claim` = R(3₁) ≤ 15.7561 (refuting the preprint).
-/
namespace OpenProblems.QEDE049
noncomputable section

/-- Points of `ℝ³` (Euclidean). -/
abbrev E3 : Type := EuclideanSpace ℝ (Fin 3)

/-- Vertex `k` of the closed polygon with vertex list `l` (indices taken mod the length). -/
def vtx (l : List E3) (k : ℕ) : E3 := l.getD (k % l.length) 0

/-- Piecewise-linear parametrization: on `[i, i+1]` it runs along the edge from vertex `i` to
vertex `i+1`; on `[0, n)` (n = number of vertices) it traverses the polygon once. -/
def param (l : List E3) (s : ℝ) : E3 :=
  (1 - (s - (⌊s⌋₊ : ℝ))) • vtx l ⌊s⌋₊ + (s - (⌊s⌋₊ : ℝ)) • vtx l (⌊s⌋₊ + 1)

/-- Double points of the polygon: parameter pairs `0 ≤ s < s' < n` with the same image. -/
def doublePts (l : List E3) : Set (ℝ × ℝ) :=
  {q : ℝ × ℝ | 0 ≤ q.1 ∧ q.1 < q.2 ∧ q.2 < (l.length : ℝ) ∧ param l q.1 = param l q.2}

/-- A polygonal knot: at least 3 vertices and the closed polygon is embedded (this also forces
consecutive vertices to be distinct). -/
def Simple (l : List E3) : Prop := 3 ≤ l.length ∧ doublePts l = ∅

/-- The polygon `x :: r` with its first vertex moved to `(1-t)x + t x'`. -/
def movePath (x x' : E3) (r : List E3) (t : ℝ) : List E3 := ((1 - t) • x + t • x') :: r

/-- Elementary isotopy moves: cyclic relabelling, subdivision of an edge, and a straight-line
slide of one vertex during which the polygon stays embedded. -/
inductive Move : List E3 → List E3 → Prop
  | rot (l : List E3) : Simple l → Move l (l.rotate 1)
  | sub (x y p : E3) (r : List E3) : Simple (x :: y :: r) → p ∈ openSegment ℝ x y →
      Move (x :: y :: r) (x :: p :: y :: r)
  | slide (x x' : E3) (r : List E3) :
      (∀ t ∈ Set.Icc (0 : ℝ) 1, Simple (movePath x x' r t)) → Move (x :: r) (x' :: r)

/-- Same (oriented) knot type: the equivalence closure of `Move` (zig-zag chains). -/
inductive Iso : List E3 → List E3 → Prop
  | refl (l : List E3) : Iso l l
  | fwd {a b c : List E3} : Move a b → Iso b c → Iso a c
  | bwd {a b c : List E3} : Move b a → Iso b c → Iso a c

/-- A trefoil (of one chirality): 12 integer points on the (2,3) torus knot
`((2 + cos 3t) cos 2t, (2 + cos 3t) sin 2t, sin 3t)`, `t = 2πk/12`, scaled by 10 and rounded. -/
def trefoil : List E3 :=
  [!₂[(30 : ℝ), 0, 0], !₂[(10 : ℝ), 17, 10], !₂[(-5 : ℝ), 9, 0], !₂[(-20 : ℝ), 0, -10],
   !₂[(-15 : ℝ), -26, 0], !₂[(10 : ℝ), -17, 10], !₂[(10 : ℝ), 0, 0], !₂[(10 : ℝ), 17, -10],
   !₂[(-15 : ℝ), 26, 0], !₂[(-20 : ℝ), 0, 10], !₂[(-5 : ℝ), -9, 0], !₂[(10 : ℝ), -17, -10]]

/-- A regular embedded closed `C¹` curve with period 1. -/
def IsClosedCurve (γ : ℝ → E3) : Prop :=
  ContDiff ℝ 1 γ ∧ (∀ t : ℝ, γ (t + 1) = γ t) ∧ (∀ t : ℝ, deriv γ t ≠ 0) ∧
    Set.InjOn γ (Set.Ico (0 : ℝ) 1)

/-- Federer's reach of a set. -/
def reach (S : Set E3) : ℝ :=
  sSup {r : ℝ | 0 ≤ r ∧ ∀ x : E3, Metric.infDist x S < r →
    ∃! y : E3, y ∈ S ∧ dist x y = Metric.infDist x S}

/-- Length of a 1-periodic `C¹` curve. -/
def curveLength (γ : ℝ → E3) : ℝ := ∫ t in (0 : ℝ)..1, ‖deriv γ t‖

/-- The curve has the knot type of the trefoil. -/
def IsTrefoil (γ : ℝ → E3) : Prop :=
  ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → Iso (List.ofFn fun k : Fin N => γ ((k : ℝ) / (N : ℝ))) trefoil

/-- `R(3₁) > 15.7561`. -/
def Claim : Prop :=
  ∃ L : ℝ, (157561 / 10000 : ℝ) < L ∧
    ∀ γ : ℝ → E3, IsClosedCurve γ → IsTrefoil γ → 0 < reach (γ '' Set.Icc (0 : ℝ) 1) →
      L ≤ curveLength γ / (2 * reach (γ '' Set.Icc (0 : ℝ) 1))

end
end OpenProblems.QEDE049
