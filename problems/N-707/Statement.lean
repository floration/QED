import Mathlib
/-! N-707: Lower the exponent 1/2 in Pasten's subexponential abc bound
For coprime a + b = c with R = rad(abc), Pasten (Invent. Math. 2024) proved subexponential
bounds of the shape log c ≤ η⁻¹ exp(κ √(log R · log log R)) (when a ≤ c^{1−η}) and
log c ≤ q exp(κ √(log R · log log R)) with q the smallest of the largest prime factors of a, b, c.
Replace the square root by a smaller power of log R.
Informal statement: Prove, for some fixed θ < 1/2, either: (1) there is κ > 0 such that for all
η ∈ (0,1) and coprime positive a + b = c with a ≤ c^{1−η}, log c ≤ η⁻¹ exp(κ (log R)^θ); or
(2) there is κ > 0 such that for all coprime positive a + b = c,
log c ≤ q · exp(κ (log R)^θ), q = min{P(a), P(b), P(c)}. (The weaker fallback
exp(O(√log R)) is not part of the Claim.)
Formalization notes: rad(n) = ∏ of the distinct primes dividing n (`Nat.primeFactors`);
P(n) = largest prime factor with P(1) = 1, written max 1 (sup of primeFactors). For a coprime
positive triple c ≥ 2, so R ≥ 2 and log R > 0: no junk values in `Real.log` or `rpow`. θ is
required to satisfy 0 < θ < 1/2 (θ ≤ 0 versions are false anyway). The constant κ may depend on θ
only; small-R cases are absorbed by κ since each R admits finitely many triples. Proving `Claim`
= an improvement of Pasten's exponent in either form; `¬Claim` would show that neither form holds
for any θ < 1/2, which would contradict the abc conjecture (abc implies both forms for all θ > 0),
so `¬Claim` is not expected.
-/
namespace OpenProblems.N707

/-- Radical: product of the distinct primes dividing `n`. -/
def rad (n : ℕ) : ℕ := ∏ p ∈ n.primeFactors, p

/-- Largest prime factor of `n`, with the convention `P(0) = P(1) = 1`. -/
def gpf (n : ℕ) : ℕ := max 1 (n.primeFactors.sup id)

/-- `(a, b, c)` is a coprime triple of positive integers with `a + b = c`. -/
def IsABC (a b c : ℕ) : Prop := 0 < a ∧ 0 < b ∧ a + b = c ∧ Nat.Coprime a b

/-- Form (1) of the bound with exponent `θ`. -/
def BoundEta (θ : ℝ) : Prop :=
  ∃ κ : ℝ, 0 < κ ∧ ∀ (η : ℝ), 0 < η → η < 1 → ∀ a b c : ℕ, IsABC a b c →
    (a : ℝ) ≤ (c : ℝ) ^ (1 - η) →
    Real.log (c : ℝ) ≤ η⁻¹ * Real.exp (κ * (Real.log (rad (a * b * c) : ℝ)) ^ θ)

/-- Form (2) of the bound with exponent `θ`. -/
def BoundQ (θ : ℝ) : Prop :=
  ∃ κ : ℝ, 0 < κ ∧ ∀ a b c : ℕ, IsABC a b c →
    Real.log (c : ℝ) ≤
      ((min (gpf a) (min (gpf b) (gpf c)) : ℕ) : ℝ) *
        Real.exp (κ * (Real.log (rad (a * b * c) : ℝ)) ^ θ)

def Claim : Prop :=
  ∃ θ : ℝ, 0 < θ ∧ θ < 1 / 2 ∧ (BoundEta θ ∨ BoundQ θ)

end OpenProblems.N707
