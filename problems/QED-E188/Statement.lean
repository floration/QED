import Mathlib
/-! QED-E188: Is the order of vanishing at 1 of a ±1 polynomial O(log n)?
How many times can a polynomial of length n with all coefficients ±1 vanish at x = 1? Boyd
showed the multiplicity is at most about (log n)²/log log n, while explicit constructions give
multiplicity about (10/log 240)·log n. Is it always O(log n)?
Informal statement: Let N(m) be the least n such that some p(x) = ∑_{j<n} ε_j x^j with all
ε_j ∈ {±1} is divisible by (x-1)^m (N(m) ≤ 2^m). By submultiplicativity N(a+b) ≤ N(a)N(b) the
limit ρ = lim N(m)^{1/m} = inf N(m)^{1/m} exists, with 1 ≤ ρ ≤ 240^{1/10}, while Boyd proved
N(m) ≥ e^{(1+o(1))√m}. Decide whether ρ > 1. Equivalently: is there C such that every
Littlewood polynomial of length n ≥ 2 has a zero at 1 of multiplicity at most C log n?
Formalization notes: `IsLittlewood p n` says p ∈ ℤ[X] has coefficients ±1 in degrees 0,…,n-1
and 0 from degree n on (length exactly n). Multiplicity of the zero at 1 is expressed by
divisibility: (X - 1)^m ∣ p. Such p are nonzero (constant term ±1), so the divisibility set
is bounded and this is the usual multiplicity. `Claim` is the O(log n) form:
∃ C, ∀ n ≥ 2, ∀ Littlewood p of length n, ∀ m, (X-1)^m ∣ p → m ≤ C log n. Equivalence with
ρ > 1: if ρ > 1 then N(m) ≥ ρ^m (inf characterization), so m ≤ log n / log ρ; conversely the
bound gives N(m) ≥ e^{m/C} for m ≥ 1 (N(m) ≥ 2 then). `Claim` ⇔ ρ > 1; `¬Claim` ⇔ ρ = 1.
-/
namespace OpenProblems.QEDE188
noncomputable section

open Polynomial

/-- `p` is a Littlewood polynomial of length `n`: coefficients ±1 below `n`, zero from `n` on. -/
def IsLittlewood (p : ℤ[X]) (n : ℕ) : Prop :=
  (∀ j : ℕ, j < n → (p.coeff j = 1 ∨ p.coeff j = -1)) ∧
  (∀ j : ℕ, n ≤ j → p.coeff j = 0)

def Claim : Prop :=
  ∃ K : ℝ, ∀ n : ℕ, 2 ≤ n → ∀ p : ℤ[X], IsLittlewood p n →
    ∀ m : ℕ, (X - Polynomial.C (1 : ℤ)) ^ m ∣ p → (m : ℝ) ≤ K * Real.log (n : ℝ)

end
end OpenProblems.QEDE188
