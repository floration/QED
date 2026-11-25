import Mathlib
/-! QED-M005: Smallest dimension of a cubic-homogeneous Jacobian counterexample
The Bass–Connell–Wright / Yagzhev reduction says that a counterexample to the Jacobian conjecture yields one of the form
x + H with H cubic homogeneous and JH nilpotent, in more variables. Such counterexamples are now reported in 18 variables
and none exists in ≤ 4 variables. The smallest number of variables N₃ is unknown; the sharpest open question is
whether the Jacobian conjecture already fails for cubic homogeneous maps in dimension 5.
Informal statement: Let N₃ be the least n such that there is H = (H₁,…,Hₙ), each Hᵢ ∈ ℂ[x₁,…,xₙ] homogeneous of degree 3,
with JH nilpotent and x + H not an automorphism of ℂⁿ. Known: 5 ≤ N₃ ≤ 18 (upper bound from an unrefereed 2026 preprint).
Determine N₃; in particular decide whether the Jacobian conjecture holds for cubic homogeneous maps in dimension 5.
Formalization notes: Claim is HJC(5,3): every cubic homogeneous H in 5 variables over ℂ with nilpotent Jacobian matrix
gives a polynomial automorphism x + H (a two-sided polynomial inverse G, composition via `MvPolynomial.bind₁`).
Claim ⇔ N₃ ≥ 6; ¬Claim ⇔ N₃ = 5 (given the known bound N₃ ≥ 5). The zero polynomial counts as homogeneous of degree 3,
which is harmless. The companion question (degree d₃ of a non-invertible Keller map ℂ³ → ℂ³) is not formalized here.
For homogeneous H, nilpotency of JH is equivalent to det(I + JH) = 1; we use nilpotency.
-/
namespace OpenProblems.QEDM005

/-- The Jacobian matrix `(∂Hᵢ/∂xⱼ)` of a polynomial map in 5 variables. -/
noncomputable def jac (H : Fin 5 → MvPolynomial (Fin 5) ℂ) :
    Matrix (Fin 5) (Fin 5) (MvPolynomial (Fin 5) ℂ) :=
  fun i j => MvPolynomial.pderiv j (H i)

/-- `F` is a polynomial automorphism of `ℂ⁵`: it has a two-sided polynomial inverse `G`. -/
def IsPolyAutomorphism (F : Fin 5 → MvPolynomial (Fin 5) ℂ) : Prop :=
  ∃ G : Fin 5 → MvPolynomial (Fin 5) ℂ,
    (∀ i : Fin 5, MvPolynomial.bind₁ G (F i) = MvPolynomial.X i) ∧
    (∀ i : Fin 5, MvPolynomial.bind₁ F (G i) = MvPolynomial.X i)

def Claim : Prop :=
  ∀ H : Fin 5 → MvPolynomial (Fin 5) ℂ,
    (∀ i : Fin 5, (H i).IsHomogeneous 3) → IsNilpotent (jac H) →
      IsPolyAutomorphism (fun i => MvPolynomial.X i + H i)

end OpenProblems.QEDM005
