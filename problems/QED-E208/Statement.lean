import Mathlib
/-! QED-E208: The centre column of Rule 30 is never periodic
Rule 30 is the one-dimensional cellular automaton in which each cell's new colour is (left) XOR (centre OR right). Start from a single black cell on an infinite white row and record the colour of the starting cell at each time step. Prove that this 0/1 sequence is not eventually periodic.
Informal statement: Let $x_0:\mathbb{Z}\to\{0,1\}$ with $x_0(0)=1$ and $x_0(j)=0$ for $j\ne0$, and $x_{t+1}(j)=x_t(j-1)\oplus\big(x_t(j)\vee x_t(j+1)\big)$. Let $c_t=x_t(0)$. Prove that there are no $p\ge1$ and $T\ge0$ with $c_{t+p}=c_t$ for all $t\ge T$.
Formalization notes: Configurations are `ℤ → Bool` (true = black). `step` is Rule 30:
new(j) = x(j-1) XOR (x(j) OR x(j+1)); XOR on Bool is written `!=` (boolean inequality, which is exactly XOR).
This is Wolfram code 30 (truth table 111↦0, 110↦0, 101↦0, 100↦1, 011↦1, 010↦1, 001↦1, 000↦0).
`orbit t` is the configuration at time t from the single seed at 0. The centre column is `orbit t 0`
(1,1,0,1,1,1,0,0,… = OEIS A051023). Claim: there are no period p ≥ 1 and threshold T with
c(t+p) = c(t) for all t ≥ T. Claim true solves Wolfram's Rule 30 Prize Problem 1; ¬Claim exhibits eventual
periodicity.
-/
namespace OpenProblems.QEDE208
noncomputable section

/-- One step of elementary cellular automaton Rule 30. -/
def step (x : ℤ → Bool) : ℤ → Bool :=
  fun j => x (j - 1) != (x j || x (j + 1))

/-- The Rule 30 orbit from a single black cell at position 0. -/
def orbit : ℕ → ℤ → Bool
  | 0 => fun j => decide (j = 0)
  | t + 1 => step (orbit t)

def Claim : Prop :=
  ¬ ∃ p T : ℕ, 0 < p ∧ ∀ t : ℕ, T ≤ t → orbit (t + p) 0 = orbit t 0

end
end OpenProblems.QEDE208
