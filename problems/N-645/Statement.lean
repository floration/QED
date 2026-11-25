import Mathlib
/-! N-645: Quintic Szego growth
STATUS: NOT YET FORMALIZED
The cubic Szegő equation on the circle is completely integrable, and Gérard–Grellier showed that its smooth solutions can have Sobolev norms that are unbounded in time. Decide whether the quintic Szegő equation, presumably not integrable, also has smooth solutions with unbounded high Sobolev norms.
Informal statement: On L²_+(𝕋) = {u ∈ L² : û(k) = 0 ∀ k < 0} with Szegő projector Π, consider i∂_t u = Π(|u|⁴u), globally well posed in H^s_+, s > 1/2, with conserved ‖u‖_{L²}, (Du,u) and ‖u‖_{L⁶}. Decide whether there exist u₀ ∈ C^∞(𝕋) ∩ L²_+ and s > 1/2 with limsup_{t→∞} ‖u(t)‖_{H^s} = ∞.
Formalization notes: Intended Claim: ∃ u₀ smooth with nonnegative Fourier support, ∃ s > 1/2, the global solution has limsup ‖u(t)‖_{H^s} = ∞. Missing pieces: the global H^s_+ solution map of the quintic Szegő flow (well-posedness theory on Sobolev spaces of the circle, the Szegő projector on L²(𝕋), uniqueness so that 'the solution' is defined). One could write the equation as an infinite ODE system on Fourier coefficients, but without the well-posedness theorem the ∃/∀ choice over solution curves would change the meaning; building it is far beyond reasonable effort.
-/
namespace OpenProblems.N645
def Claim : Prop := sorry
end OpenProblems.N645
