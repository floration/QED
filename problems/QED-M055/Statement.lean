import Mathlib
/-! QED-M055: Three identical vortices on a square torus are chaotic
On a flat torus, three point vortices with total circulation zero form an integrable system
(Stremler–Aref), but for vortices of equal strength even three are believed chaotic, from numerics
only. Prove that three identical point vortices on the square torus are not integrable; the same
question is open for four.
Informal statement: Let G be the Green function of 𝕋 = ℂ/(ℤ + iℤ) (ΔG = δ₀ − 1) and
H = −Σ_{i<j} G(z_i − z_j) on {(z_1,…,z_N) ∈ 𝕋^N : z_i ≠ z_j} with symplectic form Σ dx_i ∧ dy_i.
The centre Z = Σ z_i ∈ 𝕋 is conserved; the reduced space M_N = {Z = Z_0}/((1/N)ℤ[i]/ℤ[i]) is
symplectic of dimension 2N − 2. Prove that for N = 3 the reduced flow on M_3 has no real-analytic
first integral functionally independent of H. (`Claim` is the N = 3 statement; the N = 4 analogue
is the separate proposition `ClaimN4`.)
Formalization notes:
* Green function. Instead of a theta-function formula we characterise G: `IsTorusGreen G` says
  G : ℂ → ℝ is ℤ[i]-periodic, real-analytic off the lattice, has Laplacian −1 off the lattice, and
  G(z) − (1/2π) log|z| is bounded on a punctured disc at 0. This is exactly ΔG = δ₀ − 1 on 𝕋
  (the log term carries the unit point mass), and it determines G up to an additive constant:
  the difference of two such functions is periodic, harmonic off the lattice and bounded near it,
  hence (removable singularities) a bounded entire harmonic function, i.e. a constant. Constants
  do not change H's flow or its integrals, so `∀ G, IsTorusGreen G → …` is the statement for
  the true G. To rule out vacuity, `Claim` also asserts `∃ G, IsTorusGreen G` (true: G(z) =
  (1/2π) log|θ₁(πz | i)| − (Im z)²/2, a standard fact, not the open part).
* Lifted model of M_N. Configurations are z ∈ ℂ^N (`Fin N → ℂ`), the collision-free set is
  {z_i − z_j ∉ ℤ[i] for i ≠ j}. Real-analytic functions on M_N correspond bijectively to
  real-analytic functions I on the collision-free subset of ℂ^N that are ℤ[i]-periodic in each
  z_i separately and invariant under the diagonal translations z ↦ z + (c,…,c), c ∈ ℂ: indeed
  every configuration on 𝕋^N can be translated into {Z = Z_0}, uniquely up to the stabiliser
  (1/N)ℤ[i]/ℤ[i], so M_N ≅ (𝕋^N ∖ Δ)/𝕋 (free action). For such I the canonical Hamiltonian
  vector field is tangent to the levels {Z = const} (since Σᵢ ∂I/∂xᵢ = Σᵢ ∂I/∂yᵢ = 0), the
  levels are symplectic submanifolds, and the reduced Poisson bracket of I and H equals the
  ambient one {I,H} = Σᵢ (∂_{xᵢ}I ∂_{yᵢ}H − ∂_{yᵢ}I ∂_{xᵢ}H). Hence "I is a first integral of the
  reduced flow" ⇔ {I,H} = 0 on the collision-free set. Partial derivatives are real Fréchet
  derivatives in the directions eᵢ and i·eᵢ.
* Functional independence: dI and dH linearly independent at some point (for analytic
  functions on the connected manifold M_N this is the same as independence on an open dense
  set). Translation-invariant functions have differentials vanishing on the diagonal
  directions, so independence in ℂ^N equals independence on M_N.
* The overall sign/normalisation of H (circulation, factor 2π) only rescales or reverses time
  and does not affect integrability.
* Proving `Claim` = no extra real-analytic integral for N = 3 (non-integrability).
  Proving `¬Claim` = such an integral exists (Liouville integrability on the 4-dimensional M_3).
-/
namespace OpenProblems.QEDM055
noncomputable section

/-- The Gaussian integer lattice `ℤ + iℤ`. -/
def lattice : Set ℂ := {w : ℂ | ∃ m n : ℤ, w = (m : ℂ) + (n : ℂ) * Complex.I}

