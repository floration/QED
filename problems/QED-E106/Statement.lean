import Mathlib
/-! QED-E106: Second moment of 3-torsion in imaginary quadratic class groups
Davenport-Heilbronn showed that the average of |Cl(K)[3]| over imaginary quadratic fields K is 2,
as Cohen-Lenstra predict. Cohen-Lenstra also predict that the average of |Cl(K)[3]|² is 6.
Prove this.
Informal statement: Let K range over imaginary quadratic fields with |D_K| < X. Cohen-Lenstra
(E #Sur(Cl_K, H) = 1 for H = (ℤ/3)²) predict (1/#{K}) Σ_K |Cl_K[3]|² → 6 as X → ∞. Prove this
limit. (Fallback, not formalized here: Σ_K |Cl_K[3]|² ≪ X.)
Formalization notes: Imaginary quadratic fields are represented by subfields K of ℂ
(`IntermediateField ℚ ℂ`) of degree 2 over ℚ that are not contained in ℝ. Each imaginary
quadratic field has exactly one image in ℂ (quadratic fields are normal), so this counts
isomorphism classes exactly once. The discriminant is `NumberField.discr`, with the
(Prop-valued) `NumberField` instance supplied existentially; it exists exactly for
finite-dimensional K. `tors3 K` is the number of elements c of the class group of the ring of
integers with c³ = 1, i.e. |Cl_K[3]| (the class group is finite, so `Nat.card` is faithful).
`fieldsUpTo X` is finite for each X (Hermite), so `Set.ncard` and `finsum` are faithful; for
small X the average is 0/0 = 0 in Lean, which does not affect the limit. Proving `Claim` proves
the Cohen-Lenstra second-moment prediction (average → 6); proving `¬Claim` disproves it.
Identity behind 6: |Cl[3]|² = #Hom(Cl, (ℤ/3)²) = Σ_{H ≤ (ℤ/3)²} #Sur(Cl, H), with 1 + 4 + 1 subgroups.
-/
namespace OpenProblems.QEDE106

/-- `K ⊆ ℂ` is an imaginary quadratic field with `|disc K| < X`. -/
def IsImagQuadUpTo (X : ℝ) (K : IntermediateField ℚ ℂ) : Prop :=
  ∃ h : NumberField K,
    Module.finrank ℚ K = 2 ∧
    (∃ x : K, (x : ℂ).im ≠ 0) ∧
    |((@NumberField.discr K _ h : ℤ) : ℝ)| < X

/-- The (finite) set of imaginary quadratic subfields of `ℂ` with `|disc| < X`. -/
def fieldsUpTo (X : ℝ) : Set (IntermediateField ℚ ℂ) :=
  {K : IntermediateField ℚ ℂ | IsImagQuadUpTo X K}

/-- `|Cl_K[3]|`: the number of ideal classes of `𝓞_K` whose cube is trivial. -/
noncomputable def tors3 (K : IntermediateField ℚ ℂ) : ℕ :=
  Nat.card {c : ClassGroup (NumberField.RingOfIntegers K) // c ^ 3 = 1}

/-- Average of `|Cl_K[3]|²` over imaginary quadratic fields with `|disc| < X`. -/
noncomputable def secondMoment (X : ℝ) : ℝ :=
  (∑ᶠ K ∈ fieldsUpTo X, ((tors3 K : ℝ) ^ 2)) / ((fieldsUpTo X).ncard : ℝ)

def Claim : Prop :=
  Filter.Tendsto secondMoment Filter.atTop (nhds (6 : ℝ))

end OpenProblems.QEDE106
