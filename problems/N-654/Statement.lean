import Mathlib
/-! N-654: Two-frequency localization
For the lattice Schrödinger operator on ℤ with potential λ(cos 2π(n√2+θ₁) + cos 2π(n√3+θ₂)), prove that for all large λ and almost every phase θ the operator has pure point spectrum with exponentially decaying eigenfunctions, for this specific frequency vector.
Informal statement: For $\lambda>0$ and $\theta\in\mathbb T^2$ let $(H_{\lambda,\theta}\psi)(n)=\psi(n+1)+\psi(n-1)+\lambda\big(\cos2\pi(n\sqrt2+\theta_1)+\cos2\pi(n\sqrt3+\theta_2)\big)\psi(n)$ on $\ell^2(\mathbb Z)$. Prove there is $\lambda_0$ such that for all $\lambda\ge\lambda_0$ and Lebesgue-a.e. $\theta$, $H_{\lambda,\theta}$ has pure point spectrum with exponentially decaying eigenfunctions (Anderson localization).
Formalization notes: Anderson localization (pure point spectrum with exponentially decaying eigenfunctions) is encoded as the existence of a real orthonormal basis of ℓ²(ℤ) consisting of exponentially decaying eigenfunctions; for a bounded self-adjoint operator, pure point spectrum is equivalent to the eigenvectors being complete. Real eigenfunctions suffice since H is a real symmetric operator. Any ONB of ℓ²(ℤ) is countably infinite, so ℕ-indexing loses nothing. Orthonormality uses tsum, legitimate because exponential decay makes the products summable; completeness is Parseval's identity. θ ranges over ℝ² with Lebesgue measure; the potential is ℤ²-periodic in θ, so a.e. on ℝ² is the same as a.e. on the torus. Proving ¬Claim means: for arbitrarily large λ a positive-measure set of phases fails localization.
-/
namespace OpenProblems.N654

/-- The quasi-periodic potential `λ (cos 2π(n√2 + θ₁) + cos 2π(n√3 + θ₂))`. -/
noncomputable def pot (lam : ℝ) (θ : ℝ × ℝ) (n : ℤ) : ℝ :=
  lam * (Real.cos (2 * Real.pi * ((n : ℝ) * Real.sqrt 2 + θ.1)) +
    Real.cos (2 * Real.pi * ((n : ℝ) * Real.sqrt 3 + θ.2)))

/-- `ψ` solves `H_{λ,θ} ψ = E ψ` pointwise. -/
def IsEigenfunction (lam : ℝ) (θ : ℝ × ℝ) (E : ℝ) (ψ : ℤ → ℝ) : Prop :=
  ∀ n : ℤ, ψ (n + 1) + ψ (n - 1) + pot lam θ n * ψ n = E * ψ n

/-- `ψ` decays exponentially. -/
def ExpDecaying (ψ : ℤ → ℝ) : Prop :=
  ∃ C c : ℝ, 0 < c ∧ ∀ n : ℤ, |ψ n| ≤ C * Real.exp (-(c * |(n : ℝ)|))

/-- Anderson localization: `ℓ²(ℤ)` has an orthonormal basis `(ψ k)` of exponentially decaying
eigenfunctions of `H_{λ,θ}` (orthonormality plus Parseval's identity for every `ℓ²` vector). -/
def AndersonLocalized (lam : ℝ) (θ : ℝ × ℝ) : Prop :=
  ∃ (ψ : ℕ → ℤ → ℝ) (E : ℕ → ℝ),
    (∀ k : ℕ, IsEigenfunction lam θ (E k) (ψ k) ∧ ExpDecaying (ψ k)) ∧
    (∀ k j : ℕ, ∑' n : ℤ, ψ k n * ψ j n = if k = j then (1 : ℝ) else 0) ∧
    (∀ φ : ℤ → ℝ, Summable (fun n : ℤ => φ n ^ 2) →
      HasSum (fun k : ℕ => (∑' n : ℤ, φ n * ψ k n) ^ 2) (∑' n : ℤ, φ n ^ 2))

/-- Large-coupling Anderson localization for a.e. phase, at the fixed frequency vector `(√2, √3)`. -/
def Claim : Prop :=
  ∃ lam₀ : ℝ, ∀ lam : ℝ, lam₀ ≤ lam →
    ∀ᶠ θ in MeasureTheory.ae (MeasureTheory.volume : MeasureTheory.Measure (ℝ × ℝ)),
      AndersonLocalized lam θ

end OpenProblems.N654
