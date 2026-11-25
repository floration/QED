import Mathlib
/-! QED-E104: One-level density of quadratic Dirichlet L-functions beyond support (−2,2)
Under GRH, the low-lying zeros of L(s,χ_d) for quadratic characters are known to follow the symplectic random-matrix
law only for test functions whose Fourier transform is supported in (−2,2). Go beyond 2.
Informal statement: For the family of real primitive characters $\chi_{8d}$, $d$ odd squarefree, $X<d\le 2X$, and
even Schwartz $\phi$ with $\operatorname{supp}\hat\phi\subset(-\sigma,\sigma)$, prove under GRH that
$\frac1{|\mathcal F|}\sum_d\sum_{\gamma_d}\phi\big(\gamma_d\frac{\log X}{2\pi}\big)\to
\int\phi(x)\big(1-\frac{\sin 2\pi x}{2\pi x}\big)dx$ for some $\sigma>2$.
Formalization notes:
* GRH: every zero of `DirichletCharacter.LFunction χ` (any modulus `q ≥ 1`) in `0 < Re s < 1` has `Re s = 1/2`.
  Under GRH the nontrivial zeros of `L(s, χ_{8d})` are exactly the points `1/2 + iγ` with `L = 0`, so the zero sum is
  `Σ_{γ ∈ ℝ} m(1/2 + iγ) φ(γ log X / 2π)` where `m(s)` is the order of vanishing (least `k` with
  `L^{(k)}(s) ≠ 0`, `0` at non-zeros). It is written as a `tsum` over `ℝ` (countable support; absolutely summable for
  Schwartz `φ` by the zero-counting bound `N(T, χ) ≪ T log(qT)`). The trivial zero at `s = 0` is not on the line.
* `χ_{8d}` = Kronecker symbol `(8d/·)`: for odd `n` it equals the Jacobi symbol `(8d/n)`, and it vanishes at even `n`.
  For `d` odd squarefree positive this is a primitive even real character mod `8d` (8d is a fundamental
  discriminant). We do not construct it: for each `d` we sum over all Dirichlet characters mod `8d` satisfying this
  defining property (there is exactly one), using `finsum`.
* The family: `d` odd squarefree with `X < d ≤ 2X`; `|𝓕|` is its cardinality.
* Test functions: real-valued, even, smooth, with all `|x|^k |φ^{(m)}(x)|` bounded (Schwartz).
  `φ̂(ξ) = ∫ φ(x) e^{−2πixξ} dx` (hand-defined). The condition `supp φ̂ ⊂ (−σ,σ)` is encoded as `φ̂(ξ) = 0` for
  `|ξ| ≥ σ`; as `σ > 2` is existential, the two versions give equivalent claims (shrink `σ`).
* Symplectic density `W(x) = 1 − sin(2πx)/(2πx)` (junk value `1` at `x = 0`, a null set).
* Claim := GRH → ∃ σ > 2, ∀ admissible φ, one-level density → ∫ φ W as `X → ∞` (real `X`).
-/
namespace OpenProblems.QEDE104
noncomputable section
open scoped Classical
open Filter

/-- The Generalized Riemann Hypothesis for all Dirichlet `L`-functions. -/
def GRH : Prop :=
  ∀ (q : ℕ) (χ : DirichletCharacter ℂ (q + 1)) (s : ℂ),
    DirichletCharacter.LFunction χ s = 0 → 0 < s.re → s.re < 1 → s.re = 1 / 2

/-- `χ` is the Kronecker symbol `(8d/·)` as a character mod `8d`. -/
def IsChi8d (d : ℕ) (χ : DirichletCharacter ℂ (8 * d)) : Prop :=
  ∀ n : ℕ, χ (n : ZMod (8 * d)) =
    if n % 2 = 1 then (((jacobiSym (8 * (d : ℤ)) n : ℤ) : ℂ)) else 0

/-- Order of vanishing of `f` at `s` (`0` if `f s ≠ 0`). -/
def ord (f : ℂ → ℂ) (s : ℂ) : ℕ := sInf {k : ℕ | iteratedDeriv k f s ≠ 0}

/-- `Σ_γ m(1/2 + iγ) φ(γ log X / 2π)` over the zeros of `L(s, χ)` on the critical line. -/
def zeroSum {N : ℕ} [NeZero N] (χ : DirichletCharacter ℂ N) (φ : ℝ → ℝ) (X : ℝ) : ℝ :=
  ∑' γ : ℝ, (ord (DirichletCharacter.LFunction χ) ((1 / 2 : ℂ) + (γ : ℂ) * Complex.I) : ℝ) *
    φ (γ * Real.log X / (2 * Real.pi))

/-- The family `d` odd squarefree, `X < d ≤ 2X`. -/
def family (X : ℝ) : Finset ℕ :=
  (Finset.Ioc ⌊X⌋₊ ⌊2 * X⌋₊).filter (fun d : ℕ => Odd d ∧ Squarefree d)

/-- `Σ_γ φ(γ log X / 2π)` for `χ_{8d}` (summed over the unique character mod `8d` with the defining
property; `0` for the excluded value `d = 0`, which never lies in the family). -/
def chiZeroSum (d : ℕ) (φ : ℝ → ℝ) (X : ℝ) : ℝ :=
  if h : d = 0 then 0 else
    haveI : NeZero (8 * d) := ⟨by omega⟩
    ∑ᶠ χ : DirichletCharacter ℂ (8 * d), if IsChi8d d χ then zeroSum χ φ X else 0

/-- The averaged one-level density. -/
def oneLevel (X : ℝ) (φ : ℝ → ℝ) : ℝ :=
  ((family X).card : ℝ)⁻¹ * ∑ d ∈ family X, chiZeroSum d φ X

/-- Even real Schwartz function. -/
def IsEvenSchwartz (φ : ℝ → ℝ) : Prop :=
  (∀ r : ℕ, ContDiff ℝ r φ) ∧
  (∀ k m : ℕ, ∃ C : ℝ, ∀ x : ℝ, |x| ^ k * |iteratedDeriv m φ x| ≤ C) ∧
  (∀ x : ℝ, φ (-x) = φ x)

/-- Fourier transform `φ̂(ξ) = ∫ φ(x) e^{-2πixξ} dx`. -/
def fhat (φ : ℝ → ℝ) (ξ : ℝ) : ℂ :=
  ∫ x : ℝ, Complex.exp ((((-2) * Real.pi * x * ξ : ℝ) : ℂ) * Complex.I) * (φ x : ℂ)

/-- Symplectic one-level density `1 − sin(2πx)/(2πx)`. -/
def Wsp (x : ℝ) : ℝ := 1 - Real.sin (2 * Real.pi * x) / (2 * Real.pi * x)

def Claim : Prop :=
  GRH → ∃ σ : ℝ, 2 < σ ∧ ∀ φ : ℝ → ℝ, IsEvenSchwartz φ →
    (∀ ξ : ℝ, σ ≤ |ξ| → fhat φ ξ = 0) →
      Tendsto (fun X : ℝ => oneLevel X φ) atTop (nhds (∫ x : ℝ, φ x * Wsp x))

end
end OpenProblems.QEDE104
