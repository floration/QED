import Mathlib
/-! QED-M012: Non-arithmetic tones of the cube
STATUS: NOT YET FORMALIZED
Many Laplace eigenvalues of the surface of a cube come from flat tori and are rational multiples
of π². Prove that at least one eigenvalue is not of this form.
Informal statement: Let S be the boundary of the unit cube [0,1]³ with its intrinsic flat metric
(8 cone points of angle 3π/2), and let Δ be the Friedrichs extension of the Laplacian on S.
Prove that some eigenvalue of Δ is not in π²ℚ.
Formalization notes: Not formalized. A faithful statement needs: the cube surface as a flat
cone surface (six unit squares glued along edges, or the intrinsic path metric on ∂[0,1]³);
the Sobolev space H¹(S) on this singular surface (piecewise H¹ functions on the faces with
matching traces along glued edges); the Dirichlet form ∫_S |∇u|² and its Friedrichs extension
(or, equivalently, the eigenvalues defined by min-max of the Rayleigh quotient over H¹(S));
and discreteness of the resulting spectrum. Mathlib lacks Sobolev spaces on manifolds or
polyhedral surfaces, trace theorems, and Friedrichs extensions. An equivalent min-max
formulation over piecewise-smooth functions would still need the H¹ closure to be faithful
(the singular eigenfunctions are not smooth at the vertices). Proving `Claim` means exhibiting
an eigenvalue λ with λ/π² irrational; `¬Claim` means the whole spectrum lies in π²ℚ.
-/
namespace OpenProblems.QEDM012
def Claim : Prop := sorry
end OpenProblems.QEDM012
