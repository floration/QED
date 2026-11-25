import Mathlib
/-! QED-E018: Random Wang tiles
Informal statement: let $T_1,\dots,T_n$ be i.i.d. Wang tiles, each with its four edge colours i.i.d. uniform in
$[c]$, no rotations. Let $n=\lfloor\lambda c^2\rfloor$, $c\to\infty$. Prove $F(\lambda)=\lim_c\Pr(\{T_i\}$ tiles
$\mathbb Z^2)$ exists for every $\lambda>0$, and that $\lambda_c=\inf\{\lambda:F(\lambda)=1\}=1$ (prove or
disprove; the first-moment heuristic suggests 1). Determining $F$ on $(0,\lambda_c)$ is a further, unformalized goal.
Formalization notes:
* A tile is `Fin 4 → Fin c` (edges 0 = N, 1 = E, 2 = S, 3 = W). A tuple `T : Fin n → Tile` tiles ℤ² if some
  placement `f : ℤ × ℤ → Fin n` matches E of (x,y) with W of (x+1,y) and N of (x,y) with S of (x,y+1).
  Repeated tiles are harmless (the set {Tᵢ} tiles iff the tuple does).
* The probability is the exact uniform count over all c^{4n} tuples (finite type, so `Nat.card` is fine).
* Claim: for every λ > 0 the limit F(λ) exists, F(λ) = 1 for λ > 1, and F(λ) < 1 for 0 < λ < 1; this is
  exactly "F exists and λ_c = 1" (F(1) is left unconstrained). ¬Claim: the limit fails to exist for some λ,
  or λ_c ≠ 1 (including λ_c = ∞).
-/

namespace OpenProblems.QEDE018
noncomputable section

/-- `T` (a tuple of `n` Wang tiles over `c` colours) admits a valid tiling of `ℤ²`. -/
def Tiles {c n : ℕ} (T : Fin n → Fin 4 → Fin c) : Prop :=
  ∃ f : ℤ × ℤ → Fin n, ∀ x y : ℤ,
    T (f (x, y)) 1 = T (f (x + 1, y)) 3 ∧ T (f (x, y)) 0 = T (f (x, y + 1)) 2

/-- Probability that `n` uniformly random Wang tiles over `c` colours tile the plane. -/
def tileProb (c n : ℕ) : ℝ :=
  (Nat.card {T : Fin n → Fin 4 → Fin c // Tiles T} : ℝ) / (c : ℝ) ^ (4 * n)

def Claim : Prop :=
  ∀ l : ℝ, 0 < l → ∃ L : ℝ,
    Filter.Tendsto (fun c : ℕ => tileProb c ⌊l * (c : ℝ) ^ 2⌋₊) Filter.atTop (nhds L) ∧
    (1 < l → L = 1) ∧ (l < 1 → L < 1)

end
end OpenProblems.QEDE018
