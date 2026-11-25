import Mathlib
/-! N-628: Gromov width of the 4D l^4 ball
The 4D superball U = {x1^4+y1^4+x2^4+y2^4 <= 1} contains the round unit ball, so its Gromov
width is at least π; its cylindrical (= EHZ) capacity is c0 = 4Γ(5/4)^2/Γ(3/2) ≈ 3.7081, an upper
bound. Is the Gromov width equal to c0, as strong Viterbo for centrally symmetric bodies would
predict?
Informal statement: Let U = {x1^4+y1^4+x2^4+y2^4 <= 1} ⊂ (R^4, ω0) and c_G(U) = sup{πr^2 : B^4(r) embeds symplectically in U}. Known: π <= c_G(U) <= c0 := 4Γ(5/4)^2/Γ(3/2) ≈ 3.7081 (= c_Z(U) = c_EHZ(U)). Prove or disprove: c_G(U) = c0 (i.e. U satisfies the strong Viterbo equality between Gromov width and cylindrical capacity).
Formalization notes: R^4 is `Fin 4 → ℝ` with coordinates (x1,y1,x2,y2) = (x 0, x 1, x 2, x 3)
and ω0(u,v) = u0 v1 - u1 v0 + u2 v3 - u3 v2. The open Euclidean ball of radius r is
{x | Σ x_i^2 < r^2}. A symplectic embedding of B^4(r) into U is a C^∞ map φ on the open ball,
injective there, mapping it into U, whose derivative preserves ω0 at every point. Since c0 is a
known upper bound for c_G(U), "c_G(U) = c0" is encoded as: for every a < c0 there is r with
πr^2 > a and a symplectic embedding of B^4(r) into U. Proving Claim shows c_G(U) = c0; proving
¬Claim shows c_G(U) < c0, a centrally symmetric counterexample to the strong Viterbo
conjecture. A mere improvement of the lower bound beyond π (the other half of the original
'improve either bound') is NOT what Claim asks. The value c0 is taken from arXiv:2609.37794.
-/
namespace OpenProblems.N628

/-- Four-dimensional real space, coordinates (x1, y1, x2, y2). -/
abbrev R4 : Type := Fin 4 → ℝ

/-- The standard symplectic form dx1∧dy1 + dx2∧dy2. -/
noncomputable def omega0 (u v : R4) : ℝ := u 0 * v 1 - u 1 * v 0 + u 2 * v 3 - u 3 * v 2

/-- The open Euclidean ball of radius r centred at 0. -/
def euclidBall (r : ℝ) : Set R4 := {x | (∑ i : Fin 4, x i ^ 2) < r ^ 2}

/-- The l^4 unit ball in R^4. -/
def U : Set R4 := {x | (∑ i : Fin 4, x i ^ 4) ≤ 1}

/-- φ is a smooth symplectic embedding of the open ball of radius r into U. -/
def IsSymplecticEmbedding (r : ℝ) (φ : R4 → R4) : Prop :=
  ContDiffOn ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) φ (euclidBall r) ∧
  Set.InjOn φ (euclidBall r) ∧
  Set.MapsTo φ (euclidBall r) U ∧
  ∀ x ∈ euclidBall r, ∀ u v : R4, omega0 (fderiv ℝ φ x u) (fderiv ℝ φ x v) = omega0 u v

/-- The cylindrical / EHZ capacity of U: 4 Γ(5/4)^2 / Γ(3/2). -/
noncomputable def c0 : ℝ := 4 * Real.Gamma (5 / 4) ^ 2 / Real.Gamma (3 / 2)

def Claim : Prop :=
  ∀ a : ℝ, a < c0 → ∃ r : ℝ, 0 < r ∧ a < Real.pi * r ^ 2 ∧
    ∃ φ : R4 → R4, IsSymplecticEmbedding r φ

end OpenProblems.N628
