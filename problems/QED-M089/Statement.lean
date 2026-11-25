import Mathlib
/-! QED-M089: Derivative loss in L4 Strichartz on the cube surface
On the flat torus the L⁴ space-time Schrödinger estimate loses only ε derivatives (Bourgain). On the surface of a cube, which has eight cone points that diffract waves, only a loss of 1/4 derivative is known. Prove any loss below 1/4, or show some loss is necessary.
Informal statement: Let S be the unit cube surface, Δ the Friedrichs extension from C_c^∞(S \ vertices), and s* = inf{s ≥ 0 : ‖e^{itΔ}f‖_{L⁴([0,1]×S)} ≤ C_s‖f‖_{H^s(S)}}. Known: 0 ≤ s* ≤ 1/4 (Blair–Ford–Marzuola). Prove s* < 1/4, or s* > 0; ideally determine s* (conjecturally 0). The board's target (Claim) is s* < 1/4.
Formalization notes: The cube-surface model (shared verbatim with QED-M012 and QED-M088): S = ∂[0,1]³ ⊂ ℝ³ as
six closed faces, each the image of the closed unit square under an affine isometric chart; functions
are u : ℝ³ → ℂ restricted to S, so face functions automatically have matching edge traces; area
measure = Σ_faces Lebesgue on the open square. Core `IsTest` = continuous on S and smooth up to the
boundary on each closed face; it is a form core for the Friedrichs extension (it contains
C_c^∞(S \ vertices) and lies in H¹(S); points have zero capacity in 2D). H¹(S) membership is
witnessed by core sequences converging in L² and Cauchy in energy; `IsEigenpair lam e` is
e ∈ D(A), A e = lam e for A = −Δ_Friedrichs ≥ 0 (weak form against the core). `IsEigenbasis lam e` is
an orthonormal basis of L²(S) of such eigenfunctions (Parseval on the dense core gives completeness);
the spectrum is discrete, so this is the full spectral resolution. Schrödinger group:
e^{itΔ}(Σ c_n e_n) = Σ c_n e^{−it lam_n} e_n, and ‖f‖²_{H^s} = Σ (1 + lam_n)^s |c_n|² (H^s = D(A^{s/2})).
`StrichartzL4 lam e s C`: for every finitely supported coefficient vector c,
∫_0^1 ∫_S |e^{itΔ}f|⁴ ≤ C ‖f‖⁴_{H^s} (C is the 4th power of the constant C_s). Finite combinations of
eigenfunctions are dense in H^s and the L⁴ norm is lower semicontinuous under L² convergence (Fatou on a
subsequence), so the estimate on finite combinations is equivalent to the estimate on all of H^s; it
is also independent of which eigenbasis is used (both sides are basis-free on H^s). The space-time
integral is an `lintegral` of `ENNReal.ofReal (|·|⁴)`, so a non-integrable left side cannot make the
estimate hold by the Bochner junk value 0. `Claim` = existence of an eigenbasis (true; included so the
∀-basis clause is not vacuous) ∧ ∃ s ∈ [0, 1/4) such that for every eigenbasis the estimate holds with
some constant, i.e. s* < 1/4. Proving `¬Claim` means the BFM loss 1/4 is sharp: for every s < 1/4 the
estimate fails (it would show s* = 1/4). A positive lower bound s* > 0 is a different (also open)
statement and is not encoded.
-/
namespace OpenProblems.QEDM089
noncomputable section

open MeasureTheory Filter Topology

/-! ### Shared model of the flat surface of the unit cube

`S = ∂[0,1]³ ⊂ ℝ³`. Each face is the image of the closed unit square under an affine isometric chart;
since all faces sit inside the same `ℝ³`, the edge identifications are those of the cube and
continuity on `S` is exactly "matching edge traces". -/

/-- Points of `ℝ³`. -/
abbrev P3 : Type := Fin 3 → ℝ

/-- The six faces: `(i, b)` is the face `{x ∈ [0,1]³ | x i = b}` (`false ↦ 0`, `true ↦ 1`). -/
abbrev Face : Type := Fin 3 × Bool

/-- The fixed coordinate value of a face. -/
def bval (b : Bool) : ℝ := if b then 1 else 0

/-- Isometric affine chart of face `(i, b)`: `(s, t) ↦ x` with `x i = b`, `x (i+1) = s`, `x (i+2) = t`
(indices mod 3). -/
def chart (f : Face) (p : ℝ × ℝ) : P3 := fun m : Fin 3 =>
  if m = f.1 then bval f.2 else if m = f.1 + 1 then p.1 else p.2

/-- The closed unit square. -/
def cSq : Set (ℝ × ℝ) := Set.Icc (0 : ℝ) 1 ×ˢ Set.Icc (0 : ℝ) 1

/-- The open unit square (faces are integrated over it; the boundary is Lebesgue-null). -/
def Sq : Set (ℝ × ℝ) := Set.Ioo (0 : ℝ) 1 ×ˢ Set.Ioo (0 : ℝ) 1

/-- The cube surface `S = ∂[0,1]³`. -/
def S : Set P3 := ⋃ f : Face, chart f '' cSq

/-- Pull-back of a function on `ℝ³` to face `f`'s square. -/
def pull (u : P3 → ℂ) (f : Face) : ℝ × ℝ → ℂ := fun p => u (chart f p)

/-- Partial derivative in the first square coordinate. -/
def d1 (v : ℝ × ℝ → ℂ) (p : ℝ × ℝ) : ℂ := deriv (fun s : ℝ => v (s, p.2)) p.1

