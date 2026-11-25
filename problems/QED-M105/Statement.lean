import Mathlib
/-! QED-M105: Does the trefoil have a symbiont?
The unknotting number of a knot is the fewest crossing changes needed to turn it into an unknotted loop. In 2025 it was shown that tying two knots together end to end can need fewer changes than the two knots need separately, and in 2026 that every torus knot except possibly the trefoil has a partner like this. Does the trefoil, the simplest knot, also have such a partner? The most likely candidate is the 10-crossing knot 10_6, whose own unknotting number is still unknown (it is 2 or 3).
Informal statement: Write $u(K)$ for the unknotting number and $\#$ for connected sum. Knots $K,K'$ are symbionts if $u(K\#K')<u(K)+u(K')$. Is there a knot $K$, with some choice of mirror image, such that $u(3_1\#K)<1+u(K)$? By Scharlemann's theorem any such $K$ has $u(K)\ge2$. Concrete subquestion: is $u(10_6)=3$? Brittenham–Hermiller prove $u(3_1\#10_6)\le3$ for the mirror choice with $|\sigma(3_1\#10_6)|=2$, so $u(10_6)=3$ would give a positive answer. (The formal `Claim` is the main question; the 10_6 subquestion is not formalized.)
Formalization notes:
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
* Crossing change (`CrossChange`): the first vertex slides along a straight line and the
  intermediate polygons are embedded at all times except one time t₀ ∈ (0,1), at which the
  polygon has exactly one double point (exactly one parameter pair; triple points, tangential
  overlaps along segments or collapsed edges give more pairs, hence are excluded). Passing one
  strand through another once changes the knot by one crossing change (or, for a non-transverse
  touch, not at all); conversely every crossing change of a diagram is realised this way after
  an isotopy that makes a short edge pair pass through the other strand. So the minimal number
  of such moves is the unknotting number. `Unk m l` = l can be unknotted with m crossing
  changes, interleaved with isotopies; `unknottingNumber l = sInf {m | Unk m l}` (nonempty for
  every knot, so no junk). The unknot is a planar triangle.
* Connected sum (`IsSum P Q`): P lies in the half-space x₀ ≤ 0 meeting the plane x₀ = 0 exactly
  in its closing edge [a,b] (P = b, …, a), Q lies in x₀ ≥ 0 meeting the plane exactly in its
  closing edge [c,d] (Q = d, …, c), and a,b,c,d bound an embedded planar quadrilateral in
  x₀ = 0. That quadrilateral is a band disk meeting P ∪ Q only in [a,b] ∪ [c,d], and the
  concatenation `P ++ Q` (edges a→d and c→b replace [a,b], [c,d]) is the standard connected sum
  of the oriented knots P and Q (separated by a 2-sphere meeting it in two points). Since the
  trefoil is invertible, orientation conventions do not affect u(3₁ # K).
* Mirror images: `Claim` quantifies over all knots K (including mirrors), and fixes one
  trefoil; replacing both by mirrors preserves unknotting numbers, so this covers "some choice
  of mirror image". We state the symbiont inequality u(P # Q) < u(P) + u(Q) with P a trefoil
  (u(3₁) = 1, so this is u(3₁ # K) < 1 + u(K)).
* Proving `Claim` = the trefoil has a symbiont. Proving `¬Claim` = u(3₁ # K) = 1 + u(K) for
  every knot K.
-/
namespace OpenProblems.QEDM105
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

/-- The unknot: a planar triangle. -/
def unknot : List E3 := [!₂[(0 : ℝ), 0, 0], !₂[(1 : ℝ), 0, 0], !₂[(0 : ℝ), 1, 0]]

/-- `l'` is obtained from `l` by one crossing change (one strand passed through another once). -/
def CrossChange (l l' : List E3) : Prop :=
  ∃ (x x' : E3) (r : List E3), l = x :: r ∧ l' = x' :: r ∧ Simple l ∧ Simple l' ∧
    ∃ t₀ ∈ Set.Ioo (0 : ℝ) 1,
      (∀ t ∈ Set.Icc (0 : ℝ) 1, t ≠ t₀ → Simple (movePath x x' r t)) ∧
      (doublePts (movePath x x' r t₀)).ncard = 1

/-- `l` can be unknotted by `m` crossing changes (with isotopies in between). -/
def Unk : ℕ → List E3 → Prop
  | 0, l => Iso l unknot
  | m + 1, l => ∃ l₁ l₂ : List E3, Iso l l₁ ∧ CrossChange l₁ l₂ ∧ Unk m l₂

/-- Unknotting number. -/
def unknottingNumber (l : List E3) : ℕ := sInf {m : ℕ | Unk m l}

/-- `P ++ Q` is the connected sum of the polygonal knots `P` and `Q` (see the notes). -/
def IsSum (P Q : List E3) : Prop :=
  ∃ (a b c d : E3) (mP mQ : List E3),
    P = b :: (mP ++ [a]) ∧ Q = d :: (mQ ++ [c]) ∧
    Simple P ∧ Simple Q ∧ Simple (P ++ Q) ∧
    a 0 = 0 ∧ b 0 = 0 ∧ c 0 = 0 ∧ d 0 = 0 ∧
    (∀ v ∈ mP, v 0 < 0) ∧ (∀ v ∈ mQ, 0 < v 0) ∧ Simple [a, b, c, d]

/-- The trefoil has a symbiont: some knot `K` with `u(3₁ # K) < u(3₁) + u(K)`. -/
def Claim : Prop :=
  ∃ P Q : List E3, IsSum P Q ∧ Iso P trefoil ∧
    unknottingNumber (P ++ Q) < unknottingNumber P + unknottingNumber Q

end
end OpenProblems.QEDM105
