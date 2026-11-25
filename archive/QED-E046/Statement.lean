import Mathlib
/-! QED-E046: Rigorously refute Palásti's parking conjecture in the plane
Drop unit squares (all axis-parallel) one at a time at uniformly random positions in a huge box, keeping each one only if it does not overlap those already placed, until no more fit. In one dimension the covered fraction tends to Rényi's constant, about 0.7476. Palásti guessed the planar answer is Rényi's constant squared, about 0.5589. Simulations give about 0.5620, so the guess seems wrong, but nobody has proved it. Prove that the planar jamming density is not Rényi's constant squared.
Informal statement: Let $\rho_2$ be the jamming limit of random sequential adsorption of aligned unit squares in $[0,L]^2$ as $L\to\infty$; it exists, with $L^1$ and a.s. convergence, by Penrose (2001). Let $c_R=\int_0^\infty\exp\!\left(-2\int_0^t\frac{1-e^{-u}}{u}\,du\right)dt\approx0.747598$ be Rényi's constant. Prove $\rho_2\ne c_R^2$, for instance by proving a rigorous lower bound $\rho_2>c_R^2\approx0.55890$. More generally, give any rigorous non-trivial two-sided bound on $\rho_2$.
Formalization notes:
* RSA in the box [0,L]² (L ∈ ℕ, L ≥ 2): a unit square is identified with its lower-left corner
  p ∈ [0, L−1]², so it lies inside the box. Arrivals are i.i.d. uniform corners x₁, x₂, … in
  [0, L−1]². The k-th arrival is accepted iff its open square is disjoint from the open squares
  of all previously accepted ones, i.e. iff |p₁ − q₁| ≥ 1 or |p₂ − q₂| ≥ 1 for every accepted q
  (`overlap`). `accepted` runs this rule left to right on a finite list of arrivals.
  (The continuous-time Poisson-arrival version used by Penrose produces the same sequence of
  accepted squares, since only the order of arrivals matters; boundary contacts have
  probability 0 and do not matter.)
* Jamming: the number of accepted squares after k arrivals is nondecreasing in k and bounded by
  L², so it is eventually constant (the jammed state, reached a.s. since any region of positive
  area where a corner could still be accepted is hit eventually); by monotone convergence the
  expected final number is the supremum over k of the expected number after k arrivals. The
  latter is a finite-dimensional Lebesgue integral over ([0,L−1]²)^k divided by its volume
  (L−1)^{2k} (uniform distribution), computed with `lintegral` in `ℝ≥0∞`, so there are no
  integrability side conditions. `rho L` = expected final number / L² = expected covered area
  fraction (each square has area 1).
* Penrose (2001) proves ρ_L → ρ₂ (expectations converge; indeed L¹ and a.s.). Hence
  ρ₂ ≠ c_R² ⇔ ρ_L does not converge to c_R². `Claim` states the latter, which needs no
  separate definition of the limit.
* Rényi's constant is written with Mathlib's Bochner integrals; the integrands are continuous
  on (0,∞) (the value at u = 0 is irrelevant, measure zero) and the outer integrand decays like
  t⁻², so both integrals are genuine (no junk 0 from non-integrability).
* Proving `Claim` = Palásti's conjecture is false. Proving `¬Claim` = it is true (ρ₂ = c_R²).
-/
namespace OpenProblems.QEDE046
noncomputable section
open MeasureTheory
open scoped ENNReal Classical

/-- Open unit squares with lower-left corners `p`, `q` overlap. -/
def overlap (p q : ℝ × ℝ) : Prop := |p.1 - q.1| < 1 ∧ |p.2 - q.2| < 1

/-- Accepted corners after processing a list of arrivals in order (RSA rule). -/
def accepted (xs : List (ℝ × ℝ)) : List (ℝ × ℝ) :=
  xs.foldl (fun acc p => if ∀ q ∈ acc, ¬ overlap p q then acc ++ [p] else acc) []

/-- Admissible corners in the box `[0,L]²`. -/
def corners (L : ℕ) : Set (ℝ × ℝ) := Set.Icc (0 : ℝ) ((L : ℝ) - 1) ×ˢ Set.Icc (0 : ℝ) ((L : ℝ) - 1)

/-- Expected number of accepted squares after `k` i.i.d. uniform arrivals. -/
def expectedAfter (L k : ℕ) : ℝ≥0∞ :=
  (∫⁻ x in Set.pi Set.univ (fun _ : Fin k => corners L),
      ((accepted (List.ofFn x)).length : ℝ≥0∞)) /
    (volume (corners L)) ^ k

/-- Expected jammed covered fraction in the box `[0,L]²`. -/
def rho (L : ℕ) : ℝ := ((⨆ k : ℕ, expectedAfter L k) / ((L : ℝ≥0∞) ^ 2)).toReal

/-- Rényi's parking constant `c_R ≈ 0.747598`. -/
def renyi : ℝ :=
  ∫ t in Set.Ioi (0 : ℝ), Real.exp (-2 * ∫ u in (0 : ℝ)..t, (1 - Real.exp (-u)) / u)

/-- Palásti's conjecture `ρ₂ = c_R²` fails. -/
def Claim : Prop :=
  ¬ Filter.Tendsto rho Filter.atTop (nhds (renyi ^ 2))

end
end OpenProblems.QEDE046
