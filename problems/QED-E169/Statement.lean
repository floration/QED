import Mathlib
/-! QED-E169: Ehrhart positivity of the Birkhoff polytope
Let H_n(t) be the number of n × n matrices of nonnegative integers whose rows and columns all
sum to t. For fixed n, H_n(t) is a polynomial in t of degree (n-1)². Are all of its
coefficients positive, for every n?
Informal statement: Let H_n(t) = #{A ∈ ℤ_{≥0}^{n×n} : A𝟏 = Aᵀ𝟏 = t𝟏}, the Ehrhart polynomial
of the Birkhoff polytope B_n. Prove or disprove: for every n ≥ 1, every coefficient of t^i in
H_n(t), 0 ≤ i ≤ (n-1)², is strictly positive.
Formalization notes: `semiMagic n t` counts matrices `A : Fin n → Fin n → Fin (t+1)` with all
row and column sums equal to t; entries of such matrices are automatically ≤ t, so bounding
them by `Fin (t+1)` loses nothing and makes the set finite. Polynomiality and the degree
(n-1)² are classical (Ehrhart; dim B_n = (n-1)²), so the existential quantifier over
`p : Polynomial ℚ` is not where the content lies: the unique polynomial agreeing with H_n on
all t ∈ ℕ is the Ehrhart polynomial, and the Claim asks that all its coefficients of index
≤ (n-1)² be positive. `Claim` = Ehrhart positivity of B_n for all n ≥ 1; `¬Claim` = some n for
which the Ehrhart polynomial has a coefficient ≤ 0 (since the polynomial exists with the stated
degree, ¬Claim cannot be obtained by a degree/polynomiality loophole).
-/
namespace OpenProblems.QEDE169
noncomputable section

/-- Number of n × n nonnegative integer matrices with all row and column sums equal to t. -/
def semiMagic (n t : ℕ) : ℕ :=
  (Finset.univ.filter (fun A : Fin n → Fin n → Fin (t + 1) =>
    (∀ i : Fin n, ∑ j : Fin n, ((A i j : ℕ)) = t) ∧
    (∀ j : Fin n, ∑ i : Fin n, ((A i j : ℕ)) = t))).card

def Claim : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∃ p : Polynomial ℚ, p.natDegree = (n - 1) ^ 2 ∧
    (∀ t : ℕ, p.eval (t : ℚ) = (semiMagic n t : ℚ)) ∧
    ∀ i : ℕ, i ≤ (n - 1) ^ 2 → 0 < p.coeff i

end
end OpenProblems.QEDE169