/-- Second directional derivative of `G` at `z` in the real direction `w`. -/
def d2 (G : ℂ → ℝ) (z w : ℂ) : ℝ :=
  deriv (fun s : ℝ => deriv (fun r : ℝ => G (z + (r : ℂ) * w)) s) 0

/-- Laplacian `∂²ₓG + ∂²_yG`. -/
def lapC (G : ℂ → ℝ) (z : ℂ) : ℝ := d2 G z 1 + d2 G z Complex.I

/-- `G` is the Green function of the square torus: `ΔG = δ₀ − 1`, up to an additive constant. -/
def IsTorusGreen (G : ℂ → ℝ) : Prop :=
  (∀ z : ℂ, G (z + 1) = G z ∧ G (z + Complex.I) = G z) ∧
  (∀ z : ℂ, z ∉ lattice → AnalyticAt ℝ G z) ∧
  (∀ z : ℂ, z ∉ lattice → lapC G z = -1) ∧
  (∃ C r : ℝ, 0 < r ∧ ∀ z : ℂ, z ≠ 0 → ‖z‖ < r →
      |G z - Real.log ‖z‖ / (2 * Real.pi)| ≤ C)

/-- Collision-free configurations of `N` vortices (lifted to `ℂ^N`). -/
def collisionFree (N : ℕ) : Set (Fin N → ℂ) :=
  {z : Fin N → ℂ | ∀ i j : Fin N, i ≠ j → z i - z j ∉ lattice}

/-- The vortex Hamiltonian `H = −Σ_{i<j} G(zᵢ − zⱼ)` (identical unit circulations). -/
def ham (G : ℂ → ℝ) (N : ℕ) (z : Fin N → ℂ) : ℝ :=
  -∑ i : Fin N, ∑ j : Fin N, if i < j then G (z i - z j) else 0

/-- `∂F/∂xᵢ`. -/
def px {N : ℕ} (F : (Fin N → ℂ) → ℝ) (i : Fin N) (z : Fin N → ℂ) : ℝ :=
  fderiv ℝ F z (Pi.single i (1 : ℂ))

/-- `∂F/∂yᵢ`. -/
def py {N : ℕ} (F : (Fin N → ℂ) → ℝ) (i : Fin N) (z : Fin N → ℂ) : ℝ :=
  fderiv ℝ F z (Pi.single i Complex.I)

/-- Canonical Poisson bracket for `Σ dxᵢ ∧ dyᵢ`. -/
def poisson {N : ℕ} (F K : (Fin N → ℂ) → ℝ) (z : Fin N → ℂ) : ℝ :=
  ∑ i : Fin N, (px F i z * py K i z - py F i z * px K i z)

/-- `I` is a real-analytic first integral of the reduced flow on `M_N`, functionally
independent of `H`. -/
def IsExtraIntegral (G : ℂ → ℝ) (N : ℕ) (I : (Fin N → ℂ) → ℝ) : Prop :=
  (∀ z ∈ collisionFree N, AnalyticAt ℝ I z) ∧
  (∀ z ∈ collisionFree N, ∀ i : Fin N,
      I (z + Pi.single i (1 : ℂ)) = I z ∧ I (z + Pi.single i Complex.I) = I z) ∧
  (∀ z ∈ collisionFree N, ∀ c : ℂ, I (z + fun _ => c) = I z) ∧
  (∀ z ∈ collisionFree N, poisson I (ham G N) z = 0) ∧
  (∃ z ∈ collisionFree N, ∀ a b : ℝ,
      a • fderiv ℝ I z + b • fderiv ℝ (ham G N) z = 0 → a = 0 ∧ b = 0)

/-- No extra analytic first integral for `N` identical vortices. -/
def NoExtraIntegral (G : ℂ → ℝ) (N : ℕ) : Prop := ¬ ∃ I : (Fin N → ℂ) → ℝ, IsExtraIntegral G N I

/-- Three identical vortices on the square torus are non-integrable. -/
def Claim : Prop :=
  (∃ G : ℂ → ℝ, IsTorusGreen G) ∧ ∀ G : ℂ → ℝ, IsTorusGreen G → NoExtraIntegral G 3

/-- Secondary target (not part of `Claim`): the same for four identical vortices. -/
def ClaimN4 : Prop :=
  (∃ G : ℂ → ℝ, IsTorusGreen G) ∧ ∀ G : ℂ → ℝ, IsTorusGreen G → NoExtraIntegral G 4

end
end OpenProblems.QEDM055
