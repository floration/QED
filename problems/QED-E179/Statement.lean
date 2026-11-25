import Mathlib
/-! QED-E179: Randomized query complexity of monotone graph properties beyond n^{4/3}
A graph property on n vertices is monotone if adding edges never destroys it (like connectivity or
containing a triangle). A randomized algorithm may ask whether individual edges are present and
must answer correctly with probability at least 2/3. Every nontrivial monotone property is believed
to need about n^2 queries, but since Hajnal (1991) and Chakrabarti-Khot (2001) the best general
lower bound has been stuck at roughly n^{4/3}. Can the exponent 4/3 be improved?
Informal statement: For a graph property f of n-vertex graphs (invariant under relabelling the
vertices), monotone increasing and nontrivial (the empty graph lacks it, the complete graph has
it), let R(f) be the bounded-error randomized decision-tree complexity: the least d such that some
probability distribution over deterministic decision trees of depth ≤ d, each querying "is {i,j}
an edge?", outputs f(G) with probability ≥ 2/3 for every graph G. Prove there exist ε > 0 and
c > 0 such that R(f) ≥ c·n^{4/3+ε} for every n and every such f.
Formalization notes:
* Graphs are `SimpleGraph (Fin n)`; a property is `f : SimpleGraph (Fin n) → Bool`.
  Invariance: if `H.Adj i j ↔ G.Adj (σ i) (σ j)` for a permutation σ, then f H = f G.
  Monotone: `G ≤ H → f G = true → f H = true`. Nontrivial: f ⊥ = false, f ⊤ = true (for a
  monotone f this is the same as being non-constant).
* Decision trees (`DTree`) query ordered pairs `(i,j) : Fin n × Fin n` and receive
  `G.Adj i j`. Querying diagonal pairs (always false) or both orders of a pair is merely redundant,
  so the minimal depth is exactly the usual edge-query complexity. Depth = longest root–leaf path.
* A randomized tree of depth ≤ d is a finite convex combination of deterministic trees of depth
  ≤ d (weights `w i ≥ 0` summing to 1). This loses nothing: trees of depth ≤ d over a finite query
  set realise only finitely many functions-with-query-behaviour, and the success probability of an
  arbitrary distribution depends only on the induced distribution over those. `RandSolves f d`
  requires success probability ≥ 2/3 on every graph (two-sided bounded error, the standard R(f)).
* Claim: ∃ ε > 0, c > 0, ∀ n f (graph property, monotone, nontrivial), ∀ d, RandSolves f d →
  c·n^{4/3+ε} ≤ d, i.e. R(f) ≥ c·n^{4/3+ε}. For n ≤ 1 no nontrivial property exists (⊥ = ⊤),
  so small n impose nothing. Proving `Claim` = beating the 4/3 exponent; `¬Claim` = for every
  ε > 0 nontrivial monotone graph properties with R(f) = O(n^{4/3+ε}) along a subsequence
  (which would refute the randomized Aanderaa–Karp–Rosenberg conjecture).
-/
namespace OpenProblems.QEDE179
noncomputable section
open Classical

/-- Boolean decision trees querying bits indexed by `α`, with leaves labelled in `γ`.
`node a t₀ t₁` queries bit `a` and continues in `t₀` if it is `false`, in `t₁` if `true`. -/
inductive DTree (α : Type) (γ : Type) : Type where
  | leaf : γ → DTree α γ
  | node : α → DTree α γ → DTree α γ → DTree α γ

/-- Evaluation of a decision tree on the input `x`. -/
def DTree.eval {α γ : Type} (x : α → Bool) : DTree α γ → γ
  | DTree.leaf c => c
  | DTree.node a t₀ t₁ => if x a = true then DTree.eval x t₁ else DTree.eval x t₀

/-- Depth (number of queries on the longest root-leaf path). -/
def DTree.depth {α γ : Type} : DTree α γ → ℕ
  | DTree.leaf _ => 0
  | DTree.node _ t₀ t₁ => max (DTree.depth t₀) (DTree.depth t₁) + 1

/-- The edge-query oracle of a graph: query `(i, j)` answers whether `ij` is an edge. -/
def adjBits {n : ℕ} (G : SimpleGraph (Fin n)) : Fin n × Fin n → Bool :=
  fun p => decide (G.Adj p.1 p.2)

/-- `f` is a graph property: invariant under relabelling vertices. -/
def IsGraphProperty {n : ℕ} (f : SimpleGraph (Fin n) → Bool) : Prop :=
  ∀ (σ : Equiv.Perm (Fin n)) (G H : SimpleGraph (Fin n)),
    (∀ i j : Fin n, H.Adj i j ↔ G.Adj (σ i) (σ j)) → f H = f G

/-- `f` is monotone increasing. -/
def IsMonotoneProp {n : ℕ} (f : SimpleGraph (Fin n) → Bool) : Prop :=
  ∀ G H : SimpleGraph (Fin n), G ≤ H → f G = true → f H = true

/-- `f` is nontrivial. -/
def IsNontrivialProp {n : ℕ} (f : SimpleGraph (Fin n) → Bool) : Prop :=
  f ⊥ = false ∧ f ⊤ = true

/-- Some finite probability distribution over decision trees of depth ≤ `d` computes `f` with
success probability at least `2/3` on every graph. -/
def RandSolves {n : ℕ} (f : SimpleGraph (Fin n) → Bool) (d : ℕ) : Prop :=
  ∃ (m : ℕ) (T : Fin m → DTree (Fin n × Fin n) Bool) (w : Fin m → ℝ),
    (∀ i : Fin m, 0 ≤ w i) ∧ (∑ i : Fin m, w i) = 1 ∧ (∀ i : Fin m, (T i).depth ≤ d) ∧
    ∀ G : SimpleGraph (Fin n),
      (2 / 3 : ℝ) ≤ ∑ i ∈ Finset.univ.filter (fun i : Fin m => (T i).eval (adjBits G) = f G), w i

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∃ c : ℝ, 0 < c ∧
    ∀ (n : ℕ) (f : SimpleGraph (Fin n) → Bool),
      IsGraphProperty f → IsMonotoneProp f → IsNontrivialProp f →
        ∀ d : ℕ, RandSolves f d → c * (n : ℝ) ^ ((4 : ℝ) / 3 + ε) ≤ (d : ℝ)

end
end OpenProblems.QEDE179
