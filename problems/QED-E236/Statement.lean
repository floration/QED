import Mathlib
/-! QED-E236: Ballistic transport for the Thue–Morse quantum walk
A quantum walker on the integers flips one of two rotation coins at each site, chosen by the
Thue–Morse sequence. Previous work shows its spread is at least close to linear in time on average.
Decide whether it actually spreads linearly in time (ballistically).
Informal statement: For γ ∈ (0,π/2) let R_γ = [[cos γ, −sin γ],[sin γ, cos γ]]. Let x ∈ {0,1}^ℤ be
the two-sided Thue–Morse sequence x_n = t_n (n ≥ 0), x_n = t_{−n−1} (n < 0), t_n = s₂(n) mod 2.
On ℓ²(ℤ) ⊗ ℂ² let U = SC, (Cψ)(n) = R_{γ_{x_n}} ψ(n) with fixed γ₀ ≠ γ₁ in (0,π/2), and S shifting
the first component by +1 and the second by −1. For ψ₀ = δ₀ ⊗ e₁ let
β̃⁺ = limsup_{T→∞} log((1/T) Σ_{t<T} Σ_n |n|² ‖(U^tψ₀)(n)‖²) / (2 log T). It is known that
β̃⁺ ≥ 1/2. Decide whether β̃⁺ = 1.
Formalization notes: States are functions ℤ → ℂ² (`Fin 2 → ℂ`, component 0 = e₁); U^tψ₀ is
computed by iterating the explicit one-step map, which is the restriction of the unitary U to
finitely supported vectors (ψ₀ is finitely supported and U moves support by at most 1, so U^tψ₀ is
supported in [−t,t]). Concretely (Uψ)(n) = ((Cψ)(n−1)₀, (Cψ)(n+1)₁). The second moment uses `tsum`
over ℤ of finitely many nonzero nonnegative terms (summable, so no junk). t_n is the binary digit
sum mod 2 (`Nat.digits 2`). Since U^tψ₀ is supported in [−t,t] and has norm 1, the averaged
moment A(T) ≤ T², so β̃⁺ ≤ 1 automatically, and β̃⁺ = 1 is equivalent to: for every ε > 0,
A(T) ≥ T^{2−ε} for infinitely many T. `Claim` is stated in this form to avoid `Filter.limsup` junk
values. Quantifiers: `Claim` asserts ballistic transport for every pair γ₀ ≠ γ₁ in (0,π/2);
`¬Claim` = some such pair has β̃⁺ < 1 (if the answer depends on (γ₀,γ₁), the board answer is ¬Claim
together with the description of the pairs).
-/
namespace OpenProblems.QEDE236
noncomputable section

/-- One-sided Thue–Morse sequence `t_n = s₂(n) mod 2`. -/
def tm (n : ℕ) : ℕ := (Nat.digits 2 n).sum % 2

/-- Two-sided Thue–Morse sequence: `x_n = t_n` for `n ≥ 0`, `x_n = t_{−n−1}` for `n < 0`. -/
def tmZ (n : ℤ) : ℕ := if 0 ≤ n then tm n.toNat else tm (-n - 1).toNat

/-- Walk states: `ℤ → ℂ²`. -/
abbrev State : Type := ℤ → Fin 2 → ℂ

/-- Coin operator `(Cψ)(n) = R_{γ_{x_n}} ψ(n)`. -/
def coin (g₀ g₁ : ℝ) (ψ : State) : State := fun n =>
  let γ : ℝ := if tmZ n = 0 then g₀ else g₁
  fun i => if i = 0 then (Real.cos γ : ℂ) * ψ n 0 - (Real.sin γ : ℂ) * ψ n 1
    else (Real.sin γ : ℂ) * ψ n 0 + (Real.cos γ : ℂ) * ψ n 1

/-- Conditional shift: first component moves to `n + 1`, second to `n − 1`. -/
def shift (ψ : State) : State := fun n =>
  fun i => if i = 0 then ψ (n - 1) 0 else ψ (n + 1) 1

/-- One step `U = S C`. -/
def step (g₀ g₁ : ℝ) (ψ : State) : State := shift (coin g₀ g₁ ψ)

/-- Initial state `δ₀ ⊗ e₁`. -/
def psi0 : State := fun n i => if n = 0 ∧ i = 0 then 1 else 0

/-- `U^t ψ₀`. -/
def evol (g₀ g₁ : ℝ) (t : ℕ) : State := (step g₀ g₁)^[t] psi0

/-- Second moment `Σ_n |n|² ‖(U^tψ₀)(n)‖²`. -/
def moment (g₀ g₁ : ℝ) (t : ℕ) : ℝ :=
  ∑' n : ℤ, ((n : ℝ) ^ 2) *
    (Complex.normSq (evol g₀ g₁ t n 0) + Complex.normSq (evol g₀ g₁ t n 1))

/-- Time-averaged second moment `(1/T) Σ_{t<T} moment t`. -/
def avgMoment (g₀ g₁ : ℝ) (T : ℕ) : ℝ :=
  (1 / (T : ℝ)) * ∑ t ∈ Finset.range T, moment g₀ g₁ t

/-- Ballistic transport `β̃⁺ = 1` for every pair of distinct coin angles in `(0, π/2)`. -/
def Claim : Prop :=
  ∀ g₀ g₁ : ℝ, 0 < g₀ → g₀ < Real.pi / 2 → 0 < g₁ → g₁ < Real.pi / 2 → g₀ ≠ g₁ →
    ∀ ε : ℝ, 0 < ε → ∀ N : ℕ, ∃ T : ℕ, N ≤ T ∧
      (T : ℝ) ^ ((2 : ℝ) - ε) ≤ avgMoment g₀ g₁ T

end
end OpenProblems.QEDE236
