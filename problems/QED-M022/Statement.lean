import Mathlib
/-! QED-M022: Is the Petersen graph common?
Colour the edges of a huge complete graph red and blue. Does a uniformly random colouring
asymptotically minimise the number of monochromatic copies of the Petersen graph?
Informal statement: Let P be the Petersen graph (10 vertices, 15 edges). Is P common, i.e. is
t(P,W) + t(P,1−W) ≥ 2^{−14} for every graphon W? (Equivalently m(P) = 2^{−14}, where m(P) is
the limiting minimum fraction of monochromatic copies of P over red/blue colourings of K_n.)
Formalization notes: Petersen graph on `Fin 10`: outer cycle 0-1-2-3-4-0, spokes i–(i+5),
inner pentagram 5-7-9-6-8-5, given as a list of 15 edges. For a symmetric n × n array A with
entries in [0,1] (a step graphon with n equal parts, diagonal allowed), the homomorphism count
hom(P,A) = ∑_{φ : Fin 10 → Fin n} ∏_{ij ∈ E(P)} A(φ i, φ j) equals n^{10} · t(P, W_A). Since
step graphons are dense in the cut metric and t(P,·) is cut-continuous, "∀ graphons W" is
equivalent to "∀ n, ∀ such A". The complement is the entrywise array 1 − A(i,j) (written as a
function, not Matrix subtraction, to avoid the identity matrix). Proving `Claim` = P is common;
`¬Claim` = an explicit (step) graphon beating the random colouring, i.e. P is uncommon.
-/
namespace OpenProblems.QEDM022

/-- The 15 edges of the Petersen graph on `Fin 10`. -/
def petersenEdges : List (Fin 10 × Fin 10) :=
  [(0, 1), (1, 2), (2, 3), (3, 4), (4, 0),
   (0, 5), (1, 6), (2, 7), (3, 8), (4, 9),
   (5, 7), (7, 9), (9, 6), (6, 8), (8, 5)]

/-- Homomorphism count of the Petersen graph into the weighted graph `A`. -/
def homP {n : ℕ} (A : Fin n → Fin n → ℝ) : ℝ :=
  ∑ φ : Fin 10 → Fin n, (petersenEdges.map (fun e => A (φ e.1) (φ e.2))).prod

def Claim : Prop :=
  ∀ (n : ℕ) (A : Fin n → Fin n → ℝ),
    (∀ i j, A i j = A j i) → (∀ i j, 0 ≤ A i j ∧ A i j ≤ 1) →
    (1 / 2 : ℝ) ^ 14 * (n : ℝ) ^ 10 ≤ homP A + homP (fun i j => 1 - A i j)

end OpenProblems.QEDM022
