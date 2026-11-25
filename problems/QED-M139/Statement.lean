import Mathlib
/-! QED-M139: Three consecutive integers with large prime factors
Show that for every exponent θ below 1 there are infinitely many n such that n, n+1 and n+2 each
have a prime factor larger than n^θ (for instance θ = 0.9).
Informal statement: Let P(m) be the largest prime factor of m. Prove that for every θ < 1 there
are infinitely many n with min{P(n), P(n+1), P(n+2)} > n^θ. (Benchmark case θ = 0.9. Stronger
target, not part of `Claim`: for 1/2 ≤ θ < 1 the set has lower density ≥ c(θ) > 0, conjecturally
(log(1/θ))³.)
Formalization notes: `lpf m` is the maximum of the finset of prime factors of m (`Nat.primeFactors`),
with the convention lpf 0 = lpf 1 = 0; for m ≥ 2 it is the largest prime factor. n^θ is the real
power `(n : ℝ) ^ θ`. Junk values at n = 0 (0^θ, lpf 0 = 0) affect at most finitely many n and
hence not infiniteness. For θ ≤ 0 the condition is easy (n^θ ≤ 1 < P), so the content is θ close
to 1. Proving `Claim` = the statement for every θ < 1; proving `¬Claim` = some θ < 1 for which
only finitely many such n exist.
-/
namespace OpenProblems.QEDM139
noncomputable section

/-- Largest prime factor of `m` (0 for `m ≤ 1`). -/
def lpf (m : ℕ) : ℕ := (Nat.primeFactors m).sup id

/-- For every θ < 1, infinitely many n have P(n), P(n+1), P(n+2) all exceeding n^θ. -/
def Claim : Prop :=
  ∀ θ : ℝ, θ < 1 →
    Set.Infinite {n : ℕ | (n : ℝ) ^ θ < (lpf n : ℝ) ∧ (n : ℝ) ^ θ < (lpf (n + 1) : ℝ) ∧
      (n : ℝ) ^ θ < (lpf (n + 2) : ℝ)}

end
end OpenProblems.QEDM139
