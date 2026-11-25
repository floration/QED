import Mathlib
/-! QED-E224: Infinitely many prime losing positions in subtract-a-square
In subtract-a-square, players alternately remove a positive square number of tokens from a pile, and whoever cannot move loses. Show that infinitely many prime pile sizes are losing positions for the player to move.
Informal statement: Let $\mathcal P\subset\mathbb N_0$ be the P-positions of subtract-a-square: $0\in\mathcal P$, and $n\in\mathcal P$ iff $n-k^2\notin\mathcal P$ for all $1\le k\le\sqrt n$. Prove that $\mathcal P$ contains infinitely many primes.
Formalization notes:
* `IsPSet P` is the defining recursion of the P-positions: `n ∈ P` iff no legal move
  (`n ↦ n - k²` with `1 ≤ k`, `k² ≤ n`) leads into `P`. For `n = 0` there is no move, so `0 ∈ P`
  automatically. Since every move strictly decreases `n`, strong induction shows that exactly one
  set satisfies this recursion (the set of P-positions, OEIS A030193: 0, 2, 5, 7, 10, 12, 15, ...).
* To avoid relying on a hand-written recursive function, `Claim` states existence of a set
  satisfying the recursion (true, and it rules out a vacuous universal statement) and that every
  such set contains infinitely many primes. By uniqueness this is exactly the problem.
* Proving `Claim` = infinitely many primes are P-positions. Proving `¬Claim` = only finitely many
  primes are P-positions (existence of `P` being an easy theorem).
-/
namespace OpenProblems.QEDE224
noncomputable section

/-- `P` satisfies the recursion defining the P-positions (losing positions for the player to
move) of subtract-a-square. -/
def IsPSet (P : Set ℕ) : Prop :=
  ∀ n : ℕ, n ∈ P ↔ ∀ k : ℕ, 1 ≤ k → k ^ 2 ≤ n → n - k ^ 2 ∉ P

def Claim : Prop :=
  (∃ P : Set ℕ, IsPSet P) ∧
    ∀ P : Set ℕ, IsPSet P → {p : ℕ | p.Prime ∧ p ∈ P}.Infinite

end
end OpenProblems.QEDE224
