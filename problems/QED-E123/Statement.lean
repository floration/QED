import Mathlib
/-! QED-E123: Threshold bias of the Maker-Breaker triangle game
On the edges of the complete graph K_n, Maker claims one edge per turn and Breaker claims q edges per
turn; Maker wins if she ever owns a triangle. Let q_0(n) be the smallest q for which Breaker wins. It
is known that q_0(n) lies between about 1.414 sqrt(n) and 1.633 sqrt(n). What is the right constant,
conjecturally sqrt(2)? As a concrete step, can either bound be improved by a constant factor?
Informal statement: Let $q_0(n)$ be the least $q$ such that Breaker wins the $(1:q)$ Maker-Breaker
triangle game on $E(K_n)$ (Maker first). Known:
$(\sqrt2-o(1))\sqrt n\le q_0(n)\le(\sqrt{8/3}+o(1))\sqrt n$. Prove that one of the two bounds can be
improved by a constant factor: either there is $c'<\sqrt{8/3}$ with $q_0(n)\le c'\sqrt n$ for all
large $n$, or there is $\varepsilon>0$ with $q_0(n)\ge(\sqrt2+\varepsilon)\sqrt n$ for all large $n$.
(The full problem, determining $\lim q_0(n)/\sqrt n$, is not a single proposition; this is the
"concrete target" of the source, stated as one disjunction.)
Formalization notes:
* Edges of K_n: the non-diagonal elements of `Sym2 (Fin n)` (`allEdges n`). A position is the pair
  (M, B) of Maker's and Breaker's edge sets. One round: Maker picks an edge, then Breaker picks a
  set of edges.
* Strategies are positional: Maker's is `(M, B) ↦ edge`, Breaker's is `(M, B) ↦ set of edges`
  (Breaker sees Maker's new edge). This is without loss of generality: the continuation of the game
  depends only on the position, so by backward induction the winner of this finite game has a
  positional winning strategy, and against a fixed positional Breaker strategy any
  history-dependent Maker play can be replayed by a positional Maker strategy (positions strictly
  grow except in rounds where nothing happens, which can be cut out).
* Illegal moves become passes: Maker's edge counts only if it is unclaimed; Breaker's set is
  intersected with the unclaimed edges and counts only if it has at most q elements. Claiming fewer
  edges never helps a player in a Maker-Breaker game, so allowing "at most q" and passes gives the
  same winner as the standard rule "exactly q, or all remaining edges if fewer". In particular
  `BreakerWins n q` is monotone in q. Rounds are iterated forever; once all edges are claimed the
  position is constant.
* Maker wins iff at some time her edges contain a triangle. `BreakerWins n q` = some Breaker
  strategy prevents this against all Maker strategies.
* `q0 n = sInf {q | BreakerWins n q}`; the set is nonempty (q = number of edges of K_n: Breaker
  takes everything after Maker's first edge), so there is no junk value.
* Proving `Claim` = an explicit constant-factor improvement of the Glazik–Srivastav upper bound
  or of the Chvátal–Erdős lower bound. `¬Claim` = both bounds are asymptotically sharp along
  subsequences: for every c' < √(8/3), q0 n > c'√n infinitely often, and for every ε > 0,
  q0 n < (√2+ε)√n infinitely often.
-/
namespace OpenProblems.QEDE123
noncomputable section
open scoped Classical

/-- Edges of `K_n`. -/
def allEdges (n : ℕ) : Finset (Sym2 (Fin n)) := Finset.univ.filter fun e => ¬ e.IsDiag

/-- Positional Maker strategy. -/
abbrev MakerStrategy (n : ℕ) : Type := Finset (Sym2 (Fin n)) → Finset (Sym2 (Fin n)) → Sym2 (Fin n)

/-- Positional Breaker strategy. -/
abbrev BreakerStrategy (n : ℕ) : Type :=
  Finset (Sym2 (Fin n)) → Finset (Sym2 (Fin n)) → Finset (Sym2 (Fin n))

/-- One round of the `(1 : q)` game from position `(M, B)`. -/
def playRound (n q : ℕ) (σM : MakerStrategy n) (σB : BreakerStrategy n)
    (P : Finset (Sym2 (Fin n)) × Finset (Sym2 (Fin n))) :
    Finset (Sym2 (Fin n)) × Finset (Sym2 (Fin n)) :=
  let M := P.1
  let B := P.2
  let e := σM M B
  let M' := if e ∈ allEdges n \ (M ∪ B) then insert e M else M
  let S := σB M' B ∩ (allEdges n \ (M' ∪ B))
  let B' := if S.card ≤ q then B ∪ S else B
  (M', B')

/-- Position after `t` rounds. -/
def gamePos (n q : ℕ) (σM : MakerStrategy n) (σB : BreakerStrategy n) (t : ℕ) :
    Finset (Sym2 (Fin n)) × Finset (Sym2 (Fin n)) :=
  (playRound n q σM σB)^[t] (∅, ∅)

/-- The edge set contains a triangle. -/
def HasTriangle {n : ℕ} (M : Finset (Sym2 (Fin n))) : Prop :=
  ∃ a b c : Fin n, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧ s(a, b) ∈ M ∧ s(b, c) ∈ M ∧ s(a, c) ∈ M

/-- Breaker wins the `(1 : q)` triangle game on `K_n`. -/
def BreakerWins (n q : ℕ) : Prop :=
  ∃ σB : BreakerStrategy n, ∀ σM : MakerStrategy n, ∀ t : ℕ,
    ¬ HasTriangle (gamePos n q σM σB t).1

/-- The threshold bias `q_0(n)`. -/
def q0 (n : ℕ) : ℕ := sInf {q : ℕ | BreakerWins n q}

def Claim : Prop :=
  (∃ c' : ℝ, c' < Real.sqrt (8 / 3) ∧
      ∀ᶠ n : ℕ in Filter.atTop, (q0 n : ℝ) ≤ c' * Real.sqrt n) ∨
  (∃ ε : ℝ, 0 < ε ∧
      ∀ᶠ n : ℕ in Filter.atTop, (Real.sqrt 2 + ε) * Real.sqrt n ≤ (q0 n : ℝ))

end
end OpenProblems.QEDE123
