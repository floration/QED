import Mathlib
/-! QED-M081: Lower the exponent 0.7785 for A4-quartic fields
Let N_{A4}(X) be the number of quartic number fields with Galois group A4 and |discriminant| ≤ X.
Malle predicts N_{A4}(X) ~ c X^{1/2} log X; Loughran-Paterson proved the matching lower bound.
The best upper bound is N_{A4}(X) ≪ X^{0.7784...+ε} (Bhargava-Shankar-Taniguchi-Thorne-Tsimerman-
Zhao). Lower this exponent.
Informal statement: Let N_{A4}(X) count quartic L/ℚ with Gal(L̃/ℚ) ≅ A4 and |Δ_L| ≤ X. Prove
N_{A4}(X) ≪ X^β for some β < 0.7784 (ideally β = 1/2 + ε).
Formalization notes: Instead of isomorphism classes of fields we count subfields K of ℂ
(`IntermediateField ℚ ℂ`). An A4-quartic field has trivial automorphism group, so each
isomorphism class corresponds to exactly 4 subfields of ℂ; this changes counts by the constant
factor 4, irrelevant for the exponent. A subfield K is an A4-quartic iff [K:ℚ] = 4 and its normal
closure in ℂ has degree 12 over ℚ (A4 is the only transitive subgroup of S4 of order 12).
The discriminant is Mathlib's `NumberField.discr`; the `NumberField` instance is supplied by an
existential over the (Prop-valued) class, which holds exactly when K is finite-dimensional.
To avoid any junk value from cardinalities of possibly infinite sets, the claim bounds the size
of EVERY finite family of such fields with |Δ| ≤ X (equivalent to bounding N_{A4}(X), which is
finite by Hermite). Proving `Claim` means some exponent β < 0.7784 works for all X ≥ 1 with a
fixed constant C; `¬Claim` means no exponent below 0.7784 works (which would contradict Malle's
conjecture). Known: X^{1/2} log X ≪ N_{A4}(X) ≪ X^{0.7784...+ε}; every β strictly below 0.7784 is a
strict improvement on the record exponent 0.7784....
-/
namespace OpenProblems.QEDM081

/-- `K ⊆ ℂ` is a quartic field with Galois group `A4` and `|disc K| ≤ X`. -/
def IsA4QuarticUpTo (X : ℝ) (K : IntermediateField ℚ ℂ) : Prop :=
  ∃ h : NumberField K,
    Module.finrank ℚ K = 4 ∧
    -- the Galois closure of K (smallest normal subfield of ℂ containing K) has degree 12,
    -- which for a quartic field means Galois group A4
    (∃ M : IntermediateField ℚ ℂ, K ≤ M ∧ Normal ℚ M ∧ Module.finrank ℚ M = 12 ∧
      ∀ M' : IntermediateField ℚ ℂ, K ≤ M' → Normal ℚ M' → M ≤ M') ∧
    |((@NumberField.discr K _ h : ℤ) : ℝ)| ≤ X

def Claim : Prop :=
  ∃ β : ℝ, β < (0.7784 : ℝ) ∧ ∃ C : ℝ, ∀ X : ℝ, 1 ≤ X →
    ∀ S : Finset (IntermediateField ℚ ℂ), (∀ K ∈ S, IsA4QuarticUpTo X K) →
      (S.card : ℝ) ≤ C * X ^ β

end OpenProblems.QEDM081
