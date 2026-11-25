import Mathlib
/-! QED-E160: Random 2-complexes are not simply connected at density c/sqrt(n)
Take the complete graph on n vertices and add each of its triangles independently with probability p (the Linial-Meshulam random 2-complex). It is known to be simply connected once p is a bit above (9.48 n)^(-1/2), and to have a nontrivial (hyperbolic) fundamental group when p is at most n^(-1/2-eps). Is the threshold really of order n^(-1/2)? Show that for some small constant c > 0, at p = c/sqrt(n) there is with high probability a loop that cannot be contracted.
Informal statement: Let $Y\sim Y_2(n,p)$: complete 1-skeleton on $[n]$, each 2-face included independently with probability $p$. Then $\pi_1(Y)\cong\langle g_{ij}\ (1\le i<j\le n)\mid g_{1j}=1\ (2\le j\le n);\ g_{ij}g_{jk}=g_{ik}\ \text{for each 2-face }\{i<j<k\}\in Y\rangle$. Prove: there exists $c>0$ such that $\Pr[\pi_1(Y_2(n,c\,n^{-1/2}))\ne 1]\to1$ as $n\to\infty$. (Known: nontrivial a.a.s. for $p\le n^{-1/2-\varepsilon}$; trivial a.a.s. for $p\ge c\,n^{-1/2}$ with $c>(27/256)^{1/2}\approx0.325$.)
Formalization notes:
* Vertices are `Fin n` (vertex 0 plays the role of vertex 1 above). A 2-complex with complete
  1-skeleton is determined by its set `Y` of 2-faces, a finset of 3-element subsets of `Fin n`.
* `pi1 Y` is the edge-path presentation of the fundamental group with respect to the spanning
  tree "star at vertex 0": `PresentedGroup` on generators `Fin n × Fin n`, where the pairs
  `(i, j)` with `j ≤ i` are killed (they are not generators; only `i < j` index edges), the tree
  edges `(0, j)` are killed, and every face `{i < j < k} ∈ Y` contributes `g_ij g_jk g_ik⁻¹`.
  This is the standard presentation of π₁ of a connected simplicial 2-complex (any spanning tree
  gives an isomorphic group; the star is a spanning tree of the complete graph for n ≥ 1).
* `prob n p` is the exact probability under the product measure that π₁ is nontrivial:
  the sum over all subsets `Y` of the `C(n,3)` triangles of `p^|Y| (1-p)^(C(n,3)-|Y|)` times the
  indicator of `Nontrivial (pi1 Y)` (Mathlib's `Nontrivial`, i.e. ∃ two distinct elements).
  For small `n` the value `c/√n` may exceed 1 (junk weights), which is irrelevant to a limit.
* Claim: ∃ c > 0 with `prob n (c/√n) → 1`. Proving Claim = the Ω(n^{-1/2}) lower bound for the
  simple-connectivity threshold. ¬Claim = for every c > 0, P[π₁ ≠ 1] does not tend to 1 at
  p = c/√n (i.e. the threshold is o(n^{-1/2}) along a subsequence for some c), which would refute
  Luria–Peled's Conjecture 1.3. Neither direction follows from the known bounds (BHK need
  p ≤ n^{-1/2-ε}; Luria–Peled need c > 0.325).
-/
namespace OpenProblems.QEDE160
noncomputable section
open scoped Classical

/-- The 2-faces of the full simplex on `Fin n`: all 3-element subsets. -/
def faces (n : ℕ) : Finset (Finset (Fin n)) :=
  (Finset.univ : Finset (Finset (Fin n))).filter (fun s : Finset (Fin n) => s.card = 3)

/-- Relators of the edge-path presentation of π₁ with spanning tree the star at vertex 0. -/
def rels {n : ℕ} (Y : Finset (Finset (Fin n))) : Set (FreeGroup (Fin n × Fin n)) :=
  {r : FreeGroup (Fin n × Fin n) |
    (∃ i j : Fin n, j ≤ i ∧ r = FreeGroup.of (i, j)) ∨
    (∃ i j : Fin n, i.val = 0 ∧ i < j ∧ r = FreeGroup.of (i, j)) ∨
    (∃ i j k : Fin n, i < j ∧ j < k ∧ ({i, j, k} : Finset (Fin n)) ∈ Y ∧
      r = FreeGroup.of (i, j) * FreeGroup.of (j, k) * (FreeGroup.of (i, k))⁻¹)}

/-- The fundamental group of the 2-complex with complete 1-skeleton and 2-faces `Y`. -/
abbrev pi1 {n : ℕ} (Y : Finset (Finset (Fin n))) : Type := PresentedGroup (rels Y)

/-- Probability, in `Y₂(n,p)`, that the fundamental group is nontrivial. -/
def prob (n : ℕ) (p : ℝ) : ℝ :=
  ∑ Y ∈ (faces n).powerset,
    p ^ Y.card * (1 - p) ^ ((faces n).card - Y.card) *
      (if Nontrivial (pi1 Y) then (1 : ℝ) else 0)

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧
    Filter.Tendsto (fun n : ℕ => prob n (c / Real.sqrt (n : ℝ))) Filter.atTop (nhds (1 : ℝ))

end
end OpenProblems.QEDE160
