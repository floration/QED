import Mathlib
/-! QED-E212: Every sextic Salem number has an eventually periodic expansion of 1
For beta > 1, the map T(x) = beta x - floor(beta x) gives greedy base-beta digits; beta is a Parry number if the T-orbit of 1 is finite. A Salem number is an algebraic integer beta > 1 whose other conjugates lie in the closed unit disc, at least one on the unit circle. Boyd proved every degree-4 Salem number is Parry. Prove the same for degree 6.
Informal statement: Let $\beta>1$ be a Salem number of degree $6$ (an algebraic integer with minimal polynomial of degree 6 whose other roots satisfy $|z|\le1$, at least one with $|z|=1$), and $T_\beta(x)=\beta x-\lfloor\beta x\rfloor$ on $[0,1)$. Prove that $\{T_\beta^{\,n}(\beta-\lfloor\beta\rfloor):n\ge0\}$ is finite. (First test case: the root $>1$ of $x^6-3x^5-x^4-7x^3-x^2-3x+1$, whose orbit length exceeds $7.7\times10^{10}$ if finite.)
Formalization notes: β is a real number. `IsSalem6 β`: β > 1, β is integral over ℤ (algebraic integer), its
minimal polynomial over ℚ has degree 6, every complex root of that polynomial other than β itself has
modulus ≤ 1, and some complex root has modulus exactly 1. (The minimal polynomial is separable, so β occurs
once among the roots; the degree-6 condition rules out the junk value minpoly = 0.) The β-transformation is
T_β(x) = β x − ⌊β x⌋ = `Int.fract (β * x)`, and T_β(1) = β − ⌊β⌋ = `Int.fract β`, so the orbit of 1 is the
set {T_β^n(Int.fract β) : n ≥ 0}. Claim: for every sextic Salem β this set is finite (β is a Parry number).
¬Claim exhibits a sextic Salem number whose expansion of 1 is not eventually periodic.
-/
namespace OpenProblems.QEDE212
noncomputable section

/-- `β` is a Salem number of degree 6. -/
def IsSalem6 (β : ℝ) : Prop :=
  1 < β ∧ IsIntegral ℤ β ∧ (minpoly ℚ β).natDegree = 6 ∧
    (∀ z ∈ ((minpoly ℚ β).map (algebraMap ℚ ℂ)).roots, z ≠ (β : ℂ) → ‖z‖ ≤ 1) ∧
    (∃ z ∈ ((minpoly ℚ β).map (algebraMap ℚ ℂ)).roots, ‖z‖ = 1)

/-- The β-transformation `x ↦ β x - ⌊β x⌋`. -/
def betaT (β : ℝ) (x : ℝ) : ℝ := Int.fract (β * x)

def Claim : Prop :=
  ∀ β : ℝ, IsSalem6 β →
    (Set.range (fun n : ℕ => (betaT β)^[n] (Int.fract β))).Finite

end
end OpenProblems.QEDE212
