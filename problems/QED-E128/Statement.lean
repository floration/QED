import Mathlib
/-! QED-E128: Only 2^{O(n^2)} triangulated 3-spheres on n vertices?
Count the triangulations of the 3-dimensional sphere on n labelled vertices. Constructions give at least 2^{cn^2} of them, while the only upper bound, from counting all possible sets of tetrahedra, is 2^{Cn^2 log n}. Decide which is the truth: is the count at most 2^{Cn^2}, or does the log n factor really occur?
Informal statement: Let $s(n)$ be the number of simplicial complexes $K$ on vertex set $[n]$ (every vertex used) with $|K|\cong S^3$. Known: $2^{\Omega(n^2)}\le s(n)\le 2^{O(n^2\log n)}$. Decide whether $\log_2 s(n)=O(n^2)$ (i.e. $\exists C\ \forall n:\ s(n)\le 2^{Cn^2}$) or $\log_2 s(n)/n^2\to\infty$ along some subsequence.
Formalization notes:
* Complexes. A triangulated 3-sphere is a pure 3-dimensional simplicial complex, determined by
  its set of facets (tetrahedra = 4-element vertex sets); we represent it as
  `Finset (Finset ℕ)` (facets), or `Finset (Finset (Fin n))` for complexes on vertex set [n].
* Which complexes are 3-spheres. We avoid geometric realisations by the following classical
  facts. (1) Every triangulation of a 3-manifold is combinatorial (PL): vertex links are
  triangulated 2-spheres (Moise / standard). (2) Pachner (1991): two closed combinatorial
  manifolds are PL-homeomorphic iff they are related by a finite sequence of bistellar moves and
  a simplicial isomorphism. Hence the complexes K with |K| ≅ S³ are exactly the relabelings of
  complexes reachable from ∂Δ⁴ (the boundary of the 4-simplex on {0,…,4}) by bistellar moves.
* Bistellar move (`Move K K'`): disjoint nonempty A, B with |A| + |B| = 5 such that the facets
  of K containing A are exactly the sets A ∪ (B \ {b}), b ∈ B (i.e. star(A) = A * ∂B), and B is
  not a face of K (not contained in any facet); then replace those facets by B ∪ (A \ {a}),
  a ∈ A (star becomes ∂A * B). The cases |A| = 4, 3, 2, 1 are the 1–4, 2–3, 3–2, 4–1 moves; in the
  1–4 move B = {x} with x a fresh vertex (any unused natural number).
* Relabeling: `IsSphere3 F` iff F is the image of a reachable complex under an injective map
  ℕ → ℕ applied to vertices (this covers simplicial isomorphisms).
* `sphereCount n` (= s(n)) counts facet sets `F : Finset (Finset (Fin n))` that are 3-spheres (after the inclusion
  Fin n → ℕ) and use every vertex of [n]; this is a finite type, counted by `Nat.card`.
  (Counting labelled vs unlabelled, or allowing unused vertices, changes s(n) by at most a factor
  2^{O(n log n)}, irrelevant here.)
* Proving `Claim` = ∃ C, ∀ n, s(n) ≤ 2^{C n²}. Proving `¬Claim` = log₂ s(n)/n² is unbounded, i.e.
  → ∞ along a subsequence (the log n factor genuinely appears, at least partially). This is a
  decision problem: either proof settles it.
-/
namespace OpenProblems.QEDE128
noncomputable section
open Classical

/-- The boundary of the 4-simplex on `{0,1,2,3,4}`, as its 5 facets. -/
def bdry4Simplex : Finset (Finset ℕ) :=
  (Finset.range 5).image (fun i : ℕ => (Finset.range 5).erase i)

/-- `B` is a face of the complex with facet set `K`. -/
def IsFace (K : Finset (Finset ℕ)) (B : Finset ℕ) : Prop :=
  ∃ F ∈ K, B ⊆ F

/-- Facets of the join `A * ∂B`: the sets `A ∪ (B \ {b})`, `b ∈ B`. -/
def joinBdry (A B : Finset ℕ) : Finset (Finset ℕ) :=
  B.image (fun b : ℕ => A ∪ B.erase b)

/-- A bistellar (Pachner) move on 3-dimensional complexes given by facet sets. -/
def Move (K K' : Finset (Finset ℕ)) : Prop :=
  ∃ A B : Finset ℕ, A.Nonempty ∧ B.Nonempty ∧ Disjoint A B ∧ A.card + B.card = 5 ∧
    K.filter (fun F : Finset ℕ => A ⊆ F) = joinBdry A B ∧
    ¬ IsFace K B ∧
    K' = (K \ joinBdry A B) ∪ joinBdry B A

/-- `F` (facet set) triangulates the 3-sphere: it is a relabeling of a complex obtained from
`∂Δ⁴` by bistellar moves. -/
def IsSphere3 (F : Finset (Finset ℕ)) : Prop :=
  ∃ G : Finset (Finset ℕ), Relation.ReflTransGen Move bdry4Simplex G ∧
    ∃ f : ℕ → ℕ, Function.Injective f ∧ F = G.image (fun s : Finset ℕ => s.image f)

/-- View a facet set on `Fin n` as one on `ℕ`. -/
def toNat {n : ℕ} (F : Finset (Finset (Fin n))) : Finset (Finset ℕ) :=
  F.image (fun s : Finset (Fin n) => s.image (fun i : Fin n => (i : ℕ)))

/-- Number of triangulations of `S³` with vertex set exactly `[n] = Fin n`. -/
def sphereCount (n : ℕ) : ℕ :=
  Nat.card {F : Finset (Finset (Fin n)) //
    IsSphere3 (toNat F) ∧ ∀ i : Fin n, ∃ t ∈ F, i ∈ t}

def Claim : Prop :=
  ∃ C : ℝ, ∀ n : ℕ, (sphereCount n : ℝ) ≤ (2 : ℝ) ^ (C * (n : ℝ) ^ 2)

end
end OpenProblems.QEDE128
