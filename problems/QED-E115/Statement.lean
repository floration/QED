import Mathlib
/-! QED-E115: Rotor-router discs: logarithmic outer error
Release n chips one at a time at the origin of the square grid. Each grid point has an arrow, all
initially pointing east. A chip at an occupied point turns that point's arrow a quarter turn
counterclockwise and steps the way it now points, and it stops at the first empty point. The n
occupied points form a strikingly round disc of radius about r = sqrt(n/pi). It is proved that no
hole lies deeper than C log r inside the circle, but the best bound for outward bulges is about
sqrt(r) log r. Prove that no occupied point lies beyond r + C log r.
Informal statement: Rotor-router aggregation on $\mathbb Z^2$: rotors $\rho:\mathbb Z^2\to\{E,N,W,S\}$
start identically $E$; chips are added one at a time at $0$; a chip at an occupied site advances that
site's rotor one step counterclockwise ($E\to N\to W\to S\to E$) and moves one lattice step in the new
direction, stopping at the first unoccupied site it reaches. Let $A_n$ be the set of occupied sites
after $n$ chips and $r=\sqrt{n/\pi}$. Prove that there is a constant $C$ with
$A_n\subseteq\{z\in\mathbb Z^2:\|z\|_2\le r+C\log(2+r)\}$ for all $n\ge1$.
Formalization notes:
* Sites are `ℤ × ℤ`; a rotor configuration is `ℤ × ℤ → Fin 4` with `0 = E, 1 = N, 2 = W, 3 = S`
  (`dirVec` gives the unit steps (1,0), (0,1), (−1,0), (0,−1)). Counterclockwise advance is `+ 1`
  in `Fin 4` (wraps 3 ↦ 0, i.e. S ↦ E). The initial configuration is constantly `0` (east).
* One walker step `rotorStep` at position p: set ρ(p) := ρ(p) + 1, then move to p + dirVec(ρ(p)+1).
  This is the "rotate, then move" convention of Levine–Peres / Friedrich–Levine.
* One chip (`addChip`): starting from the origin with the current rotors, iterate `rotorStep` and
  stop at the first time k at which the walker's position is unoccupied (time 0 included, so the
  first chip occupies the origin without moving); that site becomes occupied and the rotors are
  those after the k steps. All steps before time k are taken from occupied sites, as required.
  The first exit time is `Nat.find` of the existence statement. It is a standard (and elementary)
  fact that a rotor walk on ℤ² started inside a finite set leaves it in finite time, so the `else`
  branch (state unchanged) is never used; it only makes the definition total and cannot be
  exploited, because it is never reached.
* `A n` = occupied set after n chips (it has exactly n elements). `r n = √(n/π)`.
* Proving `Claim` = an explicit-constant outer bound r + C log(2+r) for this specific (all-east,
  counterclockwise) process, matching the Levine–Peres inner bound. The `log(2 + r)` form avoids the
  degenerate value of log at small n and is equivalent to C log r for large n (small n are absorbed
  into C). Proving `¬Claim` = the outer radius minus r is not O(log r) along some sequence of n.
-/
namespace OpenProblems.QEDE115
noncomputable section

/-- Lattice sites. -/
abbrev Cell : Type := ℤ × ℤ

/-- Rotor configurations: `0 = E, 1 = N, 2 = W, 3 = S`. -/
abbrev Rotors : Type := Cell → Fin 4

/-- Unit step in direction `d` (E, N, W, S). -/
def dirVec (d : Fin 4) : Cell := ![((1 : ℤ), (0 : ℤ)), (0, 1), (-1, 0), (0, -1)] d

/-- One walker step: advance the rotor at the current site counterclockwise, then move along it. -/
def rotorStep (c : Rotors × Cell) : Rotors × Cell :=
  (Function.update c.1 c.2 (c.1 c.2 + 1), c.2 + dirVec (c.1 c.2 + 1))

/-- The walker (rotors, position) after `k` steps, started at the origin with rotors `ρ`. -/
def chipWalk (ρ : Rotors) (k : ℕ) : Rotors × Cell :=
  rotorStep^[k] (ρ, ((0 : ℤ), (0 : ℤ)))

open scoped Classical in
/-- Add one chip: it walks until the first time it is at an unoccupied site, which it occupies. -/
def addChip (s : Rotors × Set Cell) : Rotors × Set Cell :=
  if h : ∃ k : ℕ, (chipWalk s.1 k).2 ∉ s.2 then
    ((chipWalk s.1 (Nat.find h)).1, insert (chipWalk s.1 (Nat.find h)).2 s.2)
  else s

/-- State after `n` chips, starting from all rotors east and nothing occupied. -/
def config (n : ℕ) : Rotors × Set Cell :=
  addChip^[n] ((fun _ : Cell => (0 : Fin 4)), (∅ : Set Cell))

/-- The rotor-router aggregate `A_n`. -/
def A (n : ℕ) : Set Cell := (config n).2

/-- `r = √(n/π)`. -/
def r (n : ℕ) : ℝ := Real.sqrt ((n : ℝ) / Real.pi)

/-- Euclidean norm of a lattice site. -/
def euclNorm (z : Cell) : ℝ := Real.sqrt (((z.1 : ℝ)) ^ 2 + ((z.2 : ℝ)) ^ 2)

def Claim : Prop :=
  ∃ C : ℝ, ∀ n : ℕ, 1 ≤ n → ∀ z ∈ A n, euclNorm z ≤ r n + C * Real.log (2 + r n)

end
end OpenProblems.QEDE115
