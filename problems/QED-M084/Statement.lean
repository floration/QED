import Mathlib
/-! QED-M084: Push the GRH lower bound for Montgomery's F(alpha) beyond alpha = 1
Montgomery's pair-correlation function F(α) is known only for |α| ≤ 1 (on RH). Under GRH for Dirichlet L-functions,
Goldston–Gonek–Özlük–Snyder proved F(α) ≥ 3/2 − |α| − ε on 1 ≤ |α| ≤ 3/2, while the conjecture says F(α) = 1 there.
Improve this lower bound.
Informal statement: Assume GRH for all Dirichlet L-functions. Prove that for some δ > 0 and all α ∈ [1, 1+δ],
liminf_{T→∞} F(α,T) ≥ 3/2 − α + δ, or prove liminf_T ∫_1^{3/2} F(α,T) dα > 1/8 (the value forced by the GGOS bound).
Formalization notes: Montgomery's normalization: F(α,T) = (T/(2π) · log T)⁻¹ Σ_{0<γ,γ'≤T} T^{iα(γ−γ')} w(γ−γ'),
w(u) = 4/(4+u²), the sum over ordinates of zeros of ζ on the critical line counted with multiplicity; the sum is real
and equals the cosine form used here. Multiplicity of a zero ρ is the least k with ζ^{(k)}(ρ) ≠ 0 (`zetaOrder`;
it is 0 at non-zeros, so summing over all real γ with weight `mult` is a finite sum, written with `finsum`). Under
GRH (which includes RH via the trivial character mod 1) every nontrivial zero is of the form 1/2 + iγ, so this sum
runs over all nontrivial zeros. GRH is stated for all Dirichlet characters mod q ≥ 1 (Mathlib's `LFunction`, the
completed analytic continuation) in the open strip 0 < Re s < 1; imprimitive characters only add zeros on Re s = 0,
which are excluded. liminf statements are written with explicit ε, T₀. Claim is the implication GRH → (target 1 ∨
target 2), matching the "or" in the problem. Note: ¬Claim would require proving GRH, so only the positive direction
is realistic; this is inherent to a conditional problem.
-/
namespace OpenProblems.QEDM084

/-- The Generalized Riemann Hypothesis for all Dirichlet `L`-functions. -/
def GRH : Prop :=
  ∀ (q : ℕ) (χ : DirichletCharacter ℂ (q + 1)) (s : ℂ),
    DirichletCharacter.LFunction χ s = 0 → 0 < s.re → s.re < 1 → s.re = 1 / 2

/-- Order of vanishing of `ζ` at `s` (`0` if `ζ s ≠ 0`). -/
noncomputable def zetaOrder (s : ℂ) : ℕ := sInf {k : ℕ | iteratedDeriv k riemannZeta s ≠ 0}

/-- Multiplicity of `1/2 + iγ` as a zero of `ζ`, restricted to `0 < γ ≤ T`. -/
noncomputable def mult (T γ : ℝ) : ℝ :=
  if 0 < γ ∧ γ ≤ T then (zetaOrder ((1 / 2 : ℂ) + (γ : ℂ) * Complex.I) : ℝ) else 0

/-- Montgomery's weight. -/
noncomputable def w (u : ℝ) : ℝ := 4 / (4 + u ^ 2)

/-- Montgomery's pair-correlation function `F(α, T)`. -/
noncomputable def F (α T : ℝ) : ℝ :=
  (T / (2 * Real.pi) * Real.log T)⁻¹ *
    ∑ᶠ γ : ℝ, ∑ᶠ γ' : ℝ,
      mult T γ * mult T γ' * Real.cos (α * (γ - γ') * Real.log T) * w (γ - γ')

def Claim : Prop :=
  GRH →
    ((∃ δ : ℝ, 0 < δ ∧ ∀ α ∈ Set.Icc (1 : ℝ) (1 + δ), ∀ ε : ℝ, 0 < ε →
        ∃ T₀ : ℝ, ∀ T : ℝ, T₀ ≤ T → 3 / 2 - α + δ - ε ≤ F α T) ∨
     (∃ c : ℝ, 1 / 8 < c ∧ ∃ T₀ : ℝ, ∀ T : ℝ, T₀ ≤ T →
        c ≤ intervalIntegral (fun α : ℝ => F α T) 1 (3 / 2) MeasureTheory.volume))

end OpenProblems.QEDM084
