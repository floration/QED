import Mathlib
/-! QED-M053: Positive metric entropy for the x^4+y^4 billiard
The billiard table x⁴ + y⁴ ≤ 1 is smooth and convex, but its curvature vanishes at four points, so
(by Mather) it has no caustics. Its phase space mixes stable islands with apparently chaotic
regions. Prove that the chaos is real: on a set of positive measure, nearby trajectories separate
exponentially fast.
Informal statement: Let Φ be the billiard map of Ω = {x⁴ + y⁴ ≤ 1}, preserving the Liouville
measure ν = sin θ ds dθ. Prove that h_ν(Φ) > 0; equivalently, by Pesin's formula, that Φ has a
nonzero Lyapunov exponent on a set of positive ν-measure. (Formalized in the Lyapunov form.)
Formalization notes:
* Phase space. We realise the billiard map in ambient coordinates: a state is (q, v) ∈ ℝ² × ℝ²,
  q the collision point on ∂Ω = {x⁴ + y⁴ = 1}, v the outgoing unit velocity (pointing into Ω).
  The phase space is M = {(q,v) : q ∈ ∂Ω, |v| = 1, v inward}, an open annulus.
* The map. `nextTime q v = sup {t ≥ 0 : q + t v ∈ Ω}` is the free flight time to the next
  collision (Ω is compact and strictly convex, so for (q,v) ∈ M this is the second intersection
  of the chord with ∂Ω). The new velocity is the specular reflection of v in the tangent line at
  the new point q' (normal ∇(x⁴+y⁴)(q') ∥ (q'₁³, q'₂³) ≠ 0). `billiard` is defined by these
  formulas on all of (ℝ²)²; it maps M to M and agrees on M with the Birkhoff billiard map Φ.
  Near M it is real-analytic: the exit time is the larger root of t ↦ F(q + t v) = 1, a simple
  root since a chord of a strictly convex curve is transversal at its endpoints (implicit
  function theorem), so values off M only serve to make `fderiv` meaningful; they never enter
  the tangent cocycle (below).
