import Mathlib
/-! QED-M044: Chaos in the double pendulum at every energy
The planar double pendulum with equal masses and arms looks chaotic at moderate energies but almost
regular at very low and very high energies. Prove that it has positive topological entropy on every
energy level above the hanging rest state.
Informal statement: Let H(θ₁,θ₂,p₁,p₂) be the Hamiltonian of the planar double pendulum with
m₁ = m₂ = ℓ₁ = ℓ₂ = g = 1 on T*T², with minimum value E₀ = -3 (the hanging rest state). Prove that for
every E > E₀ the Hamiltonian flow restricted to {H = E} has positive topological entropy.
Formalization notes: State z = (θ₁, θ₂, p₁, p₂) ∈ ℝ⁴ (angles lifted to ℝ), with
H = (p₁² + 2p₂² − 2p₁p₂ cos(θ₁−θ₂)) / (2(1 + sin²(θ₁−θ₂))) − 2cos θ₁ − cos θ₂.
Hamilton's equations: θ̇ = ∂H/∂p, ṗ = −∂H/∂θ (partials via `fderiv`). Since we do not construct the
flow, Claim quantifies over every φ satisfying φ 0 = id and the ODE for every initial point; such a φ
exists and is unique (H is smooth and energy levels are compact in T*T²), so this is not vacuous.
Distance: `dist4` uses the chordal metric |sin((θ−θ')/2)| on angles (a genuine metric on the circle)
plus |Δp|; it is compatible with the topology of the compact level set in T*T², so it computes the
topological entropy. Lifts differing by 2π in an angle are never separated (flow is 2π-equivariant),
so separated sets count torus points. Bowen's definition: h_top > 0 iff ∃ ε > 0 such that the maximal
cardinality of (T,ε)-separated subsets of the level set grows like e^{cT} along a sequence T → ∞;
continuous-time separation over [0,T] gives the same entropy as the time-one map.
Proving `Claim` = positive entropy on every level E > −3. Proving `¬Claim` = some E > −3 has zero
topological entropy.
-/
namespace OpenProblems.QEDM044

/-- Phase-space point `(θ₁, θ₂, p₁, p₂)`. -/
abbrev State : Type := Fin 4 → ℝ

/-- Double pendulum Hamiltonian with all parameters equal to one. -/
noncomputable def H (z : State) : ℝ :=
  (z 2 ^ 2 + 2 * z 3 ^ 2 - 2 * z 2 * z 3 * Real.cos (z 0 - z 1)) /
      (2 * (1 + Real.sin (z 0 - z 1) ^ 2))
    - 2 * Real.cos (z 0) - Real.cos (z 1)

/-- Partial derivative of `H` in coordinate `i`. -/
noncomputable def pd (i : Fin 4) (z : State) : ℝ := fderiv ℝ H z (Pi.single i (1 : ℝ))

/-- Hamiltonian vector field. -/
noncomputable def V (z : State) : State := ![pd 2 z, pd 3 z, -pd 0 z, -pd 1 z]

/-- A metric on T*T² written on lifts (chordal on angles). -/
noncomputable def dist4 (z w : State) : ℝ :=
  |Real.sin ((z 0 - w 0) / 2)| + |Real.sin ((z 1 - w 1) / 2)| + |z 2 - w 2| + |z 3 - w 3|

/-- `φ` is the Hamiltonian flow of `H`. -/
def IsHamFlow (φ : ℝ → State → State) : Prop :=
  (∀ z, φ 0 z = z) ∧ ∀ (z : State) (t : ℝ), HasDerivAt (fun s => φ s z) (V (φ t z)) t

def Claim : Prop :=
  ∀ E : ℝ, -3 < E → ∀ φ : ℝ → State → State, IsHamFlow φ →
    ∃ ε : ℝ, 0 < ε ∧ ∃ c : ℝ, 0 < c ∧ ∀ T₀ : ℝ, ∃ T : ℝ, T₀ ≤ T ∧
      ∃ S : Finset State, (∀ z ∈ S, H z = E) ∧ Real.exp (c * T) ≤ (S.card : ℝ) ∧
        ∀ z ∈ S, ∀ w ∈ S, z ≠ w → ∃ t ∈ Set.Icc (0 : ℝ) T, ε ≤ dist4 (φ t z) (φ t w)

end OpenProblems.QEDM044
