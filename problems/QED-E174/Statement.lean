import Mathlib
/-! QED-E174: Unbounded partial quotients of the cube root of 2
The continued fraction of 2^{1/3} = [1; 3, 1, 5, 1, 1, 4, 1, 1, 8, 1, 14, …] is believed to
behave like that of a random number and to have arbitrarily large terms, but this has never been
proved. Prove that its partial quotients are unbounded.
Informal statement: Let 2^{1/3} = [a₀; a₁, a₂, …]. Prove sup_n a_n = ∞; equivalently 2^{1/3} is
not badly approximable: liminf_{q→∞} q‖q·2^{1/3}‖ = 0, ‖·‖ the distance to the nearest integer.
Formalization notes: We state the badly-approximable form, avoiding continued-fraction API:
for every ε > 0 there are integers q ≥ 1 and p with |q·2^{1/3} − p| < ε/q. This is equivalent to
liminf q‖q α‖ = 0: since α = 2^{1/3} is irrational, ‖qα‖ > 0 for every q ≥ 1, so the condition
for all ε forces infinitely many such q. By the classical theory of continued fractions
(the best approximations are convergents and q_k‖q_kα‖ ≍ 1/a_{k+1}) this is equivalent to
unbounded partial quotients. 2^{1/3} is the real number `(2:ℝ) ^ ((1:ℝ)/3)` (`Real.rpow`, the
unique positive real cube root of 2). `Claim` = 2^{1/3} has unbounded partial quotients;
`¬Claim` = it is badly approximable (bounded partial quotients).
-/
namespace OpenProblems.QEDE174
noncomputable section

/-- The real cube root of 2. -/
def cbrt2 : ℝ := (2 : ℝ) ^ ((1 : ℝ) / 3)

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ q : ℕ, 0 < q ∧ ∃ p : ℤ,
    |(q : ℝ) * cbrt2 - (p : ℝ)| < ε / (q : ℝ)

end
end OpenProblems.QEDE174
