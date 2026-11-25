import Mathlib
/-! QED-E233: Largest prime factor of 2^n + n
Show the largest prime factor of 2^n + n grows faster than any fixed multiple of n.
Informal statement: Let $P(m)$ be the largest prime factor of $m$. Prove $P(2^n+n)/n\to\infty$ as $n\to\infty$. (Intermediate target: $P(2^n+n)\ge n$ for all large $n$.)
Formalization notes: P(m) = `gpf m = max 1 (sup of m.primeFactors)`; for n ≥ 1, 2^n + n ≥ 3 so this is the genuine
largest prime factor (no junk). `P(2^n+n)/n → ∞` is written as: for every C ∈ ℕ there is N with C·n < P(2^n+n) for
all n ≥ N. Natural C suffice (any real bound is below some natural C), and n = 0 is excluded by taking N ≥ 1 when
needed (for n = 0 the inequality 0 < P(1) = 1 holds anyway). `Claim` = the conjecture; `¬Claim` = some C with
P(2^n+n) ≤ C n infinitely often. The intermediate target is not encoded.
-/
namespace OpenProblems.QEDE233
noncomputable section

/-- Largest prime factor of `n`, with `gpf 0 = gpf 1 = 1`. -/
def gpf (n : ℕ) : ℕ := max 1 (n.primeFactors.sup id)

/-- `P(2^n + n) / n → ∞`. -/
def Claim : Prop :=
  ∀ C : ℕ, ∃ N : ℕ, ∀ n : ℕ, N ≤ n → C * n < gpf (2 ^ n + n)

end
end OpenProblems.QEDE233
