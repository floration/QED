import Mathlib
/-! QED-E019: Period-doubling torus bundles
Informal statement: Let W_n ∈ {a,b}^{2^n} be the length-2^n prefix of the fixed point of
a ↦ ab, b ↦ aa (n ≥ 1), φ_n ∈ SL₂(ℤ) the product with a ↦ R = [[1,1],[0,1]], b ↦ L = [[1,0],[1,1]],
and M_n the once-punctured torus bundle with monodromy φ_n (hyperbolic since W_n contains both
letters). Prove that lim vol(M_n)/2^n exists.
Formalization notes: hyperbolic volume is not in Mathlib, so vol(M_n) is encoded through
Guéritaud's theorem (Geom. Topol. 10 (2006)): M_ω for a cyclic word ω = ω₀…ω_{m−1} in {R,L}
containing both letters carries the Floyd–Hatcher layered triangulation with tetrahedra Δ_i,
i ∈ ℤ/m, Δ_i sitting between letters ω_i and ω_{i+1}; i is a hinge iff ω_i ≠ ω_{i+1}. Angle
structures are parametrized by w : ℤ/m → ℝ; with (a,b,c) = (w_{i−1}, w_i, w_{i+1}) the dihedral
angles of Δ_i are z = π − 2b and {x, y} = {a + c, 2b − a − c} (non-hinge) or
{b + a − c, b + c − a} (hinge); an angle structure is w with all of w_i, x_i, y_i, z_i > 0
(equivalently 0 < w_i < π/2, concavity at non-hinges, |w_{i+1} − w_{i−1}| < w_i at hinges).
vol(M_ω) = max over angle structures of Σ_i Λ(x_i)+Λ(y_i)+Λ(z_i), Λ the Lobachevsky function
(Casson–Rivin + Guéritaud: max attained in the interior, equals the hyperbolic volume). We use
sSup of the functional over the open polytope (equal to the max by continuity); it is bounded
above (Λ ≤ 0.51), and the claim additionally asserts the polytope is nonempty, so an empty set
cannot make the claim trivial. Letters: true = a ↦ R, false = b ↦ L; the formula is symmetric
in R ↔ L and in word reversal, matching volume invariance under these changes of convention.
Check: W₁ = ab gives the figure-eight knot complement, vol = 2.0298… at w ≡ π/3.
-/
namespace OpenProblems.QEDE019
noncomputable section
open Filter Topology

/-- The period-doubling substitution `a ↦ ab, b ↦ aa` (`true = a`, `false = b`). -/
def subst (ω : List Bool) : List Bool :=
  ω.flatMap fun c => if c then [true, false] else [true, true]

/-- `W n = σⁿ(a)`, the length-`2ⁿ` prefix of the fixed point. -/
def W (n : ℕ) : List Bool := subst^[n] [true]

/-- Lobachevsky function `Λ(θ) = −∫₀^θ log|2 sin u| du`. -/
def lob (θ : ℝ) : ℝ := -∫ u in (0 : ℝ)..θ, Real.log (2 * Real.sin u)

section
variable (ω : List Bool)

/-- Cyclic successor / predecessor of a tetrahedron index. -/
def nxt (i : Fin ω.length) : Fin ω.length := finRotate ω.length i
def prv (i : Fin ω.length) : Fin ω.length := (finRotate ω.length).symm i

/-- First dihedral angle of tetrahedron `i`. -/
def xAng (w : Fin ω.length → ℝ) (i : Fin ω.length) : ℝ :=
  if ω.get i = ω.get (nxt ω i) then w (prv ω i) + w (nxt ω i)
  else w i + w (prv ω i) - w (nxt ω i)

/-- Second dihedral angle of tetrahedron `i`. -/
def yAng (w : Fin ω.length → ℝ) (i : Fin ω.length) : ℝ :=
  if ω.get i = ω.get (nxt ω i) then 2 * w i - w (prv ω i) - w (nxt ω i)
  else w i + w (nxt ω i) - w (prv ω i)

/-- Third dihedral angle `π − 2 w_i`. -/
def zAng (w : Fin ω.length → ℝ) (i : Fin ω.length) : ℝ := Real.pi - 2 * w i

/-- `w` defines an angle structure on the layered triangulation of `M_ω`. -/
def IsAngleStructure (w : Fin ω.length → ℝ) : Prop :=
  ∀ i, 0 < w i ∧ 0 < xAng ω w i ∧ 0 < yAng ω w i ∧ 0 < zAng ω w i

/-- Volume functional `Σ Λ(x_i) + Λ(y_i) + Λ(z_i)`. -/
def volFun (w : Fin ω.length → ℝ) : ℝ :=
  ∑ i, (lob (xAng ω w i) + lob (yAng ω w i) + lob (zAng ω w i))

/-- Hyperbolic volume of `M_ω` (Guéritaud: max of the volume functional). -/
def hypVol : ℝ := sSup (volFun ω '' {w | IsAngleStructure ω w})

end

def Claim : Prop :=
  (∀ n : ℕ, 1 ≤ n → ∃ w, IsAngleStructure (W n) w) ∧
    ∃ L : ℝ, Tendsto (fun n : ℕ => hypVol (W n) / 2 ^ n) atTop (𝓝 L)

end
end OpenProblems.QEDE019
