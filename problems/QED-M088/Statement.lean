import Mathlib
/-! QED-M088: Critical NLS blow-up threshold on the cube surface
For the focusing cubic NLS on the flat surface of the unit cube, each vertex is a cone of angle 3π/2, which should lower the mass threshold for blow-up from ‖Q‖² to (3/4)‖Q‖². Prove global existence below m_* = (3/4)‖Q‖²_{L²(R²)} and blow-up for masses arbitrarily close above.
Informal statement: Let $S$ be the surface of the unit cube with its flat metric, and let $\Delta$ be the Friedrichs extension of the Laplace–Beltrami operator on $C_c^\infty(S\setminus\{\text{vertices}\})$. Let $Q$ be the ground state of $\Delta Q-Q+Q^3=0$ on $\mathbb R^2$, and put $m_*=\tfrac34\|Q\|_{L^2(\mathbb R^2)}^2$. For $iu_t+\Delta u+|u|^2u=0$ on $S$, prove: (i) every $u_0\in H^1(S)$ with $\|u_0\|_2^2<m_*$ gives a global (forward-in-time) $H^1$ solution; (ii) for every $\varepsilon>0$ there is $u_0\in H^1(S)$ with $m_*<\|u_0\|_2^2<m_*+\varepsilon$ whose solution blows up in finite time (its $H^1$ norm is unbounded on its maximal interval $[0,T)$, $T<\infty$). (Stronger, optional: blow-up data exist for every mass $m>m_*$; also decide whether there is blow-up at mass exactly $m_*$.)
Formalization notes: The cube-surface model (shared verbatim with QED-M012 and QED-M089): S = ∂[0,1]³ ⊂ ℝ³ as
six closed faces, each the image of the closed unit square under an affine isometric chart; functions
are u : ℝ³ → ℂ restricted to S (so edge traces match automatically); area measure = Σ_faces Lebesgue
on the open square. Core `IsTest` (continuous on S, smooth up to the edges on each closed face) is a
form core of the Friedrichs extension; `IsEigenpair`/`IsEigenbasis` describe an orthonormal eigenbasis
(e_n, lam_n) of A = −Δ_Friedrichs ≥ 0 via the weak form against the core (see M012 notes).
H¹(S) = form domain = D(A^{1/2}), with ‖v‖²_{H¹} = Σ (1 + lam_n)|⟨e_n, v⟩|² (`H1sq`); `InH1` requires
v ∈ L² and summability. NLS solution on a time interval J ∋ 0 (`SolOn`), Duhamel form in eigen-
coefficients a_n(t) = ⟨e_n, u(t)⟩: from u_t = iΔu + i|u|²u,
a_n(t) = e^{−i lam_n t} a_n(0) + i ∫_0^t e^{−i lam_n (t−τ)} ⟨e_n, |u(τ)|²u(τ)⟩ dτ,
with u ∈ C(J; H¹) (H¹-continuity of t ↦ u(t)), |u(τ)|²u(τ) ∈ L² (true for H¹ by Sobolev H¹ ⊂ L⁶ on S;
demanded so that the pairings are genuine integrals), and τ ↦ ⟨e_n, |u|²u⟩ continuous (true for
C(J;H¹) solutions; demanded so the interval integral is not a junk value). At t = 0 the coefficients
of u(0) and u₀ agree, so u(0) = u₀ in L². This is the standard notion of H¹ (energy) solution; such
solutions are unique (2D cubic NLS, Yudovich/Ogawa–Ozawa type argument on compact surfaces), so
"global solution exists" and "the maximal solution blows up" (`BlowsUp`: a solution on [0,T), T < ∞,
with unbounded H¹ norm) are the usual dichotomy. Time is forward (t ≥ 0). Ground state: Q : ℝ² → ℝ
smooth, positive, tending to 0 at infinity, solving ΔQ − Q + Q³ = 0 classically (Laplacian by iterated
partial derivatives), with Q² integrable; by Gidas–Ni–Nirenberg and Kwong it is unique up to
translation, so m_* = (3/4)∫Q² is well defined; `Claim` quantifies over all such Q and also asserts one
exists. ‖u₀‖²₂ is `normSq` (area normalization 1 per face, matching Lebesgue normalization on ℝ²).
`Claim` = (eigenbasis exists) ∧ (ground state exists) ∧ ∀ Q, ∀ eigenbasis, (i) ∧ (ii); the existence
conjuncts prevent vacuous truth. ¬Claim means a sub-threshold H¹ datum without a global solution, or
some ε with no blow-up datum of mass in (m_*, m_*+ε). The optional strengthenings are not encoded.
-/
namespace OpenProblems.QEDM088
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

