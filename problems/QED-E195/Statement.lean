import Mathlib
/-! QED-E195: Is the Held–Karp integrality ratio for asymmetric TSP equal to 2?
In the asymmetric traveling salesman problem the distance from a to b may differ from b to a, but the triangle inequality holds. The Held–Karp linear program assigns fractional weights to directed arcs so that every city has in-weight and out-weight 1 and every proper set of cities has out-weight at least 1. Is the cheapest directed tour always at most twice the LP value? A factor 2 is known to be necessary; the best proven factor is 22 in refereed work and about 14.8 in a 2026 preprint.
Informal statement: Let $n\ge2$ and $c:[n]\times[n]\to\mathbb R_{\ge0}$ with $c(u,w)\le c(u,v)+c(v,w)$ for all $u,v,w$ (not necessarily symmetric). Let $x\ge0$ be defined on arcs $(u,v)$, $u\ne v$, with $x(\delta^+(v))=x(\delta^-(v))=1$ for all $v$ and $x(\delta^+(S))\ge1$ for all $\emptyset\ne S\subsetneq[n]$. Prove or disprove: there is a cyclic ordering $v_1,\dots,v_n$ of $[n]$ with $\sum_{i=1}^n c(v_i,v_{i+1})\le 2\sum_{(u,v)}c(u,v)x_{uv}$ (indices mod $n$). Since the integrality ratio is known to be $\ge2$ (Charikar–Goemans–Karloff), a proof shows it equals $2$.
Formalization notes: Cities are `Fin n`, n ≥ 2. Costs `c : Fin n → Fin n → ℝ`, nonnegative, satisfying the
directed triangle inequality (no symmetry assumed; the loop values c v v are never used). A Held–Karp point is
`x : Fin n → Fin n → ℝ` with x ≥ 0, x v v = 0 (no loops), out-degree and in-degree 1 at every vertex, and
out-cut ∑_{u∈S, w∉S} x u w ≥ 1 for every nonempty proper S. A directed Hamiltonian tour is a permutation σ of
`Fin n` which is a single cycle through all vertices (`σ.IsCycle ∧ σ.support = univ`); its cost is
∑_v c v (σ v). Quantifying over every feasible x (not only an optimal one) is equivalent to bounding by
2·(LP optimum), since the LP minimum is attained on the compact feasible polytope. Claim true ⇒ the
integrality ratio of Held–Karp for ATSP is exactly 2 (with the Charikar–Goemans–Karloff lower bound);
¬Claim ⇒ the ratio exceeds 2 (some instance and feasible x beat every tour by more than factor 2).
-/
namespace OpenProblems.QEDE195
noncomputable section

/-- Feasible points of the Held–Karp (subtour elimination) LP for ATSP on `Fin n`. -/
def HeldKarpFeasible (n : ℕ) (x : Fin n → Fin n → ℝ) : Prop :=
  (∀ u w : Fin n, 0 ≤ x u w) ∧
  (∀ v : Fin n, x v v = 0) ∧
  (∀ v : Fin n, ∑ w : Fin n, x v w = 1) ∧
  (∀ v : Fin n, ∑ w : Fin n, x w v = 1) ∧
  (∀ S : Finset (Fin n), S.Nonempty → S ≠ Finset.univ →
    1 ≤ ∑ u ∈ S, ∑ w ∈ Finset.univ \ S, x u w)

def Claim : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∀ c : Fin n → Fin n → ℝ,
    (∀ u w : Fin n, 0 ≤ c u w) →
    (∀ u v w : Fin n, c u w ≤ c u v + c v w) →
    ∀ x : Fin n → Fin n → ℝ, HeldKarpFeasible n x →
      ∃ σ : Equiv.Perm (Fin n), σ.IsCycle ∧ σ.support = Finset.univ ∧
        ∑ v : Fin n, c v (σ v) ≤ 2 * ∑ u : Fin n, ∑ w : Fin n, c u w * x u w

end
end OpenProblems.QEDE195
