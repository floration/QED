import Mathlib
/-! QED-E194: Uniform spectral gap for the spin-2 Heisenberg antiferromagnetic ring
Put a quantum spin of size 2 at each site of a ring of L sites (L even) and couple neighbours by the
antiferromagnetic Heisenberg interaction; the Hamiltonian is an explicit Hermitian matrix of size 5^L whose
lowest eigenvalue is simple. Prove that the gap between the lowest and second-lowest eigenvalue stays above a
fixed positive constant for all even L.
Informal statement: Let $S^x,S^y,S^z$ be the spin-2 matrices on $\mathbb C^5$ and, for even $L\ge 4$,
$H_L=\sum_{i\in\mathbb Z/L\mathbb Z}\vec S_i\cdot\vec S_{i+1}$ acting on $(\mathbb C^5)^{\otimes L}$, with
eigenvalues (counted with multiplicity) $\lambda_1(L)\le\lambda_2(L)\le\cdots$. Prove that
$\inf_{L\ \mathrm{even},\,L\ge4}\big(\lambda_2(L)-\lambda_1(L)\big)>0$.
Formalization notes: The Hilbert space $(\mathbb C^5)^{\otimes L}$ is modelled in its product basis: vectors are
functions `(Fin L → Fin 5) → ℂ` and operators are matrices indexed by configurations σ : Fin L → Fin 5. The
basis index b : Fin 5 stands for the S^z-eigenvalue m = b − 2 ∈ {−2,…,2}. The spin matrices are the standard ones:
S^z = diag(m), S^+|m⟩ = √(S(S+1) − m(m+1)) |m+1⟩ with S = 2 (so S(S+1) = 6), S^- = (S^+)^T (real entries),
S^x = (S^+ + S^-)/2, S^y = (S^+ − S^-)/(2i). For single-site operators A, B and distinct sites i ≠ j, `bond A B i j`
is the matrix of A_i ⊗ B_j ⊗ (identity elsewhere) in the product basis: its (σ, τ) entry is
A(σ_i, τ_i) · B(σ_j, τ_j) if σ and τ agree off {i, j}, and 0 otherwise. The ring neighbour of i is
`finRotate L i` (i+1 mod L); for L ≥ 4 it differs from i. H_L = Σ_i Σ_{α ∈ {x,y,z}} S^α_i S^α_{i+1}; it is Hermitian.
Instead of sorting eigenvalues, the gap condition is stated by min–max: for Hermitian H, λ₂ − λ₁ ≥ c holds iff
there are an eigenvector ψ ≠ 0 with eigenvalue E such that every v ⊥ ψ satisfies ⟨v, Hv⟩ ≥ (E + c)‖v‖².
(⇒: take ψ a ground state. ⇐: the orthogonal complement of ψ is H-invariant and H ≥ E + c there, so the spectrum
is {E} together with eigenvalues ≥ E + c, hence E = λ₁ is simple and λ₂ ≥ λ₁ + c.) The inner product is
⟨u, v⟩ = Σ_σ conj(u σ) v σ and ‖v‖² = Σ_σ |v σ|².
`Claim` = there is c > 0 such that for every even L ≥ 4 the gap λ₂(L) − λ₁(L) is at least c (equivalent to
inf > 0). `¬Claim` = the gaps along even L accumulate at 0 (spin-2 chain not uniformly gapped).
-/
namespace OpenProblems.QEDE194

noncomputable section

open Matrix

/-- S^z-eigenvalue m = b − 2 of basis index b. -/
def mval (b : Fin 5) : ℝ := (b.val : ℝ) - 2

/-- Raising operator S^+ for spin 2: S^+|m⟩ = √(6 − m(m+1)) |m+1⟩. -/
def Splus : Matrix (Fin 5) (Fin 5) ℂ :=
  Matrix.of fun a b : Fin 5 =>
    if a.val = b.val + 1 then ((Real.sqrt (6 - mval b * (mval b + 1)) : ℝ) : ℂ) else 0

/-- Lowering operator S^- = (S^+)^T (entries are real). -/
def Sminus : Matrix (Fin 5) (Fin 5) ℂ :=
  Matrix.of fun a b : Fin 5 => Splus b a

/-- S^x = (S^+ + S^-)/2. -/
def Sx : Matrix (Fin 5) (Fin 5) ℂ := ((1 : ℂ) / 2) • (Splus + Sminus)

/-- S^y = (S^+ − S^-)/(2i) = (−i/2)(S^+ − S^-). -/
def Sy : Matrix (Fin 5) (Fin 5) ℂ := (-Complex.I / 2) • (Splus - Sminus)

/-- S^z = diag(m). -/
def Sz : Matrix (Fin 5) (Fin 5) ℂ := Matrix.diagonal fun b : Fin 5 => ((mval b : ℝ) : ℂ)

/-- The operator A_i ⊗ B_j (identity on the other sites) on (ℂ^5)^{⊗L}, in the product basis. -/
def bond (L : ℕ) (A B : Matrix (Fin 5) (Fin 5) ℂ) (i j : Fin L) :
    Matrix (Fin L → Fin 5) (Fin L → Fin 5) ℂ :=
  Matrix.of fun σ τ : Fin L → Fin 5 =>
    A (σ i) (τ i) * B (σ j) (τ j) *
      (if (∀ k : Fin L, k ≠ i → k ≠ j → σ k = τ k) then (1 : ℂ) else 0)

/-- The spin-2 Heisenberg ring Hamiltonian H_L = Σ_i S_i · S_{i+1}. -/
def H (L : ℕ) : Matrix (Fin L → Fin 5) (Fin L → Fin 5) ℂ :=
  ∑ i : Fin L,
    (bond L Sx Sx i (finRotate L i) + bond L Sy Sy i (finRotate L i) +
      bond L Sz Sz i (finRotate L i))

/-- Inner product ⟨u, v⟩ = Σ conj(u σ) v σ. -/
def inner5 (L : ℕ) (u v : (Fin L → Fin 5) → ℂ) : ℂ :=
  ∑ σ : Fin L → Fin 5, star (u σ) * v σ

/-- Squared norm ‖v‖². -/
def normSq5 (L : ℕ) (v : (Fin L → Fin 5) → ℂ) : ℝ :=
  ∑ σ : Fin L → Fin 5, Complex.normSq (v σ)

/-- λ₂(H_L) − λ₁(H_L) ≥ c, stated via min–max: an eigenvector ψ with eigenvalue E such that
the quadratic form is ≥ (E + c)‖v‖² on ψ^⊥. -/
def GapAtLeast (L : ℕ) (c : ℝ) : Prop :=
  ∃ ψ : (Fin L → Fin 5) → ℂ, ψ ≠ 0 ∧ ∃ E : ℝ,
    (H L).mulVec ψ = (E : ℂ) • ψ ∧
    ∀ v : (Fin L → Fin 5) → ℂ, inner5 L ψ v = 0 →
      (E + c) * normSq5 L v ≤ (inner5 L v ((H L).mulVec v)).re

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∀ L : ℕ, Even L → 4 ≤ L → GapAtLeast L c

end

end OpenProblems.QEDE194
