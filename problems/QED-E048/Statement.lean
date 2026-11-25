import Mathlib
/-! QED-E048: Equilateral stick number versus stick number
Build a knot out of straight sticks joined end to end. The stick number of a knot is the fewest sticks that can make it. If all the sticks must also be the same length, you might need more. Is there any knot that really does need more sticks when they all have to be the same length?
Informal statement: For a knot type $K$ let $s(K)$ be the minimum number of edges of a polygonal knot in $\mathbb R^3$ of type $K$, and $s_{eq}(K)$ the minimum over polygons with all edges of equal length. Trivially $s_{eq}(K)\ge s(K)$. Is there a knot type $K$ with $s_{eq}(K)>s(K)$? (Formal `Claim`: yes. The alternatives — $s_{eq}=s$ for all $K$, or for an infinite family — are not separately formalized; $\neg$Claim is "$s_{eq}=s$ for all $K$".)
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

* Stick number `stick l` = least number of vertices (= edges) of a polygon `Iso` to `l`;
  equilateral stick number `eqStick l` = the same over equilateral polygons (all edges of the
  same length as the first). Both sets are nonempty for every knot (equilateral representatives
  exist for every knot type), so `sInf` is a true minimum. Orientation and mirror conventions
  are irrelevant here (reversal and reflection preserve edge counts and edge lengths), and
  `Iso` preserves embeddedness.
* Proving `Claim` = some knot has s_eq(K) > s(K). Proving `¬Claim` = s_eq = s for every knot.
-/
namespace OpenProblems.QEDE048
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

/-- All edges of the closed polygon have the same length. -/
def Equilateral (l : List E3) : Prop :=
  ∀ k : ℕ, k < l.length → dist (vtx l k) (vtx l (k + 1)) = dist (vtx l 0) (vtx l 1)

/-- Stick number of the knot type of `l`. -/
def stick (l : List E3) : ℕ := sInf {n : ℕ | ∃ l' : List E3, Iso l l' ∧ l'.length = n}

/-- Equilateral stick number of the knot type of `l`. -/
def eqStick (l : List E3) : ℕ :=
  sInf {n : ℕ | ∃ l' : List E3, Iso l l' ∧ Equilateral l' ∧ l'.length = n}

def Claim : Prop := ∃ l : List E3, Simple l ∧ stick l < eqStick l

end
end OpenProblems.QEDE048
