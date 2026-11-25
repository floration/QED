import Mathlib
/-! QED-E234: Primes p with p² + p + 1 free of prime factors ≥ p
Show that a positive proportion of primes p have every prime factor of p² + p + 1 smaller than p.
Informal statement: Let P⁺(m) be the largest prime factor of m. Prove that
#{p ≤ x prime : P⁺(p² + p + 1) < p} ≫ x / log x. (Weaker targets, not part of `Claim`: infinitely
many such p; or P⁺(p² + p + 1) < p^θ for a positive proportion of primes with some θ < 2 as small as
possible.)
Formalization notes: `lpf m` is the maximum of `Nat.primeFactors m` (p² + p + 1 ≥ 7, so it is the
genuine largest prime factor). The count is `Set.ncard` of a bounded set of naturals. "≫ x/log x"
is the standard Vinogradov meaning: there are c > 0 and x₀ with count(x) ≥ c·x/log x for all
x ≥ x₀ (x ranging over naturals; equivalent to real x since the count is a step function and
x/log x is increasing for x ≥ 3). By the prime number theorem this is the same as a positive lower
proportion of primes. Proving `Claim` = the lower bound; proving `¬Claim` =
liminf count(x)·log x / x = 0.
-/
namespace OpenProblems.QEDE234
noncomputable section

/-- Largest prime factor of `m` (0 for `m ≤ 1`). -/
def lpf (m : ℕ) : ℕ := (Nat.primeFactors m).sup id

/-- `#{p ≤ x prime : P⁺(p² + p + 1) < p}`. -/
def count (x : ℕ) : ℕ :=
  Set.ncard {p : ℕ | p ≤ x ∧ Nat.Prime p ∧ lpf (p ^ 2 + p + 1) < p}

/-- A positive proportion of primes p have p² + p + 1 free of prime factors ≥ p. -/
def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ x₀ : ℕ, ∀ x : ℕ, x₀ ≤ x →
    c * (x : ℝ) / Real.log (x : ℝ) ≤ (count x : ℝ)

end
end OpenProblems.QEDE234
