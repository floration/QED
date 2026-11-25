import Mathlib
/-! QED-M132: The 4/3 integrality gap of the subtour LP for metric TSP
Take n cities with distances that satisfy the triangle inequality. The subtour LP relaxes 'pick a tour' to 'put fractional weights on the roads so every city has total weight 2, and every split of the cities into two groups is crossed by total weight at least 2'. Is the cheapest tour always at most 4/3 times the cheapest fractional solution? Known examples show 4/3 cannot be lowered; the best proven factor is only slightly below 3/2.
Informal statement: Let $n\ge3$ and let $c:\binom{[n]}{2}\to\mathbb R_{\ge0}$ satisfy $c_{uw}\le c_{uv}+c_{vw}$. Let $x\in\mathbb R_{\ge0}^{\binom{[n]}{2}}$ satisfy $x(\delta(v))=2$ for all $v\in[n]$ and $x(\delta(S))\ge2$ for all $\emptyset\ne S\subsetneq[n]$. Prove that some Hamiltonian cycle $H$ on $[n]$ has $c(H)\le\frac43\sum_e c_ex_e$. (Equivalently: the integrality ratio of the subtour/Held--Karp relaxation of metric TSP equals $4/3$; the lower bound $4/3$ is known.)
Formalization notes: Cities are `Fin n`. An undirected edge {i,j} (i ≠ j) is represented by
the ordered pairs (i,j) and (j,i); costs `c` and LP values `x` are functions `Fin n → Fin n → ℝ`
required to be symmetric, so `c i j = c j i` is the cost of edge {i,j} and `x i j = x j i` its
LP weight. Diagonal entries play no role in the LP (all sums below skip i = j) except that
we ask `c i i = 0` so that the triangle inequality may be stated for all triples; any metric on
the edges extends this way, so no instance is lost.
* metric: `c ≥ 0`, symmetric, `c i i = 0`, `c u w ≤ c u v + c v w` for all u v w.
* subtour LP feasibility: `x ≥ 0`, symmetric, degree constraint `∑_{j ≠ v} x v j = 2` for every v,
  cut constraint `∑_{i ∈ S} ∑_{j ∉ S} x i j ≥ 2` for every nonempty proper S (each crossing edge is
  counted once, since i ∈ S, j ∉ S fixes its orientation).
* LP objective: `∑_{i<j} c i j * x i j` (each undirected edge once).
* Hamiltonian cycle: a cyclic permutation σ of `Fin n` whose support is everything; its tour cost is
  `∑_v c v (σ v)`, each edge of the cycle counted once (n ≥ 3, so σ v ≠ v and the n edges
  {v, σ v} are distinct).
Claim says: for every n ≥ 3, every metric c and every feasible x, the optimal tour costs at most
4/3 times the LP value of x (in particular of the LP optimum). This is exactly "integrality gap ≤ 4/3".
Proving ¬Claim means exhibiting a metric instance and feasible x with every tour > (4/3)·c(x).
-/
namespace OpenProblems.QEDM132
noncomputable section

/-- `c` is a metric (semimetric with zero diagonal) on `Fin n`. -/
def IsMetricCost (n : ℕ) (c : Fin n → Fin n → ℝ) : Prop :=
  (∀ i j : Fin n, 0 ≤ c i j) ∧ (∀ i j : Fin n, c i j = c j i) ∧ (∀ i : Fin n, c i i = 0) ∧
    ∀ u v w : Fin n, c u w ≤ c u v + c v w

/-- `x` is a feasible point of the subtour (Held–Karp) LP on the complete graph on `Fin n`. -/
def SubtourFeasible (n : ℕ) (x : Fin n → Fin n → ℝ) : Prop :=
  (∀ i j : Fin n, 0 ≤ x i j) ∧ (∀ i j : Fin n, x i j = x j i) ∧
    (∀ v : Fin n, ∑ j ∈ (Finset.univ.filter fun j : Fin n => j ≠ v), x v j = 2) ∧
    ∀ S : Finset (Fin n), S.Nonempty → S ≠ Finset.univ →
      2 ≤ ∑ i ∈ S, ∑ j ∈ Sᶜ, x i j

/-- LP objective: each undirected edge `{i,j}` counted once, via `i < j`. -/
def lpCost (n : ℕ) (c x : Fin n → Fin n → ℝ) : ℝ :=
  ∑ i : Fin n, ∑ j ∈ (Finset.univ.filter fun j : Fin n => i < j), c i j * x i j

/-- A Hamiltonian cycle on `Fin n`: a single cycle permutation moving every vertex. -/
def IsHamCycle (n : ℕ) (σ : Equiv.Perm (Fin n)) : Prop :=
  σ.IsCycle ∧ σ.support = Finset.univ

/-- Cost of the tour `v → σ v`. -/
def tourCost (n : ℕ) (c : Fin n → Fin n → ℝ) (σ : Equiv.Perm (Fin n)) : ℝ :=
  ∑ v : Fin n, c v (σ v)

def Claim : Prop :=
  ∀ n : ℕ, 3 ≤ n → ∀ c : Fin n → Fin n → ℝ, IsMetricCost n c →
    ∀ x : Fin n → Fin n → ℝ, SubtourFeasible n x →
      ∃ σ : Equiv.Perm (Fin n), IsHamCycle n σ ∧ tourCost n c σ ≤ (4 / 3 : ℝ) * lpCost n c x

end
end OpenProblems.QEDM132
