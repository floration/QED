import Mathlib
/-! QED-M028: A super-constant-degree SoS integrality gap for Unique Games
Construct Unique Games instances of optimum value at most ε on which the degree-d Sum-of-Squares
relaxation still has value at least 1 - ε, with alphabet size depending only on ε and degree d
growing without bound; the alternative is that constant-degree SoS distinguishes (1-ε)-satisfiable
from δ-satisfiable instances for every alphabet size.
Informal statement: (Gap) For every ε > 0 there is q = q(ε) such that for every degree bound D there is
a Unique Games instance over alphabet [q] with optimum ≤ ε on which the degree-2D SoS (Lasserre)
relaxation has value ≥ 1 - ε (equivalently: a family of instances of growing size n with
degree d(n) = ω(1) gaps). The (Algorithm) alternative in the original statement is exactly the
negation of (Gap), so the original disjunction was a tautology; Claim is (Gap) alone.
Formalization notes: A `UGInstance q` has `n` variables, `m` constraints, the e-th constraint asks
`perm e (f (src e)) = f (dst e)`. `value f` is the satisfied fraction. The SoS relaxation of degree 2D
uses Boolean variables `X (v,i)` ("v gets label i") and a pseudo-expectation: an ℝ-linear functional
`L` on `MvPolynomial (Fin n × Fin q) ℝ` with `L 1 = 1`, `L (p*p) ≥ 0` for `deg p ≤ D`, and
`L (p * g) = 0` for each constraint polynomial `g` (`X^2 - X`, `∑_i X (v,i) - 1`) whenever
`deg p + deg g ≤ 2D`. The SoS value is the sup of `L objective`; "value ≥ 1 - ε" is encoded by
existence of such an `L` (the sup is attained by compactness, so this is equivalent).
Proving `Claim` = constructing the super-constant-degree gap (strong evidence for UGC-type hardness of SoS).
Proving `¬Claim` = there are ε, δ (take δ = ε) such that for every q some constant degree D refutes
all instances of value ≤ ε, i.e. the algorithmic side (which would refute UGC unless P = NP).
Note: for fixed instance size, degree ≥ n·q SoS is exact, so the instances must grow with D.
-/
namespace OpenProblems.QEDM028

/-- A Unique Games instance over alphabet `Fin q`: `n` variables, `m` permutation constraints. -/
structure UGInstance (q : ℕ) where
  n : ℕ
  m : ℕ
  src : Fin m → Fin n
  dst : Fin m → Fin n
  perm : Fin m → Equiv.Perm (Fin q)

/-- Fraction of constraints satisfied by the labelling `f`. -/
noncomputable def UGInstance.value {q : ℕ} (I : UGInstance q) (f : Fin I.n → Fin q) : ℝ :=
  ((Finset.univ.filter (fun e : Fin I.m => I.perm e (f (I.src e)) = f (I.dst e))).card : ℝ) /
    (I.m : ℝ)

/-- The degree-2 objective polynomial: average over constraints of `∑_i x_{src,i} x_{dst,π i}`. -/
noncomputable def UGInstance.objective {q : ℕ} (I : UGInstance q) :
    MvPolynomial (Fin I.n × Fin q) ℝ :=
  MvPolynomial.C ((I.m : ℝ)⁻¹) *
    ∑ e : Fin I.m, ∑ i : Fin q,
      MvPolynomial.X (I.src e, i) * MvPolynomial.X (I.dst e, I.perm e i)

/-- `L` is a degree-`2D` SoS pseudo-expectation for the Boolean one-hot encoding of `I`. -/
def IsPseudoExpectation {q : ℕ} (I : UGInstance q) (D : ℕ)
    (L : MvPolynomial (Fin I.n × Fin q) ℝ →ₗ[ℝ] ℝ) : Prop :=
  L 1 = 1 ∧
  (∀ p : MvPolynomial (Fin I.n × Fin q) ℝ, p.totalDegree ≤ D → 0 ≤ L (p * p)) ∧
  (∀ (p : MvPolynomial (Fin I.n × Fin q) ℝ) (v : Fin I.n) (i : Fin q),
      p.totalDegree + 2 ≤ 2 * D →
      L (p * (MvPolynomial.X (v, i) * MvPolynomial.X (v, i) - MvPolynomial.X (v, i))) = 0) ∧
  (∀ (p : MvPolynomial (Fin I.n × Fin q) ℝ) (v : Fin I.n),
      p.totalDegree + 1 ≤ 2 * D →
      L (p * ((∑ i : Fin q, MvPolynomial.X (v, i)) - 1)) = 0)

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ q : ℕ, ∀ D : ℕ, ∃ I : UGInstance q,
    0 < I.m ∧
    (∀ f : Fin I.n → Fin q, I.value f ≤ ε) ∧
    ∃ L : MvPolynomial (Fin I.n × Fin q) ℝ →ₗ[ℝ] ℝ,
      IsPseudoExpectation I D L ∧ 1 - ε ≤ L I.objective

end OpenProblems.QEDM028
