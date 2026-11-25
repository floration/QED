import Mathlib
/-! N-669: Deciding limit cycles
Given a planar polynomial vector field with rational coefficients, is it algorithmically decidable whether it has a limit cycle (an isolated non-constant periodic orbit)?
Informal statement: Let $\mathcal L=\{(P,Q)\in\mathbb Q[x,y]^2:\ \dot x=P,\dot y=Q$ has a limit cycle, i.e. a non-constant periodic orbit that has a neighbourhood containing no other periodic orbit$\}$ and $\mathcal P=\{(P,Q):$ the system has a non-constant periodic orbit in $\mathbb R^2\}$, with inputs given by their rational coefficient lists (degree unbounded). (a) Is $\mathcal L$ decidable? (b) Is $\mathcal P$ decidable? (c) Are $\mathcal L,\mathcal P$ or their complements recursively enumerable? (d) Same questions restricted to degree 2.
Formalization notes: Only part (a) is formalized (decidability of L); parts (b)-(d) are follow-ups. Inputs are pairs of lists of monomial terms with rational coefficients coded by naturals (a,b,c) |-> (a-b)/(c+1); this type is Primcodable, and the predicate depends only on the polynomial functions, so the encoding (duplicates, zero terms) is irrelevant. A periodic orbit is a globally defined C^1 solution gamma : R -> R^2 of gamma' = F(gamma) that is periodic with some period T > 0 and non-constant (equilibria excluded). A limit cycle is such an orbit with an open set U containing its image such that every periodic orbit whose image lies in U has the same image. Decidability is Mathlib's ComputablePred. Proving Claim = exhibiting an algorithm; proving ¬Claim = showing L is undecidable.
-/
namespace OpenProblems.N669

/-- A rational coefficient encoded by three naturals `(a, b, c)`, standing for `(a - b) / (c + 1)`.
Every rational number has such a code. -/
noncomputable def coefVal (r : ℕ × ℕ × ℕ) : ℝ :=
  ((r.1 : ℝ) - (r.2.1 : ℝ)) / ((r.2.2 : ℝ) + 1)

/-- A polynomial in `x, y` with rational coefficients, encoded as a finite list of terms
`((i, j), r)`, each standing for `coefVal r * x ^ i * y ^ j` (repeated monomials are added). -/
abbrev PolyCode : Type := List ((ℕ × ℕ) × (ℕ × ℕ × ℕ))

/-- Evaluation of an encoded polynomial at a point of the plane. -/
noncomputable def evalPoly (l : PolyCode) (z : ℝ × ℝ) : ℝ :=
  (l.map (fun t : (ℕ × ℕ) × (ℕ × ℕ × ℕ) => coefVal t.2 * z.1 ^ t.1.1 * z.2 ^ t.1.2)).sum

/-- An input: the pair `(P, Q)` of encoded polynomials (degree unbounded). -/
abbrev FieldCode : Type := PolyCode × PolyCode

/-- The planar vector field `(P, Q)` defined by an input. -/
noncomputable def field (c : FieldCode) (z : ℝ × ℝ) : ℝ × ℝ :=
  (evalPoly c.1 z, evalPoly c.2 z)

/-- `γ` is a non-constant periodic solution of `z' = F z`. -/
def IsPeriodicOrbit (F : ℝ × ℝ → ℝ × ℝ) (γ : ℝ → ℝ × ℝ) : Prop :=
  (∀ t : ℝ, HasDerivAt γ (F (γ t)) t) ∧
  (∃ T : ℝ, 0 < T ∧ Function.Periodic γ T) ∧
  (∃ s t : ℝ, γ s ≠ γ t)

/-- `F` has a limit cycle: a non-constant periodic orbit with an open neighbourhood of its image
that contains (the image of) no other non-constant periodic orbit. -/
def HasLimitCycle (F : ℝ × ℝ → ℝ × ℝ) : Prop :=
  ∃ γ : ℝ → ℝ × ℝ, IsPeriodicOrbit F γ ∧
    ∃ U : Set (ℝ × ℝ), IsOpen U ∧ Set.range γ ⊆ U ∧
      ∀ δ : ℝ → ℝ × ℝ, IsPeriodicOrbit F δ → Set.range δ ⊆ U → Set.range δ = Set.range γ

/-- Part (a): the set of rational planar polynomial vector fields having a limit cycle is decidable. -/
def Claim : Prop :=
  ComputablePred (fun c : FieldCode => HasLimitCycle (field c))

end OpenProblems.N669
