import Mathlib
/-! QED-M048: From density to Kolmogorov typicality of positive entropy in symplectic families
Berger and Turaev showed that families of area-preserving surface maps having positive metric entropy at every
parameter are dense among smooth families. Show this is typical, i.e. holds for a Kolmogorov-generic set of families,
or find a robust obstruction.
Informal statement (sharpened): Take `Σ = 𝕋² = ℝ²/ℤ²` with the standard area form. For `k ≥ 1` let `𝓕_k` be the
space of `C^∞` families `(f_p)_{p ∈ [0,1]^k}` of area- and orientation-preserving (= symplectic) diffeomorphisms of
`𝕋²` such that every `f_p` has an elliptic periodic point, with the `C^∞` topology on `(p, x) ↦ f_p(x)`. Let
`𝓕_+ = {families with h_Leb(f_p) > 0 for Lebesgue-a.e. p}`. Claim: for every `k ≥ 1`, `𝓕_+` is Kolmogorov typical,
i.e. contains a countable intersection of open subsets that are dense in `𝓕_k`. ¬Claim: for some `k ≥ 1`, `𝓕_+`
contains no residual subset of `𝓕_k` (a robust obstruction).
Formalization notes:
* Surface: `𝕋²`, represented by lifts `f : ℝ² → ℝ²` with `f(x + m) = f(x) + A m` (`m ∈ ℤ²`, `A ∈ SL₂(ℤ)`),
  `f` bijective and `C^∞`, `det Df ≡ 1`. Such `f` descends to a symplectic `C^∞` diffeomorphism of `𝕋²` and every one
  lifts. A lift is determined up to an integer translation; the lifted family space covers the space of torus
  families by a local homeomorphism and all sets used are saturated, so open/dense/residual notions agree.
  A fixed concrete surface is a sharpening of "fix a compact surface Σ".
* Families: `F : ℝ^k × ℝ² → ℝ²`, `C^∞` jointly, with `F(p, ·)` such a lift for each `p ∈ [0,1]^k` (values outside
  the cube are irrelevant). `C^∞` (Whitney/Fréchet) topology on the compact set `[0,1]^k × 𝕋²`: basic
  neighbourhoods `{G : ‖D^j(G − F)(z)‖ < ε for all j ≤ r, z ∈ [0,1]^k × [0,1]²}` (derivatives of `G − F` are
  `ℤ²`-periodic in `x` for `A_G = A_F`, and `A` is locally constant, so `[0,1]²` suffices). This is the topology of
  `C^∞([0,1]^k × 𝕋², 𝕋²)` used by Berger–Turaev.
* Elliptic periodic point: `f^N(x) ≡ x mod ℤ²`, `N ≥ 1`, `|tr D(f^N)(x)| < 2` (with `det = 1` this means the
  eigenvalues are non-real on the unit circle). Berger–Turaev's space `Symp^∞_el` additionally asks the elliptic
  point to be non-degenerate (twist, no strong resonance); we use plain ellipticity, as in the problem's `F`.
  (Non-degeneracy is an open dense condition at each elliptic point; we expect, but do not claim, that the
  Berger–Turaev subspace is open and dense in `𝓕_k`, in which case the two notions of typicality coincide.)
* Metric entropy: by Pesin's formula (Ruelle inequality + Pesin equality for `C²` area-preserving surface
  diffeomorphisms), `h_Leb(f) = ∫ λ⁺ dLeb` with `λ⁺(x) = lim (1/n) log ‖Df^n(x)‖ ≥ 0`, existing a.e. (Oseledets).
  Hence `h_Leb(f) > 0` iff `{x : liminf (1/n) log ‖Df^n(x)‖ > 0}` has positive area, which is how `PosEntropy` is
  written (Berger–Turaev use the same integrand `liminf (1/n) log ‖Df^n‖`). Norms: sup norm on `ℝ × ℝ`; any norm
  gives the same exponent.
* Kolmogorov typicality (Berger–Turaev): containing a countable intersection of open dense subsets of the family
  space; with `k` arbitrary. `Claim` asks it for every `k ≥ 1`.
-/
namespace OpenProblems.QEDM048
noncomputable section
open MeasureTheory Filter

/-- The plane `ℝ²`. -/
abbrev Pt := ℝ × ℝ
/-- Parameter space `ℝ^k`. -/
abbrev Par (k : ℕ) := Fin k → ℝ

/-- `m ∈ ℤ²` as a point of `ℝ²`. -/
def lat (m : ℤ × ℤ) : Pt := ((m.1 : ℝ), (m.2 : ℝ))

/-- Entries of the Jacobian matrix. -/
def j11 (f : Pt → Pt) (x : Pt) : ℝ := (fderiv ℝ f x ((1 : ℝ), (0 : ℝ))).1
def j12 (f : Pt → Pt) (x : Pt) : ℝ := (fderiv ℝ f x ((0 : ℝ), (1 : ℝ))).1
def j21 (f : Pt → Pt) (x : Pt) : ℝ := (fderiv ℝ f x ((1 : ℝ), (0 : ℝ))).2
def j22 (f : Pt → Pt) (x : Pt) : ℝ := (fderiv ℝ f x ((0 : ℝ), (1 : ℝ))).2

