import Mathlib
/-! N-687: Additive excess for sorting pattern-avoiding sequences
Sorting an input promised to avoid a fixed pattern τ needs at least log2 |Av_n(τ)| comparisons,
and Fredman's theorem gives log2 |Av_n(τ)| + 2n. Is the excess always o(n)?
Informal statement: For a permutation τ let C_τ(n) be the minimum worst-case number of comparisons of a decision tree (knowing τ) that sorts a_1,…,a_n under the promise that their order pattern lies in Av_n(τ), and δ_τ = limsup_n (C_τ(n) − log_2|Av_n(τ)|)/n ∈ [0,2]. Prove or disprove: δ_τ = 0 for every permutation τ.
Formalization notes: An input order is a permutation σ of Fin n, where σ i is the rank of a_i;
the comparison "a_i < a_j?" is σ i < σ j. A comparison tree (`CompTree n`) has leaves labelled by
permutations and internal nodes labelled by a pair (i, j); `run t σ` follows the comparisons and
returns the leaf label. A tree sorts the class if `run t σ = σ` for every σ avoiding τ. Depth is
the worst-case number of comparisons. σ contains τ (of length k) if some strictly increasing
e : Fin k → Fin n has σ(e a) < σ(e b) ↔ τ a < τ b. δ_τ = 0 is encoded as: for every ε > 0 and
all large n there is a sorting tree of depth <= log2 |Av_n(τ)| + εn (δ_τ >= 0 is automatic).
For patterns of length <= 2 the statement is trivial (|Av_n| <= 1). Proving Claim answers yes
for all τ; proving ¬Claim exhibits a τ with δ_τ > 0. The weaker target δ_1324 < 2 from the
original is not encoded. Known: 0 <= δ_τ <= 2 (Fredman 1976).
-/
namespace OpenProblems.N687

/-- Comparison decision trees on n keys. -/
inductive CompTree (n : ℕ) where
  | leaf : Equiv.Perm (Fin n) → CompTree n
  | node : Fin n → Fin n → CompTree n → CompTree n → CompTree n

/-- Run a comparison tree on the input whose order is `σ` (σ i = rank of the i-th key).
At `node i j l r` go left iff key i is smaller than key j. -/
def CompTree.run {n : ℕ} : CompTree n → Equiv.Perm (Fin n) → Equiv.Perm (Fin n)
  | CompTree.leaf π, _ => π
  | CompTree.node i j l r, σ => if σ i < σ j then CompTree.run l σ else CompTree.run r σ

/-- Worst-case number of comparisons. -/
def CompTree.depth {n : ℕ} : CompTree n → ℕ
  | CompTree.leaf _ => 0
  | CompTree.node _ _ l r => max (CompTree.depth l) (CompTree.depth r) + 1

/-- `σ` contains the pattern `τ`. -/
def Contains {k n : ℕ} (τ : Equiv.Perm (Fin k)) (σ : Equiv.Perm (Fin n)) : Prop :=
  ∃ e : Fin k → Fin n, StrictMono e ∧ ∀ a b : Fin k, (σ (e a) < σ (e b) ↔ τ a < τ b)

/-- |Av_n(τ)|. -/
noncomputable def avCount {k : ℕ} (τ : Equiv.Perm (Fin k)) (n : ℕ) : ℕ :=
  Nat.card {σ : Equiv.Perm (Fin n) // ¬ Contains τ σ}

/-- `t` sorts every input whose order pattern avoids `τ`. -/
def SortsAv {k n : ℕ} (τ : Equiv.Perm (Fin k)) (t : CompTree n) : Prop :=
  ∀ σ : Equiv.Perm (Fin n), ¬ Contains τ σ → CompTree.run t σ = σ

def Claim : Prop :=
  ∀ (k : ℕ) (τ : Equiv.Perm (Fin k)) (ε : ℝ), 0 < ε →
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
      ∃ t : CompTree n, SortsAv τ t ∧
        (CompTree.depth t : ℝ) ≤ Real.logb 2 (avCount τ n : ℝ) + ε * (n : ℝ)

end OpenProblems.N687
