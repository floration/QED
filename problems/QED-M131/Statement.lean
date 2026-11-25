import Mathlib
/-! QED-M131: Is the 4-sphere algorithmically recognizable?
A triangulated 4-dimensional shape can be given as a finite list of 5-element vertex sets. Is there
an algorithm that decides whether such a list describes the piecewise-linear 4-sphere? The question
is solved (yes) in dimension 3 and known to be undecidable in every dimension 5 and above;
dimension 4 is the single open case.
Informal statement: A bistellar move on a finite pure 4-dimensional simplicial complex K (vertices
in ℕ, given by facets) replaces A * ∂B by ∂A * B, where A ∩ B = ∅, |A ∪ B| = 6, |A|, |B| ≥ 1,
A ∈ K, lk_K(A) = ∂B and B ∉ K (for |B| = 1: a fresh vertex). Let 𝒮 be the set of finite complexes
isomorphic to one obtained from ∂Δ⁵ by finitely many bistellar moves; by Pachner's theorem these
are exactly the combinatorial triangulations of the PL 4-sphere. Decide whether 𝒮 is a decidable
set. Board claim (either direction accepted): give an algorithm deciding membership in 𝒮, or prove
that none exists.
Formalization notes:
* A complex is its set of facets `K : Finset (Finset ℕ)`; its faces are all subsets of facets
  (`IsFace`, including ∅). Complexes reachable from ∂Δ⁵ always have all facets of size 5.
* Link: `τ ∈ lk_K(A)` iff `τ ∩ A = ∅` and `τ ∪ A` is a face. `lk_K(A) = ∂B` is stated as: for
  every finset τ, (τ ∩ A = ∅ ∧ τ ∪ A face) ↔ τ ⊊ B. (For |B| = 1 this says A is a facet.)
* Move (`BistellarStep K K'`): A, B disjoint, |A|,|B| ≥ 1, |A ∪ B| = 6, A a face, link
  condition, B not a face of K. Given the link condition the facets of K containing A are exactly
  A ∪ (B∖{b}); they are removed and replaced by (A∖{a}) ∪ B for a ∈ A. The condition "B not a face"
  is the standard requirement; for |B| = 1 it says exactly that the new vertex is fresh, and it
  guarantees the new facets are not already present. This is Pachner's set of bistellar moves.
* ∂Δ⁵ = all 5-subsets of {0,…,5}. Isomorphism = relabelling vertices by a permutation of ℕ.
  `InS K` := K is isomorphic to a complex reachable from ∂Δ⁵ by finitely many moves
  (`Relation.ReflTransGen`).
* Inputs to an algorithm are codes `List (List ℕ)` (a list of vertex lists; `decodeComplex`
  turns each into a finset and the list into a finset of facets), which carry Mathlib's
  `Primcodable` structure; every finite complex has a code, and the decoded set is computable from
  the code, so decidability of `InS` on codes is the same as decidability of 𝒮.
* Claim := `ComputablePred (fun c => InS (decodeComplex c))` (Mathlib's notion of a decidable
  predicate on a `Primcodable` type, i.e. a partial-recursive total decision procedure).
  Proving `Claim` = 4-sphere recognition is decidable; `¬Claim` = it is undecidable. Both are
  accepted.
-/
namespace OpenProblems.QEDM131
noncomputable section

/-- `σ` is a face of the complex with facet set `K`. -/
def IsFace (K : Finset (Finset ℕ)) (σ : Finset ℕ) : Prop :=
  ∃ F ∈ K, σ ⊆ F

/-- The bistellar move with parameters `A`, `B` turns `K` into `K'`. -/
def BistellarMove (K : Finset (Finset ℕ)) (A B : Finset ℕ) (K' : Finset (Finset ℕ)) : Prop :=
  Disjoint A B ∧ A.Nonempty ∧ B.Nonempty ∧ (A ∪ B).card = 6 ∧ IsFace K A ∧
    (∀ τ : Finset ℕ, (Disjoint τ A ∧ IsFace K (τ ∪ A)) ↔ τ ⊂ B) ∧
    ¬ IsFace K B ∧
    K' = K.filter (fun F => ¬ A ⊆ F) ∪ A.image (fun a => (A.erase a) ∪ B)

/-- One bistellar move. -/
def BistellarStep (K K' : Finset (Finset ℕ)) : Prop :=
  ∃ A B : Finset ℕ, BistellarMove K A B K'

/-- The boundary of the 5-simplex on vertices `{0,…,5}`. -/
def boundarySimplex5 : Finset (Finset ℕ) :=
  (Finset.range 6).powersetCard 5

/-- Two facet sets are isomorphic: related by a relabelling of the vertices. -/
def ComplexIso (L K : Finset (Finset ℕ)) : Prop :=
  ∃ e : Equiv.Perm ℕ, K = L.image (fun F => F.map e.toEmbedding)

/-- `K` is a combinatorial triangulation of the PL 4-sphere (Pachner): isomorphic to a complex
reachable from `∂Δ⁵` by bistellar moves. -/
def InS (K : Finset (Finset ℕ)) : Prop :=
  ∃ L : Finset (Finset ℕ), Relation.ReflTransGen BistellarStep boundarySimplex5 L ∧ ComplexIso L K

/-- Decoding an input: a list of vertex lists, read as a set of facets. -/
def decodeComplex (c : List (List ℕ)) : Finset (Finset ℕ) :=
  (c.map List.toFinset).toFinset

def Claim : Prop :=
  ComputablePred (fun c : List (List ℕ) => InS (decodeComplex c))

end
end OpenProblems.QEDM131
