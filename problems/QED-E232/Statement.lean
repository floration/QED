import Mathlib
/-! QED-E232: Bombieri–Vinogradov for primes with a missing decimal digit
Maynard proved there are infinitely many primes with no digit 7 in base 10, with the expected count.
Show these primes are also well spread over arithmetic progressions, on average over all moduli up to a
small power of x, as the Bombieri-Vinogradov theorem says for all primes.
Informal statement: Let 𝒮 be the set of positive integers with no digit 7 in base 10, and for
(a, q) = 1 let π_𝒮(x; q, a) = #{p ≤ x prime : p ∈ 𝒮, p ≡ a (mod q)}, π_𝒮(x) = π_𝒮(x; 1, 0). Prove
there is θ > 0 such that for every A > 0:
∑_{q ≤ x^θ, (q,10)=1} max_{(a,q)=1} |π_𝒮(x; q, a) − π_𝒮(x)/φ(q)| ≪_A π_𝒮(x) (log x)^{−A}.
Formalization notes: Counts are cardinalities of finite sets of primes p ≤ ⌊x⌋ with
`7 ∉ Nat.digits 10 p` and `p % q = a % q`. "≪_A" is unfolded as: there are C and x₀ (depending on A,
and on θ) with the inequality for all real x ≥ x₀. The max over residues a coprime to q is replaced by
an arbitrary choice function `a : ℕ → ℕ` with `Nat.Coprime (a q) q` for every q, with C, x₀ chosen
before `a`; this is equivalent to the max version (take a(q) to be a maximiser; conversely each term is
at most the max). q ranges over 1 ≤ q ≤ ⌊x^θ⌋ with gcd(q, 10) = 1; φ is `Nat.totient`; (log x)^{−A} is
written as division by `Real.log x ^ A` (real power). Proving `Claim` = a positive level of
distribution for missing-digit primes; `¬Claim` = for every θ > 0 some A violates it.
-/
namespace OpenProblems.QEDE232

noncomputable section

/-- `#{p ≤ x prime : 7 is not a decimal digit of p, p ≡ a (mod q)}`. -/
def piS (x : ℝ) (q a : ℕ) : ℕ :=
  ((Finset.range (⌊x⌋₊ + 1)).filter
    (fun p : ℕ => p.Prime ∧ 7 ∉ Nat.digits 10 p ∧ p % q = a % q)).card

def Claim : Prop :=
  ∃ θ : ℝ, 0 < θ ∧ ∀ A : ℝ, 0 < A → ∃ C : ℝ, ∃ x₀ : ℝ, ∀ x : ℝ, x₀ ≤ x →
    ∀ a : ℕ → ℕ, (∀ q : ℕ, Nat.Coprime (a q) q) →
      ∑ q ∈ (Finset.Icc 1 ⌊x ^ θ⌋₊).filter (fun q : ℕ => Nat.Coprime q 10),
          |(piS x q (a q) : ℝ) - (piS x 1 0 : ℝ) / (Nat.totient q : ℝ)|
        ≤ C * (piS x 1 0 : ℝ) / Real.log x ^ A

end

end OpenProblems.QEDE232
