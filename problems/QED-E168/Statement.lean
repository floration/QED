import Mathlib
/-! QED-E168: Real-rooted h*-polynomials of hypersimplices
The hypersimplex Δ(k,n) is the slice of the unit cube [0,1]^n by the hyperplane x_1+...+x_n = k. Count the lattice points in its t-fold dilate for every t. These counts are packaged into a polynomial h*(z) with nonnegative integer coefficients. For k = 2 this polynomial is known to have only real roots. Is that true for every k and n?
Informal statement: Let $L_{k,n}(t)=\#\{x\in\{0,\dots,t\}^n:\ \sum x_i=kt\}$ and define $h^*_{k,n}(z)$ by $\sum_{t\ge0}L_{k,n}(t)z^t=h^*_{k,n}(z)/(1-z)^n$. Claim: for all $1\le k\le n-1$, every root of $h^*_{k,n}$ is real. Weaker open target: the coefficients of $h^*_{k,n}$ are unimodal for all k, n.
Formalization notes:
* `L k n t` counts `x : Fin n → Fin (t+1)` with `∑ x i = k t`, i.e. lattice points of tΔ(k,n).
* Multiplying the series identity by (1-z)^n gives the coefficients
  `hcoef k n j = ∑_{i=0}^{j} (-1)^i C(n,i) L(j-i)` of h* (as a formal power series).
* Δ(k,n) is an (n-1)-dimensional lattice polytope for 1 ≤ k ≤ n-1, so by Stanley's theorem h*
  has degree ≤ n-1. We define `hstar k n` as the polynomial with coefficients `hcoef k n j` for
  j < n, and, so that this truncation loses nothing even in principle, Claim also asserts
  `hcoef k n j = 0` for j ≥ n (a known theorem; it does not affect the open content).
* Real-rootedness: every complex root `z` of `hstar k n` (via `Polynomial.aeval`) has `z.im = 0`.
  (h* has constant term 1, so it is never the zero polynomial.)
* Only the main real-rootedness claim is formalized, not the weaker unimodality target.
  Proving Claim = real-rootedness for all hypersimplices; ¬Claim = some h*_{k,n} has a non-real root.
-/
namespace OpenProblems.QEDE168
noncomputable section

/-- Number of lattice points in the `t`-th dilate of the hypersimplex Δ(k,n). -/
def L (k n t : ℕ) : ℕ :=
  ((Finset.univ : Finset (Fin n → Fin (t + 1))).filter
    (fun x : Fin n → Fin (t + 1) => ∑ i : Fin n, (x i : ℕ) = k * t)).card

/-- Coefficient of `z^j` in `(1 - z)^n · ∑_t L(t) z^t`. -/
def hcoef (k n j : ℕ) : ℤ :=
  ∑ i ∈ Finset.range (j + 1), (-1 : ℤ) ^ i * (n.choose i : ℤ) * (L k n (j - i) : ℤ)

/-- The h*-polynomial of Δ(k,n) (degree ≤ n - 1). -/
def hstar (k n : ℕ) : Polynomial ℤ :=
  ∑ j ∈ Finset.range n, Polynomial.C (hcoef k n j) * Polynomial.X ^ j

def Claim : Prop :=
  ∀ k n : ℕ, 1 ≤ k → k < n →
    (∀ j : ℕ, n ≤ j → hcoef k n j = 0) ∧
    ∀ z : ℂ, Polynomial.aeval z (hstar k n) = 0 → z.im = 0

end
end OpenProblems.QEDE168