/-- `‖v‖²_{H¹(S)} = Σ (1 + lam_n) |⟨e_n, v⟩|²`. -/
def H1sq (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) (v : P3 → ℂ) : ℝ :=
  ∑' n : ℕ, (1 + lam n) * ‖ip (e n) v‖ ^ 2

/-- `v ∈ H¹(S)` (the form domain of the Friedrichs Laplacian). -/
def InH1 (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) (v : P3 → ℂ) : Prop :=
  IsL2 v ∧ Summable (fun n : ℕ => (1 + lam n) * ‖ip (e n) v‖ ^ 2)

/-- The cubic nonlinearity `|v|² v`. -/
def cubic (v : P3 → ℂ) : P3 → ℂ := fun x => ((‖v x‖ ^ 2 : ℝ) : ℂ) * v x

/-- `u` is an `H¹` solution of `i u_t + Δu + |u|²u = 0`, `u(0) = u₀`, on the time interval `J ∋ 0`,
in Duhamel form on the eigen-coefficients. -/
def SolOn (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) (J : Set ℝ) (u0 : P3 → ℂ) (u : ℝ → P3 → ℂ) : Prop :=
  (0 : ℝ) ∈ J ∧
  (∀ t ∈ J, InH1 lam e (u t) ∧ IsL2 (cubic (u t))) ∧
  (∀ t₀ ∈ J, Tendsto (fun t : ℝ => H1sq lam e (u t - u t₀)) (𝓝[J] t₀) (𝓝 0)) ∧
  (∀ n : ℕ, ContinuousOn (fun τ : ℝ => ip (e n) (cubic (u τ))) J) ∧
  ∀ n : ℕ, ∀ t ∈ J,
    ip (e n) (u t) =
      Complex.exp (-(Complex.I * (lam n : ℂ) * (t : ℂ))) * ip (e n) u0 +
        Complex.I * ∫ τ in (0 : ℝ)..t,
          Complex.exp (-(Complex.I * (lam n : ℂ) * ((t - τ : ℝ) : ℂ))) * ip (e n) (cubic (u τ))

/-- Finite-time blow-up: an `H¹` solution on `[0,T)`, `T < ∞`, whose `H¹` norm is unbounded. -/
def BlowsUp (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ) (u0 : P3 → ℂ) : Prop :=
  ∃ T : ℝ, 0 < T ∧ ∃ u : ℝ → P3 → ℂ, SolOn lam e (Set.Ico 0 T) u0 u ∧
    ¬ BddAbove ((fun t : ℝ => H1sq lam e (u t)) '' Set.Ico 0 T)

/-- Laplacian on `ℝ²` by iterated classical partial derivatives. -/
def lap2 (Q : ℝ × ℝ → ℝ) (x : ℝ × ℝ) : ℝ :=
  deriv (fun a : ℝ => deriv (fun a' : ℝ => Q (a', x.2)) a) x.1 +
    deriv (fun b : ℝ => deriv (fun b' : ℝ => Q (x.1, b')) b) x.2

/-- `Q` is a ground state of `ΔQ − Q + Q³ = 0` on `ℝ²` (positive, decaying, smooth). -/
def IsGroundState (Q : ℝ × ℝ → ℝ) : Prop :=
  (∀ k : ℕ, ContDiff ℝ k Q) ∧ (∀ x : ℝ × ℝ, 0 < Q x) ∧
    Tendsto Q (cocompact (ℝ × ℝ)) (𝓝 0) ∧
    Integrable (fun x : ℝ × ℝ => Q x ^ 2) ∧
    ∀ x : ℝ × ℝ, lap2 Q x - Q x + Q x ^ 3 = 0

/-- Sharp threshold `m_* = (3/4) ‖Q‖²` for the focusing cubic NLS on the cube surface. -/
def Claim : Prop :=
  (∃ (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ), IsEigenbasis lam e) ∧
  (∃ Q : ℝ × ℝ → ℝ, IsGroundState Q) ∧
  ∀ Q : ℝ × ℝ → ℝ, IsGroundState Q →
    ∀ (lam : ℕ → ℝ) (e : ℕ → P3 → ℂ), IsEigenbasis lam e →
      let mstar : ℝ := 3 / 4 * ∫ x : ℝ × ℝ, Q x ^ 2
      (∀ u0 : P3 → ℂ, InH1 lam e u0 → normSq u0 < mstar →
          ∃ u : ℝ → P3 → ℂ, SolOn lam e (Set.Ici 0) u0 u) ∧
      (∀ ε : ℝ, 0 < ε → ∃ u0 : P3 → ℂ, InH1 lam e u0 ∧
          mstar < normSq u0 ∧ normSq u0 < mstar + ε ∧ BlowsUp lam e u0)

end
end OpenProblems.QEDM088
