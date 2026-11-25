import Mathlib
/-! QED-E118: Sylver coinage: who wins after the opening 16?
In Sylver coinage two players take turns naming positive integers. You may not name a number that can be written as a sum of numbers already named (repeats allowed), and whoever names 1 loses. Every prime 5 or larger is a winning first move. Any other winning first move must have the form 2^a 3^b, and the openings 1, 2, 3, 4, 6, 8, 9 and 12 are known to lose. Which player wins if the first player opens with 16?
Informal statement: A position is a finite set $S\subset\mathbb Z_{>0}$; a legal move from $S$ is any integer
$n\ge 2$ not in the additive monoid $\langle S\rangle$, giving $S\cup\{n\}$. Under normal play the player with no
legal move loses (this matches the rule that naming $1$ loses). Every play is finite, by Dickson's lemma.
Decide whether $\{16\}$ is a $\mathcal P$-position (the player who named $16$ wins) or an $\mathcal N$-position.
Formalization notes:
* Positions are `Finset ℕ` (the numbers named so far); `⟨S⟩` is `AddSubmonoid.closure (S : Set ℕ)`,
  the set of sums of elements of `S` with repetition (it contains 0, which is harmless since moves
  are `≥ 2`).
* Moves: `Legal S n ↔ 2 ≤ n ∧ n ∉ ⟨S⟩`. Naming 1 (legal in the original game while `1 ∉ ⟨S⟩`)
  loses immediately, so no player names 1 while another move exists, and a player with no move
  `≥ 2` is forced to name 1 and loses: this is exactly normal play on moves `≥ 2`.
* `PLose S` (the player to move from `S` loses under optimal play) is the inductive (least
  fixed point) predicate: every legal `n` has a legal reply `m` with `PLose (S ∪ {n, m})`.
  Terminal positions satisfy it vacuously. Being inductive, `PLose S` asserts that the
  second player can force a win in finitely many moves; since every play is finite (each move
  strictly enlarges `⟨S⟩`, and ℕ has the ascending chain condition on submonoids), this is the
  game-theoretic outcome, and every position is exactly one of `PLose` or
  `NWin S := ∃ n, Legal S n ∧ PLose (insert n S)` (determinacy, provable by well-founded induction).
* The opening 16 is the position `{16}` with the second player to move. `Claim := PLose {16}`,
  i.e. `{16}` is a 𝒫-position: the first player, having named 16, wins. Proving `¬Claim`
  (equivalently, by determinacy, `NWin {16}`) = the second player has a winning reply, i.e. 16 is a
  losing opening. Either proof settles the problem; the choice of polarity is not a conjecture.
-/
namespace OpenProblems.QEDE118
noncomputable section

/-- A legal move from position `S`: an integer `n ≥ 2` that is not a sum of named numbers. -/
def Legal (S : Finset ℕ) (n : ℕ) : Prop :=
  2 ≤ n ∧ n ∉ AddSubmonoid.closure (S : Set ℕ)

/-- One step of the losing-position rule: every legal move `n` from `S` has a legal reply `m`
after which the position is again in `P`. -/
def LoseStep (P : Finset ℕ → Prop) (S : Finset ℕ) : Prop :=
  ∀ n : ℕ, Legal S n → ∃ m : ℕ, Legal (insert n S) m ∧ P (insert m (insert n S))

/-- `PLose S`: the player to move from `S` loses (normal play, moves `≥ 2`). Defined as the
least fixed point of `LoseStep` (impredicative encoding of the inductive definition
`LoseStep PLose S → PLose S`, which Lean rejects as a nested inductive through `∃`). -/
def PLose (S : Finset ℕ) : Prop :=
  ∀ P : Finset ℕ → Prop, (∀ T, LoseStep P T → P T) → P S

/-- `NWin S`: the player to move from `S` has a winning move. -/
def NWin (S : Finset ℕ) : Prop :=
  ∃ n : ℕ, Legal S n ∧ PLose (insert n S)

/-- After the opening `16`, the second player (to move) loses: `16` is a winning opening. -/
def Claim : Prop := PLose {16}

end
end OpenProblems.QEDE118
