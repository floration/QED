import Mathlib
/-! QED-M096: Liouville theorem for Lane-Emden with a shifted nonlinearity
Gidas-Spruck: -Δu = u^p has no positive entire solution on R^n for 1 < p < (n+2)/(n-2). If the
nonlinearity is evaluated at a shifted point, -Δu(x) = u(x+e)^p with e ≠ 0, is there still no
positive solution for every subcritical p?
Informal statement: Let n >= 3, 1 < p < (n+2)/(n-2), e ∈ R^n \ {0}. Prove or disprove: there is no
positive u ∈ C^2(R^n) with -Δu(x) = u(x+e)^p for all x.
Formalization notes: R^n is `Fin n → ℝ`; the Laplacian is defined from the second Fréchet
derivative as Σ_i D^2u(x)(e_i, e_i) with e_i = `Pi.single i 1` (independent of the norm used).
u(x+e)^p is the real power `Real.rpow` (u > 0, so no junk values). Claim asserts nonexistence for
all n >= 3, all subcritical p > 1 and all e ≠ 0 simultaneously; ¬Claim means a positive C^2
solution exists for some such (n, p, e). The range 1 < p < n/(n-2) is believed to follow from
the Mitidieri-Pohozaev test-function method; the open range is n/(n-2) <= p < (n+2)/(n-2). The
supercritical question p >= (n+2)/(n-2) is not part of Claim.
-/
namespace OpenProblems.QEDM096

/-- The Laplacian of `u : ℝ^n → ℝ` at `x`, via the second Fréchet derivative. -/
noncomputable def laplacian {n : ℕ} (u : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i : Fin n, fderiv ℝ (fderiv ℝ u) x (Pi.single i (1 : ℝ)) (Pi.single i (1 : ℝ))

def Claim : Prop :=
  ∀ n : ℕ, 3 ≤ n → ∀ p : ℝ, 1 < p → p < ((n : ℝ) + 2) / ((n : ℝ) - 2) →
    ∀ e : Fin n → ℝ, e ≠ 0 →
      ¬ ∃ u : (Fin n → ℝ) → ℝ, ContDiff ℝ 2 u ∧ (∀ x, 0 < u x) ∧
        ∀ x, -(laplacian u x) = (u (x + e)) ^ p

end OpenProblems.QEDM096
