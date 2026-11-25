import Mathlib
/-! N-656: Spikes at the squares
On the half-line lattice put a spike of fixed height λ ≠ 0 at every perfect square. Remling's theorem rules out
absolutely continuous spectrum in the free band (-2,2). The question is whether the spectral measure of δ₁ restricted
to (-2,2) is pure point (localization), purely singular continuous (as the Cheon–Exner–Šeba heuristic predicts), or mixed.
Informal statement: Let (Hu)(n) = u(n+1) + u(n-1) + λ·1_{m², m ≥ 1}(n)·u(n) on ℓ²(ℕ), u(0) = 0, λ ≠ 0 fixed, and let μ be
the spectral measure of δ₁. Determine the spectral type of μ restricted to (-2,2): pure point, purely singular
continuous, or mixed.
Formalization notes: Sites are n ≥ 1; site 0 carries the Dirichlet condition u(0) = 0 (`applyH` forces the value 0 there).
`spikePot lam n = lam` exactly when n = m² with m ≥ 1 (so site 1 carries a spike). Mathlib has no spectral measures for
unbounded or general self-adjoint operators on ℓ², so μ is characterized by its moments: H is bounded
(‖H‖ ≤ 2 + |λ|), so the spectral measure of δ₁ is the unique finite Borel measure on ℝ with
∫ x^k dμ = ⟨δ₁, H^k δ₁⟩ for all k (the moment problem is determinate for compactly supported data), and
⟨δ₁, H^k δ₁⟩ = `moment lam k`, computed by iterating `applyH` on finitely supported sequences. "Pure point on I" means
μ(I \ C) = 0 for some countable C. The "determine the type" question is turned into the localization conjecture:
Claim says that for EVERY λ ≠ 0, μ restricted to (-2,2) is pure point. Proving ¬Claim means exhibiting some λ ≠ 0
(and the, necessarily unique, measure with these moments) whose restriction to (-2,2) has a continuous part;
combined with Remling's theorem (μ_ac = 0), that is singular continuous spectrum. Note the asymmetry: a result
"pure point for some λ only" or "purely singular continuous for all λ" settles the question informally, but only the
latter (or any λ with a continuous component) refutes Claim.
-/
namespace OpenProblems.N656

/-- The potential: value `lam` at every perfect square `m ^ 2` with `m ≥ 1`, zero elsewhere. -/
noncomputable def spikePot (lam : ℝ) (n : ℕ) : ℝ :=
  Set.indicator {k : ℕ | ∃ m : ℕ, 1 ≤ m ∧ m ^ 2 = k} (fun _ => lam) n

/-- The operator `H` acting on a sequence `u : ℕ → ℝ`; site `0` is the Dirichlet boundary and is set to `0`. -/
noncomputable def applyH (lam : ℝ) (u : ℕ → ℝ) : ℕ → ℝ :=
  fun n => if n = 0 then 0 else u (n + 1) + u (n - 1) + spikePot lam n * u n

/-- The unit vector `δ₁`. -/
noncomputable def delta1 : ℕ → ℝ := fun n => if n = 1 then 1 else 0

/-- The `k`-th moment `⟨δ₁, H^k δ₁⟩` of the spectral measure of `δ₁`. -/
noncomputable def moment (lam : ℝ) (k : ℕ) : ℝ := ((applyH lam)^[k] delta1) 1

/-- `μ` has the moments of the spectral measure of `δ₁` (this determines `μ` uniquely). -/
def IsSpectralMeasure (lam : ℝ) (μ : MeasureTheory.Measure ℝ) : Prop :=
  ∀ k : ℕ, MeasureTheory.Integrable (fun x : ℝ => x ^ k) μ ∧
    MeasureTheory.integral μ (fun x : ℝ => x ^ k) = moment lam k

/-- `μ` is pure point on `I`: it is carried, inside `I`, by a countable set. -/
def PurePointOn (μ : MeasureTheory.Measure ℝ) (I : Set ℝ) : Prop :=
  ∃ C : Set ℝ, C.Countable ∧ μ (I \ C) = 0

def Claim : Prop :=
  ∀ lam : ℝ, lam ≠ 0 → ∀ μ : MeasureTheory.Measure ℝ, IsSpectralMeasure lam μ →
    PurePointOn μ (Set.Ioo (-2 : ℝ) 2)

end OpenProblems.N656
