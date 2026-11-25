import Mathlib
/-! QED-E116: Square-lattice polygon counts satisfy no polynomial recurrence
Let p_n count closed self-avoiding loops of length 2n on the square grid, up to translation (p_2 = 1, p_3 = 2, p_4 = 7, p_5 = 28, ...). Many solved lattice models have counting sequences that obey a linear recurrence with polynomial coefficients (their generating function is 'D-finite'). For square-lattice polygons it is believed that no such recurrence exists, reflecting that the model has no exact solution of this kind. Prove it.
Informal statement: Let $p_n$ be the number of self-avoiding polygons (unrooted, unoriented closed nearest-neighbour cycles) of perimeter $2n$ on $\mathbb Z^2$, counted modulo translation, so $p_1=0$, $p_2=1,p_3=2,p_4=7$. Prove that there are no $k\ge0$ and polynomials $Q_0,\dots,Q_k\in\mathbb Q[x]$, not all zero, with $\sum_{i=0}^k Q_i(n)\,p_{n+i}=0$ for all $n\ge1$. Equivalently, $P(x)=\sum_n p_nx^n$ is not D-finite.
Formalization notes:
* `Adj2` is the square-lattice nearest-neighbour relation (ℓ¹-distance 1).
* `rooted m` is the finite set of injective maps `ω : Fin m → ℤ × ℤ` with `ω 0 = (0,0)` (written
  `∀ h : 0 < m, ω ⟨0, h⟩ = (0,0)` to avoid needing `NeZero m`) and cyclic adjacency
  `Adj2 (ω i) (ω (finRotate m i))`, where `finRotate m i = i+1 mod m`. All such vertices lie in
  the box `[-m,m]²`, so the `piFinset` filter counts all of them.
* For `m = 2n ≥ 4`, such an `ω` is exactly a self-avoiding polygon with `2n` edges together with a
  choice of starting vertex (translated to the origin) and a direction of traversal; each polygon
  modulo translation gives exactly `2n · 2` distinct such `ω` (reversal gives a different sequence
  since the cycle has at least 4 vertices). Hence `p n = #rooted (2n) / (4n)` for `n ≥ 2`
  (computed in ℚ; the division is exact). For `n ≤ 1` there is no polygon (an injective length-2
  "cycle" is a back-and-forth step, not a polygon), so `p 0 = p 1 = 0` is set by hand.
  Check: `#rooted 4 = 8`, so `p 2 = 1`.
* `Claim` is the negation of P-recursiveness: no `k` and no family `Q : Fin (k+1) → ℚ[x]`, not all
  zero, with `∑ᵢ Qᵢ(n) p(n+i) = 0` for all `n ≥ 1`. This is the standard definition; requiring
  the recurrence for all `n ≥ 1` rather than for all large `n` is equivalent (multiply the
  `Qᵢ` by a polynomial vanishing at the finitely many exceptional `n`), as is the choice of
  values `p 0`, `p 1`. P-recursiveness of `(p n)` is equivalent to D-finiteness of `∑ p_n xⁿ`.
  Proving `Claim` = the isotropic SAP generating function is not D-finite; `¬Claim` = it is.
-/
namespace OpenProblems.QEDE116
noncomputable section
open scoped Classical

/-- Nearest-neighbour relation on `ℤ²`: ℓ¹-distance exactly 1. -/
def Adj2 (a b : ℤ × ℤ) : Prop := |a.1 - b.1| + |a.2 - b.2| = 1

/-- The box `[-m,m]²`. -/
def box (m : ℕ) : Finset (ℤ × ℤ) :=
  Finset.Icc (-(m : ℤ)) (m : ℤ) ×ˢ Finset.Icc (-(m : ℤ)) (m : ℤ)

/-- Rooted, oriented self-avoiding cycles of length `m` through the origin, as injective cyclic
nearest-neighbour sequences starting at the origin. -/
def rooted (m : ℕ) : Finset (Fin m → ℤ × ℤ) :=
  (Fintype.piFinset (fun _ : Fin m => box m)).filter (fun ω : Fin m → ℤ × ℤ =>
    (∀ h : 0 < m, ω ⟨0, h⟩ = (0, 0)) ∧
    (∀ i : Fin m, Adj2 (ω i) (ω (finRotate m i))) ∧ Function.Injective ω)

/-- Number of self-avoiding polygons of perimeter `2n` on `ℤ²` modulo translation. -/
def p (n : ℕ) : ℚ :=
  if 2 ≤ n then ((rooted (2 * n)).card : ℚ) / (4 * (n : ℚ)) else 0

def Claim : Prop :=
  ¬ ∃ (k : ℕ) (Q : Fin (k + 1) → Polynomial ℚ), (∃ i : Fin (k + 1), Q i ≠ 0) ∧
    ∀ n : ℕ, 1 ≤ n → ∑ i : Fin (k + 1), (Q i).eval (n : ℚ) * p (n + (i : ℕ)) = 0

end
end OpenProblems.QEDE116
