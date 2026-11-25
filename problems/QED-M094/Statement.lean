import Mathlib
/-! QED-M094: Heat with a cosine reaction
For u_t = Δu + a(x)u^p with a periodic, mean-zero, not identically zero weight, the first-order reaction
averages out, but homogenization produces an effective +c·u^{2p−1} term, predicting the Fujita-type
threshold p* = 1 + 1/d. The test case u_t = u_xx + cos(2πx)u² is exactly critical.
Informal statement: Let d ≥ 1, a ∈ C^∞(ℝ^d) ℤ^d-periodic with ∫_{[0,1]^d} a = 0, a ≢ 0. Consider
u_t = Δu + a(x)u^p, u(·,0) = u₀ ∈ C_c(ℝ^d), u₀ ≥ 0, u₀ ≢ 0. Prove: (i) if 1 < p ≤ 1 + 1/d, every such
solution blows up in finite time; (ii) if p > 1 + 1/d, then for every such u₀ the solution with
initial data εu₀ is global for all sufficiently small ε > 0.
Formalization notes: A global solution is u : ℝ^d × ℝ → ℝ, C² on {t > 0}, continuous on {t ≥ 0},
nonnegative, bounded on every strip ℝ^d × [0,T], with u(x,0) = u₀(x) and u_t = Δu + a u^p pointwise
for t > 0 (partials via `fderiv`; `u^p` is `Real.rpow`, meaningful since u ≥ 0; nonnegativity holds for
the true solution by the comparison principle). By local well-posedness and uniqueness in the class
of solutions bounded on strips, "blows up in finite time" ⇔ "no global solution in this class".
For (ii), "sufficiently small u₀" is read profile-wise (data εu₀, ε small), the standard Fujita form.
Smoothness of a is `∀ n : ℕ, ContDiff ℝ n a`.
Proving `Claim` = both (i) and (ii) for all d, a, p. Proving `¬Claim` = a counterexample to either:
a global positive solution for some p ≤ 1 + 1/d, or a supercritical p and profile u₀ for which
arbitrarily small multiples blow up.
-/
namespace OpenProblems.QEDM094

/-- ℝ^d. -/
abbrev Rd (d : ℕ) : Type := Fin d → ℝ

/-- Spatial Laplacian of `u` at `z = (x,t)`. -/
noncomputable def lap {d : ℕ} (u : Rd d × ℝ → ℝ) (z : Rd d × ℝ) : ℝ :=
  ∑ i : Fin d,
    fderiv ℝ (fun y : Rd d × ℝ => fderiv ℝ u y ((Pi.single i (1 : ℝ) : Rd d), (0 : ℝ))) z
      ((Pi.single i (1 : ℝ) : Rd d), (0 : ℝ))

/-- Time derivative of `u` at `z`. -/
noncomputable def dt {d : ℕ} (u : Rd d × ℝ → ℝ) (z : Rd d × ℝ) : ℝ :=
  fderiv ℝ u z ((0 : Rd d), (1 : ℝ))

/-- Admissible weight: smooth, ℤ^d-periodic, mean zero, not identically zero. -/
def AdmissibleWeight (d : ℕ) (a : Rd d → ℝ) : Prop :=
  (∀ n : ℕ, ContDiff ℝ n a) ∧
  (∀ (x : Rd d) (i : Fin d), a (x + Pi.single i (1 : ℝ)) = a x) ∧
  (∫ x in Set.Icc (0 : Rd d) 1, a x) = 0 ∧
  (∃ x, a x ≠ 0)

/-- Admissible initial datum: continuous, compactly supported, nonnegative, not identically zero. -/
def AdmissibleDatum (d : ℕ) (u₀ : Rd d → ℝ) : Prop :=
  Continuous u₀ ∧ HasCompactSupport u₀ ∧ (∀ x, 0 ≤ u₀ x) ∧ (∃ x, u₀ x ≠ 0)

/-- `u` is a global (bounded on strips) classical nonnegative solution. -/
def IsGlobalSolution (d : ℕ) (a : Rd d → ℝ) (p : ℝ) (u₀ : Rd d → ℝ) (u : Rd d × ℝ → ℝ) : Prop :=
  ContDiffOn ℝ 2 u {z | 0 < z.2} ∧
  ContinuousOn u {z | 0 ≤ z.2} ∧
  (∀ x, u (x, 0) = u₀ x) ∧
  (∀ z : Rd d × ℝ, 0 ≤ z.2 → 0 ≤ u z) ∧
  (∀ T : ℝ, ∃ M : ℝ, ∀ z : Rd d × ℝ, 0 ≤ z.2 → z.2 ≤ T → |u z| ≤ M) ∧
  (∀ z : Rd d × ℝ, 0 < z.2 → dt u z = lap u z + a z.1 * u z ^ p)

def Claim : Prop :=
  ∀ d : ℕ, 1 ≤ d → ∀ a : Rd d → ℝ, AdmissibleWeight d a → ∀ p : ℝ, 1 < p →
    (p ≤ 1 + 1 / (d : ℝ) →
      ∀ u₀ : Rd d → ℝ, AdmissibleDatum d u₀ → ∀ u : Rd d × ℝ → ℝ, ¬ IsGlobalSolution d a p u₀ u) ∧
    (1 + 1 / (d : ℝ) < p →
      ∀ u₀ : Rd d → ℝ, AdmissibleDatum d u₀ → ∃ ε₀ : ℝ, 0 < ε₀ ∧ ∀ ε : ℝ, 0 < ε → ε < ε₀ →
        ∃ u : Rd d × ℝ → ℝ, IsGlobalSolution d a p (fun x => ε * u₀ x) u)

end OpenProblems.QEDM094
