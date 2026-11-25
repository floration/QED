import Mathlib
/-! QED-M089: Derivative loss in L4 Strichartz on the cube surface
STATUS: NOT YET FORMALIZED
On the flat torus the L⁴ space-time Schrödinger estimate loses only ε derivatives (Bourgain). On the surface of a cube, which has eight cone points that diffract waves, only a loss of 1/4 derivative is known. Prove any loss below 1/4, or show some loss is necessary.
Informal statement: Let S be the unit cube surface, Δ the Friedrichs extension from C_c^∞(S \ vertices), and s* = inf{s ≥ 0 : ‖e^{itΔ}f‖_{L⁴([0,1]×S)} ≤ C_s‖f‖_{H^s(S)}}. Known: 0 ≤ s* ≤ 1/4 (Blair–Ford–Marzuola). Prove s* < 1/4, or s* > 0; ideally determine s* (conjecturally 0).
Formalization notes: Intended Claim: s* < 1/4, i.e. ∃ s < 1/4, ∃ C, ∀ f, ‖e^{itΔ}f‖_{L⁴([0,1]×S)} ≤ C‖f‖_{H^s}. Missing pieces: the cube surface as a flat cone manifold with its measure, the Friedrichs extension of the Laplacian there (unbounded self-adjoint operators and form extensions are not in Mathlib), the unitary group e^{itΔ} via functional calculus, and H^s(S) defined spectrally. An eigenfunction-expansion encoding would require proving discreteness of the spectrum and identifying the singular eigenfunctions, so it is not a reasonable-effort faithful statement.
-/
namespace OpenProblems.QEDM089
def Claim : Prop := sorry
end OpenProblems.QEDM089
