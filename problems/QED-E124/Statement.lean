import Mathlib
/-! QED-E124: Separating words below the cube-root barrier
Given two different binary words of the same length n, how small a deterministic finite automaton (DFA) is needed to accept one and reject the other? The best known upper bound is about n^{1/3} states and the best lower bound is only about log n. Prove that O(n^c) states always suffice for some exponent c < 1/3.
Informal statement: For distinct $u,v\in\{0,1\}^n$ let $\mathrm{sep}(u,v)$ be the least number of states of a DFA over $\{0,1\}$ that accepts exactly one of $u,v$, and let $S(n)=\max\{\mathrm{sep}(u,v):u\ne v,\ |u|=|v|=n\}$. Prove that there exist $c<1/3$ and $C>0$ with $S(n)\le C\,n^{c}$ for all $n\ge2$. (Known: $\Omega(\log n)\le S(n)\le O(n^{1/3}\log^{7}n)$; the conjectured truth is $S(n)=O(\log n)$.)
Formalization notes:
* DFAs are Mathlib's `DFA Bool (Fin k)` (complete deterministic automata: total transition
  function `step`, start state, accepting set), evaluated by `DFA.eval` (left fold of `step`
  from `start`). Binary words are `List Bool`. A DFA with state type `Fin k` has exactly `k`
  states (k ≥ 1 automatically, as `start : Fin k`).
* "Some DFA with exactly k states separates u, v" is monotone in k (add unreachable states),
  so `S(n) ≤ C n^c` ⇔ for all distinct u, v of length n there is k ≤ C n^c and a k-state DFA
  accepting exactly one of u, v. This is the form used in `Claim`.
* `n ^ c` is `Real.rpow` with base n ≥ 2 > 0; c is any real < 1/3 (negative c would only make
  the claim stronger and is in fact impossible since S(n) ≥ 2).
* Proving `Claim` = a polynomial improvement of the exponent 1/3 (Chase). Proving `¬Claim` =
  S(n) is not O(n^c) for any c < 1/3 (would refute the O(log n) conjecture).
-/
namespace OpenProblems.QEDE124
noncomputable section

/-- Some DFA with `k` states over `{0,1}` accepts exactly one of `u` and `v`. -/
def Separates (k : ℕ) (u v : List Bool) : Prop :=
  ∃ M : DFA Bool (Fin k), ¬ (M.eval u ∈ M.accept ↔ M.eval v ∈ M.accept)

def Claim : Prop :=
  ∃ c : ℝ, c < 1 / 3 ∧ ∃ C : ℝ, 0 < C ∧
    ∀ n : ℕ, 2 ≤ n → ∀ u v : List Bool, u.length = n → v.length = n → u ≠ v →
      ∃ k : ℕ, (k : ℝ) ≤ C * (n : ℝ) ^ c ∧ Separates k u v

end
end OpenProblems.QEDE124
