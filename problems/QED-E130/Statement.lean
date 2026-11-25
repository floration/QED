import Mathlib
/-! QED-E130: Sign uncertainty on the line: reach 1/2
If a real even function f on the line has f(0) ≤ 0 and its Fourier transform is also ≤ 0 at the origin, then f and its transform cannot both become permanently nonnegative too soon: with A(f), A(f̂) the radii beyond which each is nonnegative, the product A(f)A(f̂) is bounded below. The best proven lower bound for the square root of this product is 0.45 (2017), while the best examples give about 0.567. Prove the bound 1/2.
Informal statement: With $\hat f(\xi)=\int_{\mathbb{R}}f(x)e^{-2\pi i x\xi}dx$, let $\mathcal{A}_+$ be the set of nonzero real-valued even continuous $f\in L^1(\mathbb{R})$ with $\hat f\in L^1(\mathbb{R})$, $f(0)\le0$, $\hat f(0)\le0$, and $f,\hat f$ eventually nonnegative; for real $g$ put $A(g)=\inf\{r>0: g(x)\ge0\text{ for all }|x|\ge r\}$. Prove $A(f)A(\hat f)\ge 1/4$ for all $f\in\mathcal{A}_+$, i.e. $\mathbb{A}_+(1):=\inf_{f\in\mathcal A_+}\sqrt{A(f)A(\hat f)}\ge 1/2$ (currently $0.45\le\mathbb{A}_+(1)\le 0.5671$).
Formalization notes:
* Fourier transform with the `e^{-2πixξ}` convention. For even integrable real `f` the sine part
  `∫ f(x) sin(2πxξ) dx` vanishes (odd integrand), so `f̂(ξ) = ∫ f(x) cos(2πxξ) dx` is real; we
  define `fhat` directly as this cosine integral (a Bochner integral over Lebesgue measure).
* Continuity of `f` is added explicitly (the informal statement is sharpened accordingly). This
  is the standard setting (Bourgain–Clozel–Kahane; Gonçalves–Oliveira e Silva–Steinerberger):
  for `f, f̂ ∈ L¹`, `f` agrees a.e. with a continuous function, and the pointwise conditions
  `f(0) ≤ 0` and `A(f)` refer to that representative. Without continuity the statement is
  false for junk reasons: `f = -1` at `0` and `0` elsewhere has `f̂ = 0` and `A(f) = 0`.
* "Nonzero" is `∃ x, f x ≠ 0`, which for continuous `f` means `f ≠ 0` in `L¹`.
* `A g = sInf {r | 0 < r ∧ ∀ x, r ≤ |x| → 0 ≤ g x}`. The eventual-nonnegativity hypotheses make
  this set nonempty, and it is bounded below by 0, so `A g` is the genuine infimum (no junk).
  (`A f = 0` is impossible for admissible `f`: it forces `f ≥ 0` everywhere by continuity, and
  with `∫ f = f̂(0) ≤ 0` this gives `f = 0`.)
* `Claim`: `1/4 ≤ A(f)·A(f̂)` for every admissible `f`, i.e. `𝔸₊(1) ≥ 1/2`. `¬Claim` exhibits an
  admissible `f` with `A(f)A(f̂) < 1/4`, i.e. `𝔸₊(1) < 1/2`.
-/
namespace OpenProblems.QEDE130
noncomputable section
open MeasureTheory

/-- Fourier transform of an even real function (`e^{-2πixξ}` convention), which is real. -/
def fhat (f : ℝ → ℝ) (ξ : ℝ) : ℝ :=
  ∫ x : ℝ, f x * Real.cos (2 * Real.pi * x * ξ)

/-- The radius beyond which `g` is nonnegative. -/
def A (g : ℝ → ℝ) : ℝ :=
  sInf {r : ℝ | 0 < r ∧ ∀ x : ℝ, r ≤ |x| → 0 ≤ g x}

/-- The class `𝒜₊` of the `+1` sign uncertainty principle on `ℝ`. -/
def Admissible (f : ℝ → ℝ) : Prop :=
  Continuous f ∧ Integrable f ∧ Integrable (fhat f) ∧ (∀ x : ℝ, f (-x) = f x) ∧
    (∃ x : ℝ, f x ≠ 0) ∧ f 0 ≤ 0 ∧ fhat f 0 ≤ 0 ∧
    (∃ R : ℝ, ∀ x : ℝ, R ≤ |x| → 0 ≤ f x) ∧
    (∃ R : ℝ, ∀ ξ : ℝ, R ≤ |ξ| → 0 ≤ fhat f ξ)

def Claim : Prop :=
  ∀ f : ℝ → ℝ, Admissible f → (1 : ℝ) / 4 ≤ A f * A (fhat f)

end
end OpenProblems.QEDE130
