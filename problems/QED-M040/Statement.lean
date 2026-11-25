import Mathlib
/-! QED-M040: Optimal dimension dependence in the smoothed complexity of the simplex method
Bach and Huiberts (2025) found a simplex method with smoothed complexity
O(σ^{-1/2} d^{11/4} log^{7/4} n) pivots and showed σ^{-1/2} is optimal. In the dimension d, the
best lower bound is only about d^{1/2}. Close the gap in d.
Informal statement (sharpened to the lower-bound side): Model: rows (ā_i, b̄_i) ∈ ℝ^{d+1},
i ≤ n, of Euclidean norm ≤ 1, each perturbed by independent N(0, σ² I), giving
P = {x ∈ ℝ^d : ⟨a_i, x⟩ ≤ b_i}. Let diam(P) be the combinatorial diameter (graph diameter of the
vertex-edge graph of P, 0 if P has no vertices). Known (Bach–Huiberts): the expected diameter is
Ω(σ^{-1/2} d^{1/2} (ln 4/σ)^{-1/4}) at n = ⌊(4/σ)^d⌋, and their simplex method takes
O(σ^{-1/2} d^{11/4} log^{7/4} n) pivots. Question (Claim): is there b > 1/2 such that, for all
large d and all 0 < σ ≤ 1/d, some n ≤ (4/σ)^{Kd} and some unperturbed rows give
E[diam(P)] ≥ c σ^{-1/2} d^b (log 4/σ)^{-K}, with constants c > 0, K independent of d and σ?
(The companion algorithmic question, whether some polynomial-time-per-pivot rule achieves
O(σ^{-1/2} d^a (log n)^{O(1)}) pivots with Phase I for some a < 11/4, is not formalized here; see
the notes.)
Formalization notes:
* Polyhedra, vertices and edges are as in QED-M058. A vertex is a feasible point whose active
  rows span ℝ^d. Distinct vertices x, y are adjacent iff the rows active at both span a
  (d−1)-dimensional space. This is the vertex-edge graph for every polyhedron, pointed or not
  (a non-pointed one has no vertices), and with probability 1 the perturbed system is in general
  position anyway. `graphDist` is the least number of edges on a path. The graph of a pointed
  polyhedron is connected, so the `sInf ∅ = 0` junk value never occurs between vertices. `diam` is
  the maximum over pairs of vertices. The set is finite (at most C(n,d) vertices), so `sSup` is a
  true maximum.
* Perturbation: the n×d matrix and the n-vector of right-hand sides get i.i.d. `gaussianReal 0 σ²`
  entries (a product measure, so each row gets N(0, σ² I_{d+1})). The expectation is a lintegral in
  ℝ≥0∞ of the ℕ-valued diameter. That diameter is a semialgebraic, hence Borel-measurable,
  function of the data, so the lintegral is the true expectation and no integrability side
  condition is needed.
* Regime: "n ≤ 2^{poly(d)}, σ ≤ 1/d" from the original statement, made precise as
  log n = O(d log(1/σ)), i.e. n ≤ (4/σ)^{Kd}. The known construction uses n = (4/σ)^d. With n
  bounded only by 2^{poly(d)} but σ → 0, any σ^{-1/2} lower bound is impossible because the vertex
  count is bounded, so n must be allowed to grow with 1/σ. The factor (log 4/σ)^{-K} allows the
  polylogarithmic losses already present in the known d^{1/2} bound, which is the case b = 1/2.
* Why not the algorithmic side: "a simplex pivot rule computable in polynomial time per pivot,
  Phase I included" has no canonical formal definition. It needs a real-number machine model and a
  convention for which auxiliary-program pivots count. If computation is unrestricted, a rule can
  find a good start vertex for free, and the question collapses to the geometric distance and
  diameter quantities stated here. The diameter question is the model-independent core of "close
  the gap in d". Bach–Huiberts derive their σ-optimality statement for simplex methods from
  exactly this diameter quantity, so a b > 1/2 bound is the dimension analogue.
Proving `Claim` = expected diameter Ω̃(σ^{-1/2} d^b) for some b > 1/2 in this regime. Proving
`¬Claim` = for every b > 1/2 and c, K the diameter lower bound fails for arbitrarily large d (at
some σ ≤ 1/d). That is an upper bound on smoothed diameters of order σ^{-1/2} d^{1/2+o(1)} up to
polylog(1/σ) factors, which would show that d^{1/2} is the right diameter exponent.
-/
namespace OpenProblems.QEDM040
noncomputable section
open MeasureTheory ProbabilityTheory
open scoped ENNReal

