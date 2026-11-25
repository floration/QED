import Mathlib
/-! QED-E068: Singularities of the permanental hypersurface
The hypersurface where the n×n determinant vanishes has rational singularities. Decide whether the
hypersurface where the n×n permanent vanishes has rational singularities for every n (and compute
its minimal exponent).
Informal statement: Let X_n = {per_n = 0} ⊂ 𝔸^{n²}_ℂ and α̃(X_n) Saito's minimal exponent (the
smallest root of b_{per_n}(−s)/(1−s)). X_n has rational singularities iff α̃(X_n) > 1. Decide whether
X_n has rational singularities for every n (Claim: yes). Known: α̃(X_2) = 2; for det_n,
b(s) = ∏_{i=1}^n (s+i), so α̃ = 2. The sharper questions (exact value of α̃(X_n), e.g. n = 3; is
α̃(X_n) = 2 for all n?) are not part of Claim.
Formalization notes: The Bernstein–Sato polynomial b_f is the monic generator of the ideal of
b ∈ ℂ[s] for which there is an operator P(s) = ∑_{j,α} s^j c_{j,α}(x) ∂^α in D_n[s] with
P(s) f^{s+1} = b(s) f^s. Because the evaluation s ↦ m, f^s ↦ f^m is a D-module map to ℂ[x]_f and a
polynomial identity in s holding at all m ∈ ℕ holds identically, this functional identity is
equivalent to the polynomial identities ∑ m^j c_{j,α} ∂^α(f^{m+1}) = b(m) f^m for all m ∈ ℕ, which
is how `IsBMultiple` is stated (∂^α via iterated `MvPolynomial.pderiv`). Saito: rational
singularities ⇔ α̃ > 1 ⇔ b_f(s) = (s+1)q(s) with every root of q < −1. Since b_f divides every
admissible b and (s+1) | b_f, this is equivalent to: some admissible b has the form (s+1)q with q ≠ 0
and all roots of q having real part < −1 (roots of b-functions are negative rationals). n = 0 is
excluded (per_0 = 1 is a unit).
Proving `Claim` = per_n has rational singularities for all n ≥ 1 (exhibit such operators).
Proving `¬Claim` = for some n, α̃(per_n) ≤ 1 (non-rational singularities).
-/
namespace OpenProblems.QEDE068

/-- The n×n permanent as a polynomial in the n² entries. -/
noncomputable def per (n : ℕ) : MvPolynomial (Fin n × Fin n) ℂ :=
  ∑ π : Equiv.Perm (Fin n), ∏ i : Fin n, MvPolynomial.X (i, π i)

/-- Iterated partial derivative `∂^α g` (the partials commute, so the order is irrelevant). -/
noncomputable def iterPDeriv {σ : Type*} [Fintype σ] [DecidableEq σ] (α : σ →₀ ℕ)
    (g : MvPolynomial σ ℂ) : MvPolynomial σ ℂ :=
  (Finset.univ : Finset σ).toList.foldr
    (fun i acc => (⇑(MvPolynomial.pderiv i : Derivation ℂ (MvPolynomial σ ℂ) (MvPolynomial σ ℂ)))^[α i] acc) g

/-- `b` lies in the Bernstein–Sato ideal of `f`: some `P(s) = ∑ s^j c_{j,α} ∂^α` satisfies
`P(s) f^{s+1} = b(s) f^s`, written via the equivalent identities at every `s = m ∈ ℕ`. -/
def IsBMultiple {σ : Type*} [Fintype σ] [DecidableEq σ] (f : MvPolynomial σ ℂ)
    (b : Polynomial ℂ) : Prop :=
  ∃ (S : Finset (ℕ × (σ →₀ ℕ))) (c : ℕ × (σ →₀ ℕ) → MvPolynomial σ ℂ),
    ∀ m : ℕ,
      ∑ jα ∈ S, MvPolynomial.C ((m : ℂ) ^ jα.1) * c jα * iterPDeriv jα.2 (f ^ (m + 1)) =
        MvPolynomial.C (b.eval (m : ℂ)) * f ^ m

def Claim : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∃ q : Polynomial ℂ, q ≠ 0 ∧ (∀ r : ℂ, q.IsRoot r → r.re < -1) ∧
    IsBMultiple (per n) ((Polynomial.X + 1) * q)

end OpenProblems.QEDE068
