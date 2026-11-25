import Mathlib
/-! QED-E209: Langton's ant builds a highway from every finite start
Langton's ant walks on the square grid of black and white cells. On a white cell it turns right, on a black cell it turns left, then it flips the colour of the cell it is on and steps forward. Starting from any configuration with finitely many black cells, simulations always end with the ant building a 'highway': after some time its motion repeats periodically while it drifts off in a fixed direction. Prove that this always happens.
Informal statement: A state is $(S,p,d)$ with $S\subset\mathbb{Z}^2$ finite (the black cells), $p\in\mathbb{Z}^2$ and $d\in\{(1,0),(0,1),(-1,0),(0,-1)\}$. One step: if $p\notin S$, rotate $d$ by $-90^\circ$, otherwise by $+90^\circ$; then set $S\leftarrow S\,\triangle\,\{p\}$ and $p\leftarrow p+d$. Prove that for every initial state with $S_0$ finite there exist $T\ge0$, $P\ge1$ and $v\in\mathbb{Z}^2\setminus\{0\}$ such that $p_{t+P}=p_t+v$ and $d_{t+P}=d_t$ for all $t\ge T$.
Formalization notes:
* The black set is a `Finset (ℤ × ℤ)` (finitely many black cells; the step preserves
  finiteness). The direction is `Fin 4`, with d ↦ (1,0), (0,1), (−1,0), (0,−1) for d = 0,1,2,3,
  i.e. counterclockwise order, so a +90° (left) turn is d + 1 and a −90° (right) turn is d − 1
  (mod 4, `Fin 4` arithmetic).
* One step: turn right if the current cell is white (pos ∉ black), left if black; toggle the
  colour of the current cell (erase if black, insert if white = symmetric difference with
  {pos}); move one cell in the new direction. This is exactly the step in the informal statement.
* Claim: for every initial state there are T, P ≥ 1 and v ≠ 0 with
  pos(t+P) = pos(t) + v and dir(t+P) = dir(t) for all t ≥ T (the highway conjecture, in the
  weak form not insisting on the period-104 highway). ¬Claim: some finite start never settles
  into such a periodic drift.
-/
namespace OpenProblems.QEDE209
noncomputable section

/-- State of Langton's ant: black cells, position, direction. -/
structure AntState where
  black : Finset (ℤ × ℤ)
  pos : ℤ × ℤ
  dir : Fin 4

/-- Unit vector of a direction (counterclockwise order). -/
def dirVec (d : Fin 4) : ℤ × ℤ :=
  if d = 0 then (1, 0) else if d = 1 then (0, 1) else if d = 2 then (-1, 0) else (0, -1)

/-- One step of Langton's ant. -/
def step (s : AntState) : AntState :=
  let d : Fin 4 := if s.pos ∈ s.black then s.dir + 1 else s.dir - 1
  { black := if s.pos ∈ s.black then s.black.erase s.pos else insert s.pos s.black
    pos := s.pos + dirVec d
    dir := d }

/-- The highway conjecture for Langton's ant. -/
def Claim : Prop :=
  ∀ s₀ : AntState, ∃ T P : ℕ, ∃ v : ℤ × ℤ, 0 < P ∧ v ≠ 0 ∧
    ∀ t : ℕ, T ≤ t →
      (step^[t + P] s₀).pos = (step^[t] s₀).pos + v ∧
      (step^[t + P] s₀).dir = (step^[t] s₀).dir

end
end OpenProblems.QEDE209
