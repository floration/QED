import Mathlib
/-! QED-M097: Mass-critical scattering on flat cones
STATUS: NOT YET FORMALIZED
Dodson proved that the defocusing cubic NLS in the plane scatters for every finite-mass initial
datum. Prove the same on every flat cone (a plane with one conical singularity of total angle α).
Informal statement: For α > 0 let C_α = (0,∞) × (ℝ/αℤ) with metric dr² + r²dθ² and Δ the Friedrichs
extension of the Laplacian on C_c^∞(C_α). Prove that for every α > 0 and every u₀ ∈ L²(C_α) the
solution of iu_t + Δu = |u|²u, u(0) = u₀, is global with ‖u‖_{L⁴_{t,x}(ℝ × C_α)} < ∞, hence scatters in L².
(Known: α = 2π/k, and radial data for any α.)
Formalization notes: Not formalized. Missing pieces: (1) the Friedrichs extension of a symmetric
semibounded operator on a Hilbert space (here L²(C_α, r dr dθ)), or equivalently the Hankel/Bessel
spectral resolution of the cone Laplacian; (2) the unitary group e^{itΔ} on L² (Stone's theorem for
unbounded self-adjoint operators); (3) the notion of L²-strong (Duhamel/mild) solution of the cubic
NLS in C(ℝ; L²) ∩ L⁴_{loc}L⁴, its uniqueness class and maximal lifespan; (4) mixed space-time
Lebesgue norms on ℝ × C_α. Classical smooth solutions would not capture arbitrary L² data, and
restricting to smooth data would change the problem. A faithful statement therefore needs several
hundred lines of operator theory not in Mathlib.
-/
namespace OpenProblems.QEDM097

def Claim : Prop := sorry

end OpenProblems.QEDM097