/-- Partial derivative in the second square coordinate. -/
def d2 (v : ℝ × ℝ → ℂ) (p : ℝ × ℝ) : ℂ := deriv (fun t : ℝ => v (p.1, t)) p.2

/-- Core of the Dirichlet form: functions continuous on `S` whose restriction to every closed face
is the restriction of a `C^∞` function on `ℝ²` (smooth up to the edges). -/
def IsTest (u : P3 → ℂ) : Prop :=
  ContinuousOn u S ∧
    ∀ f : Face, ∃ g : ℝ × ℝ → ℂ, (∀ k : ℕ, ContDiff ℝ k g) ∧ Set.EqOn (pull u f) g cSq

/-- `u` is (a representative of) an element of `L²(S)` for the surface (area) measure. -/
def IsL2 (u : P3 → ℂ) : Prop :=
  ∀ f : Face, AEStronglyMeasurable (pull u f) (volume.restrict Sq) ∧
    Integrable (fun p : ℝ × ℝ => ‖pull u f p‖ ^ 2) (volume.restrict Sq)

/-- `L²(S)` inner product, conjugate-linear in the first slot. -/
def ip (u v : P3 → ℂ) : ℂ :=
  ∑ f : Face, ∫ p in Sq, (starRingEnd ℂ) (pull u f p) * pull v f p

/-- `‖u‖²_{L²(S)}` (the mass). -/
def normSq (u : P3 → ℂ) : ℝ := ∑ f : Face, ∫ p in Sq, ‖pull u f p‖ ^ 2

/-- Sesquilinear Dirichlet form `E(u,v) = ∫_S ⟨∇u, ∇v⟩`, computed face by face. -/
def dform (u v : P3 → ℂ) : ℂ :=
  ∑ f : Face, ∫ p in Sq,
    ((starRingEnd ℂ) (d1 (pull u f) p) * d1 (pull v f) p +
      (starRingEnd ℂ) (d2 (pull u f) p) * d2 (pull v f) p)

/-- Energy `E(u) = ∫_S |∇u|²`. -/
def energy (u : P3 → ℂ) : ℝ :=
  ∑ f : Face, ∫ p in Sq, (‖d1 (pull u f) p‖ ^ 2 + ‖d2 (pull u f) p‖ ^ 2)

/-- `w` is a sequence in the core that converges to `e` in `L²` and is Cauchy for the energy, i.e.
it witnesses that `e` lies in the form domain `H¹(S)` (closure of the core in the form norm). -/
def Approximates (e : P3 → ℂ) (w : ℕ → P3 → ℂ) : Prop :=
  (∀ m : ℕ, IsTest (w m)) ∧
    Tendsto (fun m : ℕ => normSq (w m - e)) atTop (𝓝 0) ∧
    ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ m l : ℕ, N ≤ m → N ≤ l → energy (w m - w l) < ε

/-- `e` is an eigenfunction of the Friedrichs Laplacian `A = -Δ ≥ 0` with eigenvalue `lam`:
`e ∈ H¹(S)` and `E(e, φ) = lam ⟨e, φ⟩` for every `φ` in the core. -/
def IsEigenpair (lam : ℝ) (e : P3 → ℂ) : Prop :=
  IsL2 e ∧ ∃ w : ℕ → P3 → ℂ, Approximates e w ∧
    ∀ φ : P3 → ℂ, IsTest φ →
      Tendsto (fun m : ℕ => dform (w m) φ) atTop (𝓝 ((lam : ℂ) * ip e φ))

/-- An orthonormal eigenbasis of `L²(S)` for the Friedrichs Laplacian (eigenvalues of `-Δ`,
listed with multiplicity in any order). Completeness is Parseval's identity on the dense core. -/
def IsEigenbasis (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) : Prop :=
  (∀ n : ℕ, IsEigenpair (lam n) (e n)) ∧
    (∀ n m : ℕ, ip (e n) (e m) = if n = m then (1 : ℂ) else 0) ∧
    ∀ u : P3 → ℂ, IsTest u → HasSum (fun n : ℕ => ‖ip (e n) u‖ ^ 2) (normSq u)

/-- The `L⁴([0,1] × S)` Strichartz estimate with `s` derivatives, for the eigenbasis `(lam, e)`:
`∫₀¹∫_S |e^{itΔ} f|⁴ ≤ C ‖f‖_{H^s}⁴` for all finite eigenfunction expansions `f = Σ_{n ∈ F} c n • e n`. -/
def StrichartzL4 (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) (s C : ℝ) : Prop :=
  ∀ (F : Finset ℕ) (c : ℕ → ℂ),
    (∫⁻ t in Set.Icc (0 : ℝ) 1, ∑ f : Face, ∫⁻ p in Sq,
        ENNReal.ofReal (‖∑ n ∈ F, c n * Complex.exp (-(Complex.I * (lam n : ℂ) * (t : ℂ))) *
          e n (chart f p)‖ ^ 4)) ≤
      ENNReal.ofReal (C * (∑ n ∈ F, (1 + lam n) ^ s * ‖c n‖ ^ 2) ^ 2)

/-- `s* < 1/4`: the `L⁴` Strichartz estimate on the cube surface holds with a loss of fewer than
`1/4` derivatives. -/
def Claim : Prop :=
  (∃ (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ), IsEigenbasis lam e) ∧
    ∃ s : ℝ, 0 ≤ s ∧ s < 1 / 4 ∧
      ∀ (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ), IsEigenbasis lam e → ∃ C : ℝ, StrichartzL4 lam e s C

end
end OpenProblems.QEDM089
