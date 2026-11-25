import Mathlib
/-! QED-E178: Median selection in 2.5n comparisons
How many pairwise comparisons does a deterministic algorithm need, in the worst case, to find
the median of n distinct numbers? The best algorithm uses about 2.95n comparisons and the best
lower bound is barely above 2n. Can the median always be found with (2.5 + o(1))n comparisons?
Informal statement: A comparison tree on n elements has internal nodes labelled by pairs
(i,j) ∈ [n]² (branch on x_i < x_j) and leaves labelled by an index in [n]; it computes the median
if for every injective x : [n] → ℕ, n odd, the leaf reached outputs the i with
|{j : x_j < x_i}| = (n-1)/2. Let V(n) be the minimum depth of such a tree. Claim:
V(n) ≤ (5/2 + o(1))n, i.e. ∀ε>0 ∃N ∀ odd n ≥ N: V(n) ≤ (2.5+ε)n.
Formalization notes: The model is the standard comparison-tree (decision-tree) model, in
which the worst-case number of comparisons of a deterministic comparison algorithm is exactly
the depth of its tree. `CTree n` is an inductive binary tree: `leaf k` outputs index k;
`cmp i j lt ge` compares x_i with x_j and continues in `lt` if x_i < x_j and in `ge` otherwise.
`depth` counts comparisons on the longest root-to-leaf path. Inputs are injective maps
`Fin n → ℕ` (distinct keys; only their relative order matters, so ℕ loses nothing). For odd n,
`n / 2 = (n-1)/2` in ℕ. The model is nonempty (e.g. a sorting tree of depth O(n²) computes the
median), so an existence claim is not vacuous, and `¬Claim` means there are ε > 0 and infinitely
many odd n with V(n) > (2.5+ε)n, i.e. a lower bound strictly above 2.5n infinitely often.
-/
namespace OpenProblems.QEDE178
noncomputable section

/-- Comparison trees on `n` keys. -/
inductive CTree (n : ℕ) : Type
  | leaf (k : Fin n) : CTree n
  | cmp (i j : Fin n) (lt ge : CTree n) : CTree n

namespace CTree

/-- Number of comparisons on the longest root-to-leaf path. -/
def depth {n : ℕ} : CTree n → ℕ
  | leaf _ => 0
  | cmp _ _ lt ge => max (depth lt) (depth ge) + 1

/-- The output index reached on input `x`. -/
def eval {n : ℕ} (x : Fin n → ℕ) : CTree n → Fin n
  | leaf k => k
  | cmp i j lt ge => if x i < x j then eval x lt else eval x ge

end CTree

/-- `t` outputs the median of every input with distinct keys. -/
def IsMedianTree {n : ℕ} (t : CTree n) : Prop :=
  ∀ x : Fin n → ℕ, Function.Injective x →
    (Finset.univ.filter (fun j : Fin n => x j < x (t.eval x))).card = n / 2

def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n : ℕ, N ≤ n → Odd n →
    ∃ t : CTree n, IsMedianTree t ∧ (t.depth : ℝ) ≤ (5 / 2 + ε) * (n : ℝ)

end
end OpenProblems.QEDE178
