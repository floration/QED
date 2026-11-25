import Mathlib
/-! QED-E186: Are the real multilinear Bohnenblust–Hille constants bounded?
Take an m-linear form T on n-dimensional real space with the max norm, and look at its coefficients T(e_{j1},...,e_{jm}). The Bohnenblust–Hille inequality says that the l^{2m/(m+1)}-norm of these coefficients is at most B_m times the supremum of |T| over the unit cube, with B_m not depending on n. For m=2 the best constant is sqrt 2 (Littlewood's 4/3 inequality). Do the best constants B_m stay bounded as m grows, as conjectured (B_m = 2^{1-1/m}, tending to 2), or do they go to infinity?
Informal statement: For real $m$-linear $T:(\mathbb R^n)^m\to\mathbb R$ let $\|T\|=\sup\{|T(x^{(1)},\dots,x^{(m)})|:\|x^{(i)}\|_\infty\le1\}$ and let $B_{\mathbb R,m}=\sup_{n\ge1}\sup_{T\ne0}\big(\sum_{j\in[n]^m}|T(e_{j_1},\dots,e_{j_m})|^{\frac{2m}{m+1}}\big)^{\frac{m+1}{2m}}/\|T\|$. Prove or disprove: $\sup_{m\ge1}B_{\mathbb R,m}<\infty$.
Formalization notes:
* An m-linear form T on (ℝ^n)^m is determined by its coefficient array
  `c : (Fin m → Fin n) → ℝ`, `c j = T(e_{j 1}, …, e_{j m})`, via
  `T(x^{(1)},…,x^{(m)}) = Σ_j c j · ∏_i x^{(i)}_{j i}`; every array arises. `evalT c x` is this
  sum, with `x : Fin m → Fin n → ℝ` the tuple of vectors.
* `normT c` is the supremum (`sSup`) of `|T(x)|` over tuples with all coordinates in [-1,1].
  The set is nonempty and bounded above (by Σ_j |c j|), so `sSup` is the genuine supremum.
* `p m = 2m/(m+1)`; the coefficient side is `(Σ_j |c j|^p)^{1/p}` with `Real.rpow`
  (bases are ≥ 0). m ≥ 1 is required (m = 0 is degenerate: p = 0).
* `Claim`: ∃ C, ∀ m ≥ 1, ∀ n ≥ 1, ∀ c, (Σ |c j|^p)^{1/p} ≤ C · ‖T‖. This is exactly
  sup_m B_{ℝ,m} < ∞ (the c = 0 case is trivially fine, so including it is harmless).
* Proving `Claim` = the real BH constants are uniformly bounded. Proving `¬Claim` =
  B_{ℝ,m} → ∞ along a subsequence (unbounded).
-/
namespace OpenProblems.QEDE186
noncomputable section

/-- The m-linear form with coefficient array `c`, evaluated at `x = (x^{(1)},…,x^{(m)})`. -/
def evalT {m n : ℕ} (c : (Fin m → Fin n) → ℝ) (x : Fin m → Fin n → ℝ) : ℝ :=
  ∑ j : Fin m → Fin n, c j * ∏ i : Fin m, x i (j i)

/-- Sup norm of the form over the product of unit cubes of `ℓ^∞_n`. -/
def normT {m n : ℕ} (c : (Fin m → Fin n) → ℝ) : ℝ :=
  sSup {r : ℝ | ∃ x : Fin m → Fin n → ℝ, (∀ i : Fin m, ∀ k : Fin n, |x i k| ≤ 1) ∧
    r = |evalT c x|}

/-- The Bohnenblust–Hille exponent `2m/(m+1)`. -/
def p (m : ℕ) : ℝ := 2 * (m : ℝ) / ((m : ℝ) + 1)

def Claim : Prop :=
  ∃ C : ℝ, ∀ m n : ℕ, 1 ≤ m → 1 ≤ n → ∀ c : (Fin m → Fin n) → ℝ,
    (∑ j : Fin m → Fin n, |c j| ^ p m) ^ (1 / p m) ≤ C * normT c

end
end OpenProblems.QEDE186
