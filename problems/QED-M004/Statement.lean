import Mathlib
/-! QED-M004: Smallest degree of a Keller counterexample in dimension 3
In 2026 the Jacobian conjecture was refuted in three variables; the first explicit counterexample
(Alpöge's map) has degree 7, and Wang's theorem excludes degree 2. What is the smallest degree
d₃ of a counterexample in three variables? In particular, is there one of degree at most 5?
Informal statement: Let d₃ be the least d such that some polynomial map F : ℂ³ → ℂ³ with
maxᵢ deg Fᵢ = d and det DF ∈ ℂ^× is not an automorphism. Wang gives d₃ ≥ 3, Alpöge's map gives
d₃ ≤ 7. Determine d₃; in particular decide whether d₃ ≤ 5. The Claim is: d₃ ≤ 5.
Formalization notes: F is a triple of polynomials `Fin 3 → MvPolynomial (Fin 3) ℂ` with
total degree ≤ 5; the Jacobian determinant is `det (∂Fᵢ/∂xⱼ)` computed with
`MvPolynomial.pderiv`, required to equal a nonzero constant `C c`. "Automorphism" means a
polynomial inverse G: `bind₁ F (Gᵢ) = Xᵢ` and `bind₁ G (Fᵢ) = Xᵢ` for all i (G ∘ F = F ∘ G = id
as polynomial maps; `bind₁ F p` substitutes Fⱼ for Xⱼ in p). Since degree 2 is impossible
(Wang), "d₃ ≤ 5" is the same as "some Keller map of degree 3, 4 or 5 is not an automorphism".
Proving `Claim` = exhibiting such a map (with a proof that it has no polynomial inverse);
`¬Claim` = the Jacobian conjecture for all maps ℂ³ → ℂ³ of degree ≤ 5. Other values of d₃ (6,7)
are the complementary outcomes.
-/
namespace OpenProblems.QEDM004

open MvPolynomial

/-- `F` has constant nonzero Jacobian determinant (a Keller map). -/
def IsKeller (F : Fin 3 → MvPolynomial (Fin 3) ℂ) : Prop :=
  ∃ c : ℂ, c ≠ 0 ∧
    (Matrix.of (fun i j : Fin 3 => pderiv j (F i))).det = C c

/-- `F` is a polynomial automorphism of `ℂ³`: it has a two-sided polynomial inverse. -/
def IsPolyAutomorphism (F : Fin 3 → MvPolynomial (Fin 3) ℂ) : Prop :=
  ∃ G : Fin 3 → MvPolynomial (Fin 3) ℂ,
    (∀ i, bind₁ F (G i) = X i) ∧ (∀ i, bind₁ G (F i) = X i)

def Claim : Prop :=
  ∃ F : Fin 3 → MvPolynomial (Fin 3) ℂ,
    (∀ i, (F i).totalDegree ≤ 5) ∧ IsKeller F ∧ ¬ IsPolyAutomorphism F

end OpenProblems.QEDM004
