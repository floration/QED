import Mathlib
/-! QED-M051: Is the measure of the hyperbolic real quadratic parameters computable?
For real c in [-2, 1/4], the map x ↦ x^2 + c has an attracting cycle for an open dense set
of parameters c, yet the non-hyperbolic (stochastic) parameters have positive length
(Jakobson). Is the total length λ(H) of the hyperbolic parameters a computable real number?
It is lower semicomputable (list certified windows), but no method approximates it from above.
Informal statement: Let H = {c ∈ [-2,1/4] : x ↦ x^2 + c has an attracting periodic orbit}.
Is the Lebesgue measure λ(H) a computable real number? (H is open, λ(H) is lower
semicomputable; Luzzatto–Takahashi give λ(H) ≤ 9/4 − 10^(-5000).)
Formalization notes:
* `quadMap c y = y^2 + c`. A periodic point `x` of period `n ≥ 1` (not necessarily minimal)
  is attracting iff its multiplier `(f^n)'(x) = ∏_{k<n} 2·f^k(x)` has absolute value `< 1`
  (strict: parabolic cycles are excluded, matching the open set H). Only real orbits are
  considered; for real c an attracting cycle attracts the (real) critical orbit, so it is
  real and nothing is lost.
* `hyperbolicMeasure` is `(volume H).toReal`; H ⊆ [-2,1/4] so the measure is finite and
  `toReal` is faithful. No measurability is needed for `volume` (outer measure), and H is open
  in [-2,1/4] anyway.
* A real r is computable iff there is a computable (Mathlib `Computable`, i.e. partial
  recursive total) f : ℕ → ℕ × ℕ × ℕ with |(a−b)/(c+1) − r| ≤ 2^(-n) where f n = (a,b,c).
  This is the standard Cauchy-name definition, encoded with naturals to use only basic
  `Primcodable` instances.
* Proving `Claim`: λ(H) is computable. Proving `¬Claim`: it is not.
* The "equivalently" clause (lower semicomputability of the stochastic measure) is the same
  question via λ(stochastic) = 9/4 − λ(H) (Lyubich, Avila–Moreira) and is not separately
  formalized.
-/
namespace OpenProblems.QEDM051

/-- The real quadratic family `x ↦ x^2 + c`. -/
def quadMap (c : ℝ) : ℝ → ℝ := fun y : ℝ => y ^ 2 + c

/-- The multiplier `(f_c^n)'(x)` of `x` along `n` steps, computed by the chain rule. -/
def multiplier (c x : ℝ) (n : ℕ) : ℝ :=
  ∏ k ∈ Finset.range n, (2 * (quadMap c)^[k] x)

/-- Parameters `c ∈ [-2, 1/4]` for which `x ↦ x^2 + c` has an attracting periodic orbit. -/
def hyperbolicSet : Set ℝ :=
  {c : ℝ | c ∈ Set.Icc (-2 : ℝ) (1 / 4) ∧
    ∃ x : ℝ, ∃ n : ℕ, 1 ≤ n ∧ (quadMap c)^[n] x = x ∧ |multiplier c x n| < 1}

/-- Lebesgue measure of the hyperbolic parameter set, as a real number. -/
noncomputable def hyperbolicMeasure : ℝ :=
  (MeasureTheory.volume hyperbolicSet).toReal

/-- `r` is a computable real: a computable sequence of rationals `(a-b)/(c+1)` converges to `r`
at rate `2^(-n)`. -/
def IsComputableReal (r : ℝ) : Prop :=
  ∃ f : ℕ → ℕ × ℕ × ℕ, Computable f ∧
    ∀ n : ℕ, |(((f n).1 : ℝ) - ((f n).2.1 : ℝ)) / (((f n).2.2 : ℝ) + 1) - r| ≤ 1 / (2 : ℝ) ^ n

def Claim : Prop := IsComputableReal hyperbolicMeasure

end OpenProblems.QEDM051
