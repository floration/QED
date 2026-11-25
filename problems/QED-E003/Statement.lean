import Mathlib
/-! QED-E003: Keller monodromy is everything
Informal statement (narrowed per referee): for every n ≥ 4 with n ≢ 3 (mod 4) and n not of
the form k·d with k odd ≥ 3 and d ≥ 3 (first cases n = 4,5,6,8,10,13,14,16,17), there is a
polynomial map F : ℂ³ → ℂ³ with det JF ∈ ℂ^×, geometric degree [ℂ(x) : ℂ(F)] = n, and
geometric monodromy group S_n. (Other n are done by Kistner–Shaska, arXiv 2608.02863,
Thms 6.1, 6.5.)
Formalization notes: K = FractionRing (MvPolynomial (Fin 3) ℂ) = ℂ(x₁,x₂,x₃); the base field
is the intermediate field ℂ(F₁,F₂,F₃) = `IntermediateField.adjoin ℂ (range F)`. The Jacobian
condition is det (∂F_i/∂x_j) = C c with c ≠ 0. Geometric degree is `finrank L K = n` (n ≥ 4 > 0
forces finiteness, so no finrank junk). Since ℂ is algebraically closed the geometric
monodromy group is Gal(N/L), N the Galois closure of K/L. Taking a primitive element α
(minpoly of degree n, so K = L(α)), N is the splitting field of minpoly L α, and the Galois
group, a transitive subgroup of S_n, equals S_n iff it has order n!. ¬Claim: some listed n
has no Keller map of that degree with full symmetric monodromy.
-/
namespace OpenProblems.QEDE003
noncomputable section

abbrev Poly3 := MvPolynomial (Fin 3) ℂ

/-- The rational function field ℂ(x₁, x₂, x₃). -/
abbrev K3 := FractionRing Poly3

/-- Jacobian matrix `(∂F_i/∂x_j)`. -/
def jacobian (F : Fin 3 → Poly3) : Matrix (Fin 3) (Fin 3) Poly3 :=
  Matrix.of fun i j => MvPolynomial.pderiv j (F i)

/-- Keller map: the Jacobian determinant is a nonzero constant. -/
def IsKeller (F : Fin 3 → Poly3) : Prop :=
  ∃ c : ℂ, c ≠ 0 ∧ (jacobian F).det = MvPolynomial.C c

/-- The subfield `ℂ(F₁, F₂, F₃) ⊆ ℂ(x₁, x₂, x₃)`. -/
def baseField (F : Fin 3 → Poly3) : IntermediateField ℂ K3 :=
  IntermediateField.adjoin ℂ (Set.range fun i => algebraMap Poly3 K3 (F i))

/-- Geometric degree `n` and monodromy group `S_n`. -/
def HasDegreeAndFullMonodromy (F : Fin 3 → Poly3) (n : ℕ) : Prop :=
  Module.finrank (baseField F) K3 = n ∧
    ∃ α : K3, (minpoly (baseField F) α).natDegree = n ∧
      Nat.card (minpoly (baseField F) α).Gal = n.factorial

/-- Degrees already covered by Kistner–Shaska. -/
def KnownDegree (n : ℕ) : Prop :=
  n % 4 = 3 ∨ ∃ k d : ℕ, Odd k ∧ 3 ≤ k ∧ 3 ≤ d ∧ n = k * d

def Claim : Prop :=
  ∀ n : ℕ, 4 ≤ n → ¬ KnownDegree n →
    ∃ F : Fin 3 → Poly3, IsKeller F ∧ HasDegreeAndFullMonodromy F n

end
end OpenProblems.QEDE003
