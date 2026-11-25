import Mathlib
/-! QED-E196: The 6/5 integrality gap for 2-edge-connected spanning multigraphs
Given nonnegative edge costs on a complete graph, find the cheapest multiset of edges (each edge may be used
twice) such that every cut is crossed at least twice, i.e. the result is 2-edge-connected. The LP relaxation only
asks for fractional edge weights crossing every cut with total at least 2. Is the best integral solution always
within a factor 6/5 of the LP optimum?
Informal statement: Let $n\ge2$, $c\in\mathbb R_{\ge0}^{E(K_n)}$ and $x\in\mathbb R_{\ge0}^{E(K_n)}$ with
$x(\delta(S))\ge2$ for all $\emptyset\ne S\subsetneq[n]$. Prove that there is $z\in\mathbb Z_{\ge0}^{E(K_n)}$ with
$z(\delta(S))\ge2$ for all such $S$ and $c^\top z\le\tfrac65\,c^\top x$.
Formalization notes: Vertices are Fin n. An edge of K_n is a pair (i, j) with i < j; edge functions are given as
`Fin n → Fin n → ℝ` (resp. ℕ) and only the values at i < j are ever used, so values at i ≥ j are irrelevant junk
(this loses nothing and adds nothing). `cut f S` = Σ over edges ij (i < j) with exactly one endpoint in S of f i j,
i.e. f(δ(S)). `cost c f` = Σ_{i<j} c i j · f i j. A multigraph is z with z i j ∈ ℕ copies of edge ij; no upper
bound on multiplicities is imposed (with c ≥ 0, multiplicities can always be capped at 2 without breaking any cut
constraint or increasing cost, so this is the same as the "each edge at most twice" version). The cut LP is
{x ≥ 0 : x(δ(S)) ≥ 2 ∀ ∅ ≠ S ⊊ V}, without upper bounds, as in the literature on 2ECM (by parsimony it has the same
value as the subtour LP for metric costs). `Claim` = for every n ≥ 2, every nonnegative cost and every feasible
fractional x there is an integral 2-edge-connected multigraph z of cost ≤ (6/5)·cost(x), i.e. the integrality gap
is ≤ 6/5 (hence exactly 6/5 by known examples). `¬Claim` = an explicit instance with gap > 6/5.
-/
namespace OpenProblems.QEDE196

noncomputable section

open Classical

/-- f(δ(S)): total weight of edges ij (i < j) with exactly one endpoint in S. -/
def cut {n : ℕ} {R : Type} [AddCommMonoid R] (f : Fin n → Fin n → R) (S : Finset (Fin n)) : R :=
  ∑ i : Fin n, ∑ j : Fin n, if i < j ∧ (i ∈ S ↔ j ∉ S) then f i j else 0

/-- Cost Σ_{i<j} c_ij f_ij. -/
def cost {n : ℕ} (c f : Fin n → Fin n → ℝ) : ℝ :=
  ∑ i : Fin n, ∑ j : Fin n, if i < j then c i j * f i j else 0

/-- Fractional feasibility: every nonempty proper vertex subset is crossed with weight ≥ 2. -/
def CutFeasibleR {n : ℕ} (f : Fin n → Fin n → ℝ) : Prop :=
  ∀ S : Finset (Fin n), S.Nonempty → S ≠ Finset.univ → (2 : ℝ) ≤ cut f S

/-- Integral feasibility: the multigraph z is 2-edge-connected (every cut has ≥ 2 edge copies). -/
def CutFeasibleN {n : ℕ} (z : Fin n → Fin n → ℕ) : Prop :=
  ∀ S : Finset (Fin n), S.Nonempty → S ≠ Finset.univ → 2 ≤ cut z S

def Claim : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∀ c x : Fin n → Fin n → ℝ,
    (∀ i j : Fin n, 0 ≤ c i j) → (∀ i j : Fin n, 0 ≤ x i j) → CutFeasibleR x →
      ∃ z : Fin n → Fin n → ℕ, CutFeasibleN z ∧
        cost c (fun i j => (z i j : ℝ)) ≤ (6 / 5 : ℝ) * cost c x

end

end OpenProblems.QEDE196
