import Mathlib
/-! QED-E158: Once-reinforced random walk on Z^2: recurrent for some reinforcement?
A walker on the square grid prefers edges it has already crossed: a used edge has weight beta, an unused edge weight 1. With beta = 1 this is simple random walk, which returns to its start infinitely often. Is there any beta > 1 for which the reinforced walk is still recurrent (returns to the origin infinitely often with probability 1)? In dimensions 2 to 5, no beta > 1 is known to give either recurrence or transience.
Informal statement: Fix $\beta>1$. ORRW$(\beta)$ on $\mathbb Z^2$: $X_0=0$; let $E_t$ be the set of undirected nearest-neighbour edges traversed by $X$ up to time $t$, $w_t(e)=\beta$ if $e\in E_t$ and $w_t(e)=1$ otherwise, and $\Pr(X_{t+1}=y\mid X_0,\dots,X_t)=w_t(\{X_t,y\})/\sum_{z\sim X_t}w_t(\{X_t,z\})$ for $y\sim X_t$. Claim: there exists $\beta>1$ such that $\Pr(X_t=0\text{ for infinitely many }t)=1$.
Formalization notes:
* A trajectory of length M is a step sequence s : Fin M → Fin 4 (directions `dir`: ±e₁, ±e₂); X_t is the sum of the first t steps. Edges are undirected (`Sym2 (ℤ × ℤ)`).
* `pathProb β ds` is the ORRW(β) probability of the step list ds, computed exactly as the product over t of w_t(chosen edge) / Σ over the 4 neighbours of w_t, where the traversed-edge set E_t is updated after every step. For β > 0 these numbers are positive, the length-M probabilities sum to 1, and they are Kolmogorov-consistent, so they are the finite-dimensional marginals of the ORRW(β) path measure.
* `visitProb β N M` = Σ over length-M trajectories of pathProb, restricted to those with X_t = 0 for some N < t ≤ M. This is exactly P(∃ t ∈ (N, M], X_t = 0) for the walk (the event depends only on the first M steps). It is nondecreasing in M with limit P(∃ t > N, X_t = 0).
* P(X_t = 0 infinitely often) = 1 ⇔ for every N, P(∃ t > N, X_t = 0) = 1 (countable intersection of a decreasing family of events) ⇔ `Recurrent β`: ∀ N, ∀ ε > 0, ∃ M, visitProb β N M > 1 − ε. No measure theory is needed.
* `Claim` = ∃ β > 1, Recurrent β (the weakest open form; the 'all large β' / 'every β > 1' conjectures of Beffara and Sidoravicius are stronger and not encoded). Proving `¬Claim` = for every β > 1, with positive probability the walk visits 0 only finitely often (this does not by itself mean transience in the strong sense, but it refutes recurrence for every β > 1). β = 1 (simple random walk, recurrent) is excluded by the strict inequality.
-/
namespace OpenProblems.QEDE158
noncomputable section
open Classical

/-- The four unit steps of ℤ². -/
def dir : Fin 4 → ℤ × ℤ := ![(1, 0), (-1, 0), (0, 1), (0, -1)]

/-- The undirected edge from `x` in direction `d`. -/
def edge (x : ℤ × ℤ) (d : Fin 4) : Sym2 (ℤ × ℤ) := s(x, x + dir d)

/-- Current weight of an edge: `β` if already traversed, `1` otherwise. -/
def wt (β : ℝ) (E : Set (Sym2 (ℤ × ℤ))) (e : Sym2 (ℤ × ℤ)) : ℝ :=
  if e ∈ E then β else 1

/-- Probability of stepping in direction `d` from `x` when `E` is the traversed-edge set. -/
def stepProb (β : ℝ) (E : Set (Sym2 (ℤ × ℤ))) (x : ℤ × ℤ) (d : Fin 4) : ℝ :=
  wt β E (edge x d) / ∑ d' : Fin 4, wt β E (edge x d')

/-- Probability that ORRW(β), currently at `x` with traversed edges `E`, takes the steps `ds` next. -/
def pathProbAux (β : ℝ) : Set (Sym2 (ℤ × ℤ)) → ℤ × ℤ → List (Fin 4) → ℝ
  | _, _, [] => 1
  | E, x, d :: ds => stepProb β E x d * pathProbAux β (insert (edge x d) E) (x + dir d) ds

/-- Probability that ORRW(β) started at the origin with no traversed edges takes the steps `ds`. -/
def pathProb (β : ℝ) (ds : List (Fin 4)) : ℝ := pathProbAux β ∅ (0, 0) ds

/-- Position after the first `t` steps of `ds`. -/
def pos (ds : List (Fin 4)) (t : ℕ) : ℤ × ℤ := ((ds.take t).map dir).sum

/-- `P(∃ t, N < t ≤ M, X_t = 0)` for ORRW(β). -/
def visitProb (β : ℝ) (N M : ℕ) : ℝ :=
  ∑ s : Fin M → Fin 4,
    if (∃ t : ℕ, N < t ∧ t ≤ M ∧ pos (List.ofFn s) t = (0, 0)) then pathProb β (List.ofFn s) else 0

/-- ORRW(β) returns to the origin infinitely often almost surely. -/
def Recurrent (β : ℝ) : Prop :=
  ∀ N : ℕ, ∀ ε : ℝ, 0 < ε → ∃ M : ℕ, 1 - ε < visitProb β N M

/-- Some reinforcement `β > 1` makes once-reinforced random walk on ℤ² recurrent. -/
def Claim : Prop := ∃ β : ℝ, 1 < β ∧ Recurrent β

end
end OpenProblems.QEDE158
