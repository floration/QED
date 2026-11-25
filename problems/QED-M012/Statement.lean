import Mathlib
/-! QED-M012: Non-arithmetic tones of the cube
Many vibration frequencies of a cube's surface come from flat tori and are rational multiples of pi squared. Prove that at least one frequency is not of this form.
Informal statement: Let $S$ be the boundary of the unit cube $[0,1]^3$ with its intrinsic flat metric (8 cone points of angle $3\pi/2$), and let $\Delta$ be the Friedrichs extension of the Laplacian on $S$. Prove that some eigenvalue of $\Delta$ is not in $\pi^2\mathbb{Q}$.
Formalization notes: Model of the cube surface (shared verbatim with QED-M088 and QED-M089): S = ∂[0,1]³ ⊂ ℝ³,
covered by six closed faces, each the image of the closed unit square under an affine isometric
chart `chart (i,b)`. Because the faces sit inside ℝ³, a function `u : ℝ³ → ℂ` restricted to S is a
tuple of face functions whose traces automatically agree on shared edges; the intrinsic flat metric
of S is the one induced by these isometric charts (8 cone points of angle 3π/2). The surface
measure is the sum of 2D Lebesgue measure over the six (open) faces; edges and vertices are null.
Core: `IsTest` = continuous on S and, on each closed face, the restriction of a C^∞ function on ℝ²
(smooth up to the edges). This class lies in H¹(S) and contains C_c^∞(S \ vertices) (a function smooth
in the flat structure and vanishing near the vertices is smooth up to the edges of each face and
extends smoothly to ℝ² by Seeley/Whitney extension); since points have zero capacity in dimension 2,
the closure of C_c^∞(S \ vertices) in the H¹ norm is all of H¹(S). So `IsTest` is a form core of the
Friedrichs extension. Dirichlet form: `dform u v = Σ_faces ∫ (conj ∂₁u ∂₁v + conj ∂₂u ∂₂v)` with
classical partial derivatives in the isometric square coordinates (only the open square is
integrated, where the partials are those of the smooth extension). The form domain H¹(S) is
represented through `Approximates e w`: a core sequence converging to e in L² and Cauchy in energy
(the form is closable, being the restriction of the closed H¹ form). `IsEigenpair lam e` says
e ∈ H¹(S) and E(e, φ) = lam ⟨e, φ⟩ for all core φ (with E(e,φ) := lim E(w_m, φ)); by the
representation theorem for closed forms this is exactly e ∈ D(A), A e = lam e, where A = −Δ_Friedrichs
≥ 0. Sign: eigenvalues are taken for −Δ (nonnegative); membership in π²ℚ is sign-insensitive.
`IsEigenbasis` (orthonormal eigenbasis, Parseval on the dense core) is part of the shared model but
not needed here. `Claim` says some L²-nonzero eigenfunction has eigenvalue lam with lam ≠ π²q for all
rational q. Proving `¬Claim` means the whole spectrum lies in π²ℚ. Junk checks: `IsL2` demands
measurability and square-integrability face by face, so the L² convergence cannot be satisfied
vacuously by a non-integrable e; `0 < normSq e` rules out the zero function.
-/
namespace OpenProblems.QEDM012
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

/-- Some eigenvalue of the Friedrichs Laplacian of the cube surface is not a rational multiple
of `π²`. -/
def Claim : Prop :=
  ∃ (lam : ℝ) (e : P3 → ℂ), IsEigenpair lam e ∧ 0 < normSq e ∧
    ∀ q : ℚ, lam ≠ Real.pi ^ 2 * (q : ℝ)

end
end OpenProblems.QEDM012