* Chart. `chart (φ, θ)` = (q(φ), cos θ·T(φ) + sin θ·N(φ)), where q(φ) = r(φ)(cos φ, sin φ),
  r(φ) = (cos⁴φ + sin⁴φ)^(-1/4) is the polar parametrisation of ∂Ω (analytic since
  cos⁴ + sin⁴ ≥ 1/2), T the positively oriented unit tangent and N = inward unit normal; θ is
  the Birkhoff angle between v and the tangent. On (0,2π) × (0,π) this is an analytic
  diffeomorphism onto M minus a null curve, so Lebesgue measure dφ dθ and ν = sin θ ds dθ
  (ds = |q'(φ)| dφ) are mutually absolutely continuous there: "positive ν-measure" = "positive
  dφ dθ-measure".
* Lyapunov exponent. `jac n p = D(Φⁿ ∘ chart)(p)`; by the chain rule this is
  DΦⁿ|_{T M} ∘ D chart(p), which only involves Φ on M (Φⁿ ∘ chart maps into M). D chart(p) is
  injective, so ‖jac n p‖ is comparable, up to constants depending only on p, to the norm of the
  tangent cocycle DΦⁿ(x) : T_x M → T_{Φⁿx} M for the metric induced from ℝ⁴. This metric is
  uniformly equivalent to the (s, θ) chart metric, and passing to the Birkhoff coordinates
  (s, cos θ) changes the cocycle by factors bounded by C/sin θ(Φⁿx); since log(1/sin θ) is
  ν-integrable, Birkhoff's ergodic theorem gives (1/n) log(1/sin θ(Φⁿx)) → 0 ν-a.e. So the
  upper exponent limsup (1/n) log ‖jac n p‖ is the standard top Lyapunov exponent λ⁺ a.e.
  "λ⁺(p) > 0" is encoded as: ∃ λ > 0 with ‖jac n p‖ ≥ e^{λn} for infinitely many n.
* Since Φ preserves the smooth measure ν, exponents come in pairs ±λ, and by Pesin's entropy
  formula (Katok–Strelcyn version for billiards / smooth maps with tempered singularities) plus
  Ruelle's inequality, h_ν(Φ) = ∫ λ⁺ dν; so h_ν(Φ) > 0 ⇔ λ⁺ > 0 on a set of positive measure.
  `fderiv` junk (value 0 where not differentiable) can only shrink the set, so it cannot make
  `Claim` cheaply true; and Φ is differentiable at all chart points, so it does not bias ¬Claim.
* Proving `Claim` = positive metric entropy (nonzero Lyapunov exponent on positive measure).
  Proving `¬Claim` = Lyapunov exponents vanish ν-a.e. (zero metric entropy).
-/
namespace OpenProblems.QEDM053
noncomputable section

/-- The quartic `F(x,y) = x⁴ + y⁴`; the table is `Ω = {F ≤ 1}`. -/
def quartic (q : ℝ × ℝ) : ℝ := q.1 ^ 4 + q.2 ^ 4

/-- Free flight time from `q` in direction `v` until leaving `Ω`. -/
def nextTime (q v : ℝ × ℝ) : ℝ := sSup {t : ℝ | 0 ≤ t ∧ quartic (q + t • v) ≤ 1}

/-- Specular reflection of `v` in the tangent line of `∂Ω` at `q` (normal `∥ (q₁³, q₂³)`). -/
def reflect (q v : ℝ × ℝ) : ℝ × ℝ :=
  v - (2 * (v.1 * q.1 ^ 3 + v.2 * q.2 ^ 3) / (q.1 ^ 6 + q.2 ^ 6)) • ((q.1 ^ 3, q.2 ^ 3) : ℝ × ℝ)

/-- The billiard map on states `(collision point, outgoing velocity)`. -/
def billiard (z : (ℝ × ℝ) × (ℝ × ℝ)) : (ℝ × ℝ) × (ℝ × ℝ) :=
  let q' : ℝ × ℝ := z.1 + nextTime z.1 z.2 • z.2
  (q', reflect q' z.2)

/-- Polar radius of `∂Ω`: `r(φ) = (cos⁴ φ + sin⁴ φ)^(-1/4)`. -/
def radius (φ : ℝ) : ℝ := (Real.cos φ ^ 4 + Real.sin φ ^ 4) ^ (-(1 / 4 : ℝ))

/-- Boundary point with polar angle `φ`. -/
def bdry (φ : ℝ) : ℝ × ℝ := (radius φ * Real.cos φ, radius φ * Real.sin φ)

/-- Chart `(φ, θ) ↦ (q(φ), cos θ · T + sin θ · N)` of the phase space, with `T` the positively
oriented unit tangent and `N` the inward unit normal at `q(φ)`. -/
def chart (p : ℝ × ℝ) : (ℝ × ℝ) × (ℝ × ℝ) :=
  let q : ℝ × ℝ := bdry p.1
  let g : ℝ := Real.sqrt (q.1 ^ 6 + q.2 ^ 6)
  let T : ℝ × ℝ := (-(q.2 ^ 3) / g, q.1 ^ 3 / g)
  let N : ℝ × ℝ := (-(q.1 ^ 3) / g, -(q.2 ^ 3) / g)
  (q, Real.cos p.2 • T + Real.sin p.2 • N)

/-- Derivative of `Φⁿ ∘ chart` at `p` (the tangent cocycle read in the chart). -/
def jac (n : ℕ) (p : ℝ × ℝ) : (ℝ × ℝ) →L[ℝ] ((ℝ × ℝ) × (ℝ × ℝ)) :=
  fderiv ℝ (fun x : ℝ × ℝ => (billiard^[n]) (chart x)) p

/-- Positive top Lyapunov exponent on a set of positive Liouville measure. -/
def Claim : Prop :=
  0 < MeasureTheory.volume
    {p : ℝ × ℝ | p ∈ Set.Ioo (0 : ℝ) (2 * Real.pi) ×ˢ Set.Ioo (0 : ℝ) Real.pi ∧
      ∃ lam : ℝ, 0 < lam ∧
        ∃ᶠ n : ℕ in Filter.atTop, Real.exp (lam * (n : ℝ)) ≤ ‖jac n p‖}

end
end OpenProblems.QEDM053
