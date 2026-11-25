import Mathlib
/-! QED-M125: A positive fraction of matroids are sparse paving
A matroid of rank r is sparse paving if its non-bases are r-sets, no two of which share r−1 elements; equivalently, all circuits have size r or r+1, and so do all circuits of its dual. These are the 'generic' matroids, and it is believed that almost all matroids on n labelled elements are of this kind. Even the much weaker statement is open: show that a fixed positive fraction of all matroids on n elements are sparse paving, for all large n.
Informal statement: Let $m_n$ be the number of matroids on the ground set $[n]$ and $s_n$ the number of sparse paving matroids on $[n]$ (rank $r$ matroids whose set $\mathcal N$ of non-bases is a family of $r$-subsets with $|X\triangle Y|\ge 4$ for distinct $X,Y\in\mathcal N$). Claim: $\liminf_{n\to\infty} s_n/m_n>0$.
Formalization notes:
* A matroid on the labelled ground set `Fin n` is identified with its family of bases
  ℬ ⊆ 2^[n], characterised by the standard base axioms: ℬ nonempty, and the exchange axiom
  (for B₁, B₂ ∈ ℬ and x ∈ B₁ \ B₂ there is y ∈ B₂ \ B₁ with (B₁ − x) + y ∈ ℬ). This is a
  bijection between matroids on [n] and such families, so `m n` counts labelled matroids.
  (All bases then have a common size, the rank.)
* Sparse paving: there is r such that every base has size r, and the non-bases
  𝒩 = (r-subsets) \ ℬ satisfy |X Δ Y| ≥ 4 for distinct X, Y ∈ 𝒩, with X Δ Y written as
  (X \ Y) ∪ (Y \ X). `s n` counts base families that are both matroids and sparse paving.
* m n ≥ 1 (e.g. ℬ = {∅}), so liminf s_n/m_n > 0 is equivalent to: ∃ c > 0 and N₀ with
  c·m n ≤ s n for all n ≥ N₀. That is `Claim`. `¬Claim` means liminf s_n/m_n = 0.
-/
namespace OpenProblems.QEDM125
noncomputable section
open Classical

/-- `ℬ` satisfies the matroid base axioms on ground set `Fin n`. -/
def IsMatroidBases {n : ℕ} (ℬ : Finset (Finset (Fin n))) : Prop :=
  ℬ.Nonempty ∧
    ∀ B₁ ∈ ℬ, ∀ B₂ ∈ ℬ, ∀ x ∈ B₁ \ B₂, ∃ y ∈ B₂ \ B₁, insert y (B₁.erase x) ∈ ℬ

/-- The matroid with bases `ℬ` is sparse paving. -/
def IsSparsePaving {n : ℕ} (ℬ : Finset (Finset (Fin n))) : Prop :=
  ∃ r : ℕ, (∀ B ∈ ℬ, B.card = r) ∧
    ∀ X ∈ (Finset.univ : Finset (Fin n)).powersetCard r \ ℬ,
    ∀ Y ∈ (Finset.univ : Finset (Fin n)).powersetCard r \ ℬ,
      X ≠ Y → 4 ≤ ((X \ Y) ∪ (Y \ X)).card

/-- Number of matroids on `Fin n`. -/
def m (n : ℕ) : ℕ :=
  ((Finset.univ : Finset (Finset (Finset (Fin n)))).filter
    (fun ℬ : Finset (Finset (Fin n)) => IsMatroidBases ℬ)).card

/-- Number of sparse paving matroids on `Fin n`. -/
def s (n : ℕ) : ℕ :=
  ((Finset.univ : Finset (Finset (Finset (Fin n)))).filter
    (fun ℬ : Finset (Finset (Fin n)) => IsMatroidBases ℬ ∧ IsSparsePaving ℬ)).card

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∃ N₀ : ℕ, ∀ n : ℕ, N₀ ≤ n → c * (m n : ℝ) ≤ (s n : ℝ)

end
end OpenProblems.QEDM125
