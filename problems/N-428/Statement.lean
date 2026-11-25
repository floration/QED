import Mathlib
/-! N-428: Superlinear unit distances on the unit sphere
On the sphere of radius 1/√2 in ℝ³ there are n-point sets with ≫ n^{4/3} unit distances, but on
the unit sphere S² the best known construction gives only ≫ n √(log n) (Swanepoel-Valtr). Is
there a power gain n^{1+c} on the unit sphere?
Informal statement: Prove or disprove: there is c > 0 such that for infinitely many n there exist
P ⊂ S² = {x ∈ ℝ³ : |x| = 1} with |P| = n and #{{p,q} ⊂ P : |p − q| = 1} ≥ n^{1+c}.
Formalization notes: Points are in `EuclideanSpace ℝ (Fin 3)` with the Euclidean norm, so
`dist p q = ‖p - q‖`. `unitPairs P` (an ncard of a finite subset of P × P) counts ORDERED pairs (p, q) ∈ P × P with dist p q = 1; since
dist p p = 0 ≠ 1, this is exactly twice the number of unordered unit-distance pairs, hence the
factor 2 in the claim. "Infinitely many n" is encoded as ∀ N, ∃ n > N. Proving `Claim` gives a
power gain; proving `¬Claim` shows that for every c > 0, all sufficiently large n-point sets on
S² have fewer than n^{1+c} unit distances (i.e. u_{S²}(n) = n^{1+o(1)}). Known: Ω(n √log n)
lower bound (Swanepoel-Valtr), O(n^{4/3}) upper bound.
-/
namespace OpenProblems.N428

/-- Number of ordered pairs of points of `P` at Euclidean distance exactly `1`. -/
noncomputable def unitPairs (P : Finset (EuclideanSpace ℝ (Fin 3))) : ℕ :=
  Set.ncard {pq : EuclideanSpace ℝ (Fin 3) × EuclideanSpace ℝ (Fin 3) |
    pq.1 ∈ P ∧ pq.2 ∈ P ∧ dist pq.1 pq.2 = 1}

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∀ N : ℕ, ∃ n : ℕ, N < n ∧
    ∃ P : Finset (EuclideanSpace ℝ (Fin 3)), P.card = n ∧ (∀ p ∈ P, ‖p‖ = 1) ∧
      2 * (n : ℝ) ^ (1 + c) ≤ (unitPairs P : ℝ)

end OpenProblems.N428
