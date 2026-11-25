import Mathlib
/-! QED-E114: Planar self-avoiding walk spreads at least diffusively
Pick one of the self-avoiding n-step walks on the square grid from the origin uniformly at random, and let R_n^2 be the average squared distance of its endpoint from the origin. Intuition says avoiding yourself only pushes you outward, so R_n^2 should be at least of order n, the value for ordinary random walk; physicists expect n^{3/2}. Yet nobody can prove even R_n^2 >= c n for some c > 0: the best proven lower bound is of order n^{2/3}.
Informal statement: Let $\mathrm{SAW}_n$ be the set of $n$-step self-avoiding walks on $\mathbb Z^2$ starting at $0$ and $\langle|\omega(n)|^2\rangle_n=|\mathrm{SAW}_n|^{-1}\sum_{\omega\in\mathrm{SAW}_n}\|\omega_n\|_2^2$. Prove $\liminf_{n\to\infty}\langle|\omega(n)|^2\rangle_n/n>0$, equivalently: there is $c>0$ with $\langle|\omega(n)|^2\rangle_n\ge c\,n$ for all $n\ge1$.
Formalization notes:
* An n-step walk on ℤ² from 0 is encoded by its step sequence `s : Fin n → Fin 4`, each step
  being one of the four unit vectors (±1,0), (0,±1) (`dir`). Its vertex after `i` steps is
  `pos s i = ∑_{j < i} dir (s j)`, so `pos s 0 = 0`. This is a bijection with nearest-neighbour
  paths ω : {0,…,n} → ℤ² with ω(0) = 0, and the encoding makes the set of walks a finite type.
* Self-avoiding: `i ↦ pos s i` is injective on `Fin (n+1)` (all n+1 visited vertices distinct).
* `msd n` = (∑ over SAWs of ‖endpoint‖₂²) / #SAWs, as a real number. #SAWs ≥ 1 for every n (the
  straight walk), so there is no division-by-zero junk value.
* Equivalence with the liminf form: for n ≥ 1 the endpoint of a SAW is a nonzero lattice point,
  so msd n ≥ 1; hence liminf msd n / n > 0 ⇔ ∃ c > 0, ∀ n ≥ 1, msd n ≥ c n (the finitely many
  small n are absorbed by shrinking c).
* Proving `Claim` = a linear (diffusive) lower bound on the mean-square displacement of the
  uniform n-step SAW on ℤ². Proving `¬Claim` = liminf msd n / n = 0 (physically not expected).
  The stronger variant msd n ≥ n is not formalized.
-/
namespace OpenProblems.QEDE114
noncomputable section
open Classical

/-- The four unit steps of the square lattice. -/
def dir (d : Fin 4) : ℤ × ℤ :=
  if d = 0 then (1, 0) else if d = 1 then (-1, 0) else if d = 2 then (0, 1) else (0, -1)

/-- Position after the first `i` steps of the step sequence `s`. -/
def pos {n : ℕ} (s : Fin n → Fin 4) (i : ℕ) : ℤ × ℤ :=
  ∑ j ∈ Finset.univ.filter (fun j : Fin n => (j : ℕ) < i), dir (s j)

/-- The step sequence `s` is a self-avoiding walk: its `n + 1` vertices are pairwise distinct. -/
def IsSAW {n : ℕ} (s : Fin n → Fin 4) : Prop :=
  Function.Injective (fun i : Fin (n + 1) => pos s (i : ℕ))

/-- The finite set of `n`-step self-avoiding walks from the origin. -/
def saw (n : ℕ) : Finset (Fin n → Fin 4) :=
  Finset.univ.filter (fun s : Fin n → Fin 4 => IsSAW s)

/-- Squared Euclidean norm of a lattice point, as a real. -/
def sqNorm (p : ℤ × ℤ) : ℝ := ((p.1 : ℝ)) ^ 2 + ((p.2 : ℝ)) ^ 2

/-- Mean-square end-to-end displacement of the uniform `n`-step SAW. -/
def msd (n : ℕ) : ℝ :=
  (∑ s ∈ saw n, sqNorm (pos s n)) / ((saw n).card : ℝ)

def Claim : Prop :=
  ∃ c : ℝ, 0 < c ∧ ∀ n : ℕ, 1 ≤ n → c * (n : ℝ) ≤ msd n

end
end OpenProblems.QEDE114
