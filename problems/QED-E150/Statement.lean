import Mathlib
/-! QED-E150: Beat n^2 empty triangles
Scatter n points in the plane with no three on a line. A triangle with corners among the points is empty if no other point is inside it. Every such configuration has at least about n^2 empty triangles, and the best constructions have about 1.62 n^2. Show that every configuration actually has at least (1+c) n^2 empty triangles for some fixed c > 0.
Informal statement: For a finite $S\subset\mathbb{R}^2$ with no three points collinear, let $e(S)$ be the number of 3-subsets $T\subseteq S$ with $\operatorname{conv}(T)\cap S=T$. Let $h_3(n)=\min_{|S|=n}e(S)$. Prove that there is $c>0$ with $h_3(n)\ge(1+c)\,n^2$ for all sufficiently large $n$.
Formalization notes:
* The plane is `EuclideanSpace ℝ (Fin 2)`; a point set is a `Finset` of it.
* General position: every 3-element subset is not `Collinear ℝ`.
* `emptyTri S` = 3-subsets T of S (via `powersetCard 3`) such that every point of S lying in the
  closed convex hull of T is a vertex of T, i.e. conv(T) ∩ S = T. In general position no other
  point can lie on an edge, so closed vs open hull does not matter.
* "h₃(n) ≥ (1+c)n² for large n" is stated as a bound for every general-position S with
  |S| ≥ N, which is equivalent because h₃(n) is the minimum of e(S) over |S| = n.
* Claim: ∃ c > 0, ∃ N, all such S with N ≤ |S| have (1+c)|S|² ≤ e(S). ¬Claim: liminf h₃(n)/n² ≤ 1
  (so, with the known lower bound, h₃(n) = (1+o(1))n² along a subsequence).
-/
namespace OpenProblems.QEDE150
noncomputable section
open scoped Classical

abbrev Plane := EuclideanSpace ℝ (Fin 2)

def GeneralPosition (S : Finset Plane) : Prop :=
  ∀ T : Finset Plane, T ⊆ S → T.card = 3 → ¬ Collinear ℝ (T : Set Plane)

/-- The empty triangles of `S`: 3-subsets whose convex hull meets `S` only in their vertices. -/
def emptyTri (S : Finset Plane) : Finset (Finset Plane) :=
  (S.powersetCard 3).filter (fun T : Finset Plane =>
    ∀ q ∈ S, q ∈ convexHull ℝ (T : Set Plane) → q ∈ T)

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ N : ℕ, ∀ S : Finset Plane, GeneralPosition S → N ≤ S.card →
    (1 + c) * ((S.card : ℕ) : ℝ) ^ 2 ≤ (((emptyTri S).card : ℕ) : ℝ)

end
end OpenProblems.QEDE150