/-- Jacobian determinant. -/
def jdet (f : Pt → Pt) (x : Pt) : ℝ := j11 f x * j22 f x - j12 f x * j21 f x
/-- Jacobian trace. -/
def jtr (f : Pt → Pt) (x : Pt) : ℝ := j11 f x + j22 f x

/-- `f` is the lift of a symplectic `C^∞` diffeomorphism of `𝕋² = ℝ²/ℤ²`. -/
def IsTorusSymp (f : Pt → Pt) : Prop :=
  (∀ r : ℕ, ContDiff ℝ r f) ∧ Function.Bijective f ∧
  (∃ a b c e : ℤ, a * e - b * c = 1 ∧ ∀ x : Pt, ∀ m : ℤ × ℤ,
      f (x + lat m) = f x + lat (a * m.1 + b * m.2, c * m.1 + e * m.2)) ∧
  ∀ x : Pt, jdet f x = 1

/-- `f` has an elliptic periodic point on `𝕋²`. -/
def HasEllipticPeriodicPoint (f : Pt → Pt) : Prop :=
  ∃ x : Pt, ∃ N : ℕ, 0 < N ∧ (∃ m : ℤ × ℤ, f^[N] x = x + lat m) ∧ |jtr (f^[N]) x| < 2

/-- The fundamental domain `[0,1]²`. -/
def unitSq : Set Pt := Set.Icc ((0 : ℝ), (0 : ℝ)) ((1 : ℝ), (1 : ℝ))

/-- Positive metric entropy w.r.t. area: positive Lyapunov exponent on a set of positive area. -/
def PosEntropy (f : Pt → Pt) : Prop :=
  0 < volume {x ∈ unitSq | ∃ ε : ℝ, 0 < ε ∧
    ∀ᶠ n : ℕ in atTop, ε * (n : ℝ) ≤ Real.log ‖fderiv ℝ (f^[n]) x‖}

/-- The parameter cube `[0,1]^k`. -/
def cube (k : ℕ) : Set (Par k) := {p : Par k | ∀ i : Fin k, p i ∈ Set.Icc (0 : ℝ) 1}

/-- Smooth `k`-parameter families of symplectic torus diffeomorphisms. -/
def Fam (k : ℕ) : Set (Par k × Pt → Pt) :=
  {F | (∀ r : ℕ, ContDiff ℝ r F) ∧ ∀ p ∈ cube k, IsTorusSymp (fun x : Pt => F (p, x))}

/-- Families each of whose members has an elliptic periodic point (the space `𝓕_k`). -/
def Ell (k : ℕ) : Set (Par k × Pt → Pt) :=
  {F | F ∈ Fam k ∧ ∀ p ∈ cube k, HasEllipticPeriodicPoint (fun x : Pt => F (p, x))}

/-- `𝓕_+`: positive metric entropy for Lebesgue-a.e. parameter. -/
def Plus (k : ℕ) : Set (Par k × Pt → Pt) :=
  {F | ∀ᵐ p ∂(volume.restrict (cube k)), PosEntropy (fun x : Pt => F (p, x))}

/-- `G` is in the basic `C^r`, `ε`-neighbourhood of `F`. -/
def Near (k r : ℕ) (ε : ℝ) (F G : Par k × Pt → Pt) : Prop :=
  ∀ j : ℕ, j ≤ r → ∀ z ∈ cube k ×ˢ unitSq,
    ‖iteratedFDeriv ℝ j (fun w : Par k × Pt => G w - F w) z‖ < ε

/-- Open subset of the family space (`C^∞` topology). -/
def IsOpenFam (k : ℕ) (U : Set (Par k × Pt → Pt)) : Prop :=
  U ⊆ Fam k ∧ ∀ F ∈ U, ∃ r : ℕ, ∃ ε : ℝ, 0 < ε ∧ ∀ G ∈ Fam k, Near k r ε F G → G ∈ U

/-- `D ∩ Y` is dense in `Y`. -/
def DenseIn (k : ℕ) (D Y : Set (Par k × Pt → Pt)) : Prop :=
  ∀ F ∈ Y, ∀ r : ℕ, ∀ ε : ℝ, 0 < ε → ∃ G ∈ D ∩ Y, Near k r ε F G

def Claim : Prop :=
  ∀ k : ℕ, 1 ≤ k → ∃ D : ℕ → Set (Par k × Pt → Pt),
    (∀ i : ℕ, IsOpenFam k (D i) ∧ DenseIn k (D i) (Ell k)) ∧ Ell k ∩ (⋂ i, D i) ⊆ Plus k

end
end OpenProblems.QEDM048
