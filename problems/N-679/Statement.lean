import Mathlib
/-! N-679: Alternating quotients of knot groups
The trefoil group surjects onto every alternating group A_n with n >= 9 (and onto A_5),
because it maps onto the modular group. Does every nontrivial knot group surject onto A_n for
all sufficiently large n?
Informal statement: Let K ⊂ S^3 be a nontrivial knot and G_K = π_1(S^3 \ K). (a) Prove that
G_K surjects onto A_n for all n >= N(K) (and bound N(K) in terms of the crossing number).
(b, weaker) Prove that G_K surjects onto A_n for infinitely many n.
Formalization notes: Only the main question (a), existence of N(K), is formalized; the request
to bound N(K) by the crossing number, the weaker variants (b), and the specific question
N(4_1) = 9 are not. Knots are tame: a knot is a subset K of R^3 = `Fin 3 → ℝ` that is a finite
union of straight segments and is homeomorphic to the unit circle (a polygonal knot). Every
tame knot is ambient isotopic to a polygonal one, and the knot group is the same whether the
complement is taken in R^3 or in S^3 (removing a point from a 3-manifold does not change π_1).
"Nontrivial" is encoded as: the knot group is not isomorphic to ℤ. By Dehn's lemma
(Papakyriakopoulos) this is equivalent to K not being the unknot. The basepoint x₀ is arbitrary
(the complement is path-connected, so the group does not depend on it up to isomorphism).
Proving Claim answers (a) affirmatively; proving ¬Claim means exhibiting a nontrivial polygonal
knot whose group fails to surject onto A_n for infinitely many n.
-/
namespace OpenProblems.N679

/-- Three-dimensional real space as a function type (product topology = Euclidean). -/
abbrev R3 : Type := Fin 3 → ℝ

/-- The unit circle in the plane. -/
def unitCircle : Set (Fin 2 → ℝ) := {p | p 0 ^ 2 + p 1 ^ 2 = 1}

/-- A polygonal (hence tame) knot: a finite union of segments homeomorphic to a circle. -/
def IsPolygonalKnot (K : Set R3) : Prop :=
  (∃ S : Finset (R3 × R3), K = ⋃ s ∈ S, segment ℝ s.1 s.2) ∧
  Nonempty (↥K ≃ₜ ↥unitCircle)

def Claim : Prop :=
  ∀ K : Set R3, IsPolygonalKnot K → ∀ x₀ : ↥(Kᶜ),
    IsEmpty (FundamentalGroup ↥(Kᶜ) x₀ ≃* Multiplicative ℤ) →
      ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
        ∃ f : FundamentalGroup ↥(Kᶜ) x₀ →* ↥(alternatingGroup (Fin n)),
          Function.Surjective f

end OpenProblems.N679
