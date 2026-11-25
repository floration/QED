import Mathlib
/-! QED-E125: A subcubic bound for reset words
A finite automaton is synchronizing if some input word sends every state to one and the same state; the shortest such word is called a reset word. For automata with n states the shortest reset word is conjectured to have length at most (n-1)^2, but the best proven bound is still about n^3/6. Prove any bound that is asymptotically smaller than n^3.
Informal statement: For a complete DFA $\mathcal A=(Q,\Sigma,\delta)$ over a finite alphabet $\Sigma$, call
$w\in\Sigma^*$ reset if $|\delta(Q,w)|=1$; let $\mathrm{rt}(\mathcal A)$ be the length of a shortest reset word, and
$C(n)=\max\{\mathrm{rt}(\mathcal A): |Q|=n,\ \mathcal A\text{ synchronizing},\ \Sigma\text{ finite}\}$ (finite, since
$\mathrm{rt}(\mathcal A)<2^n$). Prove $C(n)=o(n^3)$. (Known: $(n-1)^2\le C(n)\le(7/48+15625/798768)\,n^3+o(n^3)
\approx0.1654\,n^3$.)
Formalization notes:
* A complete DFA with `n` states over a `k`-letter alphabet is a transition function
  `δ : Fin n → Fin k → Fin n` (no initial/final states are relevant). Every finite alphabet is
  in bijection with some `Fin k`, so quantifying over all `k : ℕ` covers all finite alphabets.
* The action of a word `w : List (Fin k)` on a state is `List.foldl δ q w` (letters read left
  to right). `w` is a reset word iff all states are sent to the same state, which for `n ≥ 1` is
  `|δ(Q,w)| = 1`.
* `C(n) = o(n³)` is written out: for every `ε > 0` there is `N` such that for all `n ≥ N`,
  every synchronizing `n`-state DFA over any finite alphabet has a reset word of length
  `≤ ε n³`. (Equivalent to `C(n)/n³ → 0`, since `C(n)` is the max of shortest reset lengths.)
* `Claim` = a subcubic bound `C(n) = o(n³)`. `¬Claim` = `C(n) ≥ c n³` for some `c > 0` and
  infinitely many `n` (which would refute the Černý conjecture).
-/
namespace OpenProblems.QEDE125
noncomputable section

/-- The state reached from `q` after reading `w`. -/
def run {n k : ℕ} (δ : Fin n → Fin k → Fin n) (q : Fin n) (w : List (Fin k)) : Fin n :=
  w.foldl δ q

/-- `w` is a reset (synchronizing) word: it sends every state to one and the same state. -/
def IsReset {n k : ℕ} (δ : Fin n → Fin k → Fin n) (w : List (Fin k)) : Prop :=
  ∀ q q' : Fin n, run δ q w = run δ q' w

/-- Subcubic reset thresholds: `C(n) = o(n³)`. -/
def Claim : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ (k : ℕ) (δ : Fin n → Fin k → Fin n),
    (∃ w : List (Fin k), IsReset δ w) →
      ∃ w : List (Fin k), IsReset δ w ∧ (w.length : ℝ) ≤ ε * (n : ℝ) ^ 3

end
end OpenProblems.QEDE125
