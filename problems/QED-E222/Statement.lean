import Mathlib
/-! QED-E222: One firefighter on the UIPT
A fire starts at the root of the uniform infinite planar triangulation and spreads to all neighbouring vertices each turn, while firefighters permanently protect some vertices each turn. Is one firefighter per turn enough to stop it with probability one?
Informal statement: Let $(T,\rho)$ be the type II UIPT (Angel–Schramm: local limit of uniform rooted triangulations of the sphere with $n$ vertices, multiple edges allowed, no loops). The fire starts at $\rho$. At each step $t\ge1$ the defender protects $k_t$ vertices, then the fire spreads to all unprotected unburnt neighbours of burning vertices. Prove that with $k_t\equiv1$, almost surely there is a protection strategy that contains the fire (equivalently, by local convergence: for every $\varepsilon>0$ there is $T$ such that, for all large $n$, the uniform $n$-vertex triangulation lets one firefighter per step contain the fire by time $T$ with probability $\ge1-\varepsilon$). More generally determine $k_*=\min\{k:\ \text{constant budget }k\text{ contains the fire a.s.}\}$; the formal `Claim` is the case $k=1$, i.e. $k_*=1$.
Formalization notes:
* Finite maps. A rooted planar map with `N = 2m` darts is a pair of permutations `(σ, α)` of
  `Fin N`: `α` a fixed-point-free involution (edges), `σ` the rotation at vertices (vertices =
  `σ`-orbits), faces = orbits of `σ * α`. `⟨σ, α⟩` transitive = connected. The root is the dart with
  index `0`, the root vertex its `σ`-orbit. A rooted map has no non-trivial automorphism, so each
  rooted map (up to isomorphism) has exactly `(N-1)!` labellings with the root at `0`; hence the
  uniform measure on valid pairs `(σ, α)` is the uniform measure on rooted maps.
* `IsTriII n σ α` with `N = 6n - 12` darts: all faces have degree 3 (`φ d ≠ d`, `φ³ d = d`), no
  loops (`α d` is never in the `σ`-orbit of `d`), connected, and exactly `n` vertices (counted as
  darts minimal in their `σ`-orbit). Euler: `V - E + F = n - (3n-6) + (2n-4) = 2`, so these are
  exactly the rooted type II triangulations of the sphere with `n` vertices (`3n-6` edges).
* Firefighting, on darts: a vertex is protected/burnt via any of its darts (`sameV`). A schedule
  `P t` (darts, at most `k` per step; `P 0` unused) protects the vertices of its darts permanently
  from step `t` on. `burn 0` = root vertex; `burn (t+1)` adds every vertex adjacent to `burn t`
  (via an edge `d' ↦ α d'`) that is not protected by step `t+1`. Protecting a burning vertex is
  allowed but useless, which does not change the game. `ContainedBy k σ α T`: some schedule with
  budget `k` has `burn (t+1) = burn t` for some `t ≤ T`; protections are permanent, so the fire then
  never spreads again.
* Reduction of the UIPT statement. On the (infinite, locally finite) UIPT the fire is contained iff
  `ContainedBy`-style stabilisation happens at some finite `T`; the event "contained by time `T`"
  is a function of the ball of radius `T+1` around the root, the same function as on finite maps.
  By Angel–Schramm, the law of that ball under the uniform `n`-vertex type II triangulation
  converges to its UIPT law (total variation over the countably many ball shapes, Scheffé), so
  `p_T := P_UIPT(contained by T) = lim_n probContained 1 n T`, and `P_UIPT(contained) = sup_T p_T`.
  Hence `P_UIPT(contained) = 1` iff `∀ ε > 0, ∃ T, ∀ᶠ n, probContained 1 n T ≥ 1 - ε`, which is
  `Claim`. (In a finite map a fire that burns everything also "stops"; that only happens if the ball
  of radius `T+1` is the whole map, whose probability tends to 0.) This avoids constructing the
  infinite random map in Lean.
* If no valid maps existed, `probContained` would be `0/0 = 0` and `Claim` false; valid type II
  triangulations exist for every `n ≥ 3`, so this is not a loophole.
