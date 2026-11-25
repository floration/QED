import Mathlib
/-! N-553: Minimal degree of a Jacobian counterexample
After the 2026 counterexamples to the Jacobian conjecture in three variables (best degree 7),
and Wang's theorem that degree 2 Keller maps are injective, what is the smallest degree d_3 of a
non-injective Keller map of C^3? The decisive open case is degree 3.
Informal statement: Call F ∈ C[x,y,z]^3 a Keller map if det JF ∈ C^×, and let deg F = max_i deg F_i. Prove or disprove: every Keller map F : C^3 → C^3 with deg F <= 3 is injective (equivalently, by Białynicki-Birula-Rosenlicht and the Keller condition, a polynomial automorphism); i.e. d_3 >= 4. (Known: 3 <= d_3 <= 7, where d_3 is the least degree of a non-injective Keller map of C^3.)
Formalization notes: Polynomial maps are triples `F : Fin 3 → MvPolynomial (Fin 3) ℂ`; degree
is the maximum total degree of the components. The Jacobian determinant is the determinant of
the matrix of partial derivatives `MvPolynomial.pderiv j (F i)`, and Keller means it equals a
nonzero constant. The map C^3 → C^3 is x ↦ (eval x (F i))_i. The original M ('improve either
bound or determine d_3') is, as a proposition, trivially true (d_3 >= 4 or d_3 <= 6 always holds),
so Claim is the sharp question d_3 >= 4, i.e. the Jacobian conjecture for cubic maps of C^3.
Proving Claim gives d_3 >= 4; proving ¬Claim exhibits a non-injective cubic Keller map, giving
d_3 = 3. A non-injective Keller map of degree 4, 5 or 6 (improving the upper bound without
deciding the cubic case) is not captured by this Claim.
-/
namespace OpenProblems.N553

/-- The Jacobian determinant of a polynomial map C^3 → C^3. -/
noncomputable def jacobianDet (F : Fin 3 → MvPolynomial (Fin 3) ℂ) : MvPolynomial (Fin 3) ℂ :=
  Matrix.det (Matrix.of fun i j : Fin 3 => MvPolynomial.pderiv j (F i))

/-- Keller condition: the Jacobian determinant is a nonzero constant. -/
def IsKeller (F : Fin 3 → MvPolynomial (Fin 3) ℂ) : Prop :=
  ∃ c : ℂ, c ≠ 0 ∧ jacobianDet F = MvPolynomial.C c

/-- The polynomial map C^3 → C^3 defined by `F`. -/
noncomputable def polyMap (F : Fin 3 → MvPolynomial (Fin 3) ℂ) (x : Fin 3 → ℂ) : Fin 3 → ℂ :=
  fun i => MvPolynomial.eval x (F i)

def Claim : Prop :=
  ∀ F : Fin 3 → MvPolynomial (Fin 3) ℂ, (∀ i : Fin 3, (F i).totalDegree ≤ 3) → IsKeller F →
    Function.Injective (polyMap F)

end OpenProblems.N553
