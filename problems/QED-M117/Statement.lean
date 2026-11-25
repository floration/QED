import Mathlib
/-! QED-M117: An exponential improvement of the diagonal Ramsey lower bound
The Ramsey number R(k) is the least N such that every red/blue colouring of the edges of the complete graph K_N contains a one-coloured K_k. Erdos's 1947 random-colouring argument gives R(k) > (sqrt 2)^k, and in nearly 80 years only the constant factor in front has improved. Is there a fixed eps > 0 with R(k) > (sqrt 2 + eps)^k for all large k?
Informal statement: Prove that there exists $\varepsilon>0$ such that $R(k,k)\ge(\sqrt2+\varepsilon)^k$ for all sufficiently large $k$; equivalently, for every large $k$ there is a graph on $N\ge(\sqrt2+\varepsilon)^k$ vertices with no clique and no independent set of size $k$. (Best known: $R(k,k)\ge(1+o(1))\frac{\sqrt2}{e}\,k\,2^{k/2}$, Spencer 1975.)
Formalization notes:
* We use the graph form: a red/blue colouring of `K_N` is a simple graph `G` on `Fin N`
  (red = edge of `G`); a monochromatic `K_k` is a `k`-clique of `G` or of its complement `Gᶜ`.
  Mathlib's `SimpleGraph.CliqueFree k` says there is no `k`-clique, so a graph on `Fin N` with
  `G.CliqueFree k ∧ Gᶜ.CliqueFree k` witnesses `R(k,k) > N`.
* `Claim`: there is `ε > 0` such that for all sufficiently large `k` such a graph exists on
  `N ≥ (√2 + ε)^k` vertices. This gives `R(k,k) > (√2+ε)^k`; conversely `R(k,k) ≥ (√2+ε)^k`
  for all large `k` gives `Claim` with `ε/2` in place of `ε` (take `N = R(k,k) - 1`), so the
  two forms are equivalent. `¬Claim` means: for every `ε > 0`, `R(k,k) < (√2+ε)^k + 1` for
  infinitely many `k`, i.e. `liminf R(k,k)^{1/k} ≤ √2`.
-/
namespace OpenProblems.QEDM117
noncomputable section
open Filter

def Claim : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∀ᶠ k : ℕ in atTop, ∃ N : ℕ, (Real.sqrt 2 + ε) ^ k ≤ (N : ℝ) ∧
    ∃ G : SimpleGraph (Fin N), G.CliqueFree k ∧ Gᶜ.CliqueFree k

end
end OpenProblems.QEDM117
