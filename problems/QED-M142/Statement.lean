import Mathlib
/-! QED-M142: Lonely runner with speeds at most 2n
Tao proved the lonely runner conjecture when every speed is at most 1.2 times the number of runners.
Push this to speeds at most twice the number of runners (and ideally any fixed multiple).
Informal statement: For distinct positive integers v_1, …, v_n let δ(v) = sup_{t ∈ ℝ} min_i ‖t v_i‖,
where ‖·‖ is the distance to the nearest integer. Prove: for every n ≥ 1 and all distinct
v_1, …, v_n ∈ {1, …, 2n}, δ(v) ≥ 1/(n+1). (Tao 2018, Prop. 1.5, gives this with 2n replaced by ⌊6n/5⌋;
conjecturally it holds with no bound on the speeds.)
Formalization notes: ‖y‖ = min(fract y, 1 − fract y) with `Int.fract`. The function
t ↦ min_i ‖t v_i‖ is continuous and 1-periodic, so the supremum δ(v) is attained and
"δ(v) ≥ 1/(n+1)" is equivalent to "∃ t, ∀ i, ‖t v_i‖ ≥ 1/(n+1)", which is what we state.
Speeds are an injective `v : Fin n → ℕ` with 1 ≤ v i ≤ 2n. The source phrased the goal as C^* ≥ 2 for
C^* = sup{C ≥ 1 : the bound holds whenever all v_i ≤ ⌊Cn⌋}; literally, C^* ≥ 2 only gives speeds
≤ 2n − 1 (⌊Cn⌋ ≤ 2n − 1 for C < 2), so we state the intended and slightly stronger version with
speeds ≤ 2n (which is exactly "the bound holds at C = 2"). Proving `Claim` settles the conjecture for
all speed vectors with max speed ≤ 2n; `¬Claim` exhibits a counterexample to the lonely runner
conjecture itself.
-/
namespace OpenProblems.QEDM142

noncomputable section

/-- Distance from `y` to the nearest integer. -/
def distInt (y : ℝ) : ℝ := min (Int.fract y) (1 - Int.fract y)

def Claim : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∀ v : Fin n → ℕ, Function.Injective v →
    (∀ i : Fin n, 1 ≤ v i ∧ v i ≤ 2 * n) →
      ∃ t : ℝ, ∀ i : Fin n, (1 : ℝ) / ((n : ℝ) + 1) ≤ distInt (t * (v i : ℝ))

end

end OpenProblems.QEDM142
