import Mathlib
/-! QED-M024: Paley spin glass
Put a ±1 spin on each element of F_p (p ≡ 1 mod 4) and let each pair interact via the Legendre symbol of their difference. The spectral bound gives ground-state energy E_p ≤ p^{3/2}/2, attained asymptotically along special primes. Is it asymptotically attained for all primes?
Informal statement: For primes $p\equiv1\pmod4$ let $E_p=\max_{\sigma\in\{\pm1\}^{\mathbb F_p}}\sum_{i<j}\left(\frac{j-i}{p}\right)\sigma_i\sigma_j$. The circulant matrix $Q=\big(\big(\frac{j-i}p\big)\big)_{i,j\in\mathbb F_p}$ is symmetric with eigenvalues $\pm\sqrt p$ (each with multiplicity $\frac{p-1}2$) and $0$, so $E_p\le\frac12p^{3/2}$. (For the Paley graph $P_p$, $\mathrm{surp}(P_p)=\mathrm{maxcut}(P_p)-\frac12|E(P_p)|\le \frac14E_p+\frac p8$.) It is known that $\limsup_p E_p/p^{3/2}=\frac12$: if $(\frac qp)=1$ for all primes $q\le y$, then $\sigma_x=\operatorname{sgn}\cos(2\pi x/p)$ has ratio $\frac12-o_y(1)$; and the same $\sigma$ gives $E_p/p^{3/2}\ge\frac4{\pi^2}\big(2-\frac{\pi^2}8\big)-o(1)\approx0.31$ for every $p$. Determine $\liminf_{p}E_p/p^{3/2}$; in particular, is it $\frac12$?
Formalization notes: Elements of F_p are represented by Fin p; for i<j the difference j-i is a natural in [1,p-1], so no ℕ-subtraction junk occurs. The Legendre symbol is defined from scratch (chi) to avoid needing a Fact p.Prime instance. E_p is the max of energy over s : Fin p → Bool; instead of the max, Claim asserts existence of a good configuration, which is equivalent. Known: E_p ≤ p^{3/2}/2 for all such p, limsup E_p/p^{3/2} = 1/2, and liminf ≥ 0.31 (square-wave configuration). Claim is 'liminf = 1/2'. Proving ¬Claim means exhibiting ε>0 and infinitely many primes p ≡ 1 mod 4 with E_p < (1/2-ε)p^{3/2}.
-/
namespace OpenProblems.QEDM024

/-- `d` is a square modulo `p` (for `p ∤ d` this means `d` is a quadratic residue). -/
def IsSqMod (p d : ℕ) : Prop := ∃ x : ℕ, x ^ 2 % p = d % p

open Classical in
/-- The Legendre symbol `(d / p)`, defined from scratch: `0` if `p ∣ d`, `1` if `d` is a nonzero
square mod `p`, and `-1` otherwise. -/
noncomputable def chi (p d : ℕ) : ℤ :=
  if d % p = 0 then 0 else if IsSqMod p d then 1 else -1

/-- The spin `±1` attached to a Boolean. -/
def spin (b : Bool) : ℤ := if b then 1 else -1

/-- The energy `∑_{i<j} ((j-i)/p) σ_i σ_j` of a spin configuration on `{0, …, p-1} ≅ F_p`. -/
noncomputable def energy (p : ℕ) (s : Fin p → Bool) : ℤ :=
  ∑ i : Fin p, ∑ j : Fin p,
    if i.val < j.val then chi p (j.val - i.val) * spin (s i) * spin (s j) else 0

/-- `liminf_{p ≡ 1 (mod 4)} E_p / p^{3/2} = 1/2`. Since `E_p ≤ p^{3/2}/2` always, this says: for every
`ε > 0`, all sufficiently large primes `p ≡ 1 (mod 4)` admit a configuration with energy at least
`(1/2 - ε) p^{3/2}`. -/
def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ P₀ : ℕ, ∀ p : ℕ, Nat.Prime p → p % 4 = 1 → P₀ ≤ p →
    ∃ s : Fin p → Bool, ((1 : ℝ) / 2 - ε) * ((p : ℝ) * Real.sqrt (p : ℝ)) ≤ (energy p s : ℝ)

end OpenProblems.QEDM024
