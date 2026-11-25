import Mathlib
/-! QED-M072: Irrationality of the quartic oscillator ground state
The lowest energy of the quartic oscillator −d²/dx² + x⁴ on the line is about 1.0603620905.
Show that it is irrational.
Informal statement: Let E₀ = min σ(−d²/dx² + x⁴), the operator taken self-adjoint on L²(ℝ)
(E₀ = 1.06036209048418…). Prove that E₀ ∉ ℚ.
Formalization notes:
* E₀ is defined variationally: E₀ = inf over nonzero real φ ∈ C_c^1(ℝ) of the Rayleigh quotient
  (∫ φ'² + x⁴ φ²) / ∫ φ². By the min-max principle, E₀ = inf σ(H) for the Friedrichs
  (= unique, since x⁴ ≥ 0 and C_c^∞ is a core) self-adjoint realization, because C_c^1 lies
  in the form domain and contains C_c^∞, which is a form core. Restricting to real φ loses
  nothing: for φ = u + iv the quotient is a weighted average of those of u and v.
* C^1 (`ContDiff ℝ 1`) is used deliberately instead of `ContDiff ℝ ⊤`, which in current Mathlib
  may mean analytic and would make the set empty. For continuous compactly supported
  integrands the Bochner integrals are the genuine integrals, and φ ≠ 0 with φ continuous
  makes the denominator positive. The set is nonempty and bounded below by 0, so `sInf` is
  the true infimum.
* Proving `Claim`: E₀ is irrational. Proving `¬Claim`: E₀ is rational.
-/
namespace OpenProblems.QEDM072

/-- The Rayleigh quotient of `−d²/dx² + x⁴` at `φ`. -/
noncomputable def rayleighQuotient (φ : ℝ → ℝ) : ℝ :=
  (∫ x : ℝ, (deriv φ x) ^ 2 + x ^ 4 * (φ x) ^ 2) / (∫ x : ℝ, (φ x) ^ 2)

/-- The ground state energy `E₀` of the quartic oscillator, defined variationally. -/
noncomputable def groundStateEnergy : ℝ :=
  sInf {E : ℝ | ∃ φ : ℝ → ℝ, ContDiff ℝ 1 φ ∧ HasCompactSupport φ ∧ φ ≠ 0 ∧
    E = rayleighQuotient φ}

def Claim : Prop := Irrational groundStateEnergy

end OpenProblems.QEDM072
