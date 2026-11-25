import Mathlib
/-! QED-M092: Forced blow-up up to the Lions threshold
STATUS: NOT YET FORMALIZED
With an ordinary Laplacian, a smooth compactly supported force can make a fluid at rest blow up in finite time (2026). With dissipation (−Δ)^α, α ≥ 5/4, solutions stay smooth (Lions). Does forced blow-up from rest still happen for every α strictly between 1 and 5/4?
Informal statement: For α ∈ (1,5/4) consider ∂_t u + (u·∇)u + ∇p = −(−Δ)^α u + f, ∇·u = 0 on ℝ³, u(·,0) = 0. Determine the set of α ∈ (1,5/4) for which there is f ∈ C_c^∞(ℝ³ × (0,∞); ℝ³) whose unique smooth solution satisfies limsup_{t↑T} ‖u(t)‖_{L^∞} = ∞ for some T < ∞. In particular: is it all of (1,5/4)? Is it nonempty?
Formalization notes: Intended Claim: ∀ α ∈ (1,5/4), ∃ f ∈ C_c^∞(ℝ³×(0,∞);ℝ³) such that the smooth solution from rest has ‖u(t)‖_∞ unbounded as t ↑ T for some finite T. Missing pieces: the fractional Laplacian (−Δ)^α on vector fields on ℝ³ (Fourier multiplier on Schwartz/Sobolev spaces), the Leray projection / pressure, and a notion of the unique smooth (mild or classical) solution on its maximal interval with local well-posedness so that 'the solution blows up' is meaningful; none of this exists in Mathlib and a faithful encoding needs hundreds of lines.
-/
namespace OpenProblems.QEDM092
def Claim : Prop := sorry
end OpenProblems.QEDM092
