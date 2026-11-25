import Mathlib
/-! QED-E129: The centred maximal function diminishes variation
Replace a function on the real line by its centred maximal average: at each point take the largest average of |f| over intervals centred there. The total variation of the new function should be no larger than that of f. This is known for the uncentred maximal function and, for the centred one, for indicator functions and special step functions; for general f the best proven bound allows growth by a factor 240,004.
Informal statement: For locally integrable $f:\mathbb{R}\to\mathbb{R}$ let
$Mf(x)=\sup_{r>0}\frac{1}{2r}\int_{x-r}^{x+r}|f(y)|\,dy$. Prove or disprove: for every $f$ of bounded variation,
$\operatorname{Var}(Mf)\le\operatorname{Var}(f)$, where $\operatorname{Var}(f)$ is the essential variation (variation
of the best normalized representative) and $\operatorname{Var}(Mf)$ the pointwise variation of the everywhere-defined
function $Mf$. Discrete companion (also open; a separate statement `DiscreteClaim` below, not part of `Claim`): for
finitely supported $f:\mathbb{Z}\to\mathbb{R}$ with
$Mf(n)=\sup_{r\in\mathbb{N}_0}\frac{1}{2r+1}\sum_{|k|\le r}|f(n+k)|$, prove
$\sum_{n}|Mf(n+1)-Mf(n)|\le\sum_n|f(n+1)-f(n)|$. The constant 1 cannot be improved.
Formalization notes:
* `maximalFn f x = sup_{r>0} (2r)⁻¹ ∫_{[x-r,x+r]} |f|`, computed in `ℝ≥0∞` with the lower Lebesgue
  integral (no integrability junk). It depends only on the a.e. class of `f` and is defined at every
  `x`. For `f` of bounded variation, `f` is bounded, so `maximalFn f x ≤ sup |f| < ∞` and taking
  `toReal` loses nothing.
* Variation: Mathlib's `eVariationOn g Set.univ` (supremum over finite increasing sequences of
  `∑ |g(x_{i+1}) - g(x_i)|`, valued in `ℝ≥0∞`), i.e. pointwise variation. For `Mf` this is the
  quantity in the literature (Aldaz–Pérez Lázaro, Kurka): `Mf` is defined everywhere.
* Essential vs pointwise variation of `f`: `Claim` uses the pointwise variation of an arbitrary
  representative `f` with finite variation. This is equivalent to the essential-variation statement:
  pointwise `Var f ≥ essVar f`, so the essential version implies `Claim`; conversely, given `f` with
  finite essential variation, apply `Claim` to its normalized representative `f̃` (pointwise
  `Var f̃ = essVar f`), using `M f = M f̃`. BV functions are differences of monotone functions,
  hence measurable, so "locally integrable" is automatic.
* `Claim` = `Var(Mf) ≤ Var(f)` for all BV `f` on ℝ (continuous, centred). `¬Claim` = an explicit BV
  `f` with `Var(Mf) > Var(f)`.
* `DiscreteClaim` (companion, not part of `Claim`): finitely supported `f : ℤ → ℝ`, discrete centred
  maximal function with radii `r ∈ ℕ` (including `r = 0`, so `Mf ≥ |f|`), sums as `ℝ≥0∞`-valued
  `tsum`s (both sides are finite: the right side is a finite sum, the left side converges since
  `Mf(n) ≍ 1/|n|` has a summable difference sequence; `ℝ≥0∞` avoids junk either way). Equivalence of the
  two versions is known only for special step functions, so they are kept separate.
-/
namespace OpenProblems.QEDE129
noncomputable section
open MeasureTheory
open scoped ENNReal

/-- Centred Hardy–Littlewood maximal function on ℝ (values in `ℝ≥0∞`). -/
def maximalFn (f : ℝ → ℝ) (x : ℝ) : ℝ≥0∞ :=
  ⨆ (r : ℝ) (_ : 0 < r),
    ENNReal.ofReal (1 / (2 * r)) * ∫⁻ y in Set.Icc (x - r) (x + r), ENNReal.ofReal |f y|

/-- Variation-diminishing property of the centred maximal function on ℝ. -/
def Claim : Prop :=
  ∀ f : ℝ → ℝ, eVariationOn f Set.univ ≠ ⊤ →
    eVariationOn (fun x : ℝ => (maximalFn f x).toReal) Set.univ ≤ eVariationOn f Set.univ

/-- Discrete centred maximal function on ℤ, radii `r ∈ ℕ` (values in `ℝ≥0∞`). -/
def discMaximalFn (f : ℤ → ℝ) (n : ℤ) : ℝ≥0∞ :=
  ⨆ r : ℕ, (∑ k ∈ Finset.Icc (-(r : ℤ)) (r : ℤ), ENNReal.ofReal |f (n + k)|) /
    (2 * (r : ℝ≥0∞) + 1)

/-- Discrete companion (separate open problem, not part of `Claim`). -/
def DiscreteClaim : Prop :=
  ∀ f : ℤ → ℝ, (∃ N : ℕ, ∀ n : ℤ, (N : ℤ) < |n| → f n = 0) →
    ∑' n : ℤ, ENNReal.ofReal |(discMaximalFn f (n + 1)).toReal - (discMaximalFn f n).toReal| ≤
      ∑' n : ℤ, ENNReal.ofReal |f (n + 1) - f n|

end
end OpenProblems.QEDE129