/-- Standard dot product on ℝ^d. -/
def dot {d : ℕ} (a x : Fin d → ℝ) : ℝ := ∑ j : Fin d, a j * x j

/-- `x` lies in the polyhedron {x | A x ≤ b}. -/
def InPoly {n d : ℕ} (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ) (x : Fin d → ℝ) : Prop :=
  ∀ i : Fin n, dot (A i) x ≤ b i

/-- `x` is a vertex: it lies in the polyhedron and its active rows span ℝ^d. -/
def IsVertex {n d : ℕ} (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ) (x : Fin d → ℝ) : Prop :=
  InPoly A b x ∧ Submodule.span ℝ (A '' {i : Fin n | dot (A i) x = b i}) = ⊤

/-- `x` and `y` are distinct vertices joined by an edge of the polyhedron. -/
def IsEdge {n d : ℕ} (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ) (x y : Fin d → ℝ) : Prop :=
  IsVertex A b x ∧ IsVertex A b y ∧ x ≠ y ∧
    Module.finrank ℝ ↥(Submodule.span ℝ (A '' {i : Fin n | dot (A i) x = b i ∧ dot (A i) y = b i}))
      + 1 = d

/-- `x` reaches `y` in at most `k` steps of the relation `R`. -/
def ReachableWithin {α : Type} (R : α → α → Prop) : ℕ → α → α → Prop
  | 0, x, y => x = y
  | k + 1, x, y => x = y ∨ ∃ z : α, R x z ∧ ReachableWithin R k z y

/-- Edge distance between two points in the vertex-edge graph. -/
def graphDist {n d : ℕ} (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ) (x y : Fin d → ℝ) : ℕ :=
  sInf {k : ℕ | ReachableWithin (IsEdge A b) k x y}

/-- Combinatorial diameter (0 if there are no vertices). -/
def diam {n d : ℕ} (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ) : ℕ :=
  sSup {k : ℕ | ∃ x y : Fin d → ℝ, IsVertex A b x ∧ IsVertex A b y ∧ graphDist A b x y = k}

/-- Law of the Gaussian perturbation `(G, g)`: all `n·d + n` entries i.i.d. `N(0, σ²)`. -/
def gaussPert (n d : ℕ) (σ : ℝ) : Measure ((Fin n → Fin d → ℝ) × (Fin n → ℝ)) :=
  (Measure.pi fun _ : Fin n => Measure.pi fun _ : Fin d => gaussianReal 0 (σ ^ 2).toNNReal).prod
    (Measure.pi fun _ : Fin n => gaussianReal 0 (σ ^ 2).toNNReal)

/-- Expected combinatorial diameter of the perturbed polyhedron `{x | (A₀+G) x ≤ b₀+g}`. -/
def expDiam (n d : ℕ) (σ : ℝ) (A₀ : Fin n → Fin d → ℝ) (b₀ : Fin n → ℝ) : ℝ≥0∞ :=
  ∫⁻ G, ((diam (fun i j => A₀ i j + G.1 i j) (fun i => b₀ i + G.2 i) : ℕ) : ℝ≥0∞)
    ∂(gaussPert n d σ)

def Claim : Prop :=
  ∃ β : ℝ, 1 / 2 < β ∧ ∃ c : ℝ, 0 < c ∧ ∃ K : ℕ, ∃ D : ℕ, ∀ d : ℕ, D ≤ d →
    ∀ σ : ℝ, 0 < σ → σ ≤ 1 / (d : ℝ) →
      ∃ n : ℕ, (n : ℝ) ≤ (4 / σ) ^ (K * d) ∧
        ∃ (A₀ : Fin n → Fin d → ℝ) (b₀ : Fin n → ℝ),
          (∀ i : Fin n, (∑ j : Fin d, A₀ i j ^ 2) + b₀ i ^ 2 ≤ 1) ∧
          ENNReal.ofReal (c * σ ^ (-(1 / 2 : ℝ)) * (d : ℝ) ^ β * Real.log (4 / σ) ^ (-(K : ℝ)))
            ≤ expDiam n d σ A₀ b₀

end
end OpenProblems.QEDM040
