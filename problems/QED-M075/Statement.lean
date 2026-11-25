import Mathlib
/-! QED-M075: Break the 5/8 barrier for primes with triply well-factorable weights
Primes are equidistributed in residue classes on average over moduli q up to x^{5/8-ε} when the
average is weighted by triply well-factorable weights (Pascadi 2025). The problem is to push the
exponent beyond 5/8.
Informal statement: Say (λ_q)_{q ≤ Q} is triply well-factorable of level Q if for all Q₁Q₂Q₃ = Q
there are 1-bounded α, β, γ supported on q_i ≤ Q_i with λ = α * β * γ (Dirichlet convolution).
Let θ* be the sup of θ such that for all ε, A > 0, fixed a ≠ 0, and every such λ of level
Q = x^{θ-ε}: ∑_{q ≤ Q, (q,a)=1} λ_q (π(x;q,a) − π(x)/φ(q)) ≪_{ε,A,a} x (log x)^{-A}.
Known θ* ≥ 5/8 (Pascadi). Prove θ* > 5/8.
Formalization notes: Weights are complex. "Triply well-factorable of level Q" requires, for every
real Q₁, Q₂, Q₃ ≥ 1 with Q₁Q₂Q₃ = Q, sequences α, β, γ with |·| ≤ 1 supported on [1, Q_i] whose
triple Dirichlet convolution is λ (so λ is automatically supported on [1, Q]). π(x;q,a) counts primes
p ≤ x with p ≡ a (mod q); π(x) counts primes p ≤ x; φ = Nat.totient. The implied constant C and the
threshold x₀ may depend on θ, ε, A, a but must be uniform in λ. Since the property for θ implies it
for every smaller θ (absorb θ − θ' into ε), "θ* > 5/8" is equivalent to the existence of some
θ > 5/8 with the property, which is what `Claim` says. Proving `Claim` breaks the 5/8 barrier;
proving `¬ Claim` would show that 5/8 is the true limit for this class of weights (a barrier
theorem). Known: the property holds for θ = 5/8 (Pascadi, arXiv:2505.00653, Thm 1.3).
-/
namespace OpenProblems.QEDM075

/-- `α` is 1-bounded and supported on integers in `[1, Q]`. -/
def BoundedSupported (Q : ℝ) (α : ℕ → ℂ) : Prop :=
  (∀ n : ℕ, ‖α n‖ ≤ 1) ∧ (∀ n : ℕ, α n ≠ 0 → 1 ≤ n ∧ (n : ℝ) ≤ Q)

/-- Triple Dirichlet convolution `(α * β * γ)(q) = ∑_{abc = q} α(a) β(b) γ(c)`. -/
noncomputable def conv3 (α β γ : ℕ → ℂ) (q : ℕ) : ℂ :=
  ∑ a ∈ q.divisors, ∑ b ∈ (q / a).divisors, α a * β b * γ (q / a / b)

/-- Triply well-factorable weights of level `Q`. -/
def TriplyWellFactorable (Q : ℝ) (w : ℕ → ℂ) : Prop :=
  ∀ Q₁ Q₂ Q₃ : ℝ, 1 ≤ Q₁ → 1 ≤ Q₂ → 1 ≤ Q₃ → Q₁ * Q₂ * Q₃ = Q →
    ∃ α β γ : ℕ → ℂ, BoundedSupported Q₁ α ∧ BoundedSupported Q₂ β ∧ BoundedSupported Q₃ γ ∧
      ∀ q : ℕ, w q = conv3 α β γ q

open Classical in
/-- `π(x)`: number of primes `p ≤ x`. -/
noncomputable def primeCount (x : ℝ) : ℕ :=
  ((Finset.range (⌊x⌋₊ + 1)).filter (fun p => Nat.Prime p)).card

open Classical in
/-- `π(x; q, a)`: number of primes `p ≤ x` with `p ≡ a (mod q)`. -/
noncomputable def primeCountAP (x : ℝ) (q : ℕ) (a : ℤ) : ℕ :=
  ((Finset.range (⌊x⌋₊ + 1)).filter
    (fun p => Nat.Prime p ∧ (p : ℤ) % (q : ℤ) = a % (q : ℤ))).card

/-- `π(x;q,a) − π(x)/φ(q)`. -/
noncomputable def discrepancy (x : ℝ) (q : ℕ) (a : ℤ) : ℝ :=
  (primeCountAP x q a : ℝ) - (primeCount x : ℝ) / (Nat.totient q : ℝ)

open Classical in
/-- The weighted sum `∑_{q ≤ Q, (q,a)=1} w_q (π(x;q,a) − π(x)/φ(q))`. -/
noncomputable def weightedSum (x Q : ℝ) (a : ℤ) (w : ℕ → ℂ) : ℂ :=
  ∑ q ∈ ((Finset.Icc 1 ⌊Q⌋₊ : Finset ℕ).filter (fun q : ℕ => Int.gcd (q : ℤ) a = 1)),
    w q * ((discrepancy x q a : ℝ) : ℂ)

def Claim : Prop :=
  ∃ θ : ℝ, 5 / 8 < θ ∧
    ∀ ε : ℝ, 0 < ε → ∀ A : ℝ, 0 < A → ∀ a : ℤ, a ≠ 0 →
      ∃ C x₀ : ℝ, ∀ x : ℝ, x₀ ≤ x → ∀ w : ℕ → ℂ,
        TriplyWellFactorable (x ^ (θ - ε)) w →
          ‖weightedSum x (x ^ (θ - ε)) a w‖ ≤ C * x * (Real.log x) ^ (-A)

end OpenProblems.QEDM075
