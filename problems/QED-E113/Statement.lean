import Mathlib
/-! QED-E113: Does the self-avoiding-walk growth ratio converge on the square lattice?
Let c_n be the number of n-step walks on the square grid that start at the origin and never visit a point twice. It is classical that c_n^{1/n} tends to a constant mu (about 2.638), and Kesten proved in 1963 that the two-step ratio c_{n+2}/c_n tends to mu^2. Does the one-step ratio c_{n+1}/c_n converge (necessarily to mu)? Numerically the ratios alternate between even and odd n with a shrinking gap, but no proof exists in dimensions 2, 3 or 4.
Informal statement: Let $c_n=\#\{(\omega_0,\dots,\omega_n)\in(\mathbb Z^2)^{n+1}:\omega_0=0,\ \|\omega_{i+1}-\omega_i\|_1=1,\ \omega_i\neq\omega_j\ (i\neq j)\}$ and $\mu=\lim_n c_n^{1/n}$. Prove that $\lim_{n\to\infty} c_{n+1}/c_n$ exists. (Given Kesten's theorem $c_{n+2}/c_n\to\mu^2$, this is equivalent to $c_{n+1}/c_n\to\mu$, i.e. to the even and odd subsequences of $c_{n+1}/c_n$ having the same limit.)
Formalization notes:
* `Adj2 a b` is the nearest-neighbour relation of the square lattice: ℓ¹-distance exactly 1.
* An n-step self-avoiding walk is an injective map `ω : Fin (n+1) → ℤ × ℤ` with `ω 0 = (0,0)`
  and `Adj2 (ω i) (ω (i+1))` for `i < n`. Every such walk stays in the box `[-n,n]²`, so
  filtering the finite set `piFinset (fun _ => box n)` counts exactly all of them; `c n` is the
  number of n-step self-avoiding walks (c 0 = 1, c 1 = 4, c 2 = 12, ...).
* `c n ≥ 1` for every n (straight walks), so the ratio `c (n+1) / c n` has no junk values.
* `Claim` says the real sequence `c (n+1) / c n` converges to some finite real limit. Since
  `1 ≤ c (n+1)/c n ≤ 3` and by Kesten's theorem/Fekete, any limit is necessarily μ; this is not
  stated. Proving `¬Claim` means the ratio sequence does not converge (e.g. a persistent
  even/odd oscillation).
-/
namespace OpenProblems.QEDE113
noncomputable section
open scoped Classical
open Filter Topology

/-- Nearest-neighbour relation on `ℤ²`: ℓ¹-distance exactly 1. -/
def Adj2 (a b : ℤ × ℤ) : Prop := |a.1 - b.1| + |a.2 - b.2| = 1

/-- The box `[-n,n]²`, which contains every `n`-step walk started at the origin. -/
def box (n : ℕ) : Finset (ℤ × ℤ) :=
  Finset.Icc (-(n : ℤ)) (n : ℤ) ×ˢ Finset.Icc (-(n : ℤ)) (n : ℤ)

/-- The `n`-step self-avoiding walks on `ℤ²` starting at the origin. -/
def saw (n : ℕ) : Finset (Fin (n + 1) → ℤ × ℤ) :=
  (Fintype.piFinset (fun _ : Fin (n + 1) => box n)).filter (fun ω : Fin (n + 1) → ℤ × ℤ =>
    ω 0 = (0, 0) ∧ (∀ i : Fin n, Adj2 (ω i.castSucc) (ω i.succ)) ∧ Function.Injective ω)

/-- Number of `n`-step self-avoiding walks on the square lattice. -/
def c (n : ℕ) : ℕ := (saw n).card

def Claim : Prop :=
  ∃ L : ℝ, Tendsto (fun n : ℕ => (c (n + 1) : ℝ) / (c n : ℝ)) atTop (𝓝 L)

end
end OpenProblems.QEDE113
