import Mathlib
/-! QED-E088: Integrability of the egg-crate torus
Put the surface z = ε sin x sin y over the flat square torus ℝ²/(2πℤ)². Show that its geodesic
flow is never integrable (no extra real-analytic first integral), however small ε > 0 is.
Informal statement: For ε > 0 let g_ε be the metric on 𝕋² = ℝ²/(2πℤ)² induced from the graph
z = ε sin x sin y, i.e. g_ε = dx² + dy² + ε²(cos x sin y dx + sin x cos y dy)². Prove that for
every ε > 0 the geodesic flow on T*𝕋² \ 0 has no real-analytic first integral functionally
independent of the Hamiltonian.
Formalization notes: Phase-space points are `q : Fin 4 → ℝ` with q 0 = x, q 1 = y, q 2 = p_x,
q 3 = p_y. With w = (cos x sin y, sin x cos y), g_ε = I + ε² w wᵀ, so
g_ε⁻¹ = I − ε² w wᵀ / (1 + ε²|w|²) and the geodesic Hamiltonian is
H_ε = ½ (p_x² + p_y² − ε² (w·p)² / (1 + ε²|w|²)) (`ham`). T*𝕋² \ 0 is modelled by the open set
`U = {p ≠ 0}` in ℝ⁴ together with 2π-periodicity of F in x and y. `pd F i q` is the partial
derivative ∂F/∂q_i (Fréchet derivative applied to the i-th basis vector) and `poisson` is the
canonical Poisson bracket Σ (∂F/∂x_k ∂G/∂p_k − ∂F/∂p_k ∂G/∂x_k). An additional first integral is
an F that is real-analytic on U (`AnalyticOnNhd`), 2π-periodic in x and y, Poisson-commutes with
H_ε on U, and is functionally independent of H_ε, i.e. dF ∧ dH_ε ≠ 0 at some point of U (for
real-analytic F on the connected set U this is equivalent to independence on an open dense set).
Proving `Claim` means: for every ε > 0 no such F exists (non-integrability; positive topological
entropy would suffice by Paternain/Taimanov). Proving `¬Claim` means exhibiting some ε > 0 and
such an integral. Kozlov's theorem already excludes integrals analytic in ε.
-/
namespace OpenProblems.QEDE088

/-- The geodesic Hamiltonian of the egg-crate metric `g_ε` in coordinates `(x, y, p_x, p_y)`. -/
noncomputable def ham (ε : ℝ) (q : Fin 4 → ℝ) : ℝ :=
  let w1 : ℝ := Real.cos (q 0) * Real.sin (q 1)
  let w2 : ℝ := Real.sin (q 0) * Real.cos (q 1)
  (1 / 2 : ℝ) * (q 2 ^ 2 + q 3 ^ 2
    - ε ^ 2 * (w1 * q 2 + w2 * q 3) ^ 2 / (1 + ε ^ 2 * (w1 ^ 2 + w2 ^ 2)))

/-- Partial derivative of `F` in the `i`-th coordinate at `q`. -/
noncomputable def pd (F : (Fin 4 → ℝ) → ℝ) (i : Fin 4) (q : Fin 4 → ℝ) : ℝ :=
  fderiv ℝ F q (Pi.single i (1 : ℝ))

/-- Canonical Poisson bracket `{F, G}` with positions `q 0, q 1` and momenta `q 2, q 3`. -/
noncomputable def poisson (F G : (Fin 4 → ℝ) → ℝ) (q : Fin 4 → ℝ) : ℝ :=
  pd F 0 q * pd G 2 q + pd F 1 q * pd G 3 q - pd F 2 q * pd G 0 q - pd F 3 q * pd G 1 q

/-- The cotangent bundle minus the zero section (before quotienting by periods): `p ≠ 0`. -/
def U : Set (Fin 4 → ℝ) := {q | q 2 ≠ 0 ∨ q 3 ≠ 0}

/-- `F` is 2π-periodic in both position coordinates, i.e. a function on `T*𝕋²`. -/
def IsTorusPeriodic (F : (Fin 4 → ℝ) → ℝ) : Prop :=
  (∀ q : Fin 4 → ℝ, F (Function.update q 0 (q 0 + 2 * Real.pi)) = F q) ∧
  (∀ q : Fin 4 → ℝ, F (Function.update q 1 (q 1 + 2 * Real.pi)) = F q)

/-- `F` is a real-analytic first integral of the geodesic flow of `g_ε`, independent of `H_ε`. -/
def IsExtraIntegral (ε : ℝ) (F : (Fin 4 → ℝ) → ℝ) : Prop :=
  AnalyticOnNhd ℝ F U ∧ IsTorusPeriodic F ∧
  (∀ q ∈ U, poisson F (ham ε) q = 0) ∧
  ∃ q ∈ U, ∃ i j : Fin 4, pd F i q * pd (ham ε) j q - pd F j q * pd (ham ε) i q ≠ 0

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ¬ ∃ F : (Fin 4 → ℝ) → ℝ, IsExtraIntegral ε F

end OpenProblems.QEDE088
