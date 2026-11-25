import Mathlib
/-! QED-E002: Keller maps injective on integer points
Informal statement (prove or disprove): let $F\in\mathbb{Z}[x,y,z]^3$ with $\det JF\equiv 1$. If $F|_{\mathbb{Z}^3}$
is injective, then $F$ has a polynomial inverse (equivalently, by Białynicki-Birula–Rosenlicht, $F$ is injective
on $\mathbb{C}^3$).
Caution (referee): if some 3D Keller counterexample with F(0)=0 has only finitely many colliding integer pairs,
then F(Nx)/N for suitable N is an integer Keller map injective on ℤ³ that is not an automorphism, so the claim
may well be false; it is posed as a decision.
Formalization notes:
* `F : Fin 3 → MvPolynomial (Fin 3) ℤ`; the Jacobian determinant is computed in `ℤ[x,y,z]` with
  `MvPolynomial.pderiv` and must equal the constant polynomial `1` (identically, not just on ℤ³).
* Injectivity on ℤ³: the evaluation map `ℤ³ → ℤ³` is `Function.Injective`.
* Conclusion: a two-sided polynomial inverse over ℂ (composition via `MvPolynomial.bind₁` after mapping the
  coefficients to ℂ). This is equivalent to a polynomial inverse over ℚ or even over ℤ (the inverse of a map
  over a field k invertible over an extension is defined over k; with det JF = 1 the formal inverse has
  integer coefficients), so the choice of ℂ is harmless.
* Claim is the "prove" direction; ¬Claim is an integer Keller map injective on ℤ³ that is not an automorphism.
-/

namespace OpenProblems.QEDE002

/-- Jacobian matrix `(∂Fᵢ/∂xⱼ)` of a polynomial map in 3 variables over `ℤ`. -/
noncomputable def jac (F : Fin 3 → MvPolynomial (Fin 3) ℤ) :
    Matrix (Fin 3) (Fin 3) (MvPolynomial (Fin 3) ℤ) :=
  fun i j => MvPolynomial.pderiv j (F i)

/-- The map `ℤ³ → ℤ³` given by evaluating `F` at integer points. -/
noncomputable def evalZ (F : Fin 3 → MvPolynomial (Fin 3) ℤ) : (Fin 3 → ℤ) → (Fin 3 → ℤ) :=
  fun x i => MvPolynomial.eval x (F i)

/-- `F`, viewed over `ℂ`, has a two-sided polynomial inverse. -/
def IsPolyAutomorphismC (F : Fin 3 → MvPolynomial (Fin 3) ℤ) : Prop :=
  ∃ G : Fin 3 → MvPolynomial (Fin 3) ℂ,
    (∀ i : Fin 3, MvPolynomial.bind₁ G (MvPolynomial.map (Int.castRingHom ℂ) (F i)) =
      MvPolynomial.X i) ∧
    (∀ i : Fin 3, MvPolynomial.bind₁ (fun j => MvPolynomial.map (Int.castRingHom ℂ) (F j)) (G i) =
      MvPolynomial.X i)

def Claim : Prop :=
  ∀ F : Fin 3 → MvPolynomial (Fin 3) ℤ,
    (jac F).det = 1 → Function.Injective (evalZ F) → IsPolyAutomorphismC F

end OpenProblems.QEDE002
