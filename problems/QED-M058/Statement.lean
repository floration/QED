import Mathlib
/-! QED-M058: Beat the (1-o(1)) log2 d exponent in quasi-polynomial polytope diameter bounds
All known bounds on the diameter of a d-dimensional polyhedron with n facets have the form
(n-d)^{log2 d - O(log log d)} (Kalai-Kleitman and refinements). Improve the exponent to
(1-ε) log2 d.
Informal statement: Let Δ_u(d,n) be the maximum graph diameter of a pointed d-polyhedron with n
facets. Known: Δ_u(d,n) <= (n-d)^{log2 G_d}, G_d = (4 ln 2 + o(1)) d/(ln d)^2 (Liu-Ge-Ye 2026),
after Kalai-Kleitman, Todd, Sukegawa. Prove Δ_u(d,n) <= (n-d)^{(1-ε) log2 d} for some fixed ε > 0
and all large d.
Formalization notes: A polyhedron is P = {x ∈ R^d : <A_i, x> <= b_i, i < n}, with rows
A_i : Fin d → ℝ. It is required to be full-dimensional (a point satisfying all inequalities
strictly), so no inequality is an implicit equality and P has at most n facets; conversely a
d-polyhedron with m <= n facets is of this form, and the target bound is monotone in n, so
quantifying over n inequalities is equivalent to quantifying over n facets. A vertex is a point
of P whose active rows span R^d. Two distinct vertices x, y are adjacent iff the rows active at
both span a subspace of dimension d-1 (the smallest face containing both is then 1-dimensional,
i.e. an edge). Pointedness is implicit (the statement is vacuous without vertices). The diameter
bound says any two vertices are joined by an edge path of length at most (n-d)^{(1-ε) log2 d}
(real power; base n-d >= 0 whenever a vertex exists). Proving Claim gives the improved exponent;
proving ¬Claim shows that for every ε > 0 there are arbitrarily large d with a polyhedron whose
diameter exceeds (n-d)^{(1-ε) log2 d}.
-/
namespace OpenProblems.QEDM058

/-- Standard dot product on ℝ^d. -/
noncomputable def dot {d : ℕ} (a x : Fin d → ℝ) : ℝ := ∑ j : Fin d, a j * x j

/-- `x` lies in the polyhedron {x | A x <= b}. -/
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

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ D : ℕ, ∀ d : ℕ, D ≤ d →
    ∀ (n : ℕ) (A : Fin n → Fin d → ℝ) (b : Fin n → ℝ),
      (∃ x₀ : Fin d → ℝ, ∀ i : Fin n, dot (A i) x₀ < b i) →
      ∀ x y : Fin d → ℝ, IsVertex A b x → IsVertex A b y →
        ∃ k : ℕ, (k : ℝ) ≤ ((n : ℝ) - (d : ℝ)) ^ ((1 - ε) * Real.logb 2 (d : ℝ)) ∧
          ReachableWithin (IsEdge A b) k x y

end OpenProblems.QEDM058
