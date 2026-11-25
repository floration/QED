import Mathlib
/-! QED-M077: Do GRH and Elliott–Halberstam together refute the Alternative Hypothesis?
The Alternative Hypothesis says normalized gaps between zeta zeros are almost all near half-integers. It contradicts
GUE, but no proven hypothesis is known to rule it out. Decide whether GRH plus Elliott–Halberstam (strong statements
about primes, not zeros) is incompatible with it.
Informal statement: Let AH be as in arXiv:2508.10857. Does RH + GRH for Dirichlet L-functions + the
Elliott–Halberstam conjecture imply that AH fails?
Formalization notes:
* RH: every zero of `riemannZeta` in the open strip `0 < Re s < 1` has real part `1/2`.
  GRH: the same for `DirichletCharacter.LFunction χ` for every Dirichlet character `χ` of every modulus `q ≥ 1`
  (it contains RH via the modulus-1 character; RH is kept as a separate hypothesis to match the problem).
* EH (Elliott–Halberstam), level-of-distribution form: for every `ε > 0`, `A > 0`,
  `Σ_{q ≤ x^{1-ε}} max_{(a,q)=1} |ψ(x;q,a) − ψ(x)/φ(q)| ≪_{ε,A} x/(log x)^A`, where
  `ψ(x;q,a) = Σ_{n ≤ x, n ≡ a (q)} Λ(n)`. The `max` over `a` is encoded equivalently as a bound uniform over all
  choice functions `q ↦ a q` with `gcd(a q, q) = 1`. We use EH, not GEH; since GEH ⇒ EH, `Claim` with EH is the
  stronger (harder) form, and the GEH variant ("or GEH") is a weaker statement not encoded here.
* AH, transcribed from Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh (arXiv:2508.10857, §1): let
  `0 < γ_1 < γ_2 < …` be the distinct positive ordinates of zeros of `ζ`, `γ̃ = (γ/2π) log γ`. AH: for each `n`
  there is an integer `k_n ≥ 0` with `γ̃_{n+1} − γ̃_n = k_n/2 + O(|γ_{n+1} − γ_n| ψ(γ_n))`, where `ψ` is a positive
  function with `ψ(γ) → ∞` and `ψ(γ) = o(log γ)`. We quantify `ψ` and the `O`-constant existentially
  (the paper leaves `ψ` unquantified; existential is the natural reading). Consecutive ordinates are encoded as
  `γ < γ'` both ordinates with no ordinate strictly between. Ordinates with positive imaginary part are exactly the
  nontrivial zeros (trivial zeros are real; the junk value `ζ(1)` is real).
* Claim := RH → GRH → EH → ¬AH. Proving ¬Claim would require proving RH, GRH and EH, so only the positive
  direction is realistic; this is inherent to the conditional problem.
-/
namespace OpenProblems.QEDM077
noncomputable section
open Filter

/-- The Riemann Hypothesis. -/
def RH : Prop :=
  ∀ s : ℂ, riemannZeta s = 0 → 0 < s.re → s.re < 1 → s.re = 1 / 2

/-- The Generalized Riemann Hypothesis for all Dirichlet `L`-functions. -/
def GRH : Prop :=
  ∀ (q : ℕ) (χ : DirichletCharacter ℂ (q + 1)) (s : ℂ),
    DirichletCharacter.LFunction χ s = 0 → 0 < s.re → s.re < 1 → s.re = 1 / 2

/-- `ψ(x; q, a) = Σ_{n ≤ x, n ≡ a mod q} Λ(n)`. -/
def psiAP (x : ℝ) (q a : ℕ) : ℝ :=
  ∑ n ∈ (Finset.Icc 1 ⌊x⌋₊).filter (fun n : ℕ => n % q = a % q), ArithmeticFunction.vonMangoldt n

/-- Chebyshev's `ψ(x)`. -/
def psi (x : ℝ) : ℝ := psiAP x 1 0

/-- The Elliott–Halberstam conjecture. -/
def EH : Prop :=
  ∀ ε : ℝ, 0 < ε → ∀ A : ℝ, 0 < A → ∃ C : ℝ, ∀ x : ℝ, 2 ≤ x → ∀ a : ℕ → ℕ,
    (∀ q : ℕ, Nat.Coprime (a q) q) →
      ∑ q ∈ Finset.Icc 1 ⌊x ^ (1 - ε)⌋₊, |psiAP x q (a q) - psi x / (Nat.totient q : ℝ)|
        ≤ C * x / Real.log x ^ A

/-- Positive ordinates of zeros of `ζ` (distinct values). -/
def Ordinates : Set ℝ := {γ : ℝ | 0 < γ ∧ ∃ s : ℂ, riemannZeta s = 0 ∧ s.im = γ}

/-- Normalized ordinate `γ̃ = (γ / 2π) log γ`. -/
def normOrd (γ : ℝ) : ℝ := γ / (2 * Real.pi) * Real.log γ

/-- `γ < γ'` are consecutive ordinates. -/
def Consecutive (γ γ' : ℝ) : Prop :=
  γ ∈ Ordinates ∧ γ' ∈ Ordinates ∧ γ < γ' ∧ ∀ t ∈ Ordinates, ¬ (γ < t ∧ t < γ')

/-- The Alternative Hypothesis (arXiv:2508.10857). -/
def AH : Prop :=
  ∃ ψ : ℝ → ℝ, (∀ γ : ℝ, 0 < ψ γ) ∧ Tendsto ψ atTop atTop ∧
    Tendsto (fun γ : ℝ => ψ γ / Real.log γ) atTop (nhds 0) ∧
    ∃ C : ℝ, ∀ γ γ' : ℝ, Consecutive γ γ' →
      ∃ k : ℕ, |normOrd γ' - normOrd γ - (k : ℝ) / 2| ≤ C * (γ' - γ) * ψ γ

def Claim : Prop := RH → GRH → EH → ¬ AH

end
end OpenProblems.QEDM077
