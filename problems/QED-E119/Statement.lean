import Mathlib
/-! QED-E119: Maker-Breaker 7-in-a-row on the infinite grid
Two players take turns claiming cells of the infinite square grid. Maker wins if she ever owns k
consecutive cells in a row, column or diagonal, and Breaker wins if he stops this forever. Maker
wins for k <= 5, and Breaker wins for k >= 8 with a pairing strategy. Does Breaker win for k = 7?
Informal statement: Maker and Breaker alternately claim one unclaimed cell of $\mathbb Z^2$, Maker
first. A winning line is a set $\{p+i d:0\le i<7\}$ with $p\in\mathbb Z^2$ and
$d\in\{(1,0),(0,1),(1,1),(1,-1)\}$. Decide whether Breaker has a strategy such that, against every
Maker strategy, Maker never owns all cells of any winning line.
Formalization notes:
* Cells are `ℤ × ℤ`. A play is an infinite sequence of moves; move number t (t = 0, 1, 2, …) is
  Maker's if t is even and Breaker's if t is odd (Maker first).
* A (pure, full-information) strategy is a function from the history so far to a cell. The history
  is the list of effective moves `Option (ℤ × ℤ)` in chronological order (`none` = pass). Both
  players see the whole history, as in any perfect-information game.
* Illegal moves (choosing an already-claimed cell) are converted into passes. This does not change
  who wins: a pass is never better than a legal move in a Maker-Breaker game (an extra claimed cell
  never hurts its owner), and a legal move always exists since only finitely many cells are claimed
  at any time. So a Breaker strategy that wins with passes allowed can be converted into a legal
  one, and Maker strategies with passes are dominated by legal ones.
* Maker owns a cell iff she claimed it at some (even) time; "Maker ever owns a whole winning line"
  is therefore "every cell of the line is in Maker's set over the whole infinite play". Since cells
  are never lost, this is the same as owning the line at some finite time.
* `Claim` = Breaker has a winning strategy for k = 7: ∃ σB, ∀ σM, no winning line is all Maker's.
  `¬Claim` = for every Breaker strategy some Maker strategy completes a line; by Gale–Stewart
  determinacy (Maker's winning set is open) this is equivalent to Maker having a winning strategy.
-/
namespace OpenProblems.QEDE119
noncomputable section

/-- Cells of the board. -/
abbrev Cell : Type := ℤ × ℤ

/-- A strategy: next cell as a function of the history of effective moves (`none` = pass). -/
abbrev Strategy : Type := List (Option Cell) → Cell

open scoped Classical in
/-- The effective next move after history `h`: the player to move is Maker iff `h` has even
length; an already-claimed cell becomes a pass. -/
def effMove (σM σB : Strategy) (h : List (Option Cell)) : Option Cell :=
  let c : Cell := if h.length % 2 = 0 then σM h else σB h
  if some c ∈ h then none else some c

/-- History after `t` moves. -/
def hist (σM σB : Strategy) : ℕ → List (Option Cell)
  | 0 => []
  | t + 1 => hist σM σB t ++ [effMove σM σB (hist σM σB t)]

/-- Maker claims `c` at some point of the play. -/
def MakerOwns (σM σB : Strategy) (c : Cell) : Prop :=
  ∃ t : ℕ, t % 2 = 0 ∧ effMove σM σB (hist σM σB t) = some c

/-- The four line directions. -/
def dirs : Set Cell := {((1 : ℤ), (0 : ℤ)), (0, 1), (1, 1), (1, -1)}

/-- The winning line of length 7 starting at `p` in direction `d`, cell `i`. -/
def lineCell (p d : Cell) (i : ℕ) : Cell :=
  (p.1 + (i : ℤ) * d.1, p.2 + (i : ℤ) * d.2)

/-- Breaker wins the play: Maker never owns a whole winning line. -/
def BreakerWinsPlay (σM σB : Strategy) : Prop :=
  ∀ p : Cell, ∀ d ∈ dirs, ¬ ∀ i : ℕ, i < 7 → MakerOwns σM σB (lineCell p d i)

def Claim : Prop := ∃ σB : Strategy, ∀ σM : Strategy, BreakerWinsPlay σM σB

end
end OpenProblems.QEDE119