* Proving `Claim` = one firefighter a.s. suffices on the type II UIPT (`k_* = 1`). Proving `¬Claim` =
  with one firefighter per step the fire escapes with positive probability (`k_* ≥ 2`). Type I is
  not treated; the problem allows either type.
-/
namespace OpenProblems.QEDE222
noncomputable section
open scoped Classical

/-- Number of darts of a triangulation of the sphere with `n` vertices (`2·(3n-6)`). -/
def nDarts (n : ℕ) : ℕ := 6 * n - 12

/-- Darts `d` and `e` lie at the same vertex (same `σ`-orbit). -/
def sameV {N : ℕ} (σ : Equiv.Perm (Fin N)) (d e : Fin N) : Prop :=
  ∃ k : ℤ, (σ ^ k) d = e

/-- `(σ, α)` on `Fin N` is a rooted type II triangulation of the sphere with `n` vertices
(when `N = nDarts n`). -/
def IsTriII (n : ℕ) {N : ℕ} (σ α : Equiv.Perm (Fin N)) : Prop :=
  (∀ d : Fin N, α (α d) = d) ∧
  (∀ d : Fin N, α d ≠ d) ∧
  (∀ d : Fin N, (σ * α) d ≠ d ∧ ((σ * α) ^ 3) d = d) ∧
  (∀ d e : Fin N, ∃ g ∈ Subgroup.closure ({σ, α} : Set (Equiv.Perm (Fin N))), g d = e) ∧
  (∀ d : Fin N, ¬ sameV σ d (α d)) ∧
  {d : Fin N | ∀ k : ℤ, d ≤ (σ ^ k) d}.ncard = n

/-- Dart `e` is at a vertex protected by the end of step `t` under schedule `P`. -/
def Prot {N : ℕ} (σ : Equiv.Perm (Fin N)) (P : ℕ → Finset (Fin N)) (t : ℕ) (e : Fin N) : Prop :=
  ∃ s : ℕ, 1 ≤ s ∧ s ≤ t ∧ ∃ p ∈ P s, sameV σ p e

/-- Darts at burning vertices after step `t`. -/
def burn {N : ℕ} (σ α : Equiv.Perm (Fin N)) (P : ℕ → Finset (Fin N)) : ℕ → Set (Fin N)
  | 0 => {e : Fin N | ∃ r : Fin N, r.val = 0 ∧ sameV σ r e}
  | t + 1 => burn σ α P t ∪
      {e : Fin N | ¬ Prot σ P (t + 1) e ∧
        ∃ d ∈ burn σ α P t, ∃ d' : Fin N, sameV σ d d' ∧ sameV σ (α d') e}

/-- With `k` firefighters per step the fire can be stopped by time `T`. -/
def ContainedBy (k : ℕ) {N : ℕ} (σ α : Equiv.Perm (Fin N)) (T : ℕ) : Prop :=
  ∃ P : ℕ → Finset (Fin N), (∀ t : ℕ, (P t).card ≤ k) ∧
    ∃ t : ℕ, t ≤ T ∧ burn σ α P (t + 1) = burn σ α P t

/-- Probability, under the uniform rooted type II triangulation with `n` vertices, that budget `k`
contains the fire by time `T`. -/
def probContained (k n T : ℕ) : ℝ :=
  (({p : Equiv.Perm (Fin (nDarts n)) × Equiv.Perm (Fin (nDarts n)) |
      IsTriII n p.1 p.2 ∧ ContainedBy k p.1 p.2 T}.ncard : ℕ) : ℝ) /
  (({p : Equiv.Perm (Fin (nDarts n)) × Equiv.Perm (Fin (nDarts n)) |
      IsTriII n p.1 p.2}.ncard : ℕ) : ℝ)

/-- Constant budget `k` contains the fire on the type II UIPT almost surely
(equivalent form via the Angel–Schramm local limit, see the notes). -/
def ContainsAS (k : ℕ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ T : ℕ, ∀ᶠ n : ℕ in Filter.atTop, 1 - ε ≤ probContained k n T

def Claim : Prop := ContainsAS 1

end
end OpenProblems.QEDE222
