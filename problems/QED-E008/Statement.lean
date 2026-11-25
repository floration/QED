import Mathlib
/-! QED-E008: Two vortices on a cube
Two identical point vortices moving on the surface of a cube form a two-degree-of-freedom
Hamiltonian system with no continuous symmetry. Prove their motion is genuinely chaotic.

Informal statement: Let S be the boundary of the unit cube with its flat cone metric (eight cone
points of angle 3π/2), area A = 6, G its Green function (-Δ_z G(z,w) = δ_w - 1/A, mean zero),
R(z) = lim_{w→z}[G(z,w) + (1/2π) log d(z,w)] its Robin function, and
H = G(z₁,z₂) + ½(R(z₁)+R(z₂)) on M = {z₁ ≠ z₂, z_j not a vertex} with ω = dA(z₁) + dA(z₂).
Prove that the Hamiltonian flow has a compact invariant set, inside one energy level, on which its
topological entropy is positive.

Formalization notes (conformal model):
* S is conformally the round unit sphere S² ⊂ ℝ³ with the 8 vertices at v = (±1,±1,±1)/√3
  (the cube's rotation group acts conformally, hence after a Möbius change as the standard
  octahedral group, and the vertices form its 8-point orbit). By Troyanov's uniqueness of flat cone
  metrics, the cube metric is g = λ σ g_round with σ(p) = ∏_v |p - v|^{-1/2} (cone angle 3π/2 ↔
  exponent -1/4 in the plane chart; the chordal conversion gives exactly this product).
* Then G(p,q) = -(1/2π) log|p-q| + Ψ(p) + Ψ(q) + const, Ψ(p) = (1/2πA) ∫ log|p-ζ| dA_g(ζ),
  R(p) = 2Ψ(p) + (1/4π) log σ(p) + const, so up to an additive constant
  H = -(1/2π) log|p₁-p₂| + 2Ψ(p₁) + 2Ψ(p₂) + (1/8π) log(σ(p₁)σ(p₂)).
* Normalisations: Ψ is written as a ratio of integrals, so the scale of the sphere measure
  (`volume.toSphere`, a multiple of area) and λ drop out; λ only rescales time (entropy of the
  time-1 map scales by a positive factor), and additive constants in H do not matter.
* The vector field is written explicitly, X_j = σ(p_j)⁻¹ (∇_{p_j} H) × p_j (ambient gradient of
  the extension to ℝ³; only its tangential part enters), with gradients computed termwise
  (differentiation under the integral for Ψ), avoiding `fderiv` junk values. The sign convention
  (X vs -X) is irrelevant for positivity of entropy.
* The flow on K is the time-1 map T together with genuine trajectories through every point of K
  staying in K for all real time (so K is invariant; the field is smooth on M, so trajectories are
  unique and T is the time-1 flow map). Entropy is Mathlib's `Dynamics.coverEntropy T K`.
-/
namespace OpenProblems.QEDE008
noncomputable section
open MeasureTheory Real

abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- The unit sphere. -/
def S2 : Set E3 := Metric.sphere 0 1

/-- The eight cube vertices `(±1, ±1, ±1)/√3` on the unit sphere. -/
def vert (ε : Fin 3 → Bool) : E3 :=
  WithLp.toLp 2 (fun i => if ε i then 1 / Real.sqrt 3 else -(1 / Real.sqrt 3))

def IsVertex (p : E3) : Prop := ∃ ε : Fin 3 → Bool, p = vert ε

/-- Conformal density of the cube metric w.r.t. the round metric (up to a constant factor). -/
def dens (p : E3) : ℝ := ∏ ε : Fin 3 → Bool, ‖p - vert ε‖ ^ (-(1 / 2 : ℝ))

/-- A positive multiple of the round area measure on the unit sphere. -/
def μS : Measure (Metric.sphere (0 : E3) 1) := (volume : Measure E3).toSphere

/-- Total cube-area (up to the same constant factor). -/
def mass : ℝ := ∫ ζ, dens (ζ : E3) ∂μS

/-- `Ψ(p) = (1/(2π A)) ∫ log |p - ζ| dA_g(ζ)`. -/
def Ψ (p : E3) : ℝ := (∫ ζ, Real.log ‖p - (ζ : E3)‖ * dens (ζ : E3) ∂μS) / (2 * π * mass)

/-- Ambient gradient of `Ψ`. -/
def gradΨ (p : E3) : E3 :=
  (1 / (2 * π * mass)) • ∫ ζ, (dens (ζ : E3) / ‖p - (ζ : E3)‖ ^ 2) • (p - (ζ : E3)) ∂μS

/-- The two-vortex Hamiltonian (up to an additive constant). -/
def H (p₁ p₂ : E3) : ℝ :=
  -(1 / (2 * π)) * Real.log ‖p₁ - p₂‖ + 2 * Ψ p₁ + 2 * Ψ p₂
    + (1 / (8 * π)) * (Real.log (dens p₁) + Real.log (dens p₂))

/-- Ambient gradient of `H` in its first argument. -/
def gradH₁ (p₁ p₂ : E3) : E3 :=
  (-(1 / (2 * π)) / ‖p₁ - p₂‖ ^ 2) • (p₁ - p₂) + (2 : ℝ) • gradΨ p₁
    - (1 / (16 * π)) • ∑ ε : Fin 3 → Bool, (1 / ‖p₁ - vert ε‖ ^ 2) • (p₁ - vert ε)

/-- Cross product on `ℝ³`. -/
def cross (a b : E3) : E3 :=
  WithLp.toLp 2 ![a 1 * b 2 - a 2 * b 1, a 2 * b 0 - a 0 * b 2, a 0 * b 1 - a 1 * b 0]

/-- Hamiltonian vector field for `ω = σ dA(p₁) + σ dA(p₂)`. -/
def vf (q : E3 × E3) : E3 × E3 :=
  ((dens q.1)⁻¹ • cross (gradH₁ q.1 q.2) q.1, (dens q.2)⁻¹ • cross (gradH₁ q.2 q.1) q.2)

/-- Phase space: distinct non-vertex positions on the sphere. -/
def Mset : Set (E3 × E3) :=
  {q | q.1 ∈ S2 ∧ q.2 ∈ S2 ∧ q.1 ≠ q.2 ∧ ¬ IsVertex q.1 ∧ ¬ IsVertex q.2}

/-- There is a nonempty compact flow-invariant set inside one energy level on which the time-1
map of the two-vortex flow has positive topological entropy. -/
def Claim : Prop :=
  ∃ K : Set (E3 × E3), K.Nonempty ∧ IsCompact K ∧ K ⊆ Mset ∧
    (∃ E : ℝ, ∀ q ∈ K, H q.1 q.2 = E) ∧
    ∃ T : E3 × E3 → E3 × E3, Set.MapsTo T K K ∧
      (∀ q ∈ K, ∃ γ : ℝ → E3 × E3, γ 0 = q ∧ γ 1 = T q ∧
        ∀ t : ℝ, γ t ∈ K ∧ HasDerivAt γ (vf (γ t)) t) ∧
      0 < Dynamics.coverEntropy T K

end
end OpenProblems.QEDE008
