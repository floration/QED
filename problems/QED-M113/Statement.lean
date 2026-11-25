import Mathlib
/-! QED-M113: Big line or six visible points
Two points of a finite set in the plane see each other if the segment between them passes through no other point of the set. Prove that for every l there is an N such that any N points in the plane contain either l points on a line or 6 points that all see each other. This is known for 5 points that all see each other (for every l), and since 2026 for 6 such points when l = 4.
Informal statement: For finite $P\subset\mathbb R^2$, call $p,q\in P$ visible if $[p,q]\cap P=\{p,q\}$. Claim: for every $\ell\ge 3$ there is $N(\ell)$ such that every $P\subset\mathbb R^2$ with $|P|\ge N(\ell)$ contains $\ell$ collinear points or $6$ pairwise visible points.
Formalization notes:
* The plane is `ℝ × ℝ` (an affine space over itself); collinearity (`Collinear ℝ`) and closed
  segments (`segment ℝ p q`) are affine notions, so no Euclidean structure is needed.
* `Visible P p q` : every point of `P` on the closed segment `[p, q]` is an endpoint. For `p = q`
  this holds trivially; it only matters for distinct points of the 6-set `C`, which has 6 distinct
  elements because `C.card = 6`.
* "Contains `ℓ` collinear points": a subset `L ⊆ P` with `|L| = ℓ` that is collinear (equivalent to
  "at least `ℓ`", by taking subsets). "6 pairwise visible points": `C ⊆ P`, `|C| = 6`, all pairs
  visible with respect to the whole set `P` (not just `C`), as in the big-line-big-clique conjecture.
* `Claim` = the clique-6 row of the big-line-big-clique conjecture for every line size `ℓ ≥ 3`.
  `¬Claim` = some `ℓ` and arbitrarily large point sets with no `ℓ` collinear and no 6 mutually
  visible points. The hypothesis `3 ≤ ℓ` only excludes trivial cases (for `ℓ ≤ 2` any 2 points are
  collinear).
-/
namespace OpenProblems.QEDM113
noncomputable section

/-- `p` and `q` see each other in `P`: no point of `P` other than `p`, `q` lies on `[p, q]`. -/
def Visible (P : Finset (ℝ × ℝ)) (p q : ℝ × ℝ) : Prop :=
  ∀ r ∈ P, r ∈ segment ℝ p q → r = p ∨ r = q

/-- Every sufficiently large finite planar set has `ℓ` collinear points or 6 pairwise visible points. -/
def Claim : Prop :=
  ∀ ℓ : ℕ, 3 ≤ ℓ → ∃ N : ℕ, ∀ P : Finset (ℝ × ℝ), N ≤ P.card →
    (∃ L : Finset (ℝ × ℝ), L ⊆ P ∧ L.card = ℓ ∧ Collinear ℝ (L : Set (ℝ × ℝ))) ∨
    (∃ C : Finset (ℝ × ℝ), C ⊆ P ∧ C.card = 6 ∧ ∀ p ∈ C, ∀ q ∈ C, Visible P p q)

end
end OpenProblems.QEDM113
